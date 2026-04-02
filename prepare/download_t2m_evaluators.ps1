# Mirror of download_t2m_evaluators.sh — run from repo root:
#   powershell -ExecutionPolicy Bypass -File .\prepare\download_t2m_evaluators.ps1

$ErrorActionPreference = "Stop"
. "$PSScriptRoot\PrepareHelpers.ps1"

$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

Write-Host "Downloading T2M evaluators"
Invoke-Gdown -Arguments @(
    '--fuzzy',
    'https://drive.google.com/file/d/1O_GUHgjDbl2tgbyfSwZOUYXDACnk25Kb/view',
    '-O', 't2m.zip'
)
Assert-ZipExists -Path 't2m.zip'
Invoke-Gdown -Arguments @(
    '--fuzzy',
    'https://drive.google.com/file/d/12liZW5iyvoybXD8eOw4VanTgsMtynCuU/view',
    '-O', 'kit.zip'
)
Assert-ZipExists -Path 'kit.zip'

if (Test-Path t2m) { Remove-Item -Recurse -Force t2m }
if (Test-Path kit) { Remove-Item -Recurse -Force kit }
Expand-Archive -Path t2m.zip -DestinationPath . -Force
Expand-Archive -Path kit.zip -DestinationPath . -Force
Remove-Item t2m.zip, kit.zip
Write-Host "Done."
