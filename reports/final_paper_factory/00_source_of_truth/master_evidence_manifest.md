# Master Evidence Manifest

This document freezes the current report-phase evidence surface for RES201 without modifying any result artifacts.

## Canonical Decisions

- Main-results namespace: `Results_Hyperparameter_Set_1/`
- Canonical report bundle for the main setting: `reports/Hyperparameter Set 1/`
- Canonical zero-shot namespace: `Results_Before_Correction/` with `reports/zero_shot/zero_shot_summary.csv`
- Canonical embedding-analysis package: `reports/week4_embedding_analysis/`
- Comparison namespaces: `Results_Hyperparameter_Set_2/` and `Results_Hyperparameter_Set_3/`
- Provenance-only report bundles: `reports/week2/` and `reports/provenance/colab/`

## Coverage Snapshot

| Category | Canonical source-of-truth | Comparison or appendix coverage | Verified coverage |
| --- | --- | --- | --- |
| Zero-shot evaluation | `reports/zero_shot/zero_shot_summary.csv` plus the two `Results_Before_Correction/.../zero_shot/predictions.csv` files | None | 2 families and 1726 fixed-test predictions |
| Fine-tuning main setting | Set 1 summary tables and Set 1 learning curves | Set 1 parity and training-curve manifests as appendix support | Set 1 complete with 60 runs |
| From-scratch main setting | Set 1 from-scratch summary tables and Set 1 comparison plots | Set 1 training-curve manifest as appendix support | Set 1 complete with 20 runs |
| Hyperparameter robustness | Set 2 and Set 3 summary bundles and aggregate plots | Set 2 and Set 3 parity and training-curve manifests | Set 2 complete with 60 fine-tune and 20 from-scratch runs; Set 3 complete with 60 fine-tune and 20 from-scratch runs |
| Embedding analysis | `reports/week4_embedding_analysis/final_figures/figure6a-d` plus `family_separation_metrics.csv` and `nitride_distance_error_stats.csv` | Sensitivity figures and detailed embedding tables | 4 curated main-text figures; 4 curated appendix sensitivity figures; 5 structured tables |
| Historical provenance | None | `reports/week2/` and `reports/provenance/colab/` | Retained for auditability only |

## What Belongs In Main Text

- Zero-shot summary table from `reports/zero_shot/zero_shot_summary.csv`
- Set 1 fine-tuning summary tables and the two Set 1 learning-curve figures
- Set 1 from-scratch summary tables and the two Set 1 comparison plots
- Embedding Figure 6 panels from `reports/week4_embedding_analysis/final_figures/figure6a-d`
- Embedding quantitative tables `family_separation_metrics.csv` and `nitride_distance_error_stats.csv`

## What Stays Out Of Main Text By Default

- Set 1 parity plots and Set 1 per-run training curves
- All Set 2 and Set 3 artifacts unless the paper explicitly enters a robustness or hyperparameter-sensitivity section
- Embedding sensitivity figures for alternate t-SNE perplexities and UMAP neighbor counts
- Detailed embedding tables such as per-structure distance listings and optional element-correlation tables
- Historical `reports/week2/` and `reports/provenance/colab/` bundles

## Guardrails

- Treat `Results_Hyperparameter_Set_1/` as the main-results namespace because it matches the project-brief setting `epochs=50`, `batch_size=16`, and `learning_rate=1e-4`.
- Treat Set 2 and Set 3 as robustness namespaces even though they are complete and numerically competitive.
- Keep zero-shot evidence anchored to `Results_Before_Correction/` and `reports/zero_shot/`.
- Keep embedding claims anchored to the structured Week 4 tables. Use projection plots as descriptive support rather than primary statistics.
- Do not overwrite or regenerate result artifacts during the paper phase.
