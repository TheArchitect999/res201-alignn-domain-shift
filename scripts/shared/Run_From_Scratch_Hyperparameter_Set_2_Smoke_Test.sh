#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

python scripts/shared/Preflight_From_Scratch_Hyperparameter_Set_2.py
python scripts/shared/Run_From_Scratch_Suite.py \
  --repo-root . \
  --families oxide nitride \
  --Ns 50 \
  --seeds 0 \
  --device cuda \
  --epochs 5 \
  --batch-size 64 \
  --lr 0.001 \
  --run-subdir train_alignn_fromscratch_smoke \
  --config-dir configs/week3_fromscratch_smoke \
  --report-dir reports/week3_fromscratch_smoke

echo "Week 3 smoke runs finished."
