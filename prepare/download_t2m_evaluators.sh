#!/usr/bin/env bash
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

echo -e "Downloading T2M evaluators"
# run_gdown --fuzzy https://drive.google.com/file/d/1DSaKqWX2HlwBtVH5l7DdW96jeYUIXsOP/view
# run_gdown --fuzzy https://drive.google.com/file/d/1tX79xk0fflp07EZ660Xz1RAFE33iEyJR/view
run_gdown --fuzzy "https://drive.google.com/file/d/1O_GUHgjDbl2tgbyfSwZOUYXDACnk25Kb/view" -O t2m.zip
run_gdown --fuzzy "https://drive.google.com/file/d/12liZW5iyvoybXD8eOw4VanTgsMtynCuU/view" -O kit.zip
rm -rf t2m
rm -rf kit

unzip -o t2m.zip
unzip -o kit.zip
echo -e "Cleaning\n"
rm t2m.zip
rm kit.zip

echo -e "Downloading done!"
