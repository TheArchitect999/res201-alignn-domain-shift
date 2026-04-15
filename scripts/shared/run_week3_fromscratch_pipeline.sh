#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

python scripts/shared/preflight_week3_fromscratch.py
python scripts/shared/run_week3_fromscratch_suite.py \
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
python scripts/shared/summarize_week3_fromscratch.py \
  --repo-root . \
  --families oxide nitride \
  --Ns 50 500 \
  --run-subdir train_alignn_fromscratch \
  --out-dir reports/week3_fromscratch_baseline
bash scripts/shared/check_week3_fromscratch_status.sh . train_alignn_fromscratch reports/week3_fromscratch_baseline
