# Cleanup Summary

## Result

- Total files deleted in the staged cleanup: 2,504.
- Duplicate/redundant groups resolved automatically: 5 categories.
- Cleanup reports created under `reports/repo_cleanup/`: 7.

## Canonical Zero-Shot Location

The surviving authoritative zero-shot files are:

- `reports/zero_shot/zero_shot_summary.csv`
- `Results_Before_Correction/oxide/zero_shot/predictions.csv`
- `Results_Before_Correction/nitride/zero_shot/predictions.csv`

The deleted report-level CSV files were convenience copies only. Zero-shot MAE
values remain available in `reports/zero_shot/zero_shot_summary.csv` and
embedded comparison columns inside fine-tuning/from-scratch summary tables.

## Main Cleanup Categories

1. Removed redundant report-level zero-shot summary CSV copies from `reports/week2/` and the three hyperparameter-set fine-tuning summary folders.
2. Consolidated the two family-level zero-shot summary JSON files into `reports/zero_shot/zero_shot_summary.csv` and removed the JSON copies from `Results_Before_Correction/`.
3. Removed provenance zero-shot summary CSV copies that repeated the same values with stale absolute paths.
4. Removed generated ALIGNN/DGL LMDB cache files and cache markers from `id_prop.csv*_data/` folders across result namespaces, plus root-level cache folders.
5. Removed generated embedding-analysis LMDB caches under `artifacts/embedding_analysis/cache/` and the local JARVIS download cache under `cache/`.
6. Removed the obsolete `.gitattributes` file that only routed `*.mdb` caches through Git LFS.
7. Updated manifests, scripts, README files, and inventory docs so deleted files are not expected as canonical assets.

## Manual-Review Items Left Untouched

- Exact duplicate result/model artifacts across experiment namespaces.
- Exact duplicate structure/POSCAR and run-level dataset materializations.
- Curated final figures/tables that may duplicate source figures but serve report insertion.
- Repeated local README files that are useful in mirrored report folders.

## Cohesion Note

The repo now has a single zero-shot summary source of truth under
`reports/zero_shot/`, while the full zero-shot prediction tables remain in
`Results_Before_Correction/`. Hyperparameter-set reports keep only their
experiment-specific summaries and comparison tables. This keeps navigation
cleaner without removing unique scientific assets.

Generated cache files are not part of the canonical research record. They are
now ignored by `.gitignore` and can be regenerated from the retained datasets,
configs, split manifests, scripts, and experiment outputs if a workflow is rerun.
