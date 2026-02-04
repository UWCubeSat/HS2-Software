Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RootDir = Resolve-Path (Join-Path $PSScriptRoot "..")
$VenvDir = Join-Path $RootDir "fprime-venv"

Write-Host "==> HS2-Software Windows bootstrap"
Write-Host "==> Repo: $RootDir"

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
  Write-Error "python not found. Install Python 3.9+ and retry."
}

$ReqFile = Join-Path $RootDir "lib\fprime\requirements.txt"
if (-not (Test-Path $ReqFile)) {
  Write-Host "==> Cloning F Prime into lib/fprime"
  if (Test-Path (Join-Path $RootDir "lib\fprime")) {
    Remove-Item -Recurse -Force (Join-Path $RootDir "lib\fprime")
  }
  git clone --depth 1 https://github.com/nasa/fprime.git (Join-Path $RootDir "lib\fprime")
} else {
  Write-Host "==> Initializing submodules"
  git -C $RootDir submodule update --init --recursive
}

Write-Host "==> Creating virtual environment"
python -m venv $VenvDir

Write-Host "==> Activating virtual environment"
$Activate = Join-Path $VenvDir "Scripts\Activate.ps1"
& $Activate

Write-Host "==> Upgrading pip"
python -m pip install --upgrade pip

if (-not (Test-Path $ReqFile)) {
  Write-Error "lib\fprime\requirements.txt not found. Check F Prime clone."
}

Write-Host "==> Installing F Prime dependencies and tools"
pip install -r $ReqFile
pip install fprime-tools fprime-gds pre-commit cpplint

Write-Host "==> Installing pre-commit hooks"
pre-commit install

Write-Host "==> Generating build files"
Set-Location $RootDir
fprime-util generate

Write-Host "==> Done. Activate with: .\fprime-venv\Scripts\Activate.ps1"
