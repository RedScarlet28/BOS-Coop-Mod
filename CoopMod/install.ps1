# install.ps1 - installs the CoopMod proxy into the game folder.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\install.ps1
#
#   Bos.dll (original)    -> Bos_core.dll   (kept byte-for-byte)
#   CoopMod\bin\Bos.dll   -> Bos.dll
#
# Safe to re-run: if the proxy is already installed it is just updated.
# Undo with CoopMod\uninstall.ps1 (or Steam "Verify integrity of game files").

$ErrorActionPreference = 'Stop'
$game = Split-Path $PSScriptRoot -Parent
$origHash = '3DFB6EF35C152E5A2E49060A75199B7461CEA5D6CF072A53BB2305C62DFA5395'
$bos   = Join-Path $game 'Bos.dll'
$core  = Join-Path $game 'Bos_core.dll'
$proxy = Join-Path $PSScriptRoot 'bin\Bos.dll'

function Get-Sha256($p) { (Get-FileHash $p -Algorithm SHA256).Hash }

if (-not (Test-Path (Join-Path $game 'BoS.exe'))) { throw "BoS.exe not found in $game" }
if (-not (Test-Path $proxy)) { throw "Proxy not built yet - run CoopMod\build.ps1 first." }
if (Get-Process -Name BoS, Dedicated_Server -ErrorAction SilentlyContinue) {
    throw "The game (or dedicated server) is running - close it first."
}

$bosHash = Get-Sha256 $bos
if ($bosHash -eq $origHash) {
    Copy-Item $bos $core -Force
    Write-Host "saved original  Bos.dll -> Bos_core.dll"
} elseif ((Test-Path $core) -and (Get-Sha256 $core) -eq $origHash) {
    Write-Host "proxy already installed; updating it"
} else {
    throw "Bos.dll is neither the original game file nor the CoopMod proxy (sha256 $bosHash). Refusing to touch it."
}

Copy-Item $proxy $bos -Force
Write-Host "installed proxy Bos.dll  ($((Get-Item $bos).Length) bytes)"
Write-Host ""
Write-Host "Each game run now writes a log to coop_logs\ next to BoS.exe (coop_proxy.log names the latest)."
