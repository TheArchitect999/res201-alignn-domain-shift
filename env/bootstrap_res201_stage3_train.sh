#!/usr/bin/env bash
set -euo pipefail
ENV_NAME="${1:-res201_train}"
MODE="${2:-cpu}"  # cpu or gpu
source "$(conda info --base)/etc/profile.d/conda.sh"
conda create -y -n "$ENV_NAME" python=3.10
conda activate "$ENV_NAME"
if [[ "$MODE" == "gpu" ]]; then
  conda install -y dgl=2.1.0 pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia
else
  conda install -y dgl=2.1.0 pytorch torchvision torchaudio cpuonly -c pytorch
fi
python -m pip install --upgrade pip
python -m pip install alignn jarvis-tools 'pandas>=1.2.3' scikit-learn matplotlib
python - <<'PY'
import torch, alignn, pandas, jarvis
from alignn.pretrained import get_figshare_model
print({'torch': torch.__version__, 'cuda': torch.cuda.is_available(), 'alignn': getattr(alignn, '__version__', 'unknown'), 'pandas': pandas.__version__})
result = get_figshare_model('jv_formation_energy_peratom_alignn')
model = result[0] if isinstance(result, tuple) else result
print('pretrained_ok', model.__class__.__name__)
PY
