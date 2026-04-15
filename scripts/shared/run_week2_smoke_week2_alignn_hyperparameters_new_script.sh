#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_alignn_hyperparameters_new_script}"
cd "$REPO_ROOT"

python scripts/shared/preflight_week2_alignn_hyperparameters_new_script.py

python scripts/shared/run_week2_finetune_suite_week2_alignn_hyperparameters_new_script.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --families oxide \
  --Ns 10 1000 \
  --seeds 0 \
  --device cuda \
  --epochs 300 \
  --batch-size 64 \
  --lr 0.001

echo "Smoke run complete for tag=${TAG}."
