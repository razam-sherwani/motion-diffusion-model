# Install en_core_web_sm without `python -m spacy download`.
# The CLI imports spaCy -> thinc -> torch; if PyTorch DLLs fail to load, download never runs.
# Installing the wheel only uses pip and does not import torch.
#
# Pair with prepare/windows_reinstall_pytorch_cu110.ps1 if `import torch` still fails afterward.
#
# Usage:
#   conda activate mdm
#   powershell -ExecutionPolicy Bypass -File .\prepare\windows_install_en_core_web_sm.ps1

$ErrorActionPreference = "Stop"
. "$PSScriptRoot\PrepareHelpers.ps1"

$wheelUrl = "https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.3.0/en_core_web_sm-3.3.0-py3-none-any.whl"

Write-Host "Installing en_core_web_sm 3.3.0 (compatible with spaCy 3.3.x)..."
Invoke-Pip -Arguments @('install', $wheelUrl)

Write-Host "Done. Load check (requires working PyTorch for thinc)..."
Invoke-PythonExe -Arguments @(
    '-c',
    "import spacy; nlp = spacy.load('en_core_web_sm'); print('en_core_web_sm OK')"
)
