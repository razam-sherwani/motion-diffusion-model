# Reinstall PyTorch 1.7.1 + CUDA 11.0 using official pip wheels (not conda packages).
# Fixes many Windows OSError / WinError 182 issues when loading torch\lib\*.dll.
#
# Usage (from any directory, with env active):
#   conda activate mdm
#   powershell -ExecutionPolicy Bypass -File .\prepare\windows_reinstall_pytorch_cu110.ps1
#
# If this still fails:
#   - Install/update "Microsoft Visual C++ Redistributable" x64:
#     https://aka.ms/vs/17/release/vc_redist.x64.exe
#   - Temporarily remove other CUDA installs from PATH (e.g. CUDA v12 Toolkit bin)
#     so they do not shadow DLLs bundled with PyTorch.

param(
    [switch]$CpuOnly
)

$ErrorActionPreference = "Stop"
. "$PSScriptRoot\PrepareHelpers.ps1"

if (-not $env:CONDA_PREFIX) {
    throw "Activate the conda env first: conda activate mdm"
}

Write-Host "Removing conda PyTorch / cudatoolkit (pip wheels ship their own CUDA DLLs)..."
conda remove -y -p $env:CONDA_PREFIX pytorch torchvision torchaudio cudatoolkit --force
if ($LASTEXITCODE -ne 0) {
    Write-Host "(conda remove exited $LASTEXITCODE — continuing if packages were pip-only)"
}
Invoke-Pip -Arguments @('uninstall', '-y', 'torch', 'torchvision', 'torchaudio') 2>&1 | Out-Host

if ($CpuOnly) {
    Write-Host "Installing CPU-only PyTorch 1.7.1 (GPU will NOT be available)..."
    Invoke-Pip -Arguments @(
        'install',
        'torch==1.7.1+cpu',
        'torchvision==0.8.2+cpu',
        'torchaudio==0.7.2',
        '-f', 'https://download.pytorch.org/whl/torch_stable.html'
    )
} else {
    Write-Host "Installing CUDA 11.0 PyTorch 1.7.1 wheels..."
    Invoke-Pip -Arguments @(
        'install',
        'torch==1.7.1+cu110',
        'torchvision==0.8.2+cu110',
        'torchaudio==0.7.2',
        '-f', 'https://download.pytorch.org/whl/torch_stable.html'
    )
}

Write-Host "Verifying import..."
Invoke-PythonExe -Arguments @(
    '-c',
    "import torch; print('torch', torch.__version__, 'cuda_available', torch.cuda.is_available())"
)
