# README And Documentation Updates

## Modified README Files

| File | Update | Canonical path now referenced |
| --- | --- | --- |
| `README.md` | Clarified that the zero-shot summary lives under `reports/zero_shot/`, while prediction CSVs remain under `Results_Before_Correction/`. | `reports/zero_shot/zero_shot_summary.csv` |
| `Results_Before_Correction/README.md` | Clarified that this namespace keeps zero-shot prediction CSVs only, not summary JSON copies. | `reports/zero_shot/zero_shot_summary.csv` |
| `Results_Hyperparameter_Set_1/README.md` | Added note that zero-shot summaries are not duplicated in this namespace. | `reports/zero_shot/zero_shot_summary.csv` |
| `Results_Hyperparameter_Set_2/README.md` | Added note that zero-shot summaries are not duplicated in this namespace. | `reports/zero_shot/zero_shot_summary.csv` |
| `Results_Hyperparameter_Set_3/README.md` | Added note that zero-shot summaries are not duplicated in this namespace. | `reports/zero_shot/zero_shot_summary.csv` |
| `reports/README.md` | Added the canonical zero-shot summary folder to the reports overview. | `reports/zero_shot/zero_shot_summary.csv` |
| `reports/Hyperparameter Set 1/Summaries/Finetuning/README.md` | Replaced implied local zero-shot CSV copy with canonical zero-shot summary guidance. | `reports/zero_shot/zero_shot_summary.csv` |
| `reports/Hyperparameter Set 2/Summaries/Finetuning/README.md` | Replaced implied local zero-shot CSV copy with canonical zero-shot summary guidance. | `reports/zero_shot/zero_shot_summary.csv` |
| `reports/Hyperparameter Set 3/Summaries/Finetuning/README.md` | Replaced implied local zero-shot CSV copy with canonical zero-shot summary guidance. | `reports/zero_shot/zero_shot_summary.csv` |
| `reports/zero_shot/README.md` | Added the canonical zero-shot summary folder README. | `reports/zero_shot/zero_shot_summary.csv` |

## Modified Documentation And Manifests

| File | Update |
| --- | --- |
| `docs/PROJECT_STATUS_SO_FAR.md` | Replaced deleted `reports/week2/zero_shot_summary.csv` evidence path with canonical zero-shot summary CSV guidance. |
| `docs/WORKSPACE_ARTIFACT_GUIDE.md` | Removed root-level `id_prop.csv*_data/` caches from generated asset list and documented them as non-canonical regenerated caches. |
| `reports/week4_embedding_analysis/input_inventory.md` | Removed report-level zero-shot summary CSV copies from canonical input inventory. |
| `reports/week4_embedding_analysis/input_inventory.json` | Removed deleted zero-shot CSV paths and recorded the cleanup decision. |
| `reports/week2/week2_summary_manifest.json` | Replaced `zero_csv` with `canonical_zero_shot_summary`. |
| `reports/Hyperparameter Set 1/Summaries/Finetuning/week2_summary_manifest.json` | Replaced `zero_csv` with `canonical_zero_shot_summary`. |
| `reports/Hyperparameter Set 2/Summaries/Finetuning/week2_summary_manifest.json` | Replaced `zero_csv` with `canonical_zero_shot_summary`. |
| `reports/Hyperparameter Set 3/Summaries/Finetuning/week2_summary_manifest.json` | Replaced `zero_csv` with `canonical_zero_shot_summary`. |
| `reports/provenance/colab/*/week2_summary_manifest.json` | Replaced stale provenance `zero_csv` paths with the canonical report summary path. |

## Script Reference Updates

The fine-tuning and from-scratch summarizers now read
`reports/zero_shot/zero_shot_summary.csv` instead of family-level summary JSON
files or per-folder zero-shot summary copies. The generated summary tables still
contain zero-shot MAE columns for comparisons.
