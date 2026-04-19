# Final Methods Summary

Structure-level embeddings were extracted from the local pretrained ALIGNN formation-energy model without retraining, fine-tuning, downloading a new model, or modifying prior result folders. The analysis used the fixed oxide and nitride test sets, a balanced train+validation pool, and an oxide reference pool assembled earlier in the embedding-analysis workflow.

Three embedding levels were analyzed: `pre_head`, `last_alignn_pool`, and `last_gcn_pool`. Family visualizations were generated using PCA, direct t-SNE, and direct UMAP. For t-SNE and UMAP, embeddings were standardized first, then passed directly into the method; no PCA pre-reduction was used. PCA was treated as a standalone linear baseline.

Raw-space quantitative tests were performed on the original 256D embedding vectors. Oxide-vs-nitride separation was measured with silhouette score, Davies-Bouldin index, k-nearest-neighbor family purity, and cross-validated logistic-regression AUC on frozen embeddings. The domain-shift hypothesis was tested by comparing fixed-test nitride zero-shot absolute error against raw-space distance from the oxide reference pool: Euclidean distance to the oxide centroid and mean Euclidean distance to the five nearest oxide reference embeddings. Ledoit-Wolf Mahalanobis distance was included only as a supplemental check after covariance stability screening.

Hard nitrides were defined as the top 20% of fixed-test nitrides by absolute zero-shot error, and easy nitrides as the bottom 20%. Bootstrap confidence intervals and permutation tests were used where appropriate. The statistical tests use raw embedding space; the 2D projections are descriptive support only.
