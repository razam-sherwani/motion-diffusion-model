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

echo -e "Downloading glove (in use by the evaluators, not by MDM itself)"
run_gdown --fuzzy "https://drive.google.com/file/d/1cmXKUT31pqd7_XpJAiWEo1K81TMYHA5n/view?usp=sharing" -O glove.zip
rm -rf glove

unzip -o glove.zip
echo -e "Cleaning\n"
rm glove.zip

echo -e "Downloading done!"
