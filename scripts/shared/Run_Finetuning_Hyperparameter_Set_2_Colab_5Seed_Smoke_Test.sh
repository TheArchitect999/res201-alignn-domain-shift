#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_alignn_defaults_colab_5seed_smoke}"
GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-colab/week2-alignn-defaults-5seed}"
PUSH_AFTER_RUN="${PUSH_AFTER_RUN:-0}"

cd "$REPO_ROOT"

python scripts/shared/Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py

suite_args=(
  --repo-root .
  --experiment-tag "$TAG"
  --families oxide
  --Ns 50
  --seeds 0
  --device cuda
  --epochs 2
  --batch-size 64
  --min-batch-size 8
  --lr 0.001
)

if [[ "$PUSH_AFTER_RUN" == "1" ]]; then
  suite_args+=(--git-push-after-run --git-remote "$GIT_REMOTE" --git-branch "$GIT_BRANCH")
fi

python scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Suite.py "${suite_args[@]}"
python scripts/shared/Summarize_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --families oxide \
  --Ns 50 \
  --seeds 0
python scripts/shared/Plot_Finetuning_Training_Curves_Hyperparameter_Set_2_Colab_5Seed.py \
  --repo-root . \
  --experiment-tag "$TAG" \
  --families oxide \
  --Ns 50 \
  --seeds 0

echo "Tagged Week 2 Colab smoke run finished."
