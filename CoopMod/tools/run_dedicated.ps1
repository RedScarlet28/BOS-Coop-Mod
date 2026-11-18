# run_dedicated.ps1 - hosts one map on the dedicated server inside CoopMod\testenv for a few
# seconds and prints the proxy log. Used to test level loading without the real game.
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\tools\run_dedicated.ps1 COOP_8_CampaignMPComplete [seconds]
#   -Maps "A,B"     more maps in the server's map cycle, after $Map
#   -TimeLimit 1    round time limit in minutes (default: keep the value in Options.cfg)

param([Parameter(Mandatory)][string]$Map, [int]$Seconds = 30, [string]$Maps = '', [double]$TimeLimit = -1)
$ErrorActionPreference = 'Stop'
$env_ = Join-Path (Split-Path $PSScriptRoot -Parent) 'testenv'
if (-not (Test-Path "$env_\Dedicated_Server.exe")) { throw "run make_testenv.ps1 first" }
if (Get-Process Dedicated_Server -ErrorAction SilentlyContinue) { throw "a dedicated server is already running" }

$opt = "$env_\Mods\Bos\Settings\Options.cfg"
$text = [IO.File]::ReadAllText($opt)
$list = @($Map) + @($Maps -split ',' | Where-Object { $_ })
$cycle = "Cycle_SelectedMaps = {}`r`n`r`n"
for ($i = 0; $i -lt $list.Count; $i++) { $cycle += "Cycle_SelectedMaps[$($i + 1)] = `"$($list[$i])`";`r`n" }
$text = [regex]::Replace($text, '(?s)Cycle_SelectedMaps = \{\}.*?(?=\r?\n\s*filter_passworded_server|\z)', $cycle)
if ($TimeLimit -ge 0) {
    $text = [regex]::Replace($text, 'TimeLimit = [0-9.]+;', ('TimeLimit = {0};' -f $TimeLimit.ToString('F6', [Globalization.CultureInfo]::InvariantCulture)))
}
[IO.File]::WriteAllText($opt, $text)

$p = Start-Process "$env_\Dedicated_Server.exe" -ArgumentList '/StartServerLan' -WorkingDirectory $env_ -PassThru
Start-Sleep -Seconds $Seconds
if (-not $p.HasExited) { Stop-Process -Id $p.Id -Force }
$log = (Get-Content "$env_\coop_proxy.log" -TotalCount 1).Trim()
Get-Content $log | Where-Object { $_ -notmatch 'per-frame|\[hook\] |Failed to acquire entity|entity failed to load - skipping|^\[ *[0-9.]+\] Export(GetGameTypeList|GetModBuildVersion)' }
