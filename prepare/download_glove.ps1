# Mirror of download_glove.sh — run from repo root:
#   powershell -ExecutionPolicy Bypass -File .\prepare\download_glove.ps1

$ErrorActionPreference = "Stop"
. "$PSScriptRoot\PrepareHelpers.ps1"

$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

Write-Host "Downloading GloVe (for evaluators)"
Invoke-Gdown -Arguments @(
    '--fuzzy',
    'https://drive.google.com/file/d/1cmXKUT31pqd7_XpJAiWEo1K81TMYHA5n/view?usp=sharing',
    '-O', 'glove.zip'
)
Assert-ZipExists -Path 'glove.zip'

if (Test-Path glove) { Remove-Item -Recurse -Force glove }
Expand-Archive -Path glove.zip -DestinationPath . -Force
Remove-Item glove.zip
Write-Host "Done."
