# Family Separation Summary

These metrics quantify oxide-vs-nitride separation on the original extracted 256D structure embedding vectors.

## Scope

- Raw-space metrics are primary.
- PCA, t-SNE, and UMAP coordinates are not used in this table.
- Silhouette, Davies-Bouldin, and kNN purity use Euclidean distances in raw embedding space with no preprocessing.
- Logistic regression AUC is a frozen-embedding linear probe. It uses fold-local standardization inside cross-validation for optimization/regularization, with no dimensionality reduction and no ALIGNN retraining.
- Bootstrap confidence intervals use 1000 iterations with seed 42.

## Overall Metrics

| Dataset | Embedding level | Silhouette | Davies-Bouldin | kNN purity | Logistic AUC |
|---|---|---:|---:|---:|---:|
| `fixed_test_set` | `pre_head` | 0.1905 [0.1818, 0.1992] | 1.6937 [1.6095, 1.7811] | 0.9577 [0.9519, 0.9636] | 0.9976 [0.9956, 0.9990] |
| `fixed_test_set` | `last_alignn_pool` | 0.2392 [0.2332, 0.2456] | 1.8290 [1.7340, 1.9071] | 0.9655 [0.9603, 0.9708] | 0.9994 [0.9984, 0.9999] |
| `fixed_test_set` | `last_gcn_pool` | 0.1905 [0.1821, 0.1993] | 1.6937 [1.6081, 1.7799] | 0.9577 [0.9516, 0.9632] | 0.9973 [0.9956, 0.9988] |
| `balanced_pool_set` | `pre_head` | 0.2148 [0.2102, 0.2195] | 1.6445 [1.5976, 1.6885] | 0.9701 [0.9663, 0.9732] | 0.9989 [0.9982, 0.9994] |
| `balanced_pool_set` | `last_alignn_pool` | 0.2077 [0.2040, 0.2114] | 1.7856 [1.7432, 1.8286] | 0.9767 [0.9737, 0.9795] | 0.9993 [0.9985, 0.9999] |
| `balanced_pool_set` | `last_gcn_pool` | 0.2148 [0.2102, 0.2197] | 1.6445 [1.6002, 1.6888] | 0.9701 [0.9664, 0.9737] | 0.9989 [0.9984, 0.9994] |

## Interpretation Guardrails

- Larger silhouette, kNN purity, and logistic AUC indicate stronger family separation.
- Smaller Davies-Bouldin index indicates stronger family separation.
- Strong raw-space separation indicates that family identity is recoverable from frozen ALIGNN embeddings; it does not by itself identify a causal mechanism for domain shift.
- Projected 2D plots should be read as descriptive support, not as the primary separation evidence.
