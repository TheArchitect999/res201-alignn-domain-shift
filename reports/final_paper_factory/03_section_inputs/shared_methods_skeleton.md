# Shared Methods Skeleton

Purpose: repo-grounded methods backbone for the oxide standalone report, nitride standalone report, and combined paper. This file is a drafting scaffold, not final prose.

## Non-negotiable drafting rules

- Keep Methods separate from Results. Do not write outcome language here.
- Separate three layers every time:
  - literature-grounded context placeholders
  - our implementation details
  - our experimental setup
- If the repo does not support a precise statement, leave `TODO` instead of filling the gap with plausible wording.
- Anchor the main narrative to Hyperparameter Set 1: `epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`.
- Keep from-scratch scope honest: only `N = 50` and `N = 500` exist.
- In main-text embedding discussion, prefer `last_alignn_pool`. Treat `pre_head` and `last_gcn_pool` as robustness or appendix unless explicitly needed.

## Recommended subsection order

1. Dataset source and prediction target
2. Family definitions and oxide/nitride filtering
3. Split protocol and run-local subset construction
4. Zero-shot evaluation
5. Fine-tuning protocol
6. From-scratch protocol
7. Main narrative hyperparameter setting
8. Evaluation metric and result aggregation
9. Embedding-analysis protocol

## Shared factual anchors

### Family-level dataset summary

| family | all | train | val | test | pool | oxynitrides in family |
|---|---:|---:|---:|---:|---:|---:|
| oxide | 14991 | 11960 | 1547 | 1484 | 13507 | 499 |
| nitride | 2288 | 1837 | 209 | 242 | 2046 | 0 |

### Main fine-tuning subset sizes

The run-local train/validation split is built from the family pool with `n_val = max(5, round(0.1 * N))`, then `train = N - n_val`.

| sampled N | train | val |
|---|---:|---:|
| 10 | 5 | 5 |
| 50 | 45 | 5 |
| 100 | 90 | 10 |
| 200 | 180 | 20 |
| 500 | 450 | 50 |
| 1000 | 900 | 100 |

### Main experiment scope

| protocol | families | N values | seeds | total runs |
|---|---|---|---:|---:|
| zero-shot | oxide, nitride | fixed family test sets | not seed-varied | 2 evaluations |
| fine-tuning | oxide, nitride | 10, 50, 100, 200, 500, 1000 | 5 | 60 |
| from scratch | oxide, nitride | 50, 500 | 5 | 20 |

## 1. Dataset Source And Prediction Target

### Literature-grounded context placeholders

- State that the crystal structures and target property come from the JARVIS materials dataset/repository, with citation placeholder: `[CITE: JARVIS dataset/repository paper]`.
- If needed, briefly identify ALIGNN as the crystal graph neural network family used for formation-energy prediction: `[CITE: ALIGNN foundational paper]`.

### Our implementation details

- The family datasets were derived from `dft_3d_2021`.
- The supervised target was `formation_energy_peratom`.
- Family-level summaries are recorded in:
  - `data_shared/oxide/summaries/summary.json`
  - `data_shared/nitride/summaries/summary.json`
- The family-build script is `scripts/dataset/build_res201_family_datasets.py`.

### Our experimental setup

- Oxide and nitride experiments both reuse this same target definition.
- The fixed family test sets are later reused unchanged for zero-shot, fine-tuning, and from-scratch evaluation.

### Evidence anchors

- `data_shared/oxide/summaries/summary.json`
- `data_shared/nitride/summaries/summary.json`
- `scripts/dataset/build_res201_family_datasets.py`

### TODOs

- `TODO:` confirm the exact manuscript citation(s) to use for JARVIS dataset provenance and any benchmark-split provenance sentence.

## 2. Family Definitions And Oxide/Nitride Filtering

### Literature-grounded context placeholders

- If the report wants a general motivation for family-restricted evaluation or cross-family transfer, cite that in Introduction or Discussion, not as a Methods fact.
- No citation is required for the literal filtering rule itself.

### Our implementation details

- Family assignment is element-presence based:
  - oxide: structure contains `O`
  - nitride: structure contains `N` and does not contain `O`
  - oxynitride: structure contains both `O` and `N`
- The code path is `scripts/dataset/res201_stage2_lib.py` via `classify_family(...)`.
- The dataset builder keeps oxynitrides in the oxide arm when `keep_oxynitrides_in_oxide=True`.
- Nitrides exclude all oxygen-containing structures by construction.

### Our experimental setup

- Oxynitrides remain inside the oxide family dataset (`499` structures) and are absent from the nitride family dataset.
- The oxide and nitride reports should both state the shared filtering rule once, then shift to family-specific scope.

### Evidence anchors

- `scripts/dataset/build_res201_family_datasets.py`
- `scripts/dataset/res201_stage2_lib.py`
- `data_shared/oxide/summaries/summary.json`
- `data_shared/nitride/summaries/summary.json`

### TODOs

- `TODO:` decide whether the final prose should explicitly define "oxynitride" in Methods or leave that term to a brief parenthetical.

## 3. Split Protocol And Run-Local Subset Construction

### Literature-grounded context placeholders

- If the paper explicitly credits an official JARVIS benchmark split, add the appropriate citation placeholder near the split sentence.
- Do not cite the random run-local sampling rule as literature; that is our protocol.

### Our implementation details

- Original split identities were preserved before family filtering.
- The recorded split source is `provided:manifests/dft_3d_formation_energy_peratom_splits.csv`.
- For each family, `pool = train + val` and `test` remains fixed.
- Run-local datasets are built by `scripts/shared/Prepare_Week1_Finetuning_Dataset.py`.
- For each family, each `N`, and each seed:
  - sample `N` structures from the family `pool.csv` using `np.random.default_rng(seed).permutation(...)[:N]`
  - allocate validation rows with `n_val = max(5, int(round(0.1 * N)))`
  - if `n_val >= N`, fall back to `max(1, N // 5)`
  - place validation rows first within the sampled subset, then training rows
  - append the fixed family test set unchanged
- The generated `id_prop.csv` order matters because config files set `keep_data_order=True` and pass explicit `n_train`, `n_val`, and `n_test`.

### Our experimental setup

- Fine-tuning was run at `N = 10, 50, 100, 200, 500, 1000` for both families.
- Each fine-tuning condition uses five seeds.
- From-scratch reuses the same run-local dataset roots but only for `N = 50` and `N = 500`.
- Family test sizes are fixed at `1484` for oxide and `242` for nitride.

### Evidence anchors

- `data_shared/oxide/summaries/summary.json`
- `data_shared/nitride/summaries/summary.json`
- `scripts/dataset/build_res201_family_datasets.py`
- `scripts/shared/Prepare_Week1_Finetuning_Dataset.py`
- `scripts/shared/Write_Week1_ALIGNN_Config.py`

### TODOs

- `TODO:` decide whether the paper should state the exact train/validation counts for each `N` inline, in a table, or in the appendix only.

## 4. Zero-Shot Evaluation

### Literature-grounded context placeholders

- Introduce the pretrained ALIGNN formation-energy model with `[CITE: ALIGNN foundational paper]`.
- If the final prose wants to mention pretrained model availability or packaging conventions, add a separate citation placeholder only if an exact source is confirmed.

### Our implementation details

- Zero-shot evaluation is implemented in `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py`.
- The script reads each family's fixed `test.csv` manifest and loads corresponding POSCAR files from `data_shared/<family>/structures/`.
- Predictions are obtained with `alignn.pretrained.get_prediction(model_name=args.model_name, atoms=atoms)`.
- Performance is computed with `sklearn.metrics.mean_absolute_error`.
- The script writes:
  - per-structure predictions to `Results_Before_Correction/<family>/zero_shot/predictions.csv`
  - canonical summary rows to `reports/zero_shot/zero_shot_summary.csv`

### Our experimental setup

- Zero-shot evaluation is performed once per family on the fixed family test set.
- The shared zero-shot baseline is outside `Results_Hyperparameter_Set_1/` and should be cited from `reports/zero_shot/zero_shot_summary.csv`.

### Evidence anchors

- `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py`
- `reports/zero_shot/zero_shot_summary.csv`
- `Results_Before_Correction/oxide/zero_shot/predictions.csv`
- `Results_Before_Correction/nitride/zero_shot/predictions.csv`

### TODOs

- `TODO:` decide whether the manuscript should name the model through its `model_name` string, through the local checkpoint namespace `jv_formation_energy_peratom_alignn`, or both.

## 5. Fine-Tuning Protocol

### Literature-grounded context placeholders

- Briefly frame fine-tuning as transfer from a pretrained crystal GNN checkpoint if Methods needs that context: `[CITE: ALIGNN foundational paper]`.
- Keep broader transfer-learning motivation in Introduction or Discussion unless a specific Methods citation is required.

### Our implementation details

- Fine-tuning uses the pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt` and config `jv_formation_energy_peratom_alignn/config.json`.
- The implementation is `scripts/shared/Fine_Tune_Last_Two_ALIGNN_Layers.py`.
- All parameters are frozen first.
- Only the following groups are unfrozen:
  - `gcn_layers.3`
  - `fc`
- The script keeps the overall model in `eval()` mode, then explicitly switches `model.gcn_layers[3]` and `model.fc` to training mode.
- The script includes invariant checks so that unexpected trainable parameters or BatchNorm state updates outside `gcn_layers.3` trigger errors.
- Optimization uses:
  - `AdamW`
  - `OneCycleLR`
  - `torch.nn.L1Loss()`
- The best checkpoint is selected by lowest validation `L1`.
- Final outputs include per-split prediction CSVs and `summary.json` with `best_epoch` and `test_mae_eV_per_atom`.

### Our experimental setup

- Fine-tuning is run for both families at `N = 10, 50, 100, 200, 500, 1000`.
- Each condition uses five seeds.
- Total Set 1 fine-tuning coverage is `60` runs across both families, or `30` runs per family.

### Evidence anchors

- `scripts/shared/Fine_Tune_Last_Two_ALIGNN_Layers.py`
- `Results_Hyperparameter_Set_1/README.md`
- `configs/Hyperparameter_Set_1/week2_finetune/oxide_week2_N500_seed0.finetune_last2.json`

### TODOs

- `TODO:` in final prose, be explicit that the custom training script optimizes and selects checkpoints with `L1Loss`, even though inherited config JSONs still contain `criterion: "mse"`.

## 6. From-Scratch Protocol

### Literature-grounded context placeholders

- No citation is required just to say the from-scratch runs are matched baselines.
- If the manuscript wants to frame scratch training as a control for transfer value, that framing belongs in the surrounding narrative rather than as a Methods claim.

### Our implementation details

- The implementation is `scripts/shared/Train_ALIGNN_From_Scratch.py`.
- It reuses the same run-local dataset roots as the fine-tuning workflow.
- It instantiates a fresh `ALIGNN(ALIGNNConfig(**cfg.model.model_dump()))` with no pretrained weights loaded.
- All model parameters are trainable.
- Optimization uses:
  - `AdamW`
  - `OneCycleLR`
  - `torch.nn.L1Loss()`
- The best checkpoint is selected by lowest validation `L1`.
- Outputs mirror the fine-tuning workflow and include `summary.json` with `train_protocol: "from_scratch"` and `test_mae_eV_per_atom`.

### Our experimental setup

- From-scratch baselines exist only for `N = 50` and `N = 500`.
- Each family has five seeds at each available `N`.
- Total Set 1 from-scratch coverage is `20` runs across both families, or `10` runs per family.

### Evidence anchors

- `scripts/shared/Train_ALIGNN_From_Scratch.py`
- `scripts/shared/Run_From_Scratch_Suite.py`
- `Results_Hyperparameter_Set_1/README.md`
- `configs/Hyperparameter_Set_1/week3_fromscratch/oxide_week3_fromscratch_N500_seed0.json`

### TODOs

- `TODO:` decide whether the final Methods section should state the full shared ALIGNN architecture here or move the architecture table to a compact model-spec table.

## 7. Main Narrative Hyperparameter Setting

### Literature-grounded context placeholders

- No citation is required for the chosen hyperparameter set itself.
- If a Methods sentence explains why this setting is the canonical one, cite the project brief only if the venue allows internal-project references; otherwise state it as the study design choice.

### Our implementation details

- The canonical namespace is `Results_Hyperparameter_Set_1/`.
- Set 1 uses:
  - `epochs = 50`
  - `batch_size = 16`
  - `learning_rate = 0.0001`
- Representative config files also show:
  - `neighbor_strategy = "k-nearest"`
  - `optimizer = "adamw"`
  - `scheduler = "onecycle"`
  - `cutoff = 8.0`
  - `cutoff_extra = 3.0`
  - `max_neighbors = 12`
  - `use_canonize = true`
  - `compute_line_graph = true`
  - `use_lmdb = true`
- The shared ALIGNN model config is the pretrained geometry-aware model with four ALIGNN layers, four GCN layers, hidden size `256`, and scalar output.

### Our experimental setup

- Set 1 is the main narrative because it matches the project brief and the embedding-analysis phase is linked to the same error namespace.
- Robustness namespaces can be named elsewhere, but they should not replace Set 1 in the main Methods description.

### Evidence anchors

- `Results_Hyperparameter_Set_1/README.md`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`
- `configs/Hyperparameter_Set_1/week2_finetune/oxide_week2_N500_seed0.finetune_last2.json`
- `configs/Hyperparameter_Set_1/week3_fromscratch/oxide_week3_fromscratch_N500_seed0.json`

### TODOs

- `TODO:` decide whether to report the shared model-spec details inline or in `TAB_METHODS_EXPERIMENT_SCOPE` / a dedicated model table.

## 8. Evaluation Metric And Result Aggregation

### Literature-grounded context placeholders

- No external citation is required for MAE definition.
- If the report discusses why MAE is appropriate for formation-energy regression, that can be one short explanatory sentence without forcing a citation.

### Our implementation details

- The primary reported metric is test-set mean absolute error in `eV/atom`.
- Zero-shot MAE is computed directly in `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py`.
- Fine-tuning and from-scratch summaries both record `test_mae_eV_per_atom` in their output `summary.json`.
- The training scripts use validation `L1` for checkpoint selection.

### Our experimental setup

- Fine-tuning and from-scratch conditions are repeated over five seeds where those runs exist.
- The final report should summarize repeated-run conditions consistently.

### Evidence anchors

- `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py`
- `scripts/shared/Fine_Tune_Last_Two_ALIGNN_Layers.py`
- `scripts/shared/Train_ALIGNN_From_Scratch.py`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`

### TODOs

- `TODO:` confirm whether final tables will report `mean +/- SD`, `mean +/- SEM`, or mean-only with per-seed appendix values.

## 9. Embedding-Analysis Protocol

### Literature-grounded context placeholders

- If the report briefly motivates frozen-representation analysis, cite the ALIGNN paper only for model provenance unless a stronger representation-analysis citation is later selected.
- Keep explicit cautions about PCA, t-SNE, and UMAP interpretation in Methods or figure notes, not as casual caveats added only in Results.

### Our implementation details

- Embeddings were extracted from the local pretrained ALIGNN model without retraining or modifying prior result folders.
- Model source:
  - checkpoint: `jv_formation_energy_peratom_alignn/checkpoint_300.pt`
  - config: `jv_formation_energy_peratom_alignn/config.json`
- Three embedding sources were analyzed:
  - `pre_head`
  - `last_alignn_pool`
  - `last_gcn_pool`
- Named subsets:
  - `fixed_test_set`: all oxide test structures plus all nitride test structures
  - `balanced_pool_set`: all nitride pool structures plus a random oxide pool sample of equal size using seed `42`
  - `oxide_reference_pool`: all oxide pool structures
- Family-separation statistics on raw 256D embeddings:
  - silhouette score
  - Davies-Bouldin index
  - k-nearest-neighbor family purity with `k = 15`
  - cross-validated logistic-regression AUC with `5` folds and `StandardScaler`
- Nitride distance-versus-error analysis:
  - fixed-test nitride absolute zero-shot error
  - oxide centroid Euclidean distance
  - mean Euclidean distance to the `5` nearest oxide-reference embeddings
  - Ledoit-Wolf Mahalanobis distance only as a supplemental check after covariance screening
- Hard and easy nitride groups are defined as the top and bottom `20%` of fixed-test nitrides by absolute zero-shot error.
- Statistical defaults:
  - family-separation bootstraps: `1000`
  - distance-error bootstraps: `5000`
  - distance-error permutations: `10000`
  - within-statistic Benjamini-Hochberg FDR adjustment
- Visualization policy:
  - PCA: standardize first, fit PCA on `balanced_pool_set`, project other subsets into that basis
  - t-SNE: standardize first, no PCA pre-reduction, main perplexity `30`, sensitivity `15` and `50`
  - UMAP: standardize first, no PCA pre-reduction, main `n_neighbors = 30`, `min_dist = 0.1`, sensitivity `n_neighbors = 15` and `50`
- Overlay policy:
  - t-SNE hard/easy overlay is refit directly on `balanced_pool_set + fixed-test nitride`
  - UMAP hard/easy overlay is fit on standardized `balanced_pool_set`, then fixed-test nitrides are transformed onto that manifold

### Our experimental setup

- For main text, prefer `last_alignn_pool` as the primary reported layer.
- `pre_head` and `last_gcn_pool` can support robustness claims or appendix material.
- Raw-space statistics are the inferential layer; 2D projections are descriptive support only.

### Evidence anchors

- `reports/week4_embedding_analysis/final_methods_summary.md`
- `reports/week4_embedding_analysis/methods_notes.md`
- `scripts/embedding_analysis/01_extract_structure_embeddings.py`
- `scripts/embedding_analysis/02_build_embedding_metadata.py`
- `scripts/embedding_analysis/03_plot_pca.py`
- `scripts/embedding_analysis/04_plot_tsne.py`
- `scripts/embedding_analysis/05_plot_umap.py`
- `scripts/embedding_analysis/06_quantify_family_separation.py`
- `scripts/embedding_analysis/07_analyze_nitride_distance_vs_error.py`

### TODOs

- `TODO:` decide how much of the PCA, t-SNE, and UMAP parameter detail belongs in the main Methods versus figure-specific appendix notes.

## Open manuscript decisions

- `TODO:` decide whether the shared Methods section should contain one short "Model" paragraph or a compact table.
- `TODO:` decide whether hardware / runtime environment needs to be documented; it was not part of the frozen Phase 6 source-of-truth pack.
- `TODO:` confirm the exact citation placeholders for JARVIS and pretrained ALIGNN model provenance before prose polishing.
