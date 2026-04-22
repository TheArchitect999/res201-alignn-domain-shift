# Nitride Results Packet

Status: quote-ready nitride evidence packet for Results, Discussion, figure captions, and table calls.
Companion file: `reports/final_paper_factory/03_section_inputs/nitride_analysis_packet.md`.

Canonical namespace: Hyperparameter Set 1 for fine-tuning and from-scratch; shared zero-shot from `reports/zero_shot/`; Week 4 embedding tables for representation analysis.

## What the nitride report is actually trying to prove

Nitride is the out-of-distribution test arm. The report should show that nitride zero-shot error is substantially worse than oxide zero-shot error, that low-`N` nitride fine-tuning is effectively inert through `N=200`, that genuine adaptation begins only at `N=500` and `N=1000` but still does not beat zero-shot, and that pretrained initialization remains far better than random initialization at the two scratch-tested nitride data sizes. The embedding evidence should then connect nitride prediction difficulty to distance from the oxide-reference region in frozen pretrained space.

## Source priority

| Evidence type | Primary source |
|---|---|
| Canonical number IDs and caveats | `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md` and `.csv` |
| Zero-shot | `reports/zero_shot/zero_shot_summary.csv` |
| Fine-tuning by `N` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` |
| Fine-tuning run details | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv` |
| From-scratch summary | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` |
| From-scratch run details | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv` |
| Figure selection and captions | `reports/final_paper_factory/02_figure_memos/` |
| Embedding metrics | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` and `nitride_distance_error_stats.csv` |

## Nitride zero-shot evidence

| Canonical ID | Quantity | Exact value | Rounded prose value | Source |
|---|---|---:|---:|---|
| `CN_ZS_NITRIDE_N_TEST` | Fixed nitride test size | `242` | `242` | `reports/zero_shot/zero_shot_summary.csv` |
| `CN_ZS_NITRIDE_MAE` | Nitride zero-shot MAE | `0.06954201496284854` | `0.0695 eV/atom` | `reports/zero_shot/zero_shot_summary.csv` |
| `CN_ZS_OXIDE_MAE` | Oxide zero-shot comparator | `0.03418360680813096` | `0.0342 eV/atom` | `reports/zero_shot/zero_shot_summary.csv` |

Draftable claim: The pretrained formation-energy ALIGNN model reaches `0.0695 eV/atom` MAE on the fixed nitride test set without target-family fine-tuning, compared with `0.0342 eV/atom` on the oxide control test set, establishing the zero-shot family gap.

## Nitride fine-tuning evidence across N

Primary table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`.

| N | Runs | Train | Val | Test | Mean test MAE | Std test MAE | Mean best epoch | Zero-shot MAE | Transfer gain vs zero-shot | Flag |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| 10 | 5 | 5 | 5 | 242 | `0.08741719760770394` | `0.01990570747172502` | `1.0` | `0.06954201496284854` | `-0.01787518264485541` | `effective_zero_shot_checkpoint` |
| 50 | 5 | 45 | 5 | 242 | `0.1172923612154343` | `0.04506890822121626` | `1.0` | `0.06954201496284854` | `-0.04775034625258576` | `effective_zero_shot_checkpoint` |
| 100 | 5 | 90 | 10 | 242 | `0.17224241466038237` | `0.09959653178355464` | `1.0` | `0.06954201496284854` | `-0.10270039969753383` | `effective_zero_shot_checkpoint` |
| 200 | 5 | 180 | 20 | 242 | `0.13919243040563894` | `0.06768563446865479` | `1.0` | `0.06954201496284854` | `-0.06965041544279041` | `effective_zero_shot_checkpoint` |
| 500 | 5 | 450 | 50 | 242 | `0.0976572126288675` | `0.01783679848489001` | `40.5` | `0.06954201496284854` | `-0.02811519766601897` | none |
| 1000 | 5 | 900 | 100 | 242 | `0.09065131140364843` | `0.013479532180190537` | `45.0` | `0.06954201496284854` | `-0.021109296440799896` | none |

Writing notes:

- "Transfer gain vs zero-shot" is negative for every nitride `N`; fine-tuning does not beat zero-shot.
- `N=10`, `50`, `100`, and `200` all have `mean_best_epoch = 1.0`; treat this as an inert low-`N` regime.
- `N=500` and `N=1000` are the only genuinely adapted nitride fine-tuning rows under Set 1.
- The numerically lowest nitride fine-tuned mean is `N=10`, `0.0874171976 +/- 0.0199057075 eV/atom`, but that row is not an adaptation success because `mean_best_epoch = 1.0`.
- The best genuinely adapted row is `N=1000`, `0.0906513114 +/- 0.0134795322 eV/atom`, still worse than zero-shot by `0.0211092964 eV/atom`.

## Nitride from-scratch comparison evidence

Primary table: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`.

Scope: from-scratch nitride baselines exist only at `N=50` and `N=500`.

| N | Runs | Train | Val | Test | From-scratch MAE | From-scratch std | Fine-tune MAE | Fine-tune best epoch | Zero-shot MAE | Scratch minus fine-tune | Scratch gain vs zero-shot |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 50 | 5 | 45 | 5 | 242 | `0.6914345625279978` | `0.016308222994666725` | `0.1172923612154343` | `1.0` | `0.06954201496284854` | `0.5741422013125635` | `-0.6218925475651493` |
| 500 | 5 | 450 | 50 | 242 | `0.3682740165490257` | `0.023305927781258735` | `0.0976572126288675` | `40.5` | `0.06954201496284854` | `0.2706168039201582` | `-0.2987320015861772` |

Draftable claim: At both scratch-tested nitride data sizes, the pretrained route is much lower in error than training from scratch. The `N=50` gap of `0.5741 eV/atom` is pretrained-initialization advantage over scratch, not fine-tuning adaptation; the `N=500` gap of `0.2706 eV/atom` is the first clean comparison where the nitride fine-tuned model has undergone real multi-epoch adaptation.

## Nitride parity plot notes

Main parity figures:

- `FIG_S1_PARITY_NITRIDE_N10`: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N10.png`
- `FIG_S1_PARITY_NITRIDE_N1000`: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N1000.png`

| Figure | Memo | On-figure MAE | RMSE | R^2 | Summary mean MAE | Summary std | Mean best epoch | Main note |
|---|---|---:|---:|---:|---:|---:|---:|---|
| `FIG_S1_PARITY_NITRIDE_N10` | `fig08_nitride_lowN_parity_memo.md` | `0.0828` | `0.1203` | `0.9841` | `0.0874171976` | `0.0199057075` | `1.0` | Early-checkpoint/inert low-`N` view; worse than zero-shot. |
| `FIG_S1_PARITY_NITRIDE_N1000` | `fig09_nitride_highN_parity_memo.md` | `0.0829` | `0.1220` | `0.9837` | `0.0906513114` | `0.0134795322` | `45.0` | Genuine adaptation and tighter variability; still worse than zero-shot. |

Aggregation guardrail: parity plot MAEs use seed-averaged predictions; summary-table MAEs are averages over individual seed MAEs. Quote both only if the distinction is explicit.

Appendix parity figures:

| Appendix figure | File |
|---|---|
| `FIG_S1_PARITY_NITRIDE_N50` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_NITRIDE_N50.png` |
| `FIG_S1_PARITY_NITRIDE_N100` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_NITRIDE_N100.png` |
| `FIG_S1_PARITY_NITRIDE_N200` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_NITRIDE_N200.png` |
| `FIG_S1_PARITY_NITRIDE_N500` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_NITRIDE_N500.png` |

## Nitride figure memo references

| Figure label | Memo file | Source/copy path | Use |
|---|---|---|---|
| `FIG_SCHEMATIC` | `fig01_study_design_schematic_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_SCHEMATIC.png` | Optional study framing. |
| `FIG_S1_LC_NITRIDE` | `fig03_nitride_learning_curve_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_LC_NITRIDE.png` | Main nitride fine-tuning curve. |
| `FIG_ZS_COMPARISON` | `fig04_zero_shot_family_comparison_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_ZS_COMPARISON.png` | Main zero-shot family-gap anchor. |
| `FIG_TRANSFER_BENEFIT` | `fig05_transfer_benefit_comparison_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.png` | Combined-paper synthesis; scope `N=50` and `N=500`. |
| `FIG_S1_COMP_NITRIDE` | `fig05b_nitride_comparison_plot_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_COMP_NITRIDE.png` | Main nitride scratch comparison. |
| `FIG_S1_PARITY_NITRIDE_N10` | `fig08_nitride_lowN_parity_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N10.png` | Main low-`N` parity. |
| `FIG_S1_PARITY_NITRIDE_N1000` | `fig09_nitride_highN_parity_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N1000.png` | Main high-`N` parity. |
| `FIG_EA_6A_PCA` | `fig10_embedding_pca_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6A_PCA.png` | Main embedding family-separation opener. |
| `FIG_EA_6B_TSNE` | `fig11_embedding_tsne_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6B_TSNE_P30.png` | Main/companion embedding projection. |
| `FIG_EA_6C_UMAP` | `fig12_embedding_umap_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6C_UMAP_N30.png` | Main/companion embedding projection. |
| `FIG_EA_6D_BOXPLOT` | `fig13_nitride_distance_error_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_BOXPLOT.png` | Primary distance-error mechanism figure. |
| `FIG_EA_6D_SCATTER` | `fig13b_nitride_distance_error_scatter_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_SCATTER.png` | Continuous distance-error companion. |

## Nitride embedding-analysis notes

For the nitride standalone report, embedding evidence is not just a bridge; it is the representational act that explains the behavioral fine-tuning failure.

Primary raw-space family-separation metrics for `last_alignn_pool` on the fixed test set:

| Metric | Scope | Value | 95% CI | Source |
|---|---|---:|---|---|
| Silhouette score | overall family labels | `0.23924905439423452` | `0.23316488129108706` to `0.24563530325262747` | `family_separation_metrics.csv` |
| Silhouette score | oxide | `0.25456374327432907` | `0.2476217597241355` to `0.26169333510196163` | `family_separation_metrics.csv` |
| Silhouette score | nitride | `0.1453358382865471` | `0.1316160216690978` to `0.15817060877426564` | `family_separation_metrics.csv` |
| Davies-Bouldin index | overall family labels | `1.8289881053584107` | `1.733953690415271` to `1.9071249603130276` | `family_separation_metrics.csv` |
| 15-NN family purity | overall family labels | `0.9655465430668212` | `0.9602925840092701` to `0.9707609115488606` | `family_separation_metrics.csv` |
| 15-NN family purity | oxide | `0.987151841868823` | `0.9832423629829289` to `0.9905671608265948` | `family_separation_metrics.csv` |
| 15-NN family purity | nitride | `0.8330578512396695` | `0.7977823691460055` to `0.8644628099173554` | `family_separation_metrics.csv` |
| Logistic-regression family AUC | overall family labels | `0.9993623443451917` | `0.9983647891559555` to `0.999944379162861` | `family_separation_metrics.csv` |

Distance-error mechanism, `last_alignn_pool`, mean 5NN oxide distance:

| Metric | Value | 95% CI / detail | Source |
|---|---:|---|---|
| Nitride test size | `242` | all fixed-test nitrides | `nitride_distance_error_stats.csv` |
| Oxide reference pool size | `13507` | oxide train+val reference pool | `subset_counts.csv` |
| Hard/easy group size | `49` / `49` | top/bottom 20% by absolute zero-shot error | `nitride_distance_error_stats.csv` |
| Hard-group mean distance | `4.598814184749344` | raw 256D `last_alignn_pool` | `nitride_distance_error_stats.csv` |
| Easy-group mean distance | `3.782052246283113` | raw 256D `last_alignn_pool` | `nitride_distance_error_stats.csv` |
| Hard-minus-easy mean gap | `0.8167619384662306` | CI `0.4745924077568131` to `1.1596977522397367`; FDR q `0.00017998200179982003` | `nitride_distance_error_stats.csv` |
| Spearman correlation | `0.34276416031728496` | CI `0.22135741152572966` to `0.4597133751250733`; FDR q `0.00012855857271415716` | `nitride_distance_error_stats.csv` |
| Pearson correlation | `0.2769539689828335` | CI `0.17406549505528343` to `0.38896664339117226`; FDR q `0.00012855857271415716` | `nitride_distance_error_stats.csv` |

Embedding guardrails:

- Use `last_alignn_pool` as the main layer.
- Treat PCA, t-SNE, and UMAP projections as descriptive, not statistical proof.
- Do not claim embedding distance causes prediction error.
- Do not put `pre_head` or `last_gcn_pool` in the main text as co-equal layers.
- Use "oxide-reference region" only in distance-context language; do not call the model "oxide-pretrained."

## Strongest canonical numbers for nitride

| Claim need | Number to quote |
|---|---|
| Nitride zero-shot benchmark | `0.0695 eV/atom` on `n=242`. |
| Oxide comparator | `0.0342 eV/atom` on `n=1484`. |
| Best numerical fine-tuned nitride mean | `0.0874 +/- 0.0199 eV/atom` at `N=10`, but `mean_best_epoch = 1.0`. |
| Best genuinely adapted nitride mean | `0.0907 +/- 0.0135 eV/atom` at `N=1000`, `mean_best_epoch = 45.0`. |
| Low-N inertness | `mean_best_epoch = 1.0` at `N=10`, `50`, `100`, and `200`. |
| Adaptation onset | `mean_best_epoch = 40.5` at `N=500`, `45.0` at `N=1000`. |
| Fine-tuning vs zero-shot conclusion | `N=1000` remains `0.0211 eV/atom` worse than zero-shot. |
| Scratch at `N=50` | `0.6914 +/- 0.0163 eV/atom`. |
| Scratch at `N=500` | `0.3683 +/- 0.0233 eV/atom`. |
| Transfer benefit at `N=50` | `0.5741 eV/atom`, pretrained-initialization advantage over scratch, not fine-tuning adaptation. |
| Transfer benefit at `N=500` | `0.2706 eV/atom`, clean adapted fine-tune versus scratch comparison. |
| Embedding family separation | `last_alignn_pool` 15-NN family purity `0.9655`; logistic AUC `0.9994`. |
| Distance-error mechanism | Spearman `0.3428`, FDR q `0.0001286`; hard-minus-easy mean gap `0.8168`, FDR q `0.0001800`. |

## Recommended main figures and tables for nitride

Main figures:

| Figure | Placement recommendation | Why |
|---|---|---|
| `FIG_ZS_COMPARISON` | Main text | Establishes the zero-shot family penalty. |
| `FIG_S1_LC_NITRIDE` | Main text | Primary evidence for inert low-`N` regime and high-`N` adaptation onset. |
| `FIG_S1_PARITY_NITRIDE_N10` | Main text, paired | Low-`N` inert parity view. |
| `FIG_S1_PARITY_NITRIDE_N1000` | Main text, paired | High-`N` adapted endpoint. |
| `FIG_S1_COMP_NITRIDE` | Main text | Scratch comparison and pretraining-value evidence. |
| `FIG_EA_6A_PCA` | Main text | Family-separation opener. |
| `FIG_EA_6B_TSNE` | Main text or companion | Local-neighborhood family-separation view. |
| `FIG_EA_6C_UMAP` | Main text or companion | Neighborhood/manifold family-separation view. |
| `FIG_EA_6D_BOXPLOT` | Main text | Primary distance-error mechanism figure. |
| `FIG_EA_6D_SCATTER` | Main text if space allows | Full-sample continuous distance-error association. |
| `FIG_SCHEMATIC` | Optional main text | Useful if the report needs a visual protocol overview. |

Main tables:

| Table label | Source | Placement recommendation |
|---|---|---|
| `TAB_ZS_SUMMARY` | `reports/zero_shot/zero_shot_summary.csv` | Main text or inline quote. |
| `TAB_S1_FT_SUMMARY_BY_N` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | Main text. |
| `TAB_S1_FS_SUMMARY` | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | Main text. |
| `TAB_EA_FAMILY_SEPARATION` | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | Main text or compact table. |
| `TAB_EA_DISTANCE_ERROR_STATS` | `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv` | Main text or compact table. |
| `TAB_METHODS_DATASET_SPLITS` | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md` | Methods. |
| `TAB_METHODS_EXPERIMENT_SCOPE` | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_EXPERIMENT_SCOPE_v1.md` | Methods. |

## Recommended appendix figures for nitride

| Appendix group | Files |
|---|---|
| Intermediate nitride parity | `FIG_S1_PARITY_NITRIDE_N50.png`, `FIG_S1_PARITY_NITRIDE_N100.png`, `FIG_S1_PARITY_NITRIDE_N200.png`, `FIG_S1_PARITY_NITRIDE_N500.png` in `reports/final_paper_factory/02_figure_memos/appendix_figures/` |
| Nitride fine-tuning training curves | `reports/Hyperparameter Set 1/Training Curves/Finetuning/nitride_training_curve_grid.png` |
| Nitride from-scratch training curves | `reports/Hyperparameter Set 1/Training Curves/From Scratch/nitride_training_curve_grid.png` |
| t-SNE sensitivity | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_TSNE_P15.png`; `FIG_EA_TSNE_P50.png` |
| UMAP sensitivity | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_UMAP_N15.png`; `FIG_EA_UMAP_N50.png` |
| Alternative embedding layers | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_PCA_PRE_HEAD.png`; `FIG_EA_PCA_LAST_GCN_POOL.png` |
| Hard/easy nitride context | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_PCA_HARD_EASY.png` |
| Distance metric robustness | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_CENTROID_BOXPLOT.png`; `FIG_EA_MAHAL_BOXPLOT.png` |
| Optional element embeddings | `FIG_EA_ELEMENT_PCA.png`; `FIG_EA_ELEMENT_TSNE.png`; `FIG_EA_ELEMENT_UMAP.png` |

## Non-claims

- Do not claim nitride fine-tuning improves over nitride zero-shot under Set 1.
- Do not claim `N <= 200` proves low-data adaptation; all four rows have `mean_best_epoch = 1.0`.
- Do not treat `CN_TRANSFER_BENEFIT_NITRIDE_N50` as adaptation gain; it is pretrained-initialization advantage over scratch.
- Do not claim scratch comparisons at untested `N`.
- Do not claim embedding plots or distances prove causality.
- Do not claim cross-hyperparameter conclusions from the Set 1 main results packet.
