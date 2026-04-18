#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

python scripts/shared/Preflight_From_Scratch_Hyperparameter_Set_2.py
python scripts/shared/Run_From_Scratch_Suite.py \
  --repo-root . \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 \
  --device cuda \
  --epochs 300 \
  --batch-size 64 \
  --lr 0.001 \
  --run-subdir train_alignn_fromscratch \
  --config-dir configs/week3_fromscratch_baseline \
  --report-dir reports/week3_fromscratch_baseline
python scripts/shared/Summarize_From_Scratch_Reports.py \
  --repo-root . \
  --families oxide nitride \
  --Ns 50 500 \
  --run-subdir train_alignn_fromscratch \
  --out-dir reports/week3_fromscratch_baseline
bash scripts/shared/Check_From_Scratch_Hyperparameter_Set_2_Status.sh . train_alignn_fromscratch reports/week3_fromscratch_baseline
