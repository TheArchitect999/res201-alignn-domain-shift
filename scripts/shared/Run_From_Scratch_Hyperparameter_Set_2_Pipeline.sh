#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

RESULTS_ROOT="Results_Hyperparameter_Set_2"
RUN_SUBDIR="train_alignn_fromscratch"
CONFIG_DIR="configs/Hyperparameter_Set_2/week3_fromscratch"
REPORT_ROOT="reports/Hyperparameter Set 2"
SUMMARY_DIR="${REPORT_ROOT}/Summaries/From Scratch"
PLOT_DIR="${REPORT_ROOT}/Comparison Plots"

python scripts/shared/Preflight_From_Scratch_Hyperparameter_Set_2.py
python scripts/shared/Run_From_Scratch_Suite.py \
  --repo-root . \
  --results-root "$RESULTS_ROOT" \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --device cuda \
  --epochs 300 \
  --batch-size 64 \
  --lr 0.001 \
  --run-subdir "$RUN_SUBDIR" \
  --config-dir "$CONFIG_DIR" \
  --report-dir "$SUMMARY_DIR"
python scripts/shared/Summarize_From_Scratch_Reports.py \
  --repo-root . \
  --results-root "$RESULTS_ROOT" \
  --finetune-results-root "$RESULTS_ROOT" \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --run-subdir "$RUN_SUBDIR" \
  --finetune-run-subdir finetune_last2 \
  --summary-dir "$SUMMARY_DIR" \
  --plot-dir "$PLOT_DIR" \
  --title-label "Hyperparameter Set 2 From-Scratch Comparison" \
  --plot-name-template "{Family} Comparison Plot - Hyperparameter Set 2" \
  --plot-title-template "{Family} Comparison Plot - Hyperparameter Set 2"
bash scripts/shared/Check_From_Scratch_Hyperparameter_Set_2_Status.sh . "$RUN_SUBDIR" "$SUMMARY_DIR" "$RESULTS_ROOT" "$PLOT_DIR"
