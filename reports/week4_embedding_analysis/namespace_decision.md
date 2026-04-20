# Namespace Decision For Error-Linked Embedding Analysis

Decision: treat `Results_Hyperparameter_Set_1/` as the canonical experiment namespace for error-linked analysis, with `reports/Hyperparameter Set 1/` as the canonical report namespace.

For pure pretrained representation and zero-shot error analysis, use `Results_Before_Correction/oxide/zero_shot/predictions.csv` and `Results_Before_Correction/nitride/zero_shot/predictions.csv`. The namespace decision below applies to linking fine-tuned/from-scratch prediction errors back to structures and sampled training contexts.

## Selected Namespace

| Field | Decision |
|---|---|
| Canonical result namespace | `Results_Hyperparameter_Set_1/` |
| Canonical report namespace | `reports/Hyperparameter Set 1/` |
| Hyperparameters | `epochs=50`, `batch_size=16`, `learning_rate=0.0001` |
| Fine-tuning path pattern | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/finetune_last2/` |
| From-scratch path pattern | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/train_alignn_fromscratch/` |
| Prediction files | `prediction_results_test_set.csv` |
| Structure-linking provenance | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/dataset_root/` |

## Rationale

`Results_Hyperparameter_Set_1/` is the best canonical namespace for the embedding-analysis phase because it is closest to the official project-brief/professor-advice hyperparameter setting documented in the repo: 50 epochs, batch size 16, and learning rate 0.0001.

It is also complete. Read-only namespace checks found all expected artifacts:

| Namespace | Report bundle | Hyperparameters | Fine-tune coverage | From-scratch coverage | Role |
|---|---|---|---|---|---|
| `Results_Hyperparameter_Set_1/` | `reports/Hyperparameter Set 1/` | 50 epochs, batch 16, LR 0.0001 | Complete: 60 summaries | Complete: 20 summaries | Canonical for error-linked analysis. |
| `Results_Hyperparameter_Set_2/` | `reports/Hyperparameter Set 2/` | 300 epochs, batch 64, LR 0.001 | Complete: 60 summaries | Complete: 20 summaries | Complete comparison namespace. |
| `Results_Hyperparameter_Set_3/` | `reports/Hyperparameter Set 3/` | 100 epochs, batch 32, LR 0.00005 | Complete: 60 summaries | Complete: 20 summaries | Additional comparison namespace. |

The selected namespace includes per-run prediction CSVs, per-run summaries, and copied `dataset_root/` directories. That makes it the cleanest source for connecting model errors to specific structures without retraining or regenerating previous outputs.

## Documentation Inconsistencies

- Current organized report directories are `reports/Hyperparameter Set 1/`, `reports/Hyperparameter Set 2/`, and `reports/Hyperparameter Set 3/`.
- Historical provenance logs and one-shot migration scripts may still contain older Colab-era report path strings. Current README and workspace-orientation docs point to the organized report bundles above.
- The local pretrained config at `jv_formation_energy_peratom_alignn/config.json` has training hyperparameters matching Hyperparameter Set 2 (`epochs=300`, `batch_size=64`, `learning_rate=0.001`). That config is still the authoritative architecture/config for loading the local pretrained checkpoint, but it should not be read as the canonical fine-tuning namespace for this analysis.
- The project PDF under `Project_Task/` could not be text-extracted with available local tools during this audit. The project-brief interpretation is therefore based on local repo reports and docs that name the professor-advice setting.

## Use In Week 4 Analysis

Use these sources together:

- Frozen datasets and structures: `data_shared/oxide/` and `data_shared/nitride/`.
- Pretrained ALIGNN representation source: `jv_formation_energy_peratom_alignn/checkpoint_300.pt` plus `jv_formation_energy_peratom_alignn/config.json`.
- Zero-shot errors: `Results_Before_Correction/oxide/zero_shot/predictions.csv` and `Results_Before_Correction/nitride/zero_shot/predictions.csv`.
- Canonical error-linked fine-tuned/from-scratch namespace: `Results_Hyperparameter_Set_1/`.
- Canonical aggregate/report namespace: `reports/Hyperparameter Set 1/`.

Final recommendation: proceed with `Results_Hyperparameter_Set_1/` as the canonical error-linked namespace and keep `Results_Hyperparameter_Set_2/` plus `Results_Hyperparameter_Set_3/` as comparison/provenance namespaces only.
