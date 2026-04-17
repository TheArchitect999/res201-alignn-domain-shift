#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-main}"
PUSH_AFTER_RUN="${PUSH_AFTER_RUN:-1}"
PUSH_FINAL_REPORTS="${PUSH_FINAL_REPORTS:-1}"

RUN_SUBDIR="train_alignn_fromscratch_epochs100_bs32_lr5e5"
CONFIG_DIR="configs/week3_fromscratch_epochs100_bs32_lr5e5"
REPORT_DIR="reports/week3_fromscratch_epochs100_bs32_lr5e5"
FINETUNE_RUN_SUBDIR="finetune_last2_epochs100_bs32_lr5e5"

cd "$REPO_ROOT"

python scripts/shared/preflight_week3_fromscratch_epochs100_bs32_lr5e5.py

suite_args=(
  --repo-root .
  --device cuda
)

if [[ "$PUSH_AFTER_RUN" == "1" ]]; then
  suite_args+=(--git-push-after-run --git-remote "$GIT_REMOTE" --git-branch "$GIT_BRANCH")
fi

python scripts/shared/run_week3_fromscratch_suite_epochs100_bs32_lr5e5.py "${suite_args[@]}"

python scripts/shared/summarize_week3_fromscratch.py \
  --repo-root . \
  --results-root results \
  --finetune-results-root results \
  --zero-shot-root results \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --run-subdir "$RUN_SUBDIR" \
  --finetune-run-subdir "$FINETUNE_RUN_SUBDIR" \
  --out-dir "$REPORT_DIR" \
  --title-label "Week 3 From-Scratch Comparison (100 epochs, batch 32, lr 5e-5)"

bash scripts/shared/check_week3_fromscratch_epochs100_bs32_lr5e5_status.sh . "$RUN_SUBDIR" "$REPORT_DIR"

if [[ "$PUSH_FINAL_REPORTS" == "1" ]]; then
  git add -- "$REPORT_DIR" "$CONFIG_DIR"
  if [[ -n "$(git status --porcelain -- "$REPORT_DIR" "$CONFIG_DIR")" ]]; then
    git commit -m "colab: finalize week3 fromscratch epochs100 bs32 lr5e5 reports"
    git push "$GIT_REMOTE" "HEAD:${GIT_BRANCH}"
  fi
fi
