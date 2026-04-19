# Domain-Shift Hypothesis Test

Hypothesis: poorly predicted fixed-test nitrides lie farther from the oxide reference manifold in pretrained ALIGNN representation space.

## Method

- Distances are computed on the original extracted 256D structure embeddings.
- No PCA, t-SNE, UMAP, or other projection is used for the statistical tests.
- Oxide reference manifold proxy: `oxide_reference_pool` embeddings.
- Test structures: fixed-test nitrides with absolute zero-shot error metadata.
- Required distances: Euclidean distance to the oxide reference centroid and mean Euclidean distance to the k=5 nearest oxide reference embeddings.
- Ledoit-Wolf Mahalanobis distance is included only where the oxide covariance estimate passes the stability gate.
- Hard nitrides are the top 20% by absolute zero-shot error; easy nitrides are the bottom 20%.
- Bootstrap confidence intervals use 5000 iterations with seed 42.
- Permutation tests use 10000 iterations and the directional alternative that larger distances correspond to larger errors or harder nitrides.

## Interpretation

The raw-space results support the project domain-shift interpretation: nitrides with larger zero-shot errors are consistently farther from the oxide reference region across the required centroid and kNN distance measures.

This evidence is associative. It does not prove that distance from the oxide reference region causes prediction error.

## Primary Raw-Space Results

| Embedding level | Distance | Spearman rho | Pearson r | Hard - easy mean distance |
|---|---|---:|---:|---:|
| `pre_head` | Oxide centroid distance | 0.257 [0.135, 0.369], q=0.0002 | 0.304 [0.208, 0.401], q=0.0001 | 1.221 [0.594, 1.835], q=0.0002 |
| `pre_head` | Mean 5NN oxide distance | 0.407 [0.294, 0.514], q=0.0001 | 0.339 [0.245, 0.438], q=0.0001 | 0.947 [0.589, 1.314], q=0.0002 |
| `last_alignn_pool` | Oxide centroid distance | 0.173 [0.044, 0.295], q=0.0043 | 0.232 [0.117, 0.352], q=0.0003 | 0.613 [0.090, 1.099], q=0.0105 |
| `last_alignn_pool` | Mean 5NN oxide distance | 0.343 [0.221, 0.460], q=0.0001 | 0.277 [0.174, 0.389], q=0.0001 | 0.817 [0.475, 1.160], q=0.0002 |
| `last_gcn_pool` | Oxide centroid distance | 0.257 [0.134, 0.370], q=0.0001 | 0.304 [0.208, 0.399], q=0.0001 | 1.221 [0.600, 1.827], q=0.0002 |
| `last_gcn_pool` | Mean 5NN oxide distance | 0.407 [0.294, 0.513], q=0.0001 | 0.339 [0.252, 0.435], q=0.0001 | 0.947 [0.593, 1.324], q=0.0002 |

## Supplemental Mahalanobis Check

| Embedding level | Status | Covariance condition number | Shrinkage | Spearman rho |
|---|---|---:|---:|---:|
| `pre_head` | `computed_ledoit_wolf_stable` | 7.3e+03 | 0.0005 | 0.303 [0.177, 0.421], q=0.0001 |
| `last_alignn_pool` | `computed_ledoit_wolf_stable` | 3.15e+03 | 0.0007 | 0.240 [0.105, 0.363], q=0.0001 |
| `last_gcn_pool` | `computed_ledoit_wolf_stable` | 7.3e+03 | 0.0005 | 0.303 [0.182, 0.420], q=0.0001 |

## Figures

- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_centroid_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_centroid_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_centroid_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_centroid_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_mahalanobis_lw_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_mahalanobis_lw_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_mahalanobis_lw_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_mahalanobis_lw_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_centroid_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_centroid_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_centroid_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_centroid_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_knn5_mean_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_knn5_mean_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_knn5_mean_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_knn5_mean_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_mahalanobis_lw_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_mahalanobis_lw_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_mahalanobis_lw_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/last_gcn_pool_oxide_mahalanobis_lw_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_centroid_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_centroid_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_centroid_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_centroid_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_knn5_mean_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_knn5_mean_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_knn5_mean_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_knn5_mean_distance_vs_abs_error.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_mahalanobis_lw_distance_hard_easy_boxplot.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_mahalanobis_lw_distance_hard_easy_boxplot.png`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_mahalanobis_lw_distance_vs_abs_error.pdf`
- `reports/week4_embedding_analysis/figures/distance_vs_error/pre_head_oxide_mahalanobis_lw_distance_vs_abs_error.png`
