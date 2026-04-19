#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

SET_ROOT="reports/Hyperparameter Set 1"
SUMMARY_DIR="${SET_ROOT}/Summaries/From Scratch"
PLOT_DIR="${SET_ROOT}/Comparison Plots"
TRAINING_DIR="${SET_ROOT}/Training Curves/From Scratch"

python scripts/shared/Summarize_From_Scratch_Reports.py \
  --repo-root . \
  --results-root Results_Hyperparameter_Set_1 \
  --finetune-results-root Results_Hyperparameter_Set_1 \
  --zero-shot-root Results_Before_Correction \
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

python scripts/shared/Plot_From_Scratch_Training_Curves.py \
  --repo-root . \
  --results-root Results_Hyperparameter_Set_1 \
  --run-subdir train_alignn_fromscratch \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --out-dir "${TRAINING_DIR}" \
  --title-label "Hyperparameter Set 1 From-Scratch" \
  --protocol-note "randomly initialized ALIGNN trained from scratch; epochs=50, batch_size=16, learning_rate=0.0001"
