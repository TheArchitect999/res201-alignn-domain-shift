#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:?usage: bash env/bootstrap_res201_colab_week2_alignn_defaults_5seed.sh <repo-url> [workspace-dir] [base-branch] [target-branch]}"
WORKSPACE_DIR="${2:-/content/res201-alignn-domain-shift}"
BASE_BRANCH="${3:-main}"
TARGET_BRANCH="${4:-colab/week2-alignn-defaults-5seed}"
TAG="week2_alignn_defaults_colab_5seed"
SMOKE_TAG="week2_alignn_defaults_colab_5seed_smoke"

if [[ -n "${GITHUB_TOKEN:-}" && "$REPO_URL" == https://* ]]; then
  AUTH_REPO_URL="https://${GITHUB_TOKEN}@${REPO_URL#https://}"
else
  AUTH_REPO_URL="$REPO_URL"
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git is required in this runtime." >&2
  exit 1
fi

if ! command -v git-lfs >/dev/null 2>&1; then
  if command -v sudo >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y git-lfs
  else
    apt-get update
    apt-get install -y git-lfs
  fi
fi

git lfs install --skip-smudge

rm -rf "$WORKSPACE_DIR"
export GIT_LFS_SKIP_SMUDGE=1
git clone --filter=blob:none --depth 1 --branch "$BASE_BRANCH" "$AUTH_REPO_URL" "$WORKSPACE_DIR"

cd "$WORKSPACE_DIR"

git config user.name "${GIT_USER_NAME:-Colab Runner}"
git config user.email "${GIT_USER_EMAIL:-colab@example.com}"
git config pull.rebase false
git config advice.detachedHead false

if git ls-remote --exit-code --heads "$AUTH_REPO_URL" "$TARGET_BRANCH" >/dev/null 2>&1; then
  git fetch --depth 1 origin "$TARGET_BRANCH"
  git checkout -B "$TARGET_BRANCH" FETCH_HEAD
else
  git checkout -B "$TARGET_BRANCH"
fi

git remote set-url origin "$AUTH_REPO_URL"
git lfs install --local --skip-smudge

git sparse-checkout init --no-cone
cat > .git/info/sparse-checkout <<EOF
/*
!/*
/.gitattributes
/README.md
/docs/
/env/
/jv_formation_energy_peratom_alignn/
/scripts/
/data_shared/
/configs/
!/configs/*
/configs/${TAG}/
/configs/${SMOKE_TAG}/
/reports/
!/reports/*
/reports/${TAG}/
/reports/${SMOKE_TAG}/
/results/
!/results/*
/results/oxide/
!/results/oxide/*
/results/oxide/N*_seed*/
!/results/oxide/N*_seed*/*
/results/oxide/N*_seed*/dataset_root/
/results/oxide/N*_seed*/finetune_last2_${TAG}/summary.json
/results/oxide/N*_seed*/finetune_last2_${TAG}/history_train.json
/results/oxide/N*_seed*/finetune_last2_${TAG}/history_val.json
/results/oxide/N*_seed*/finetune_last2_${SMOKE_TAG}/summary.json
/results/oxide/N*_seed*/finetune_last2_${SMOKE_TAG}/history_train.json
/results/oxide/N*_seed*/finetune_last2_${SMOKE_TAG}/history_val.json
/results/oxide/zero_shot/summary.json
/results/nitride/
!/results/nitride/*
/results/nitride/N*_seed*/
!/results/nitride/N*_seed*/*
/results/nitride/N*_seed*/dataset_root/
/results/nitride/N*_seed*/finetune_last2_${TAG}/summary.json
/results/nitride/N*_seed*/finetune_last2_${TAG}/history_train.json
/results/nitride/N*_seed*/finetune_last2_${TAG}/history_val.json
/results/nitride/N*_seed*/finetune_last2_${SMOKE_TAG}/summary.json
/results/nitride/N*_seed*/finetune_last2_${SMOKE_TAG}/history_train.json
/results/nitride/N*_seed*/finetune_last2_${SMOKE_TAG}/history_val.json
/results/nitride/zero_shot/summary.json
EOF
git read-tree -mu HEAD

python -m pip uninstall -y torch torchvision torchaudio triton dgl torchdata
python -m pip install --upgrade pip

PY_TAG="$(python - <<'PY'
import sys
major, minor = sys.version_info[:2]
if (major, minor) not in {(3, 10), (3, 11)}:
    raise SystemExit(f"Unsupported Python version {major}.{minor}. Expected 3.10 or 3.11.")
print(f"cp{major}{minor}")
PY
)"

case "$PY_TAG" in
  cp310)
    DGL_WHEEL="https://data.dgl.ai/wheels/cu121/dgl-1.1.3%2Bcu121-cp310-cp310-manylinux1_x86_64.whl"
    ;;
  cp311)
    DGL_WHEEL="https://data.dgl.ai/wheels/cu121/dgl-1.1.3%2Bcu121-cp311-cp311-manylinux1_x86_64.whl"
    ;;
  *)
    echo "Unsupported Python tag: $PY_TAG" >&2
    exit 1
    ;;
esac

python -m pip install \
  torch==2.2.1 \
  torchvision==0.17.1 \
  torchaudio==2.2.1 \
  --index-url https://download.pytorch.org/whl/cu121

python -m pip install \
  numpy==1.26.4 \
  scipy==1.15.3 \
  alignn==2025.4.1 \
  jarvis-tools==2026.3.10 \
  pandas==2.3.3 \
  matplotlib==3.10.6 \
  requests==2.33.1 \
  urllib3==2.6.3 \
  scikit-learn==1.7.2 \
  tqdm==4.67.3 \
  psutil==7.2.2

python -m pip install --no-deps --force-reinstall "$DGL_WHEEL"

python scripts/shared/Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py

echo
echo "Colab bootstrap finished."
echo "Workspace: $WORKSPACE_DIR"
echo "Checked out branch: $TARGET_BRANCH"
echo "Next steps:"
echo "  cd $WORKSPACE_DIR"
echo "  bash scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Smoke_Test.sh ."
echo "  bash scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Pipeline.sh ."
