# Combined Methods Notes v2

**Status: CLOSED FOR PROSE DRAFTING — Phase 6 closure pass applied 2026-04-22.**
Supersedes `combined_methods_notes.md`. Use with `shared_methods_skeleton_v2.md`.

The combined paper requires the most complete and neutral Methods section because it supports both family-specific results blocks and the full embedding-analysis section.

---

## Combined-paper scope

- Methods defines one shared protocol applied to two family-specific evaluation arms.
- Must not preview the oxide-nitride performance gap or nitride inertness; those are Results claims.
- Must fully specify the frozen-embedding workflow because Results IV depends on it.
- Combined paper structure is brief-specified and fixed: Introduction → Methods → Results I (oxide) → Results II (nitride) → Results III (direct comparison) → Results IV (embedding analysis) → Discussion → Conclusion → References. Methods must terminate cleanly before Results I.
- Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model". "Oxide-reference region" is acceptable only inside the embedding-distance subsection.

## Frozen decisions (combined-paper)

| Decision | Frozen value |
|---|---|
| Repeated-run convention | Mean ± SD (five random seeds) |
| Seed wording (main text) | "five random seeds" |
| Model-spec presentation | Compact paragraph; no standalone architecture subsection |
| Oxynitride treatment | Brief parenthetical for oxide arm; excluded statement for nitride arm; both in §2 |
| Train/val counts | Reference TAB_METHODS_DATASET_SPLITS_v1 |
| Embedding layer (main text) | `last_alignn_pool` |
| PCA/t-SNE/UMAP full parameters | Main-text: primary settings only; full sensitivity details in `embedding_methods_appendix_notes_v1.md` |
| Results IV cross-reference in Methods | Procedural only; do not restate Results IV subsection order in Methods |
| Domain-shift framing | Comparative framing as study-design; cite only if confirmed |

---

## Recommended subsection order

1. Study design, dataset source, and prediction target
2. Family definitions and filtering rules
3. Split inheritance and run-local subset generation
4. Zero-shot baseline
5. Partial fine-tuning protocol
6. From-scratch comparison protocol
7. Canonical hyperparameter setting and model specification
8. Evaluation metric and repeated-run summarization
9. Frozen-embedding analysis

---

## Literature-Grounded Context

### Study design and data provenance

- "Crystal structures and formation-energy targets were drawn from the JARVIS materials repository. `[CITE: JARVIS 2020 dataset/repository paper]`"
- "The transfer experiments were built on a pretrained formation-energy ALIGNN model. `[CITE: ALIGNN foundational paper]`"

### Comparative framing

- "The study compares an oxide control arm with a nitride cross-family test arm." Study-design sentence; no additional citation required unless a confirmed domain-shift citation is added.

### Embedding-analysis framing

- "To complement error-based evaluation, we analyzed frozen pretrained structure embeddings extracted from the same ALIGNN model." No additional citation beyond ALIGNN provenance is required unless a specific frozen-representation citation is confirmed.

---

## Implementation Details

### Dataset source and target

- Both family datasets derived from `dft_3d_2021`; target: `formation_energy_peratom`.
- Family summaries: `data_shared/oxide/summaries/summary.json`, `data_shared/nitride/summaries/summary.json`.

### Family definitions and filtering

- Oxide arm: structures containing `O`. Oxynitrides (containing both `O` and `N`) are retained in the oxide arm (499 structures).
- Nitride arm: structures containing `N` and not containing `O`. Oxynitrides are excluded from the nitride arm (0 retained).
- Classification path: `scripts/dataset/res201_stage2_lib.py` via `classify_family(...)` with `keep_oxynitrides_in_oxide=True`.

### Split protocol

- Original JARVIS benchmark split identities were preserved before family filtering. `[CITE: JARVIS 2020 dataset/repository paper]` (split provenance; do not overclaim benchmark formalism beyond what the repo supports).
- Split source: `provided:manifests/dft_3d_formation_energy_peratom_splits.csv`.
- For each family: `pool = train + val`; `test` remains fixed and is never resampled.
- Run-local datasets sample N structures from the family pool with the run seed, assign roughly 10% to validation (minimum 5 validation examples), and append the unchanged family test set. `keep_data_order=True` plus explicit `n_train`, `n_val`, `n_test` enforce row order inside `id_prop.csv`.

### Zero-shot baseline

- Fixed family test manifests; predictions via `alignn.pretrained.get_prediction(...)`.
- MAE recorded per family in `reports/zero_shot/zero_shot_summary.csv`.
- Per-structure outputs in `Results_Before_Correction/<family>/zero_shot/predictions.csv`.
- Not seed-varied; single evaluation per family.

### Fine-tuning protocol

- Loads pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt` and its config.
- All parameters frozen first; selectively unfreezes `gcn_layers.3` and `fc`.
- Overall model in `eval()` mode; unfrozen modules switched to training mode explicitly. Invariant checks prevent unexpected trainable parameters.
- Optimization: `AdamW`, `OneCycleLR`, `L1Loss`. (Inherited config JSONs contain `criterion: "mse"` from the original pretraining config; the custom training script overrides this with L1Loss throughout.)
- Best-checkpoint selection: lowest validation L1.

### From-scratch protocol

- Reuses same run-local dataset roots and model config; instantiates fresh ALIGNN model with no pretrained weights.
- All parameters trainable.
- Same optimizer (`AdamW`, `OneCycleLR`) and objective (`L1Loss`) as fine-tuning.
- Best-checkpoint selection: lowest validation L1.

### Hyperparameter setting and model specification

- Hyperparameter Set 1 (canonical namespace):
  - `epochs = 50`, `batch_size = 16`, `learning_rate = 1e-4`
  - `neighbor_strategy = "k-nearest"`, `cutoff = 8.0`, `cutoff_extra = 3.0`, `max_neighbors = 12`
  - `optimizer = "adamw"`, `scheduler = "onecycle"`, `use_canonize = true`, `compute_line_graph = true`, `use_lmdb = true`
- Model: four ALIGNN layers, four gated GCN layers, hidden size 256, scalar output. `[CITE: ALIGNN foundational paper]` No standalone architecture subsection needed.

### Evaluation metric and repeated-run summarization

- Primary metric: test MAE in eV/atom.
- Checkpoint selection uses validation L1 for all trained protocols.
- **Frozen convention:** multi-seed results reported as **mean ± SD** across five random seeds. Seeds referenced in prose as "five random seeds"; seed set {0, 1, 2, 3, 4} may appear in implementation notes or appendix only.
- Zero-shot is a single evaluation per family (no SD).

---

## Frozen-Embedding Analysis Protocol (full combined-paper version)

Structure embeddings were extracted from the frozen pretrained ALIGNN model (checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`) without retraining or modifying any prior result folders.

**Embedding sources:**

- `last_alignn_pool` (primary): pooled node tensor from the last ALIGNN convolutional block — the main-text layer for all analysis.
- `pre_head`: pooled output of `model.readout` before `model.fc` — appendix/robustness use only.
- `last_gcn_pool`: pooled node tensor from the last gated GCN block — appendix/robustness use only.

`pre_head` and `last_gcn_pool` are numerical near-duplicates in the current outputs and are treated as a matched pair of supporting layers, not as two independent probes.

### Named evaluation subsets

| subset | contents | role |
|---|---|---|
| `fixed_test_set` | all oxide test structures plus all nitride test structures | shared family-separation evaluation and nitride error labels |
| `balanced_pool_set` | all nitride pool structures plus an equal-size random oxide pool sample (seed 42) | balanced visualization and family-separation subset |
| `oxide_reference_pool` | all oxide pool structures | oxide-reference manifold for nitride distance tests |

### Family-separation metrics (raw 256D embedding space)

- Silhouette score
- Davies-Bouldin index
- k-nearest-neighbor family purity (k = 15)
- Logistic-regression AUC (5-fold cross-validation, `StandardScaler`)

Raw-space statistics are the inferential layer; 2D projections are descriptive support only.

### Nitride distance-versus-error metrics

- Oxide centroid Euclidean distance
- Mean Euclidean distance to the 5 nearest oxide-reference embeddings
- Supplemental Ledoit-Wolf Mahalanobis distance (after covariance screening)

The distance-versus-error analysis is procedural in Methods; no causal language belongs here.

### Hard/easy nitride groups

- Hard: top 20% of fixed-test nitrides by absolute zero-shot error
- Easy: bottom 20% of fixed-test nitrides by absolute zero-shot error

### Statistical defaults

| quantity | value |
|---|---|
| Family-separation bootstraps | 1000 |
| Distance-error bootstraps | 5000 |
| Distance-error permutations | 10 000 |
| Multiple-comparison adjustment | within-statistic Benjamini-Hochberg FDR |

### Visualization (primary settings; full parameter details in appendix)

- **PCA:** standardize first; fit on `balanced_pool_set`; project other subsets into that basis.
- **t-SNE:** standardize first; no PCA pre-reduction; main perplexity = 30.
- **UMAP:** standardize first; no PCA pre-reduction; main `n_neighbors = 30`, `min_dist = 0.1`.

Full sensitivity runs and overlay policy are in `embedding_methods_appendix_notes_v1.md`.

---

## Methods / Results boundary guardrails

- Methods defines `mean_best_epoch` as a recorded protocol quantity; Results interprets it.
- Methods explains checkpoint selection as procedure; Results interprets what low `mean_best_epoch` implies for nitride adaptation.
- Methods must NOT call nitride low-N runs inert, effectively zero-shot, or otherwise interpret adaptation behavior. These are Results II / Discussion claims.
- Methods must NOT describe MAE trends across N or across families.
- Methods must stay neutral: one shared protocol, not two competing narratives.

---

## Experimental Setup

### Family dataset scope (see TAB_METHODS_DATASET_SPLITS_v1)

| family | all | train | val | test | pool | oxynitrides |
|---|---:|---:|---:|---:|---:|---:|
| oxide | 14991 | 11960 | 1547 | 1484 | 13507 | 499 |
| nitride | 2288 | 1837 | 209 | 242 | 2046 | 0 |

### Run scope by protocol (see TAB_METHODS_EXPERIMENT_SCOPE_v1)

| protocol | oxide | nitride | seeds | notes |
|---|---|---|---:|---|
| zero-shot | fixed test set | fixed test set | not seed-varied | canonical baseline outside Set 1 namespace |
| fine-tuning | N = 10, 50, 100, 200, 500, 1000 | N = 10, 50, 100, 200, 500, 1000 | 5 | 60 total runs |
| from scratch | N = 50, 500 only | N = 50, 500 only | 5 | 20 total runs |

### Combined-paper phrasing guidance

- Keep Methods neutral: one shared protocol, not two competing stories.
- State from-scratch scope limits explicitly so Results III does not overgeneralize.
- Use `last_alignn_pool` as the main-text embedding layer.
- Do not cross-reference the Results IV subsection order in Methods; stay purely procedural.

---

## Cross-check against required Methods coverage

| required topic | combined-paper coverage |
|---|---|
| dataset source | Dataset source and target subsection |
| family definitions | Family definitions and filtering subsection |
| split protocol | Split inheritance subsection |
| oxide/nitride filtering | Family definitions and filtering subsection |
| zero-shot evaluation | Zero-shot baseline subsection |
| fine-tuning protocol | Fine-tuning protocol subsection |
| from-scratch protocol | From-scratch protocol subsection |
| hyperparameter setting | Hyperparameter setting subsection |
| evaluation metric | Evaluation metric subsection |
| embedding-analysis protocol | Frozen-embedding analysis section (full) |

---

## Stage 6 closure provenance (combined bundle)

Supersedes `combined_methods_notes.md`. Phase 6 closure pass applied 2026-04-22.

Inputs used (unchanged from v1):
- `shared_methods_skeleton_v2.md` (active shared backbone)
- `combined_paper_blueprint_v3.md`
- `shared_vs_unique_content_map_v3.md`
- `canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `table_inventory_v2.csv`
- `source_of_truth_memo_v2.md`
- All figure memos (fig01–fig13b)

Brief-fixed constraints applied: Set 1 (`epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`); oxide = structures containing `O` (oxynitrides retained); nitride = structures containing `N` and not `O` (oxynitrides excluded); from-scratch only at N = 50 and N = 500; `last_alignn_pool` as the main-text embedding layer.
