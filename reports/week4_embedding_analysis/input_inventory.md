# Week 4 Embedding Analysis Input Inventory

Final recommendation: use `data_shared/` as the frozen dataset source, `jv_formation_energy_peratom_alignn/` as the local pretrained ALIGNN source, `Results_Before_Correction/{oxide,nitride}/zero_shot/` as the canonical zero-shot prediction source, and `Results_Hyperparameter_Set_1/` with `reports/Hyperparameter Set 1/` as the canonical namespace for error-linked fine-tuned and from-scratch analysis.

This inventory is for additive embedding analysis only. Do not retrain, fine-tune, overwrite existing results, or download a model.

## Authoritative Inputs

| Asset | Path | Use | Authority |
|---|---|---|---|
| Frozen oxide dataset | `data_shared/oxide/manifests/all.csv` | Full oxide family inventory. Count: 14,991 records. | Authoritative dataset manifest. |
| Frozen nitride dataset | `data_shared/nitride/manifests/all.csv` | Full nitride family inventory. Count: 2,288 records. | Authoritative dataset manifest. |
| Fixed oxide test set | `data_shared/oxide/manifests/test.csv` | Oxide held-out test set for zero-shot, error joins, and embeddings. Count: 1,484 records. | Authoritative split manifest. |
| Fixed nitride test set | `data_shared/nitride/manifests/test.csv` | Nitride held-out test set for zero-shot, error joins, and embeddings. Count: 242 records. | Authoritative split manifest. |
| Oxide train+val pool | `data_shared/oxide/manifests/pool.csv` | Oxide non-test pool for sampling, train/val embeddings, and support-set context. Count: 13,507 records. | Authoritative pool manifest. |
| Nitride train+val pool | `data_shared/nitride/manifests/pool.csv` | Nitride non-test pool for sampling, train/val embeddings, and support-set context. Count: 2,046 records. | Authoritative pool manifest. |
| Oxide train split | `data_shared/oxide/manifests/train.csv` | Existing train portion of the pool. Count: 11,960 records. | Authoritative split manifest. |
| Oxide validation split | `data_shared/oxide/manifests/val.csv` | Existing validation portion of the pool. Count: 1,547 records. | Authoritative split manifest. |
| Nitride train split | `data_shared/nitride/manifests/train.csv` | Existing train portion of the pool. Count: 1,837 records. | Authoritative split manifest. |
| Nitride validation split | `data_shared/nitride/manifests/val.csv` | Existing validation portion of the pool. Count: 209 records. | Authoritative split manifest. |
| Oxide structures | `data_shared/oxide/structures/` | Structure files to join with oxide manifests and prediction errors. | Authoritative local structures. |
| Nitride structures | `data_shared/nitride/structures/` | Structure files to join with nitride manifests and prediction errors. | Authoritative local structures. |
| Oxide ALIGNN-ready pool root | `data_shared/oxide/alignn_ready/pool/` | Existing ALIGNN input root for oxide pool embeddings. Includes `id_prop.csv` and `manifest.csv`. | Authoritative derived input. |
| Oxide ALIGNN-ready test root | `data_shared/oxide/alignn_ready/test/` | Existing ALIGNN input root for oxide test embeddings. Includes `id_prop.csv` and `manifest.csv`. | Authoritative derived input. |
| Nitride ALIGNN-ready pool root | `data_shared/nitride/alignn_ready/pool/` | Existing ALIGNN input root for nitride pool embeddings. Includes `id_prop.csv` and `manifest.csv`. | Authoritative derived input. |
| Nitride ALIGNN-ready test root | `data_shared/nitride/alignn_ready/test/` | Existing ALIGNN input root for nitride test embeddings. Includes `id_prop.csv` and `manifest.csv`. | Authoritative derived input. |
| Dataset summaries | `data_shared/oxide/summaries/summary.json`, `data_shared/nitride/summaries/summary.json` | Counts, dataset key, target key, and split-source metadata. | Authoritative metadata. |
| Split source | `manifests/dft_3d_formation_energy_peratom_splits.csv` | Original split provenance for frozen dataset construction. | Provenance for authoritative splits. |
| Local pretrained checkpoint | `jv_formation_energy_peratom_alignn/checkpoint_300.pt` | Load pretrained ALIGNN weights for frozen embedding extraction. | Authoritative local checkpoint. |
| Local pretrained config | `jv_formation_energy_peratom_alignn/config.json` | Load ALIGNN architecture/configuration with the local checkpoint. | Authoritative local config. |
| Local pretrained bundle notes | `jv_formation_energy_peratom_alignn/README.md` | Confirms the local bundle is tracked for zero-shot and fine-tuning use. | Authoritative metadata. |

## Canonical Zero-Shot Outputs

| Family | Path | Use | Authority |
|---|---|---|---|
| Oxide zero-shot predictions | `Results_Before_Correction/oxide/zero_shot/predictions.csv` | Join `jid`, `filename`, `target`, `prediction`, and `abs_error` to test-set structures. | Authoritative zero-shot error table. |
| Oxide zero-shot summary | `reports/zero_shot/zero_shot_summary.csv` | Zero-shot MAE and test count. Count: 1,484, MAE: 0.03418360680813096. | Authoritative summary. |
| Nitride zero-shot predictions | `Results_Before_Correction/nitride/zero_shot/predictions.csv` | Join `jid`, `filename`, `target`, `prediction`, and `abs_error` to test-set structures. | Authoritative zero-shot error table. |
| Nitride zero-shot summary | `reports/zero_shot/zero_shot_summary.csv` | Zero-shot MAE and test count. Count: 242, MAE: 0.06954201496284854. | Authoritative summary. |

The single canonical zero-shot summary table now lives at
`reports/zero_shot/zero_shot_summary.csv`.

## Canonical Error-Linked Namespace

Use `Results_Hyperparameter_Set_1/` with `reports/Hyperparameter Set 1/`.

| Asset | Path | Use | Authority |
|---|---|---|---|
| Fine-tuning namespace | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/finetune_last2/` | Error-linked predictions for project-brief/professor-advice fine-tuned runs. | Canonical experiment namespace for fine-tuned error analysis. |
| Fine-tuning predictions | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/finetune_last2/prediction_results_test_set.csv` | Per-run `id`, `target`, and `prediction` on the fixed test set. | Authoritative per-run prediction table. |
| Fine-tuning summaries | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/finetune_last2/summary.json` | Per-run MAE and metadata. | Authoritative per-run summary. |
| Copied run structure roots | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/dataset_root/` | Per-run structure copies and split manifests for direct error-to-structure linking. | Authoritative run-level provenance. |
| Fine-tuning aggregate table | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv` | Aggregated 60-run fine-tuning table. | Authoritative report aggregate. |
| Fine-tuning summary by N | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | Family and sample-size summaries. | Authoritative report aggregate. |
| Fine-tuning manifest | `reports/Hyperparameter Set 1/Summaries/Finetuning/week2_summary_manifest.json` | Report manifest and file inventory. | Authoritative report metadata. |
| From-scratch namespace | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/train_alignn_fromscratch/` | Error-linked predictions for project-brief/professor-advice from-scratch baselines. | Canonical baseline namespace for comparison. |
| From-scratch predictions | `Results_Hyperparameter_Set_1/{oxide,nitride}/N*_seed*/train_alignn_fromscratch/prediction_results_test_set.csv` | Per-run test predictions for baseline error comparison. | Authoritative per-run prediction table. |
| From-scratch aggregate table | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv` | Aggregated 20-run from-scratch table. | Authoritative report aggregate. |
| From-scratch summary | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | Family and sample-size baseline summaries. | Authoritative report aggregate. |
| Parity plot manifest | `reports/Hyperparameter Set 1/Parity Plots/parity_plot_manifest.json` | Links plotted parity artifacts to source prediction CSVs. | Authoritative report metadata. |

Completeness checked read-only: `Results_Hyperparameter_Set_1/` has 60 fine-tuning summaries and 20 from-scratch summaries, with aggregate report artifacts present.

## Alternative Namespaces

| Namespace | Report bundle | Status | Role |
|---|---|---|---|
| `Results_Hyperparameter_Set_2/` | `reports/Hyperparameter Set 2/` | Complete: 60 fine-tuning runs and 20 from-scratch runs. | Authoritative comparison namespace for ALIGNN-recommended hyperparameters, not the canonical error-linked namespace for this phase. |
| `Results_Hyperparameter_Set_3/` | `reports/Hyperparameter Set 3/` | Complete Set 3 extension. | Additional low-learning-rate comparison namespace. |
| `reports/provenance/colab/` | N/A | Imported provenance files. | Historical/provenance-only. Do not treat as canonical input paths. |

## Reusable Helper Scripts

| Script | Reuse value | Caution |
|---|---|---|
| `scripts/shared/Fine_Tune_Last_Two_ALIGNN_Layers.py` | Contains local checkpoint/config loading via `load_pretrained_model(...)` and ALIGNN data-loading patterns that can be adapted for embedding extraction. | Reuse only non-training logic. Do not call training routines. |
| `scripts/shared/Inspect_ALIGNN_Model.py` | Useful for confirming model architecture and checkpoint loading locally. | Read-only inspection only. |
| `scripts/dataset/materialize_alignn_root.py` | Builds ALIGNN-ready roots from manifests and structures. | Existing roots already exist under `data_shared/`; only use if writing a new additive analysis input copy is necessary. |
| `scripts/dataset/res201_stage2_lib.py` | Shared dataset and manifest helper logic. | Keep any new analysis outputs separate from existing data. |
| `scripts/shared/Generate_Finetuning_Parity_Plots.py` | Useful reference for prediction-file discovery and plotting conventions. | Do not overwrite existing parity plots. |
| `scripts/shared/Generate_Workspace_Inventory.py` | Existing inventory utility. | Useful for audit context, not embedding extraction. |
| `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py` | Documents zero-shot prediction schema. | It calls pretrained model helper code that may use online/cache behavior; do not use for this phase unless modified to force local checkpoint/config only. |
| `scripts/shared/Reorganize_Reports_By_Hyperparameter_Set.py` | Documents current report-bundle organization. | Not needed for embedding computation. |

## Existing Embedding-Analysis Artifacts

No completed or partial embedding-analysis script/artifact set was found. Searches for embedding, representation, PCA, UMAP, t-SNE, latent, and related filenames found only planning/report mentions and model config fields such as `embedding_features`.

`docs/PROJECT_STATUS_SO_FAR.md` also states that Week 4 embedding analysis is not yet completed.

## Ambiguities And Risks

- Historical provenance logs and one-shot migration scripts may still contain older Colab-era report path strings. Current README and workspace-orientation docs point to `reports/Hyperparameter Set 1/`, `reports/Hyperparameter Set 2/`, and `reports/Hyperparameter Set 3/`.
- `jv_formation_energy_peratom_alignn/config.json` contains pretrained training hyperparameters matching Hyperparameter Set 2 (`epochs=300`, `batch_size=64`, `learning_rate=0.001`). Those describe the local pretrained checkpoint/config, not the canonical project-brief fine-tuning namespace.
- The local zero-shot `summary.json` files contain historical absolute paths in metadata. The repo-relative prediction CSVs under `Results_Before_Correction/{oxide,nitride}/zero_shot/` are the canonical files to use.
- The project PDF in `Project_Task/` could not be text-extracted with available local tools during this audit. The project-brief hyperparameter interpretation here is based on repo reports and docs that identify the professor-advice setting as `epochs=50`, `batch_size=16`, and `learning_rate=0.0001`.
- Several namespaces are complete. The chosen namespace is about canonical interpretation for error-linked analysis, not about invalidating the other complete namespaces.

## Final Recommendation

For the rest of embedding analysis, treat these as canonical:

- Dataset and structures: `data_shared/oxide/` and `data_shared/nitride/`.
- Local pretrained model: `jv_formation_energy_peratom_alignn/checkpoint_300.pt` with `jv_formation_energy_peratom_alignn/config.json`.
- Zero-shot errors: `Results_Before_Correction/oxide/zero_shot/predictions.csv` and `Results_Before_Correction/nitride/zero_shot/predictions.csv`.
- Fine-tuned and from-scratch error-linked namespace: `Results_Hyperparameter_Set_1/`.
- Report namespace for aggregate tables and manifests: `reports/Hyperparameter Set 1/`.
