#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_alignn_defaults_colab_5seed}"
GIT_REMOTE="${GIT_REMOTE:-origin}"
GIT_BRANCH="${GIT_BRANCH:-colab/week2-alignn-defaults-5seed}"
PUSH_AFTER_RUN="${PUSH_AFTER_RUN:-1}"
PUSH_FINAL_REPORTS="${PUSH_FINAL_REPORTS:-1}"

cd "$REPO_ROOT"

python scripts/shared/preflight_week2_alignn_defaults_colab_5seed.py

suite_args=(
  --repo-root .
  --experiment-tag "$TAG"
  --families oxide nitride
  --Ns 10 50 100 200 500 1000
  --seeds 0 1 2 3 4
  --device cuda
  --epochs 300
  --batch-size 64
  --min-batch-size 8
  --lr 0.001
)

if [[ "$PUSH_AFTER_RUN" == "1" ]]; then
  suite_args+=(--git-push-after-run --git-remote "$GIT_REMOTE" --git-branch "$GIT_BRANCH")
fi

python scripts/shared/run_week2_alignn_defaults_colab_5seed_suite.py "${suite_args[@]}"
python scripts/shared/summarize_week2_alignn_defaults_colab_5seed.py \
  --repo-root . \
  --experiment-tag "$TAG"
python scripts/shared/plot_week2_training_curves_alignn_defaults_colab_5seed.py \
  --repo-root . \
  --experiment-tag "$TAG"
bash scripts/shared/check_week2_alignn_defaults_colab_5seed_status.sh . "$TAG"

if [[ "$PUSH_FINAL_REPORTS" == "1" ]]; then
  git add -- "reports/${TAG}" "configs/${TAG}"
  if [[ -n "$(git status --porcelain -- "reports/${TAG}" "configs/${TAG}")" ]]; then
    git commit -m "colab: finalize ${TAG} aggregate reports"
    git push "$GIT_REMOTE" "HEAD:${GIT_BRANCH}"
  fi
fi
