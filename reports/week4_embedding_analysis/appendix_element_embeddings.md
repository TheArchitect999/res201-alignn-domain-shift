# Appendix: Element Embedding Sanity Check

This appendix-only analysis inspects the pretrained atom-embedding layer as a chemistry sanity check. It is not part of the main oxide-vs-nitride structure-level domain-shift result.

## Scope

- Source checkpoint: `jv_formation_energy_peratom_alignn/checkpoint_300.pt`.
- Source config: `jv_formation_energy_peratom_alignn/config.json`.
- Elements included: atomic numbers `Z=1..80`.
- The local ALIGNN config uses CGCNN atom features and an atom-embedding MLP rather than a literal `nn.Embedding` lookup table.
- The saved element table therefore uses each element's CGCNN feature vector passed through the pretrained `atom_embedding` MLP in eval mode.
- This is a chemistry sanity check only; structure-level raw-space analyses remain the primary domain-shift evidence.

## Projection Outputs

- PCA explained variance: PC1 `16.71%`, PC2 `11.86%`.
- t-SNE: direct on standardized element embeddings, perplexity `15`.
- UMAP: direct on standardized element embeddings, n_neighbors `15`, min_dist `0.1`.

## Strongest Property-Dimension Correlations

Permutation p-values control the max absolute correlation across all embedding dimensions within each property and correlation method.

| Property | Method | Dimension | Correlation | Max-abs permutation p | n |
|---|---|---:|---:|---:|---:|
| Atomic radius | pearson | 71 | 0.777 | 0.0002 | 80 |
| Atomic radius | pearson | 4 | 0.754 | 0.0002 | 80 |
| Atomic radius | pearson | 202 | -0.739 | 0.0002 | 80 |
| Atomic radius | spearman | 202 | -0.829 | 0.0002 | 80 |
| Atomic radius | spearman | 152 | -0.792 | 0.0002 | 80 |
| Atomic radius | spearman | 4 | 0.791 | 0.0002 | 80 |
| Electronegativity | pearson | 4 | -0.863 | 0.0002 | 75 |
| Electronegativity | pearson | 159 | -0.830 | 0.0002 | 75 |
| Electronegativity | pearson | 202 | 0.808 | 0.0002 | 75 |
| Electronegativity | spearman | 4 | -0.881 | 0.0002 | 75 |
| Electronegativity | spearman | 159 | -0.875 | 0.0002 | 75 |
| Electronegativity | spearman | 73 | 0.836 | 0.0002 | 75 |
| Valence electrons | pearson | 29 | -0.401 | 0.3081 | 80 |
| Valence electrons | pearson | 141 | -0.400 | 0.3127 | 80 |
| Valence electrons | pearson | 153 | -0.342 | 0.6203 | 80 |
| Valence electrons | spearman | 88 | 0.497 | 0.0012 | 80 |
| Valence electrons | spearman | 189 | 0.463 | 0.0042 | 80 |
| Valence electrons | spearman | 119 | -0.459 | 0.0048 | 80 |

## Files

- element_embedding_table_npy: `artifacts/embedding_analysis/element_appendix/element_embedding_table.npy`
- element_embedding_table_csv: `artifacts/embedding_analysis/element_appendix/element_embedding_table.csv`
- raw_atom_embedding_weight_npy: `artifacts/embedding_analysis/element_appendix/atom_embedding_layer0_weight.npy`
- coordinates_csv: `artifacts/embedding_analysis/element_appendix/element_embedding_coordinates.csv`
- property_correlations_csv: `reports/week4_embedding_analysis/tables/element_embedding_property_correlations.csv`
- figure_dir: `reports/week4_embedding_analysis/figures/element_appendix`
- report: `reports/week4_embedding_analysis/appendix_element_embeddings.md`

## Figures

- `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_pca.png`
- `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_pca.pdf`
- `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_tsne.png`
- `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_tsne.pdf`
- `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_umap.png`
- `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_umap.pdf`

## Interpretation Guardrail

Element-level patterns can indicate whether the pretrained atom-embedding layer encodes broad chemical trends, but they should not be interpreted as evidence for the oxide-vs-nitride structure-level mechanism.
