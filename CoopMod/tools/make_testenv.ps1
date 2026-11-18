# make_testenv.ps1 - builds an isolated test install at CoopMod\testenv for automated
# dedicated-server runs, without touching the real install's Bos.dll or settings.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\tools\make_testenv.ps1
#
# Root files are hard links (same volume, no extra space) except Bos.dll (the freshly built
# proxy) and coop_config.ini (a copy). Mods\Bos\<folder> are junctions to the real folders,
# except Settings, which is copied so test runs can pick their own map. Level edits made in
# the real install are therefore visible here immediately.

$ErrorActionPreference = 'Stop'
$game = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$env_ = Join-Path $game 'CoopMod\testenv'
$proxy = Join-Path $game 'CoopMod\bin\Bos.dll'
if (-not (Test-Path $proxy)) { throw "build the proxy first (CoopMod\build.ps1)" }

if (Test-Path $env_) {
    # junctions must be removed without recursing into their targets
    Get-ChildItem "$env_\Mods\Bos", $env_ -Force -ErrorAction SilentlyContinue |
        Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint } |
        ForEach-Object { cmd /c rmdir "$($_.FullName)" | Out-Null }
    Remove-Item $env_ -Recurse -Force
}
New-Item -ItemType Directory -Force "$env_\Mods\Bos" | Out-Null

$core = Join-Path $game 'Bos_core.dll'
if (-not (Test-Path $core)) { $core = Join-Path $game 'Bos.dll' }   # proxy not installed in the real game
foreach ($f in Get-ChildItem $game -File) {
    switch ($f.Name) {
        'Bos.dll'         { continue }
        'Bos_core.dll'    { continue }
        'coop_proxy.log'  { continue }
        'coop_config.ini' { Copy-Item $f.FullName "$env_\coop_config.ini"; continue }
        default { cmd /c mklink /H "$env_\$($f.Name)" "$($f.FullName)" | Out-Null }
    }
}
cmd /c mklink /H "$env_\Bos_core.dll" "$core" | Out-Null
Copy-Item $proxy "$env_\Bos.dll"

# other root folders the engine expects (kte_core.dll needs <game>\Shaders to exist, even empty)
foreach ($d in Get-ChildItem $game -Directory -Force) {
    if ($d.Name -in 'Mods', 'CoopMod', 'coop_logs', '.tools', '.dsh-acl-recovery') { continue }
    cmd /c mklink /J "$env_\$($d.Name)" "$($d.FullName)" | Out-Null
}

foreach ($d in Get-ChildItem "$game\Mods\Bos" -Force) {
    if ($d.PSIsContainer) {
        if ($d.Name -eq 'Settings') { Copy-Item $d.FullName "$env_\Mods\Bos\Settings" -Recurse }
        else { cmd /c mklink /J "$env_\Mods\Bos\$($d.Name)" "$($d.FullName)" | Out-Null }
    } else {
        cmd /c mklink /H "$env_\Mods\Bos\$($d.Name)" "$($d.FullName)" | Out-Null
    }
}
# Lua test scripts for the dedicated server (coop_config.ini: test_lua=<file>)
Copy-Item (Join-Path $game 'CoopMod\test\lua\*.lua') $env_
Write-Host "test install ready: $env_"
Write-Host "for mission tests set in $env_\coop_config.ini: run_mission_scripts=2, test_lua=coop_test_solberg.lua, ai_player=Player, ai_kernel_on_sim=1"
