#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

python scripts/shared/summarize_week3_fromscratch.py \
  --repo-root . \
  --results-root results_prof_advice_alignn_recommended \
  --finetune-results-root results_prof_advice_alignn_recommended \
  --zero-shot-root results \
  --run-subdir train_alignn_fromscratch \
  --finetune-run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --out-dir reports/week3_fromscratch_alignn_recommended \
  --title-label "Week 3 ALIGNN-Recommended From-Scratch Comparison"
