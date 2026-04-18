#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

SET_ROOT="reports/Hyperparameter Set 1"
SUMMARY_DIR="${SET_ROOT}/Summaries/Finetuning"
LEARNING_DIR="${SET_ROOT}/Learning Curves"
TRAINING_DIR="${SET_ROOT}/Training Curves/Finetuning"
PARITY_DIR="${SET_ROOT}/Parity Plots"

python scripts/shared/summarize_week2_finetune.py \
  --repo-root . \
  --results-root results_prof_advice \
  --zero-shot-root results \
  --run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --summary-dir "${SUMMARY_DIR}" \
  --plot-dir "${LEARNING_DIR}" \
  --title-label "professor-hyperparameter fine-tuning learning curve" \
  --plot-name-template "{Family} Learning Curve - Hyperparameter Set 1" \
  --plot-title-template "{Family} Learning Curve - Hyperparameter Set 1"

python scripts/shared/plot_week2_training_curves.py \
  --repo-root . \
  --results-root results_prof_advice \
  --run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --out-dir "${TRAINING_DIR}" \
  --title-label "Week 2 Professor-Hyperparameter" \
  --protocol-note "pretrained ALIGNN with professor hyperparameters (epochs=50, batch_size=16, learning_rate=0.0001)"

python scripts/shared/generate_week2_parity_plots.py \
  --repo-root . \
  --results-root results_prof_advice \
  --run-subdir finetune_last2 \
  --report-dir "${SET_ROOT}" \
  --out-dir "${PARITY_DIR}" \
  --set-number 1
