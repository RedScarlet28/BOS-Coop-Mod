# uninstall.ps1 - removes the CoopMod proxy and restores the original Bos.dll.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\uninstall.ps1
#
# Leaves the co-op test levels alone; ..\coop_uninstall.ps1 removes everything.

$ErrorActionPreference = 'Stop'
$game = Split-Path $PSScriptRoot -Parent
$origHash = '3DFB6EF35C152E5A2E49060A75199B7461CEA5D6CF072A53BB2305C62DFA5395'
$bos  = Join-Path $game 'Bos.dll'
$core = Join-Path $game 'Bos_core.dll'

function Get-Sha256($p) { (Get-FileHash $p -Algorithm SHA256).Hash }

if (Get-Process -Name BoS, Dedicated_Server -ErrorAction SilentlyContinue) {
    throw "The game (or dedicated server) is running - close it first."
}

if (Test-Path $core) {
    if ((Get-Sha256 $core) -ne $origHash) {
        throw "Bos_core.dll is not the original Bos.dll - not restoring from it. Use Steam 'Verify integrity of game files'."
    }
    Copy-Item $core $bos -Force
    Remove-Item $core -Force
    Write-Host "restored original Bos.dll (and removed Bos_core.dll)"
} elseif ((Get-Sha256 $bos) -eq $origHash) {
    Write-Host "proxy not installed; Bos.dll is already the original"
} else {
    throw "Bos_core.dll is missing and Bos.dll is not the original. Use Steam 'Verify integrity of game files'."
}

foreach ($f in 'coop_proxy.log', 'coop_config.ini') {
    $p = Join-Path $game $f
    if (Test-Path $p) { Remove-Item $p -Force; Write-Host "removed $f" }
}
if (Test-Path (Join-Path $game 'coop_logs')) {
    Write-Host "kept coop_logs\ (diagnostic logs from past runs; delete it by hand if not needed)"
}
