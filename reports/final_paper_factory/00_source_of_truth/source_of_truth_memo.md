# Source of Truth Memo

This memo freezes the current evidence plan for the RES201 report phase. It is not draft prose. It is a decision record for which result namespaces and artifacts should be treated as authoritative during writing.

## Canonical Namespace Decision

- Canonical main-results namespace: `Results_Hyperparameter_Set_1/`
- Canonical main-results report bundle: `reports/Hyperparameter Set 1/`
- Canonical zero-shot namespace: `Results_Before_Correction/` with `reports/zero_shot/zero_shot_summary.csv`
- Canonical embedding-analysis package: `reports/week4_embedding_analysis/`

## Why Set 1 Is Canonical

- It matches the main project-brief setting named in user context: `epochs=50`, `learning_rate=1e-4`, and `batch_size=16`.
- Repo orientation docs repeat the same mapping in `README.md`, `configs/README.md`, and `Results_Hyperparameter_Set_1/README.md`.
- The Week 4 embedding namespace decision file already points to Set 1 as the canonical error-linked namespace.

## Verified Coverage

- `Results_Hyperparameter_Set_1/`: 60 fine-tuning runs and 20 from-scratch runs.
- `Results_Hyperparameter_Set_2/`: 60 fine-tuning runs and 20 from-scratch runs.
- `Results_Hyperparameter_Set_3/`: 60 fine-tuning runs and 20 from-scratch runs.
- Set 1 parity manifest: 12 family-by-N parity plots.
- Set 2 parity manifest: 12 family-by-N parity plots.
- Set 3 parity manifest: 12 family-by-N parity plots.
- Set 1 training-curve manifests: 60 fine-tuning curves and 20 from-scratch curves.
- Set 2 training-curve manifests: 60 fine-tuning curves and 20 from-scratch curves.
- Set 3 training-curve manifests: 60 fine-tuning curves and 20 from-scratch curves.
- Embedding package: 4 curated main-text figures plus 4 curated appendix sensitivity figures plus 5 structured tables.

## Main-Text Candidates

- `reports/zero_shot/zero_shot_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- `reports/Hyperparameter Set 1/Learning Curves/Oxide Learning Curve - Hyperparameter Set 1.{png,pdf}`
- `reports/Hyperparameter Set 1/Learning Curves/Nitride Learning Curve - Hyperparameter Set 1.{png,pdf}`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- `reports/Hyperparameter Set 1/Comparison Plots/Oxide Comparison Plot - Hyperparameter Set 1.{png,pdf}`
- `reports/Hyperparameter Set 1/Comparison Plots/Nitride Comparison Plot - Hyperparameter Set 1.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/figure6a_pca_family.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/figure6b_tsne_family.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/figure6c_umap_family.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/figure6d_nitride_error_vs_oxide_distance.{png,pdf}`
- `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- `reports/week4_embedding_analysis/subset_counts.csv`

## Appendix Or Robustness Only

- `reports/Hyperparameter Set 1/Parity Plots/parity_plot_manifest.csv`
- `reports/Hyperparameter Set 1/Training Curves/Finetuning/training_curve_manifest.csv`
- `reports/Hyperparameter Set 1/Training Curves/From Scratch/training_curve_manifest.csv`
- All Set 2 summary tables and aggregate figures
- All Set 3 summary tables and aggregate figures
- All Set 2 and Set 3 parity manifests
- All Set 2 and Set 3 training-curve manifests
- `reports/week4_embedding_analysis/final_figures/appendix_tsne_family_perplexity15.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/appendix_tsne_family_perplexity50.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/appendix_umap_family_neighbors15.{png,pdf}`
- `reports/week4_embedding_analysis/final_figures/appendix_umap_family_neighbors50.{png,pdf}`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_by_structure.csv`
- `reports/week4_embedding_analysis/tables/pca_explained_variance.csv`
- `reports/week4_embedding_analysis/tables/element_embedding_property_correlations.csv`
- `reports/week2/`
- `reports/provenance/colab/`

## Ambiguities And Risks

- The local `paper_sources/RES201_Project.pdf` file could not be text-extracted with available tools. The canonical-setting decision therefore relies on the explicit user brief plus repo docs that consistently map Set 1 to `50 / 16 / 1e-4`.
- Set 1 is the brief-aligned main setting but not the numerically strongest hyperparameter namespace. Set 2 and Set 3 fine-tuning results sit closer to zero-shot. That should be framed as robustness or sensitivity rather than as a reason to replace the main namespace.
- Zero-shot evidence is intentionally split from Set 1. The authoritative zero-shot summary lives in `reports/zero_shot/` while the full prediction tables live in `Results_Before_Correction/`.
- Set 3 is complete as a report bundle but is weaker than Set 1 for error-linking provenance because local `dataset_root/` folders were not duplicated in the Set 3 results tree.
- The embedding package reports that `pre_head` and `last_gcn_pool` are numerically identical in the current outputs. Do not write claims that depend on those two layers differing materially.
- Historical `reports/week2/` and `reports/provenance/colab/` bundles are useful for audit trails only. They should not override the reorganized Set 1 to Set 3 report bundles.

## Writing Guardrail

- During the paper phase do not regenerate edit clean up or overwrite any result artifact named in this memo or in the companion inventories.
