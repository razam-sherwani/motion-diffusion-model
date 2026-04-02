# Mirror of download_smpl_files.sh — run from repo root:
#   powershell -ExecutionPolicy Bypass -File .\prepare\download_smpl_files.ps1
# Uses gdown on PATH if present; otherwise python/python3/py -3 -m gdown.

$ErrorActionPreference = "Stop"
. "$PSScriptRoot\PrepareHelpers.ps1"

$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

New-Item -ItemType Directory -Force -Path body_models | Out-Null
Set-Location body_models

Write-Host "SMPL files -> body_models/smpl/"
Invoke-Gdown -Arguments @(
    'https://drive.google.com/uc?id=1INYlGA76ak_cKGzvpOV2Pe6RkYTlXTW2',
    '-O', 'smpl.zip'
)
Assert-ZipExists -Path 'smpl.zip'

if (Test-Path smpl) { Remove-Item -Recurse -Force smpl }
Expand-Archive -Path smpl.zip -DestinationPath . -Force
Remove-Item smpl.zip
Write-Host "Done."
