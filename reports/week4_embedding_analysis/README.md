# Week 4 Embedding Analysis Package

This folder contains the report-ready embedding-analysis package for the RES201 ALIGNN domain-shift project.

## Insertable Files

- `final_methods_summary.md`: concise methods text for the report.
- `final_results_summary.md`: concise results text and interpretation.
- `final_figures/`: curated figure files with standardized names.

## Final Figures

| File | Source analysis | Intended use |
|---|---|---|
| `final_figures/figure6a_pca_family.png/pdf` | PCA, `last_alignn_pool`, balanced pool | Linear baseline family view |
| `final_figures/figure6b_tsne_family.png/pdf` | Direct t-SNE, `last_alignn_pool`, balanced pool, perplexity 30 | Nonlinear local-neighborhood view |
| `final_figures/figure6c_umap_family.png/pdf` | Direct UMAP, `last_alignn_pool`, balanced pool, `n_neighbors=30` | Nonlinear manifold-style view |
| `final_figures/figure6d_nitride_error_vs_oxide_distance.png/pdf` | Raw-space distance/error test, `last_alignn_pool`, mean 5NN oxide distance | Main mechanistic hypothesis panel |

Appendix sensitivity figures are also included for `last_alignn_pool` t-SNE perplexities 15/50 and UMAP neighbor values 15/50.

## Primary Evidence

The quantitative tests in raw 256D embedding space are the primary evidence. PCA, t-SNE, and UMAP figures are descriptive visual support and should not be used as the main statistical basis for the claim.

Key source tables:

- `tables/family_separation_metrics.csv`
- `tables/nitride_distance_error_stats.csv`
- `tables/nitride_distance_error_by_structure.csv`
