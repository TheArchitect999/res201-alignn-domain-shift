# Stage 2 Playbook

## Goal
Create the oxide and nitride datasets **exactly as the final task requires**:
- source = `dft_3d_2021`
- use original train/val/test split IDs first
- then filter
- oxide = contains O
- nitride = contains N and no O
- oxynitrides excluded from nitride arm
- fixed test set
- pool = train + val

## Windows + WSL commands

Open the repo folder in VS Code using WSL.

### 1. Bootstrap the data environment
```bash
bash env/bootstrap_res201_stage2_data.sh res201_data
conda activate res201_data
python env/verify_res201_stage2_data.py
```

### 2. Inspect the JARVIS dataset schema first
```bash
python scripts/dataset/build_res201_family_datasets.py \
  --dataset-key dft_3d_2021 \
  --cache-dir ./cache/jarvis \
  --outdir ./data_shared \
  --inspect-only
```

Read `data_shared/diagnostics/schema_report.json` and `data_shared/diagnostics/global_record_catalog.csv`.

### 3A. If the dataset exposes split labels, build immediately
```bash
python scripts/dataset/build_res201_family_datasets.py \
  --dataset-key dft_3d_2021 \
  --cache-dir ./cache/jarvis \
  --outdir ./data_shared \
  --materialize-pool-and-test
```

### 3B. If the dataset does NOT expose split labels, supply a split manifest
Put the official split mapping in `manifests/original_split_manifest.csv` using the template.

Then run:
```bash
python scripts/dataset/build_res201_family_datasets.py \
  --dataset-key dft_3d_2021 \
  --cache-dir ./cache/jarvis \
  --outdir ./data_shared \
  --splits-file ./manifests/original_split_manifest.csv \
  --materialize-pool-and-test
```

### 4. Validate outputs
```bash
python scripts/dataset/validate_res201_stage2.py --root ./data_shared
```

## What success looks like

You should get:
- `data_shared/oxide/manifests/{all,train,val,test,pool}.csv`
- `data_shared/nitride/manifests/{all,train,val,test,pool}.csv`
- `data_shared/*/summaries/summary.json`
- optional `alignn_ready/pool` and `alignn_ready/test`

## Team rule
Only **one person** should build Stage 2 once. Then both teammates use the same `data_shared/` output.
