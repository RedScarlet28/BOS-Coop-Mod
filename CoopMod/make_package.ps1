# make_package.ps1 - builds CoopMod_client.zip (in the game folder) for another player.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\make_package.ps1
#
# The zip holds only CoopMod's own files, laid out like the game folder. It contains no game files:
# the other player's install.ps1 keeps their own original Bos.dll as Bos_core.dll.
# They unpack it into their Bet On Soldier folder and run CoopMod\install.ps1.

$ErrorActionPreference = 'Stop'
$game = Split-Path $PSScriptRoot -Parent
$out  = Join-Path $game 'CoopMod_client.zip'
$stage = Join-Path $env:TEMP 'CoopMod_client_stage'

$items = @(
    'CoopMod\bin\Bos.dll',
    'CoopMod\install.ps1',
    'CoopMod\install.bat',
    'CoopMod\uninstall.ps1',
    'coop_config.ini',
    'coop_mission.lua',
    'Mods\Bos\Tuning\Maps.cfg',
    'Mods\Bos\Tuning\Multiplayer\Coop'
)
# every co-op campaign level (COOP_<campaign level>; the numbered COOP_1..8 experiments are left out),
# its folder in Levels\Multi\BOS and its AI folder in Levels
Get-ChildItem (Join-Path $game 'Mods\Bos\Levels\Multi\BOS') -Directory -Filter 'COOP_*' |
    Where-Object { $_.Name -notmatch '^COOP_[0-9]' } | ForEach-Object {
        $items += "Mods\Bos\Levels\Multi\BOS\$($_.Name)"
        if (Test-Path (Join-Path $game "Mods\Bos\Levels\$($_.Name)")) { $items += "Mods\Bos\Levels\$($_.Name)" }
    }

if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
foreach ($rel in $items) {
    $src = Join-Path $game $rel
    if (-not (Test-Path $src)) { throw "missing: $rel" }
    $dst = Join-Path $stage $rel
    New-Item -ItemType Directory -Force (Split-Path $dst -Parent) | Out-Null
    Copy-Item $src $dst -Recurse -Force
}
# leftovers from earlier experiments, not needed by the game
Get-ChildItem $stage -Recurse -File -Include '*.broken_merge', '*.bak' | Remove-Item -Force

$howto = @"
CoopMod (Bet On Soldier campaign co-op) - for the player who joins

1. Close the game. Unpack this zip into your Bet On Soldier folder (the one with BoS.exe),
   and overwrite when asked.
2. Double-click CoopMod\install.bat (game closed). The window must say
   "OK: Bos_core.dll exists". If it doesn't, send a screenshot of it to the host.
   It keeps your original Bos.dll as Bos_core.dll. CoopMod\uninstall.ps1 (or Steam
   "Verify integrity of game files") undoes everything.
   Check: after starting the game once, a coop_logs folder appears next to BoS.exe.
   No coop_logs folder = the co-op Bos.dll is not running, and COOP maps will crash.
3. Join the host's Radmin VPN network, start the game -> Multiplayer -> LAN, join the host's game.
4. After playing, send the newest file from coop_logs\ to the host.
"@
Set-Content -Path (Join-Path $stage 'COOP_HOW_TO_JOIN.txt') -Value $howto -Encoding utf8

if (Test-Path $out) { Remove-Item $out -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $out
Remove-Item $stage -Recurse -Force
Write-Host ("built {0}  ({1:N1} MB)" -f $out, ((Get-Item $out).Length / 1MB))
