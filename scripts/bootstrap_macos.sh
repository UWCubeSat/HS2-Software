#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="${ROOT_DIR}/fprime-venv"

echo "==> HS2-Software macOS bootstrap"
echo "==> Repo: ${ROOT_DIR}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: python3 not found. Install Python 3.9+ and retry."
  exit 1
fi

if [ ! -f "${ROOT_DIR}/lib/fprime/requirements.txt" ]; then
  echo "==> Cloning F Prime into lib/fprime"
  rm -rf "${ROOT_DIR}/lib/fprime"
  git clone --depth 1 https://github.com/nasa/fprime.git "${ROOT_DIR}/lib/fprime"
else
  echo "==> Initializing submodules"
  git -C "${ROOT_DIR}" submodule update --init --recursive
fi

echo "==> Creating virtual environment"
python3 -m venv "${VENV_DIR}"

echo "==> Activating virtual environment"
# shellcheck source=/dev/null
source "${VENV_DIR}/bin/activate"

echo "==> Upgrading pip"
python -m pip install --upgrade pip

if [ ! -f "${ROOT_DIR}/lib/fprime/requirements.txt" ]; then
  echo "Error: lib/fprime/requirements.txt not found. Check F Prime clone."
  exit 1
fi

echo "==> Installing F Prime dependencies and tools"
pip install -r "${ROOT_DIR}/lib/fprime/requirements.txt"
pip install fprime-tools fprime-gds pre-commit cpplint

echo "==> Installing pre-commit hooks"
pre-commit install

echo "==> Generating build files"
cd "${ROOT_DIR}"
fprime-util generate

echo "==> Done. Activate with: source fprime-venv/bin/activate"
