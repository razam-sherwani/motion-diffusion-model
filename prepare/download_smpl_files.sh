#!/usr/bin/env bash
# Uses `gdown` on PATH if available; otherwise `python -m gdown` (works in Git Bash when Python has gdown).

set -euo pipefail

run_gdown() {
  if command -v gdown >/dev/null 2>&1; then
    gdown "$@"
  else
    if command -v python3 >/dev/null 2>&1; then
      python3 -m gdown "$@"
    elif command -v python >/dev/null 2>&1; then
      python -m gdown "$@"
    elif command -v py >/dev/null 2>&1; then
      py -3 -m gdown "$@"
    else
      echo "Install gdown (pip install gdown) or put gdown on PATH." >&2
      exit 1
    fi
  fi
}

mkdir -p body_models
cd body_models/

echo -e "The smpl files will be stored in the 'body_models/smpl/' folder\n"
run_gdown "https://drive.google.com/uc?id=1INYlGA76ak_cKGzvpOV2Pe6RkYTlXTW2" -O smpl.zip
rm -rf smpl

unzip -o smpl.zip
echo -e "Cleaning\n"
rm smpl.zip

echo -e "Downloading done!"
