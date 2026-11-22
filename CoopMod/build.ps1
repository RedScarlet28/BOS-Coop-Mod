# build.ps1 - builds the CoopMod proxy (CoopMod\bin\Bos.dll) and runs the offline load test.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\build.ps1
#
# Needs the MSVC x86 toolchain (VS 2019 Build Tools are installed on this machine).
# The proxy links the C runtime statically, so the result has no extra runtime dependency.

$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$game = Split-Path $here -Parent
$origHash = '3DFB6EF35C152E5A2E49060A75199B7461CEA5D6CF072A53BB2305C62DFA5395'

function Get-Sha256($p) { (Get-FileHash $p -Algorithm SHA256).Hash }

# the original Bos.dll is Bos.dll before install and Bos_core.dll after
$original = $null
foreach ($cand in @("$game\Bos_core.dll", "$game\Bos.dll")) {
    if ((Test-Path $cand) -and (Get-Sha256 $cand) -eq $origHash) { $original = $cand; break }
}
if (-not $original) { throw "Could not find the original Bos.dll (sha256 $origHash)." }

# Set up the x86 toolchain environment directly. vcvarsall.bat is avoided on
# purpose: on this machine it aborts with "\Microsoft was unexpected at this time".
$msvc = Get-ChildItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\*\*\VC\Tools\MSVC\*" -Directory |
        Where-Object { Test-Path "$($_.FullName)\bin\Hostx86\x86\cl.exe" } |
        Sort-Object Name | Select-Object -Last 1
if (-not $msvc) { throw "MSVC x86 toolchain (cl.exe) not found" }
$kits = "${env:ProgramFiles(x86)}\Windows Kits\10"
$sdk = Get-ChildItem "$kits\Lib" -Directory | Where-Object { Test-Path "$($_.FullName)\um\x86\kernel32.lib" } |
       Sort-Object Name | Select-Object -Last 1
if (-not $sdk) { throw "Windows SDK with x86 libraries not found" }
$m = $msvc.FullName; $v = $sdk.Name
$env:PATH    = "$m\bin\Hostx86\x86;$env:PATH"
$env:INCLUDE = "$m\include;$kits\Include\$v\ucrt;$kits\Include\$v\um;$kits\Include\$v\shared"
$env:LIB     = "$m\lib\x86;$kits\Lib\$v\ucrt\x86;$kits\Lib\$v\um\x86"
Write-Host "toolchain: MSVC $($msvc.Name), Windows SDK $v"

$src = "$here\proxy"
$bin = "$here\bin"
$obj = "$here\obj"
New-Item -ItemType Directory -Force $bin, $obj | Out-Null

python -I "$src\gen_exports.py" $original $src
if ($LASTEXITCODE) { throw "export generation failed" }

$cflags = @('/nologo', '/W3', '/O2', '/MT', '/GS', '/D_CRT_SECURE_NO_WARNINGS', '/DWIN32_LEAN_AND_MEAN')
& cl.exe @cflags /LD "$src\bos_proxy.c" "/Fo$obj\\" "/Fe$bin\Bos.dll" /link "/DEF:$src\bos_proxy.def" "/IMPLIB:$obj\Bos.lib" "/MAP:$obj\Bos.map" user32.lib kernel32.lib
if ($LASTEXITCODE) { throw "compiling the proxy failed" }
& cl.exe @cflags "$here\test\loadtest.c" "/Fo$obj\\" "/Fe$obj\loadtest.exe"
if ($LASTEXITCODE) { throw "compiling the load test failed" }

# offline test in a scratch folder: proxy as Bos.dll, original as Bos_core.dll
$t = "$obj\loadtest"
Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $t | Out-Null
Copy-Item "$bin\Bos.dll" "$t\Bos.dll"
Copy-Item $original "$t\Bos_core.dll"
Copy-Item $original "$t\Bos_control.dll"   # unhooked copy for the negative control
Copy-Item "$game\MSVCR71.dll", "$game\MSVCP71.dll" $t
Copy-Item "$game\KT_Game.dll", "$game\NxPhysics.dll", "$game\NxCooking.dll" $t   # engine, for its hook checks
Copy-Item "$obj\loadtest.exe" $t
& "$t\loadtest.exe" $t
$rc = $LASTEXITCODE
$log = (Get-Content "$t\coop_proxy.log" -TotalCount 1).Trim()
Write-Host "---- proxy log from the load test ($log) ----"
Get-Content $log
$bad = Select-String -Path $log -Pattern 'NOT installed|fatal' -Quiet
if ($rc -or $bad) { throw "load test FAILED" }
Write-Host ""
Write-Host "Build OK: $bin\Bos.dll  (install with CoopMod\install.ps1)"
