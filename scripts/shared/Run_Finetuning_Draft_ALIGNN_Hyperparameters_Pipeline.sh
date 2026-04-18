#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_alignn_hyperparameters_new_script}"
cd "$REPO_ROOT"

python scripts/shared/Preflight_Finetuning_Draft_ALIGNN_Hyperparameters.py
python scripts/shared/Run_Finetuning_Draft_ALIGNN_Hyperparameters_Suite.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --device cuda \
  --epochs 300 \
  --batch-size 64 \
  --lr 0.001
python scripts/shared/Summarize_Finetuning_Draft_ALIGNN_Hyperparameters.py \
  --repo-root . \
  --experiment-tag "$TAG"
python scripts/shared/Plot_Finetuning_Training_Curves_Draft_ALIGNN_Hyperparameters.py \
  --repo-root . \
  --experiment-tag "$TAG"
scripts/shared/Check_Finetuning_Draft_ALIGNN_Hyperparameters_Status.sh . "$TAG"
