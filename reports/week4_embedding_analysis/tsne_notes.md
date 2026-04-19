# t-SNE Notes

This is the direct t-SNE analysis of standardized ALIGNN structure embeddings.

## Method

- Embedding dimensions are standardized with `StandardScaler` before every t-SNE fit.
- The standardized embeddings are fed directly into t-SNE.
- No PCA pre-reduction or other dimensionality reduction is used as preprocessing.
- `init='pca'` is used only for t-SNE initialization, as allowed by the analysis spec.
- Main run parameters: `n_components=2`, `perplexity=30`, `learning_rate='auto'`, `metric='euclidean'`, `random_state=42`.
- Sensitivity appendix runs use perplexity `15` and `50` with the same direct-standardized input policy.

## Interpretation

t-SNE mainly preserves local neighborhood relationships. Distances between separated clusters, global geometry, and apparent gaps between far-apart groups should not be interpreted too strongly.

## Overlay Fit

t-SNE has no stable out-of-sample transform in this workflow. The hard/easy nitride overlay is therefore fit directly on `balanced_pool_set` plus fixed-test nitride structures for each embedding source and perplexity.

## Hard/Easy Nitride Definition

- Hard nitrides are the top 20% of fixed-test nitrides by absolute zero-shot error, using `ceil(0.20 * n) = 49` records.
- Easy nitrides are the bottom 20%, also `49` records.

## Main Run Diagnostics

| Embedding source | Run | Perplexity | Rows | KL divergence |
|---|---|---:|---:|---:|
| `pre_head` | `fixed_test_set` | 30 | 1726 | 1.21444 |
| `pre_head` | `balanced_pool_set` | 30 | 4092 | 1.25185 |
| `last_alignn_pool` | `fixed_test_set` | 30 | 1726 | 0.98386 |
| `last_alignn_pool` | `balanced_pool_set` | 30 | 4092 | 1.06769 |
| `last_gcn_pool` | `fixed_test_set` | 30 | 1726 | 1.21444 |
| `last_gcn_pool` | `balanced_pool_set` | 30 | 4092 | 1.25185 |

## Figures

- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_balanced_pool_family_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_balanced_pool_family_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_balanced_pool_family_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_balanced_pool_family_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_balanced_pool_family_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_balanced_pool_family_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_hard_easy_nitrides_on_balanced_pool_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_nitride_test_abs_error_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_nitride_test_abs_error_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_nitride_test_abs_error_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_nitride_test_abs_error_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_nitride_test_abs_error_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_nitride_test_abs_error_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_balanced_pool_family_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_balanced_pool_family_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_balanced_pool_family_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_balanced_pool_family_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_balanced_pool_family_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_balanced_pool_family_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_fixed_test_family_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_fixed_test_family_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_fixed_test_family_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_fixed_test_family_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_fixed_test_family_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_fixed_test_family_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_hard_easy_nitrides_on_balanced_pool_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_nitride_test_abs_error_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_nitride_test_abs_error_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_nitride_test_abs_error_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_nitride_test_abs_error_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_nitride_test_abs_error_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/last_gcn_pool_nitride_test_abs_error_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_balanced_pool_family_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_balanced_pool_family_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_balanced_pool_family_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_balanced_pool_family_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_balanced_pool_family_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_balanced_pool_family_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_fixed_test_family_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_fixed_test_family_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_fixed_test_family_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_fixed_test_family_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_fixed_test_family_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_fixed_test_family_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_hard_easy_nitrides_on_balanced_pool_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_hard_easy_nitrides_on_balanced_pool_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_hard_easy_nitrides_on_balanced_pool_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_hard_easy_nitrides_on_balanced_pool_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_hard_easy_nitrides_on_balanced_pool_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_hard_easy_nitrides_on_balanced_pool_p50.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_nitride_test_abs_error_p15.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_nitride_test_abs_error_p15.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_nitride_test_abs_error_p30.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_nitride_test_abs_error_p30.png`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_nitride_test_abs_error_p50.pdf`
- `reports/week4_embedding_analysis/figures/tsne/pre_head_nitride_test_abs_error_p50.png`
