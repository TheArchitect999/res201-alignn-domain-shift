#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_smoke}"
GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-main}"
PUSH_AFTER_RUN="${PUSH_AFTER_RUN:-0}"
RUN_SUBDIR="${RUN_SUBDIR:-finetune_last2_smoke}"
CONFIG_DIR="${CONFIG_DIR:-configs/Hyperparameter_Set_2/week2_finetune}"
SUMMARY_DIR="${SUMMARY_DIR:-reports/Hyperparameter Set 2/Summaries/Finetuning Smoke}"
TRAINING_CURVE_DIR="${TRAINING_CURVE_DIR:-reports/Hyperparameter Set 2/Training Curves/Finetuning Smoke}"

cd "$REPO_ROOT"

python scripts/shared/Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py

suite_args=(
  --repo-root .
  --experiment-tag "$TAG"
  --run-subdir "$RUN_SUBDIR"
  --config-dir "$CONFIG_DIR"
  --report-dir "$SUMMARY_DIR"
  --families oxide
  --Ns 50
  --seeds 0
  --device cuda
  --epochs 2
  --batch-size 64
  --min-batch-size 8
  --lr 0.001
)

if [[ "$PUSH_AFTER_RUN" == "1" ]]; then
  suite_args+=(--git-push-after-run --git-remote "$GIT_REMOTE" --git-branch "$GIT_BRANCH")
fi

python scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Suite.py "${suite_args[@]}"
python scripts/shared/Summarize_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --run-subdir "$RUN_SUBDIR" \
  --families oxide \
  --Ns 50 \
  --seeds 0 \
  --out-dir "$SUMMARY_DIR"
python scripts/shared/Plot_Finetuning_Training_Curves_Hyperparameter_Set_2_Colab_5Seed.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --run-subdir "$RUN_SUBDIR" \
  --families oxide \
  --Ns 50 \
  --seeds 0 \
  --out-dir "$TRAINING_CURVE_DIR"

echo "Tagged Week 2 Colab smoke run finished."
