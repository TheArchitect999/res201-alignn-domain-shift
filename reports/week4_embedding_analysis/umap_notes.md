# UMAP Notes

This is the direct UMAP analysis of standardized ALIGNN structure embeddings.

## Method

- Embedding dimensions are standardized with `StandardScaler` before every UMAP fit.
- The standardized embeddings are fed directly into UMAP.
- No PCA pre-reduction or other dimensionality reduction is used as preprocessing.
- Main run parameters: `n_components=2`, `n_neighbors=30`, `min_dist=0.1`, `metric='euclidean'`, `random_state=42`.
- Sensitivity appendix runs use `n_neighbors=15` and `n_neighbors=50` with the same direct-standardized input policy.

## Interpretation

UMAP is used here as a descriptive nonlinear embedding view and not as proof of a causal mechanism.

## Overlay Fit

For the hard/easy nitride overlay, UMAP is fit on the standardized `balanced_pool_set` manifold. Fixed-test nitride embeddings are standardized with the balanced-pool scaler and transformed onto that fitted UMAP view.

## Hard/Easy Nitride Definition

- Hard nitrides are the top 20% of fixed-test nitrides by absolute zero-shot error, using `ceil(0.20 * n) = 49` records.
- Easy nitrides are the bottom 20%, also `49` records.

## Main Run Diagnostics

| Embedding source | Run | n_neighbors | min_dist | Rows | Transform mode |
|---|---|---:|---:|---:|---|
| `pre_head` | `fixed_test_set` | 30 | 0.100 | 1726 | `fit_transform` |
| `pre_head` | `balanced_pool_set` | 30 | 0.100 | 4092 | `fit_transform` |
| `last_alignn_pool` | `fixed_test_set` | 30 | 0.100 | 1726 | `fit_transform` |
| `last_alignn_pool` | `balanced_pool_set` | 30 | 0.100 | 4092 | `fit_transform` |
| `last_gcn_pool` | `fixed_test_set` | 30 | 0.100 | 1726 | `fit_transform` |
| `last_gcn_pool` | `balanced_pool_set` | 30 | 0.100 | 4092 | `fit_transform` |

## Figures

- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_balanced_pool_family_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_balanced_pool_family_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_balanced_pool_family_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_balanced_pool_family_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_balanced_pool_family_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_balanced_pool_family_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_nitride_test_abs_error_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_nitride_test_abs_error_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_nitride_test_abs_error_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_nitride_test_abs_error_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_nitride_test_abs_error_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_nitride_test_abs_error_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_balanced_pool_family_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_balanced_pool_family_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_balanced_pool_family_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_balanced_pool_family_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_balanced_pool_family_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_balanced_pool_family_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_fixed_test_family_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_fixed_test_family_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_fixed_test_family_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_fixed_test_family_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_fixed_test_family_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_fixed_test_family_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_n50.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_nitride_test_abs_error_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_nitride_test_abs_error_n15.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_nitride_test_abs_error_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_nitride_test_abs_error_n30.png`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_nitride_test_abs_error_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/last_gcn_pool_nitride_test_abs_error_n50.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_balanced_pool_family_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_balanced_pool_family_n15.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_balanced_pool_family_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_balanced_pool_family_n30.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_balanced_pool_family_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_balanced_pool_family_n50.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_fixed_test_family_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_fixed_test_family_n15.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_fixed_test_family_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_fixed_test_family_n30.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_fixed_test_family_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_fixed_test_family_n50.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_hard_easy_nitrides_on_balanced_pool_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_hard_easy_nitrides_on_balanced_pool_n15.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_hard_easy_nitrides_on_balanced_pool_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_hard_easy_nitrides_on_balanced_pool_n30.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_hard_easy_nitrides_on_balanced_pool_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_hard_easy_nitrides_on_balanced_pool_n50.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_nitride_test_abs_error_n15.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_nitride_test_abs_error_n15.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_nitride_test_abs_error_n30.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_nitride_test_abs_error_n30.png`
- `reports/week4_embedding_analysis/figures/umap/pre_head_nitride_test_abs_error_n50.pdf`
- `reports/week4_embedding_analysis/figures/umap/pre_head_nitride_test_abs_error_n50.png`
