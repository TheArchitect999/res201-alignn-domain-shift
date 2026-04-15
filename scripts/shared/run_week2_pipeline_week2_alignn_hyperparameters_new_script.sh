#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_alignn_hyperparameters_new_script}"
cd "$REPO_ROOT"

python scripts/shared/preflight_week2_alignn_hyperparameters_new_script.py
python scripts/shared/run_week2_finetune_suite_week2_alignn_hyperparameters_new_script.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --device cuda \
  --epochs 300 \
  --batch-size 64 \
  --lr 0.001
python scripts/shared/summarize_week2_finetune_week2_alignn_hyperparameters_new_script.py \
  --repo-root . \
  --experiment-tag "$TAG"
python scripts/shared/plot_week2_training_curves_week2_alignn_hyperparameters_new_script.py \
  --repo-root . \
  --experiment-tag "$TAG"
scripts/shared/check_week2_status_week2_alignn_hyperparameters_new_script.sh . "$TAG"
