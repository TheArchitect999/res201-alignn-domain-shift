#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

python scripts/shared/summarize_week2_finetune.py \
  --repo-root . \
  --results-root results_prof_advice_alignn_recommended \
  --zero-shot-root results \
  --run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --out-dir reports/week2_prof_advice_alignn_recommended \
  --title-label "ALIGNN-recommended fine-tuning learning curve"

python scripts/shared/plot_week2_training_curves.py \
  --repo-root . \
  --results-root results_prof_advice_alignn_recommended \
  --run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --out-dir reports/week2_prof_advice_alignn_recommended/training_curves \
  --title-label "Week 2 ALIGNN-Recommended" \
  --protocol-note "pretrained ALIGNN with ALIGNN-recommended hyperparameters (epochs=300, batch_size=64, learning_rate=0.001)"
