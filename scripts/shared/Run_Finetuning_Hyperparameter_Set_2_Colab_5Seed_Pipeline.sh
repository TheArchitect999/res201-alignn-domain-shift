#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2}"
GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-main}"
PUSH_AFTER_RUN="${PUSH_AFTER_RUN:-1}"
PUSH_FINAL_REPORTS="${PUSH_FINAL_REPORTS:-1}"
RUN_SUBDIR="${RUN_SUBDIR:-finetune_last2}"
CONFIG_DIR="${CONFIG_DIR:-configs/Hyperparameter_Set_2/week2_finetune}"
SUMMARY_DIR="${SUMMARY_DIR:-reports/Hyperparameter Set 2/Summaries/Finetuning}"
LEARNING_CURVE_DIR="${LEARNING_CURVE_DIR:-reports/Hyperparameter Set 2/Learning Curves}"
TRAINING_CURVE_DIR="${TRAINING_CURVE_DIR:-reports/Hyperparameter Set 2/Training Curves/Finetuning}"

cd "$REPO_ROOT"

python scripts/shared/Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py

suite_args=(
  --repo-root .
  --experiment-tag "$TAG"
  --run-subdir "$RUN_SUBDIR"
  --config-dir "$CONFIG_DIR"
  --report-dir "$SUMMARY_DIR"
  --families oxide nitride
  --Ns 10 50 100 200 500 1000
  --seeds 0 1 2 3 4
  --device cuda
  --epochs 300
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
  --out-dir "$SUMMARY_DIR" \
  --plot-dir "$LEARNING_CURVE_DIR"
python scripts/shared/Plot_Finetuning_Training_Curves_Hyperparameter_Set_2_Colab_5Seed.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --run-subdir "$RUN_SUBDIR" \
  --out-dir "$TRAINING_CURVE_DIR"
bash scripts/shared/Check_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Status.sh . "$TAG" "$RUN_SUBDIR" "$SUMMARY_DIR" "$TRAINING_CURVE_DIR" "$LEARNING_CURVE_DIR"

if [[ "$PUSH_FINAL_REPORTS" == "1" ]]; then
  git add -- "$SUMMARY_DIR" "$LEARNING_CURVE_DIR" "$TRAINING_CURVE_DIR" "$CONFIG_DIR"
  if [[ -n "$(git status --porcelain -- "$SUMMARY_DIR" "$LEARNING_CURVE_DIR" "$TRAINING_CURVE_DIR" "$CONFIG_DIR")" ]]; then
    git commit -m "colab: finalize ${TAG} aggregate reports"
    git push "$GIT_REMOTE" "HEAD:${GIT_BRANCH}"
  fi
fi
