#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

SET_ROOT="reports/Hyperparameter Set 2"
SUMMARY_DIR="${SET_ROOT}/Summaries/From Scratch"
PLOT_DIR="${SET_ROOT}/Comparison Plots"
TRAINING_DIR="${SET_ROOT}/Training Curves/From Scratch"

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
  --summary-dir "${SUMMARY_DIR}" \
  --plot-dir "${PLOT_DIR}" \
  --title-label "Week 3 ALIGNN-Recommended From-Scratch Comparison" \
  --plot-name-template "{Family} Comparison Plot - Hyperparameter Set 2" \
  --plot-title-template "{Family} Comparison Plot - Hyperparameter Set 2"

python scripts/shared/plot_week3_training_curves.py \
  --repo-root . \
  --results-root results_prof_advice_alignn_recommended \
  --run-subdir train_alignn_fromscratch \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --out-dir "${TRAINING_DIR}" \
  --title-label "Hyperparameter Set 2 From-Scratch" \
  --protocol-note "randomly initialized ALIGNN trained from scratch; epochs=300, batch_size=64, learning_rate=0.001"
