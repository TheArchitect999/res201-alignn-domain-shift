# Final Results Summary

## Main Takeaways

Oxide and nitride structures separate clearly in pretrained ALIGNN representation space. The visualizations show family structure in PCA, t-SNE, and UMAP, while the raw-space metrics confirm that the separation is not just a 2D projection artifact.

The most useful single visualization level is `last_alignn_pool`: it is the most interpretable intermediate ALIGNN representation and gives the strongest fixed-test raw family separation among the three levels tested. On the fixed test set, `last_alignn_pool` reached silhouette `0.239`, kNN family purity `0.966`, and logistic-regression family AUC `0.999`. The final `pre_head` and `last_gcn_pool` levels gave the strongest distance-error association and appear numerically identical in these outputs, so they are useful as a sensitivity check.

PCA, t-SNE, and UMAP broadly agree that oxide/nitride family information is present in the embeddings. PCA gives the conservative linear view; t-SNE and UMAP make the nonlinear neighborhood structure more visually apparent. These projected views should be interpreted descriptively, not as the primary statistical evidence.

The mechanistic domain-shift test supports the project interpretation: poorly predicted fixed-test nitrides tend to lie farther from the oxide reference region in raw pretrained ALIGNN space. For mean 5-nearest-oxide-neighbor distance, Spearman correlations with nitride absolute error were positive across embedding levels: `0.407` for `pre_head`, `0.343` for `last_alignn_pool`, and `0.407` for `last_gcn_pool`, all with FDR-adjusted permutation q-values near `0.0001`. Hard nitrides were also farther than easy nitrides for the required centroid and kNN oxide-distance measures.

## Recommended Figure 6

- Figure 6a: `final_figures/figure6a_pca_family.png/pdf`
- Figure 6b: `final_figures/figure6b_tsne_family.png/pdf`
- Figure 6c: `final_figures/figure6c_umap_family.png/pdf`
- Figure 6d: `final_figures/figure6d_nitride_error_vs_oxide_distance.png/pdf`

Suggested caption core: PCA, direct t-SNE, and direct UMAP views of `last_alignn_pool` structure embeddings show oxide/nitride family separation in the balanced pool. Raw-space analysis links nitride zero-shot error to distance from the oxide reference manifold; higher-error nitrides tend to be farther from their nearest oxide reference neighbors.

## Caveats

- The distance-error result is associative and does not prove that oxide-manifold distance causes nitride prediction error.
- The 2D projections can distort distances and global geometry; raw 256D metrics are the primary evidence.
- Logistic family AUC shows that family identity is recoverable from frozen embeddings, but this alone does not identify the mechanism of formation-energy error.
- The final `pre_head` and `last_gcn_pool` embeddings are numerically identical in these outputs, so claims about differences between those two levels should be avoided unless the hook behavior is revisited.
- The oxide reference pool is an operational proxy for the oxide-rich reference region, not a complete physical manifold.
