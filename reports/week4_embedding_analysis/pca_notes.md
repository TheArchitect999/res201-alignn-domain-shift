# PCA Notes

PCA is used here as a standalone linear baseline visualization and variance summary.

## Method

- Each embedding source is standardized dimension-wise with `StandardScaler` before PCA.
- The scaler and PCA basis are fit on `balanced_pool_set` for each embedding source.
- `fixed_test_set` and `oxide_reference_pool` are projected into the same fitted coordinate system.
- PCA uses two components and a fixed seed of `42`; the full SVD solver is deterministic.
- Axis labels in all figures report the explained variance percentages from the fitted balanced-pool PCA basis.

## Hard/Easy Nitride Definition

- Hard nitrides are the top 20% of fixed-test nitrides by absolute zero-shot error, using `ceil(0.20 * n) = 49` records.
- Easy nitrides are the bottom 20% by the same rule, also `49` records.

## Explained Variance

| Embedding source | PC1 % | PC2 % | Cumulative 2D % |
|---|---:|---:|---:|
| `pre_head` | 9.057 | 7.962 | 17.019 |
| `last_alignn_pool` | 18.126 | 9.472 | 27.598 |
| `last_gcn_pool` | 9.057 | 7.962 | 17.019 |

## Figures

- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_balanced_pool_family.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_balanced_pool_family.png`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_fixed_test_family.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_fixed_test_family.png`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_hard_easy_nitrides_on_balanced_pool.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_hard_easy_nitrides_on_balanced_pool.png`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_nitride_test_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_nitride_test_abs_error.png`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_balanced_pool_family.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_balanced_pool_family.png`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_fixed_test_family.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_fixed_test_family.png`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_hard_easy_nitrides_on_balanced_pool.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_hard_easy_nitrides_on_balanced_pool.png`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_nitride_test_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_nitride_test_abs_error.png`
- `reports/week4_embedding_analysis/figures/pca/pre_head_balanced_pool_family.pdf`
- `reports/week4_embedding_analysis/figures/pca/pre_head_balanced_pool_family.png`
- `reports/week4_embedding_analysis/figures/pca/pre_head_fixed_test_family.pdf`
- `reports/week4_embedding_analysis/figures/pca/pre_head_fixed_test_family.png`
- `reports/week4_embedding_analysis/figures/pca/pre_head_hard_easy_nitrides_on_balanced_pool.pdf`
- `reports/week4_embedding_analysis/figures/pca/pre_head_hard_easy_nitrides_on_balanced_pool.png`
- `reports/week4_embedding_analysis/figures/pca/pre_head_nitride_test_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/pca/pre_head_nitride_test_abs_error.png`
