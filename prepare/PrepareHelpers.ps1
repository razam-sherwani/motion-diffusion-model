# Shared helpers for prepare/*.ps1 — Python / gdown / pip resolution (conda, Git-less PowerShell, py launcher).

function Invoke-PythonExe {
    param(
        [Parameter(Mandatory)][string[]]$Arguments
    )
    if (Get-Command python -ErrorAction SilentlyContinue) {
        & python @Arguments
        return
    }
    if (Get-Command python3 -ErrorAction SilentlyContinue) {
        & python3 @Arguments
        return
    }
    if (Get-Command py -ErrorAction SilentlyContinue) {
        & py -3 @Arguments
        return
    }
    throw "Python not found on PATH. Open Anaconda/Miniforge Prompt and `conda activate mdm`, or install Python and `pip install gdown`."
}

function Invoke-Gdown {
    param(
        [Parameter(Mandatory)][string[]]$Arguments
    )
    if (Get-Command gdown -ErrorAction SilentlyContinue) {
        & gdown @Arguments
        return
    }
    Invoke-PythonExe -Arguments (@('-m', 'gdown') + $Arguments)
}

function Invoke-Pip {
    param(
        [Parameter(Mandatory)][string[]]$Arguments
    )
    Invoke-PythonExe -Arguments (@('-m', 'pip') + $Arguments)
}

function Assert-ZipExists {
    param(
        [Parameter(Mandatory)][string]$Path
    )
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Download failed: missing file '$Path'."
    }
}
