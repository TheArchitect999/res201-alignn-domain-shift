# Week 2 ALIGNN Defaults Colab 5-Seed Playbook

This playbook documents the Colab-first workflow for the tagged five-seed fine-tuning sweep:

- tag: `week2`
- branch: `main`
- run subdir: `finetune_last2`
- families: `oxide`, `nitride`
- training sizes: `10, 50, 100, 200, 500, 1000`
- seeds: `0, 1, 2, 3, 4`

## Why This Workflow Exists

The local from-scratch debugging surfaced a small set of recurring environment failures that are easy to avoid if the Colab runtime is bootstrapped correctly:

- CPU-only DGL from PyPI cannot move graphs to CUDA.
- Colab and pip environments can contain conflicting preinstalled `torch`, `torchvision`, `torchaudio`, `triton`, or `dgl` packages.
- ALIGNN `2025.4.1` still declares `dgl<=1.1.1`, which is CPU-only on PyPI, so the CUDA wheel must be reinstalled explicitly after `alignn`.
- `matplotlib` and cache directories can fail noisily if they are not configured in a writable temp location.
- A full clone of this repo is unnecessary and expensive in Colab because the historical `Results_Before_Correction/` payload is large.

## Colab Setup

1. Start a Colab runtime with GPU enabled.
2. Set `GITHUB_TOKEN` in the notebook environment before running the bootstrap script.
3. Run the bootstrap script with the GitHub repo URL:

```bash
bash env/bootstrap_res201_colab_week2_alignn_defaults_5seed.sh \
  https://github.com/<owner>/<repo>.git \
  /content/res201-alignn-domain-shift
```

What the bootstrap does:

- clones `main` with `--filter=blob:none`
- checks out `main`
- applies a sparse checkout that keeps:
  - source scripts
  - `data_shared/`
  - the pretrained checkpoint/config
  - the tagged config/report paths
  - the lightweight resume files for tagged runs
- removes conflicting PyTorch/DGL packages
- installs the pinned CUDA 12.1 PyTorch wheels
- installs `alignn`, `jarvis-tools`, `pandas`, `matplotlib`, and related dependencies
- reinstalls the CUDA-enabled DGL wheel for Python `3.10` or `3.11`
- runs `scripts/shared/Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py`

## Smoke Test

Run the smoke test first:

```bash
cd /content/res201-alignn-domain-shift
bash scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Smoke_Test.sh .
```

Defaults:

- family: `oxide`
- `N=50`
- seed `0`
- epochs: `2`
- push disabled by default

To exercise the GitHub persistence path during smoke:

```bash
PUSH_AFTER_RUN=1 bash scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Smoke_Test.sh .
```

## Full Sweep

Run the full tagged five-seed sweep:

```bash
cd /content/res201-alignn-domain-shift
bash scripts/shared/Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Pipeline.sh .
```

Defaults:

- device: `cuda`
- epochs: `300`
- batch size starts at `64`
- CUDA OOM backoff: `64 -> 32 -> 16 -> 8`
- optimizer: `AdamW`
- scheduler: `OneCycleLR`
- learning rate: `0.001`
- push after every successful run: enabled
- final aggregate report push: enabled

## Fine-Tuning Protocol

The trainer now enforces the exact protocol required by the project:

- freeze everything
- unfreeze only `fc.*`
- unfreeze only `gcn_layers.3.*`
- call `model.eval()`
- then call:
  - `model.fc.train()`
  - `model.gcn_layers[3].train()`

BatchNorm behavior:

- all BatchNorm layers outside `gcn_layers.3` stay in eval mode
- BatchNorm layers inside `gcn_layers.3` are the only BN layers allowed to update

Checkpoint selection:

- `best_model.pt` is updated only on strict validation improvement
- `best_epoch` is saved in `summary.json`
- final test evaluation always uses `best_model.pt`

## Persistence Model

The suite commits and pushes only after a run finishes successfully. Each per-run push stages:

- `Results_Hyperparameter_Set_2/<family>/N<N>_seed<seed>/dataset_root/`
- `Results_Hyperparameter_Set_2/<family>/N<N>_seed<seed>/finetune_last2/`
- `configs/Hyperparameter_Set_2/week2_finetune/...`
- `reports/Hyperparameter Set 2/Summaries/Finetuning/progress_manifest.json`

Partial failed runs are never pushed.

After the suite finishes, the pipeline generates and pushes:

- aggregate CSV tables
- zero-shot comparison table
- family learning-curve plots
- per-run training-curve figures
- family grid figures
- manifests
- final checker outputs already present in the report tree

## Verification

Preflight:

```bash
python scripts/shared/Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py
```

Final checker:

```bash
bash scripts/shared/Check_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Status.sh .
```

The checker expects:

- `2 x 6 x 5 = 60` tagged run summaries
- full aggregate report outputs
- training-curve manifests
- `runs = 5` in every aggregate row

## Expected Output Roots

- configs: `configs/Hyperparameter_Set_2/week2_finetune/`
- per-run outputs: `Results_Hyperparameter_Set_2/<family>/N<N>_seed<seed>/finetune_last2/`
- reports: `reports/Hyperparameter Set 2/Summaries/Finetuning/`
- training-curve reports: `reports/Hyperparameter Set 2/Training Curves/Finetuning/`
