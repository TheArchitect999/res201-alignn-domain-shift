#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

SET_ROOT="reports/Hyperparameter Set 1"
SUMMARY_DIR="${SET_ROOT}/Summaries/From Scratch"
PLOT_DIR="${SET_ROOT}/Comparison Plots"
TRAINING_DIR="${SET_ROOT}/Training Curves/From Scratch"

python scripts/shared/summarize_week3_fromscratch.py \
  --repo-root . \
  --results-root results_prof_advice \
  --finetune-results-root results_prof_advice \
  --zero-shot-root results \
  --run-subdir train_alignn_fromscratch \
  --finetune-run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --summary-dir "${SUMMARY_DIR}" \
  --plot-dir "${PLOT_DIR}" \
  --title-label "Week 3 Professor-Hyperparameter From-Scratch Comparison" \
  --plot-name-template "{Family} Comparison Plot - Hyperparameter Set 1" \
  --plot-title-template "{Family} Comparison Plot - Hyperparameter Set 1"

python scripts/shared/plot_week3_training_curves.py \
  --repo-root . \
  --results-root results_prof_advice \
  --run-subdir train_alignn_fromscratch \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --out-dir "${TRAINING_DIR}" \
  --title-label "Hyperparameter Set 1 From-Scratch" \
  --protocol-note "randomly initialized ALIGNN trained from scratch; epochs=50, batch_size=16, learning_rate=0.0001"
