# test_all_levels.ps1 - loads each co-op level on the dedicated server (CoopMod\testenv) and prints a
# one-block summary per level: scene load, spawn entities, mission scripts, co-op script, crashes.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\tools\test_all_levels.ps1 [-Seconds 40] [-Levels "COOP_A,COOP_B"]
param([int]$Seconds = 40, [string]$Levels = '')
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$env_ = Join-Path $root 'testenv'
$cfg = Join-Path $env_ 'coop_config.ini'
$bak = "$cfg.batchbak"
Copy-Item $cfg $bak -Force
$t = [IO.File]::ReadAllText($cfg) -replace '(?m)^test_lua=.*$', 'test_lua='
[IO.File]::WriteAllText($cfg, $t)
try {
    if ($Levels) { $list = $Levels -split ',' } else {
        $list = Get-ChildItem (Join-Path $root '..\Mods\Bos\Levels\Multi\BOS') -Directory -Filter 'COOP_*' |
            Where-Object { $_.Name -notmatch '^COOP_[0-9]' } | ForEach-Object { $_.Name }
    }
    foreach ($m in $list) {
        $w = 0
        while ((Get-Process Dedicated_Server -ErrorAction SilentlyContinue) -and $w -lt 30) { Start-Sleep 1; $w++ }
        Get-Process Dedicated_Server -ErrorAction SilentlyContinue | Stop-Process -Force
        Start-Sleep 1
        & (Join-Path $PSScriptRoot 'run_dedicated.ps1') $m $Seconds | Out-Null
        $f = Get-ChildItem "$env_\coop_logs\Dedicated_Server_*.log" | Sort-Object LastWriteTime | Select-Object -Last 1
        $lines = Get-Content $f.FullName
        $pick = $lines | Select-String -Pattern '\[load\] scene file -> |\[load\] entity chunk|\[spawn\] [0-9]+ spawn areas|\[level\] checksum .*FAILED|\[crash\] exception|\[lua error\]|co-op script loaded|co-op layer loaded|\[census\] round started|Objective|\[mission\]' |
            Where-Object { $_.Line -notmatch 'Bos\+0x18500C' } | Select-Object -First 14
        $last = ($lines | Select-Object -Last 1)
        "==== $m  ($($f.Name), last line at $($last.Substring(0, [Math]::Min(10, $last.Length))))"
        $pick | ForEach-Object { '   ' + $_.Line.Substring(0, [Math]::Min(190, $_.Line.Length)) }
    }
} finally {
    Copy-Item $bak $cfg -Force
    Remove-Item $bak -Force
}
