@echo off
rem Double-click to install CoopMod. The window stays open so you can read the result.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
echo.
if exist "%~dp0..\Bos_core.dll" (echo OK: Bos_core.dll exists, the co-op Bos.dll is installed.) else (echo NOT INSTALLED - send the text above to the host.)
powershell -NoProfile -Command "Write-Host ('Bos.dll sha256:      ' + (Get-FileHash '%~dp0..\Bos.dll').Hash)"
if exist "%~dp0..\Bos_core.dll" powershell -NoProfile -Command "Write-Host ('Bos_core.dll sha256: ' + (Get-FileHash '%~dp0..\Bos_core.dll').Hash)"
echo.
pause
