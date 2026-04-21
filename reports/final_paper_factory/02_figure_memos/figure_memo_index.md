# Figure Memo Index

Memo numbering follows the Phase 4 core-figure order in `REPORT_PLAN.txt`. This keeps filenames stable even when memos are added incrementally.

## Completed Memos

| Memo No. | Memo File | Figure Label | Source Figure | Linked Table | Reports | Placement | Status |
|---|---|---|---|---|---|---|---|
| 01 | `fig01_study_design_schematic_memo.md` | `FIG_SCHEMATIC` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_SCHEMATIC.png` | `none` | `all` | `main_text` | complete |
| 02 | `fig02_oxide_learning_curve_memo.md` | `FIG_S1_LC_OXIDE` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_LC_OXIDE.png` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | `oxide | combined` | `main_text` | complete |
| 03 | `fig03_nitride_learning_curve_memo.md` | `FIG_S1_LC_NITRIDE` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_LC_NITRIDE.png` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | `nitride | combined` | `main_text` | complete |
| 05a | `fig05a_oxide_comparison_plot_memo.md` | `FIG_S1_COMP_OXIDE` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_COMP_OXIDE.png` | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | `oxide | combined` | `main_text` | complete |
| 05b | `fig05b_nitride_comparison_plot_memo.md` | `FIG_S1_COMP_NITRIDE` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_COMP_NITRIDE.png` | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | `nitride | combined` | `main_text` | complete |
| 06 | `fig06_oxide_lowN_parity_memo.md` | `FIG_S1_PARITY_OXIDE_N10` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N10.png` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | `oxide | combined` | `main_text` | complete |
| 07 | `fig07_oxide_highN_parity_memo.md` | `FIG_S1_PARITY_OXIDE_N1000` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N1000.png` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | `oxide | combined` | `main_text` | complete |
| 08 | `fig08_nitride_lowN_parity_memo.md` | `FIG_S1_PARITY_NITRIDE_N10` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N10.png` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | `nitride | combined` | `main_text` | complete |
| 09 | `fig09_nitride_highN_parity_memo.md` | `FIG_S1_PARITY_NITRIDE_N1000` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N1000.png` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | `nitride | combined` | `main_text` | complete |
| 10 | `fig10_embedding_pca_memo.md` | `FIG_EA_6A_PCA` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6A_PCA.png` | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | `nitride | combined | oxide_optional` | `main_text` | complete |
| 11 | `fig11_embedding_tsne_memo.md` | `FIG_EA_6B_TSNE` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6B_TSNE_P30.png` | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | `nitride | combined | oxide_optional` | `main_text` | complete |
| 12 | `fig12_embedding_umap_memo.md` | `FIG_EA_6C_UMAP` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6C_UMAP_N30.png` | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | `nitride | combined | oxide_optional` | `main_text` | complete |
| 13 | `fig13_nitride_distance_error_memo.md` | `FIG_EA_6D_BOXPLOT` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_BOXPLOT.png` | `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv` | `nitride | combined` | `main_text` | complete |
| 13b | `fig13b_nitride_distance_error_scatter_memo.md` | `FIG_EA_6D_SCATTER` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_SCATTER.png` | `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv` | `nitride | combined` | `main_text` | complete |

## Naming Convention

| Memo No. | Intended Memo Filename | Figure Role |
|---|---|---|
| 01 | `fig01_study_design_schematic_memo.md` | Study design schematic |
| 02 | `fig02_oxide_learning_curve_memo.md` | Oxide learning curve |
| 03 | `fig03_nitride_learning_curve_memo.md` | Nitride learning curve |
| 04 | `fig04_zero_shot_family_comparison_memo.md` | Zero-shot oxide vs nitride comparison |
| 05 | `fig05_transfer_benefit_comparison_memo.md` | Transfer-benefit comparison |
| 05a | `fig05a_oxide_comparison_plot_memo.md` | Oxide fine-tune vs from-scratch companion plot |
| 05b | `fig05b_nitride_comparison_plot_memo.md` | Nitride fine-tune vs from-scratch companion plot |
| 06 | `fig06_oxide_lowN_parity_memo.md` | Oxide low-`N` parity plot |
| 07 | `fig07_oxide_highN_parity_memo.md` | Oxide high-`N` parity plot |
| 08 | `fig08_nitride_lowN_parity_memo.md` | Nitride low-`N` parity plot |
| 09 | `fig09_nitride_highN_parity_memo.md` | Nitride high-`N` parity plot |
| 10 | `fig10_embedding_pca_memo.md` | PCA family-separation figure |
| 11 | `fig11_embedding_tsne_memo.md` | t-SNE family-separation figure |
| 12 | `fig12_embedding_umap_memo.md` | UMAP family-separation figure |
| 13 | `fig13_nitride_distance_error_memo.md` | Nitride error-versus-oxide-distance figure |
| 13b | `fig13b_nitride_distance_error_scatter_memo.md` | Nitride error-versus-oxide-distance scatter companion |

## Notes

- `FIG_S1_LC_OXIDE` is treated as core figure 02 because the Phase 4 minimum core-figure list places the study schematic first and the oxide learning curve second.
- `05` remains reserved for the cross-family transfer-benefit figure. The family-specific comparison plots are treated as companion memos `05a` and `05b` so the reserved core numbering stays stable.
- If the final paper uses both `FIG_EA_6D_KNN5_BOXPLOT` and `FIG_EA_6D_KNN5_SCATTER`, keep `fig13_nitride_distance_error_memo.md` as the primary memo and use `fig13b_nitride_distance_error_scatter_memo.md` as the continuous-association companion memo.
