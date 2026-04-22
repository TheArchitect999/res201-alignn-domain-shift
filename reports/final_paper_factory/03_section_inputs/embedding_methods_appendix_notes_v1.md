# Embedding Methods Appendix Notes v1

**Purpose:** Appendix-facing and figure-note-facing technical details for the frozen-embedding analysis. This file holds content that is too granular for main-text Methods but must be preserved for reproducibility, figure captions, and appendix sections.

**Status:** Created Phase 6 closure pass 2026-04-22.  
**Companion files:** `shared_methods_skeleton_v2.md` §9, `nitride_methods_notes_v2.md` (full embedding section), `combined_methods_notes_v2.md` (full embedding section).

**Rule:** Main-text Methods files should reference this file for detail, not reproduce it. Do not copy blocks from here back into main-text sections.

---

## 1. Embedding Extraction — Layer-Level Operational Notes

Embeddings were extracted by running each crystal structure through the frozen pretrained ALIGNN model (checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`; config `jv_formation_energy_peratom_alignn/config.json`) with gradient computation disabled. No fine-tuned or from-scratch checkpoints were used. No prior result folder was modified.

### Layer definitions

| layer name | location in model | pooling operation |
|---|---|---|
| `last_alignn_pool` | output of the last `ALIGNNConv` block (`alignn_layers[3]`) | global mean pool over nodes |
| `pre_head` | output of `model.readout` immediately before `model.fc` | global mean pool over nodes |
| `last_gcn_pool` | output of the last gated GCN block (`gcn_layers[3]`) | global mean pool over nodes |

### Near-duplicate note

In the current outputs, `pre_head` and `last_gcn_pool` produce numerically very similar embeddings. They agree on three of four fixed-test family-separation metrics; a small logistic-AUC difference exists between them. They should not be cited as two independent probes of the representation space. Main-text analysis uses `last_alignn_pool` only.

---

## 2. PCA — Full Parameter Details

- Standardize all embeddings (zero mean, unit variance) using `StandardScaler` fit on the subset being used.
- Fit PCA on `balanced_pool_set` only.
- Project `fixed_test_set` and `oxide_reference_pool` into the same PCA basis (transform only; PCA not refit on these subsets).
- Number of principal components retained: as needed for visualization (typically 2 for 2D plots).
- No dimensionality pre-reduction before PCA.

**Sensitivity note:** PCA is a linear projection. Sensitivity to component count is low for visualization purposes; PCA-based statistics are not reported as inferential quantities.

---

## 3. t-SNE — Full Parameter Details

| parameter | main setting | sensitivity setting 1 | sensitivity setting 2 |
|---|---|---|---|
| standardization | yes (`StandardScaler`) | yes | yes |
| PCA pre-reduction | none | none | none |
| perplexity | 30 | 15 | 50 |
| learning rate | auto (scikit-learn default) | auto | auto |
| n_iter | 1000 (scikit-learn default) | 1000 | 1000 |
| metric | euclidean | euclidean | euclidean |

t-SNE is run independently for each perplexity setting. t-SNE layouts are not globally comparable across runs or perplexity values; they are descriptive only.

### t-SNE hard/easy overlay policy

For the hard/easy nitride overlay figure:
- Refit t-SNE **directly on `balanced_pool_set` + fixed-test nitride structures** together.
- Hard/easy labels are then applied to the nitride points in the resulting layout.
- This ensures nitride test structures are embedded in the same manifold as the pool reference, not projected in as unseen points.

---

## 4. UMAP — Full Parameter Details

| parameter | main setting | sensitivity setting 1 | sensitivity setting 2 |
|---|---|---|---|
| standardization | yes (`StandardScaler`) | yes | yes |
| PCA pre-reduction | none | none | none |
| n_neighbors | 30 | 15 | 50 |
| min_dist | 0.1 | 0.1 | 0.1 |
| metric | euclidean | euclidean | euclidean |
| n_components | 2 | 2 | 2 |

### UMAP hard/easy overlay policy

For the hard/easy nitride overlay figure:
- Fit UMAP on standardized `balanced_pool_set`.
- Transform fixed-test nitride structures **onto the fitted manifold** (UMAP `transform` method; nitride test points are not included in the fit).
- This policy differs from t-SNE overlay; document clearly in figure notes.

**Sensitivity note:** UMAP layouts are sensitive to `n_neighbors`. The sensitivity runs at 15 and 50 are used to check whether qualitative family-separation conclusions hold across settings. These do not replace the inferential raw-space statistics.

---

## 5. Family-Separation Bootstrap Protocol

- Bootstrap resampling: 1000 iterations.
- Each bootstrap iteration: resample with replacement from `fixed_test_set` (stratified by family label); compute the four family-separation metrics on the resample.
- 95% confidence intervals reported as 2.5th–97.5th percentile of the bootstrap distribution.
- Multiple-comparison adjustment: within-statistic Benjamini-Hochberg FDR (applied separately to the set of family-separation statistics, not across all statistics in the paper).

---

## 6. Nitride Distance-Versus-Error Bootstrap and Permutation Protocol

- Distance-error bootstraps: 5000 iterations. Each iteration resamples the nitride fixed-test set with replacement; Spearman correlation between distance metric and absolute error is computed on the resample.
- Permutation test: 10 000 permutations. Each permutation randomly shuffles the error labels (keeping distances fixed) and recomputes the correlation; the p-value is the fraction of permuted correlations exceeding the observed value.
- Both bootstrap CI and permutation p-value are reported per distance metric.
- Within-statistic Benjamini-Hochberg FDR adjustment applied across the set of distance metrics tested.

---

## 7. Ledoit-Wolf Mahalanobis Distance — Covariance Screening

Ledoit-Wolf Mahalanobis distance is computed as a supplemental check only, conditioned on the covariance matrix passing a screening step:
- Fit Ledoit-Wolf shrinkage covariance estimator on the `oxide_reference_pool` embeddings.
- Check that the estimated covariance matrix is positive definite before inverting.
- If covariance screening fails, Mahalanobis distance is omitted from the reported metrics.
- Mahalanobis results are supplemental; the primary inferential metrics are centroid Euclidean and kNN Euclidean distances.

---

## 8. Named Subset Construction Details

| subset | construction | implementation note |
|---|---|---|
| `fixed_test_set` | all oxide test rows plus all nitride test rows from the fixed family test manifests | order: oxide test first, then nitride test |
| `balanced_pool_set` | all nitride pool rows plus a random sample of oxide pool rows of equal size | oxide sample uses seed 42; equal size = number of nitride pool rows (2046) |
| `oxide_reference_pool` | all oxide pool rows | no subsampling; includes all 13 507 oxide pool structures |

---

## 9. Evidence Anchors (appendix and figure-note level)

- `scripts/embedding_analysis/01_extract_structure_embeddings.py`
- `scripts/embedding_analysis/02_build_embedding_metadata.py`
- `scripts/embedding_analysis/03_plot_pca.py`
- `scripts/embedding_analysis/04_plot_tsne.py`
- `scripts/embedding_analysis/05_plot_umap.py`
- `scripts/embedding_analysis/06_quantify_family_separation.py`
- `scripts/embedding_analysis/07_analyze_nitride_distance_vs_error.py`
- `reports/week4_embedding_analysis/final_methods_summary.md`
- `reports/week4_embedding_analysis/methods_notes.md`
