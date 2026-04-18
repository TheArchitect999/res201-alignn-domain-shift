#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-main}"
PUSH_AFTER_RUN="${PUSH_AFTER_RUN:-1}"
PUSH_FINAL_REPORTS="${PUSH_FINAL_REPORTS:-1}"

RUN_SUBDIR="finetune_last2_epochs100_bs32_lr5e5"
CONFIG_DIR="configs/week2_last2_epochs100_bs32_lr5e5"
REPORT_ROOT="reports/Hyperparameter Set 3"
SUMMARY_DIR="${REPORT_ROOT}/Summaries/Finetuning"
LEARNING_DIR="${REPORT_ROOT}/Learning Curves"
TRAINING_DIR="${REPORT_ROOT}/Training Curves/Finetuning"
PARITY_DIR="${REPORT_ROOT}/Parity Plots"

cd "$REPO_ROOT"

python scripts/shared/preflight_week2_last2_epochs100_bs32_lr5e5.py

suite_args=(
  --repo-root .
  --device cuda
)

if [[ "$PUSH_AFTER_RUN" == "1" ]]; then
  suite_args+=(--git-push-after-run --git-remote "$GIT_REMOTE" --git-branch "$GIT_BRANCH")
fi

python scripts/shared/run_week2_finetune_suite_epochs100_bs32_lr5e5.py "${suite_args[@]}"

python scripts/shared/summarize_week2_finetune.py \
  --repo-root . \
  --results-root results \
  --zero-shot-root results \
  --run-subdir "$RUN_SUBDIR" \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --summary-dir "$SUMMARY_DIR" \
  --plot-dir "$LEARNING_DIR" \
  --title-label "partial fine-tuning learning curve (100 epochs, batch 32, lr 5e-5)" \
  --plot-name-template "{Family} Learning Curve - Hyperparameter Set 3" \
  --plot-title-template "{Family} Learning Curve - Hyperparameter Set 3"

python scripts/shared/plot_week2_training_curves.py \
  --repo-root . \
  --results-root results \
  --run-subdir "$RUN_SUBDIR" \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --out-dir "${TRAINING_DIR}" \
  --title-label "Week 2 E100-B32-LR5e-5" \
  --protocol-note "pretrained ALIGNN with explicit partial fine-tuning; model.eval() then fc.train() + gcn_layers[3].train(); all other layers frozen"

python scripts/shared/generate_week2_parity_plots.py \
  --repo-root . \
  --results-root results \
  --run-subdir "$RUN_SUBDIR" \
  --report-dir "$REPORT_ROOT" \
  --out-dir "$PARITY_DIR" \
  --set-number 3

bash scripts/shared/check_week2_finetune_epochs100_bs32_lr5e5_status.sh . "$RUN_SUBDIR" "$REPORT_ROOT"

if [[ "$PUSH_FINAL_REPORTS" == "1" ]]; then
  git add -- "$REPORT_ROOT" "$CONFIG_DIR"
  if [[ -n "$(git status --porcelain -- "$REPORT_ROOT" "$CONFIG_DIR")" ]]; then
    git commit -m "colab: finalize week2 last2 epochs100 bs32 lr5e5 reports"
    git push "$GIT_REMOTE" "HEAD:${GIT_BRANCH}"
  fi
fi
