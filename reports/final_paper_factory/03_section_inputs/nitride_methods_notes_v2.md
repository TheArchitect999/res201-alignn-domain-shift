# Nitride Methods Notes v2

**Status: CLOSED FOR PROSE DRAFTING — Phase 6 closure pass applied 2026-04-22.**
Supersedes `nitride_methods_notes.md`. Use with `shared_methods_skeleton_v2.md`.

The nitride report is the cross-family transfer test paper. It should preserve the shared experimental pipeline while giving full methodological space to the frozen-embedding analysis, because this report relies more heavily on representational evidence.

---

## Nitride-specific scope

- Report identity: out-of-distribution / cross-family transfer test paper.
- Methods define the common data/model protocol without smuggling in nitride outcome claims.
- Keep nitride interpretation in Results and Discussion; Methods explains only what was evaluated and how.
- Nitride Methods must match `nitride_report_blueprint_v3.md` row 2 (Set 1, nitride test-set size, canonical run counts, low-N caveat policy as protocol-level definitions only).
- Do not call the pretrained checkpoint "oxide-pretrained". Use "pretrained formation-energy ALIGNN model". "Oxide-reference region" is acceptable only inside the embedding-distance subsection.

## Frozen decisions (nitride-specific)

| Decision | Frozen value |
|---|---|
| Repeated-run convention | Mean ± SD (five random seeds) |
| Oxynitride treatment | Excluded from nitride arm; state once, no separate subsection |
| Train/val counts | Reference TAB_METHODS_DATASET_SPLITS_v1; not repeated inline |
| Embedding machinery in main text | Fuller protocol retained (family-separation metrics, distance-to-oxide, hard/easy definition) |
| PCA/t-SNE/UMAP parameters | Main-text: state method names and primary settings only; full parameter sensitivity in `embedding_methods_appendix_notes_v1.md` |
| Overlay policy details | In `embedding_methods_appendix_notes_v1.md` |
| Bootstrap/permutation counts | State totals in main text (1000 / 5000 / 10 000); operational notes in appendix file |
| Domain-shift framing | Study-design wording; cite transfer/domain-shift literature only if confirmed |
| Hard/easy nitride definition | Nitride-only Methods sentence (not shared skeleton) |
| oxide_reference_pool rationale | Brief definitional sentence in Methods; causal interpretation in Results |
| Low-N interpretation (effective zero-shot) | Results/Discussion only — not in Methods |

---

## Recommended subsection order

1. Dataset source and nitride-family construction
2. Shared split protocol and nitride run-local sampling
3. Zero-shot nitride evaluation
4. Fine-tuning and from-scratch training protocols
5. Main narrative hyperparameter setting, model specification, and evaluation metric
6. Frozen-embedding analysis protocol (full)

---

## Literature-Grounded Context

### Dataset and model provenance

- "Crystal structures and formation-energy targets were drawn from the JARVIS materials repository. `[CITE: JARVIS 2020 dataset/repository paper]`"
- "Predictions and transfer experiments were built on a pretrained formation-energy ALIGNN model. `[CITE: ALIGNN foundational paper]`"

### Nitride-study framing

- "The nitride arm was used as the cross-family test setting for transfer evaluation." Study-design wording; no additional literature citation required in Methods unless a confirmed domain-shift citation is selected.

---

## Implementation Details

### Dataset source

- Nitride data derived from `dft_3d_2021`; target: `formation_energy_peratom`.
- Summary: `data_shared/nitride/summaries/summary.json`.

### Family definitions and filtering

- Nitrides: structures containing `N` and not containing `O`. Oxygen-containing structures are excluded by construction; the nitride summary records 0 oxynitrides.
- If oxide is mentioned in nitride Methods, limit to one shared counterpart definition: oxides contain `O`.

### Split protocol

- Nitride split identities inherit the shared JARVIS benchmark split mapping before family filtering.
- Nitride counts: all = 2288, train = 1837, val = 209, test = 242, pool = 2046.
- See TAB_METHODS_DATASET_SPLITS_v1 for the manuscript-facing table.
- Run-local nitride subsets sample N structures from the nitride pool and reuse the fixed nitride test set unchanged.

### Zero-shot evaluation

- Evaluate the pretrained model on the fixed nitride test set (`data_shared/nitride/manifests/test.csv`; n = 242).
- Results cited from `reports/zero_shot/zero_shot_summary.csv` and `Results_Before_Correction/nitride/zero_shot/predictions.csv`.

### Fine-tuning protocol

- Shared partial-update protocol (see `shared_methods_skeleton_v2.md` §5):
  - pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`
  - freeze all; unfreeze `gcn_layers.3` and `fc`
  - `AdamW`, `OneCycleLR`, `L1Loss`; best checkpoint by validation L1
- Nitride fine-tuning: N = 10, 50, 100, 200, 500, 1000; five random seeds each.

### From-scratch protocol

- Reuses same dataset roots and config template; initializes model weights randomly.
- Nitride from-scratch: N = 50 and N = 500 only; five random seeds each.

### Hyperparameter setting and model specification

- Hyperparameter Set 1: `epochs = 50`, `batch_size = 16`, `learning_rate = 1e-4`.
- Model: four ALIGNN layers, four gated GCN layers, hidden size 256, scalar output. `[CITE: ALIGNN foundational paper]`
- No standalone architecture subsection needed.

### Evaluation metric

- Primary metric: test MAE in eV/atom.
- Multi-seed conditions reported as **mean ± SD** across five random seeds.
- Zero-shot is a single evaluation (no SD).

---

## Frozen-Embedding Analysis Protocol (full nitride version)

Structure embeddings were extracted from the frozen pretrained ALIGNN model — specifically from checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt` — without retraining or modifying any prior result folders. Extraction did not alter fine-tuning or from-scratch outputs.

**Primary embedding layer:** `last_alignn_pool` — the pooled node tensor returned by the last ALIGNN convolutional block. For main-text analysis, this is the only layer discussed. Two additional layers were extracted as robustness controls:

- `pre_head`: pooled output of `model.readout` immediately before `model.fc`
- `last_gcn_pool`: pooled node tensor from the last gated GCN block (`gcn_layers[3]`)

In the current outputs, `pre_head` and `last_gcn_pool` are numerical near-duplicates of each other. They are reserved for appendix/robustness sections and are not treated as independent probes.

### Named evaluation subsets

| subset | definition | main role |
|---|---|---|
| `fixed_test_set` | all oxide test structures plus all nitride test structures | family-separation evaluation and nitride error metadata |
| `balanced_pool_set` | all nitride pool structures plus an equal-size random oxide pool sample (seed 42) | balanced visualization and family-separation subset |
| `oxide_reference_pool` | all oxide pool structures | oxide-reference manifold for nitride distance analysis |

The `oxide_reference_pool` is defined as all oxide pool structures; it provides the reference manifold against which nitride embedding distances are measured. Interpretation of what those distances imply for transfer is addressed in Results.

### Family-separation metrics (raw 256D embedding space)

- Silhouette score
- Davies-Bouldin index
- k-nearest-neighbor family purity (k = 15)
- Logistic-regression AUC (5-fold cross-validation, `StandardScaler`)

Raw-space statistics are the inferential layer. PCA, t-SNE, and UMAP are descriptive support only.

### Nitride distance-versus-error metrics

- Oxide centroid Euclidean distance
- Mean Euclidean distance to the 5 nearest oxide-reference embeddings
- Supplemental Ledoit-Wolf Mahalanobis distance (after covariance screening passes)

The distance-versus-error analysis is procedural in Methods; no causal language should appear here.

### Hard/easy nitride groups (nitride-specific definition)

- Hard nitrides: top 20% of fixed-test nitrides by absolute zero-shot error
- Easy nitrides: bottom 20% of fixed-test nitrides by absolute zero-shot error

This definition is used to characterize the embedding distribution relative to prediction difficulty. It applies to the nitride report only (not the shared skeleton).

### Statistical defaults

| quantity | value |
|---|---|
| Family-separation bootstraps | 1000 |
| Distance-error bootstraps | 5000 |
| Distance-error permutations | 10 000 |
| Multiple-comparison adjustment | within-statistic Benjamini-Hochberg FDR |

### Visualization (primary settings only; full details in appendix)

- **PCA:** standardize first; fit on `balanced_pool_set`; project other subsets into that basis.
- **t-SNE:** standardize first; no PCA pre-reduction; main perplexity = 30.
- **UMAP:** standardize first; no PCA pre-reduction; main `n_neighbors = 30`, `min_dist = 0.1`.

Sensitivity runs (perplexity 15 and 50 for t-SNE; `n_neighbors` 15 and 50 for UMAP) and overlay policy details are in `embedding_methods_appendix_notes_v1.md`.

---

## Methods / Results boundary guardrails

- Methods defines `mean_best_epoch` as a recorded quantity; Results interprets what its values mean.
- Methods defines checkpoint selection; Results interprets what low `mean_best_epoch` at low N implies.
- Methods must NOT state that nitride fine-tuning is inert, effectively zero-shot, or that no meaningful adaptation occurred at low N. Those are Results claims.
- Methods must NOT describe MAE trends or adaptation trajectories.
- Keep all distance-versus-error analysis procedural; causal language belongs in Results IV or Discussion.

---

## Experimental Setup

### Nitride experiment scope (see TAB_METHODS_EXPERIMENT_SCOPE_v1)

| protocol | nitride conditions | seeds | notes |
|---|---|---:|---|
| zero-shot | fixed nitride test set (n = 242) | not seed-varied | pretrained baseline |
| fine-tuning | N = 10, 50, 100, 200, 500, 1000 | 5 | 30 total nitride runs |
| from scratch | N = 50, 500 only | 5 | 10 total nitride runs |

### Nitride-specific phrasing guidance

- Use "pretrained formation-energy ALIGNN model"; never "oxide-pretrained model".
- Do not write low-N nitride behavior into Methods as if it were an interpretation; state protocol scope only.
- Keep the distance-to-oxide analysis procedural; causal discussion in Results.

---

## Cross-check against required Methods coverage

| required topic | nitride-facing coverage |
|---|---|
| dataset source | Dataset source subsection |
| family definitions | Family definitions and filtering subsection |
| split protocol | Split protocol subsection |
| oxide/nitride filtering | Family definitions and filtering subsection |
| zero-shot evaluation | Zero-shot evaluation subsection |
| fine-tuning protocol | Fine-tuning protocol subsection |
| from-scratch protocol | From-scratch protocol subsection |
| hyperparameter setting | Hyperparameter setting subsection |
| evaluation metric | Evaluation metric subsection |
| embedding-analysis protocol | Frozen-embedding analysis section (full) |

---

## Stage 6 closure provenance (nitride bundle)

Supersedes `nitride_methods_notes.md`. Phase 6 closure pass applied 2026-04-22.

Inputs used (unchanged from v1):
- `shared_methods_skeleton_v2.md` (active shared backbone)
- `nitride_report_blueprint_v3.md`
- `canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `table_inventory_v2.csv`
- `source_of_truth_memo_v2.md`
- Figure memos: `fig01`, `fig03`, `fig04`, `fig05b`, `fig08`, `fig09`, `fig10`, `fig11`, `fig12`, `fig13`, `fig13b`

Brief-fixed constraints applied: Set 1 (`epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`); nitride = structures containing `N` and not `O` (oxynitrides excluded, 0 retained); from-scratch only at N = 50 and N = 500; `last_alignn_pool` as the main-text embedding layer.
