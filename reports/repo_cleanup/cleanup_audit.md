# Repository Cleanup Audit

Pre-deletion audit for the current local `main` branch.

## Repo Areas Inspected

- Top-level documentation and workspace guide: `README.md`, `docs/`, `reports/README.md`.
- Canonical datasets and manifests: `data_shared/`, `manifests/`, `cache/jarvis/`.
- Pretrained model payload: `jv_formation_energy_peratom_alignn/`.
- Experiment namespaces: `Results_Before_Correction/`, `Results_Hyperparameter_Set_1/`, `Results_Hyperparameter_Set_2/`, `Results_Hyperparameter_Set_3/`.
- Report bundles: `reports/week2/`, `reports/Hyperparameter Set 1/`, `reports/Hyperparameter Set 2/`, `reports/Hyperparameter Set 3/`, `reports/week4_embedding_analysis/`, and `reports/provenance/`.
- Automation and configuration: `scripts/`, `configs/`, `env/`.

## Exact Duplicate Scan

Content-hash scan used tracked files from `git ls-files`, grouped by file size, then SHA-256 hashed same-size groups.

- Tracked files scanned: 254,286.
- Same-size groups hashed: 3,179.
- Exact duplicate groups found: 18,614.
- Exact duplicate file paths in those groups: 249,826.
- Duplicate-size groups over 50 MiB: 0.

Representative exact duplicate examples retained for manual review:

- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N1000_seed0/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N1000_seed0/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N1000_seed1/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N1000_seed1/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N1000_seed2/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N1000_seed2/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N100_seed0/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N100_seed0/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N100_seed1/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N100_seed1/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N100_seed2/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N100_seed2/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N10_seed0/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N10_seed0/finetune_last2/current_model.pt`
- `16259750` bytes, `2` copies, example paths: `Results_Before_Correction/nitride/N10_seed1/finetune_last2/current_model.pt`, `Results_Hyperparameter_Set_1/nitride/N10_seed1/finetune_last2/current_model.pt`

Most exact duplicates are expected scientific/provenance artifacts: repeated structure copies, LMDB lock files, or run artifacts that belong to distinct run namespaces. They are not safe to delete automatically just because the bytes match.

## Semantic Duplicate Findings

### Zero-Shot Summary Copies

Canonical zero-shot outputs are:

- `reports/zero_shot/zero_shot_summary.csv`
- `Results_Before_Correction/oxide/zero_shot/predictions.csv`
- `Results_Before_Correction/nitride/zero_shot/predictions.csv`

The following report-level CSV files repeat only the same two MAE rows and are safe to delete after updating manifests, checks, and README/doc references:

- `reports/week2/zero_shot_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/zero_shot_summary.csv`
- `reports/Hyperparameter Set 2/Summaries/Finetuning/zero_shot_summary.csv`
- `reports/Hyperparameter Set 3/Summaries/Finetuning/zero_shot_summary.csv`

Family-level summary JSON files consolidated into the report-level CSV and removed:

- `Results_Before_Correction/oxide/zero_shot/summary.json`
- `Results_Before_Correction/nitride/zero_shot/summary.json`

The two provenance zero-shot CSV copies under `reports/provenance/colab/` also repeated the same summary values with stale absolute paths, so they were removed and their manifests now reference `reports/zero_shot/zero_shot_summary.csv`.

### Generated Root-Level LMDB Caches

The root-level folders `id_prop.csvtest_data/`, `id_prop.csvtrain_data/`, and `id_prop.csvval_data/` contain tiny generated LMDB cache files. They are not canonical datasets, reports, checkpoints, or results, and are safe to delete.

### Follow-Up Cache Policy Decision

After the initial audit, the repo-wide cache policy was tightened further: all
tracked generated LMDB caches and cache markers under `id_prop.csv*_data/`, the
embedding-analysis runtime cache under `artifacts/embedding_analysis/cache/`,
and the local JARVIS download cache under `cache/` were removed from the staged
tree. See `reports/repo_cleanup/cache_cleanup_summary.md` for the cache-specific
decision and counts.

## Safe To Delete

- Report-level zero-shot convenience CSV copies: 4 files.
- Family-level zero-shot summary JSON files transferred to report summary CSV: 2 files.
- Provenance zero-shot summary CSV copies: 2 files.
- Generated LMDB/download/runtime cache files: 2,495 files.
- Obsolete `.gitattributes` file containing only LMDB Git LFS rules: 1 file.

## Manual Review Kept

- Exact duplicate model/result artifacts across experiment namespaces.
- Exact duplicate structure or dataset materializations under run folders.
- Small repeated local README files in mirrored report subfolders.
- Curated final figures/tables that may duplicate source plot content but serve report insertion.

## Counts By Category

| Category | Action | Count |
| --- | --- | ---: |
| Semantic duplicate zero-shot report copies | Safe delete | 4 |
| Family-level zero-shot summary JSON files transferred to report summary CSV | Safe delete | 2 |
| Generated LMDB/download/runtime cache files | Safe delete | 2,495 |
| Obsolete LMDB Git LFS attributes file | Safe delete | 1 |
| Exact duplicate result/data/provenance groups | Manual review keep | 18,614 groups |
| Provenance zero-shot CSV copies | Safe delete | 2 files |

## Decision Standard

When a file carried unique scientific context, run provenance, curated report value, or uncertain downstream usage, it was kept. Only redundant report convenience copies, family-level summary JSON files consolidated into the report summary table, and non-canonical generated root cache files are selected for deletion.
