#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

python scripts/shared/summarize_week2_finetune.py \
  --repo-root . \
  --results-root results_prof_advice \
  --zero-shot-root results \
  --run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --out-dir reports/week2_prof_advice \
  --title-label "professor-hyperparameter fine-tuning learning curve"

python scripts/shared/plot_week2_training_curves.py \
  --repo-root . \
  --results-root results_prof_advice \
  --run-subdir finetune_last2 \
  --families oxide nitride \
  --Ns 10 50 100 200 500 1000 \
  --seeds 0 1 2 3 4 \
  --out-dir reports/week2_prof_advice/training_curves \
  --title-label "Week 2 Professor-Hyperparameter" \
  --protocol-note "pretrained ALIGNN with professor hyperparameters (epochs=50, batch_size=16, learning_rate=0.0001)"
