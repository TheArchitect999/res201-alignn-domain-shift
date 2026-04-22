# Oxide Results Packet

Status: quote-ready oxide evidence packet for Results, Discussion, figure captions, and table calls.
Companion file: `reports/final_paper_factory/03_section_inputs/oxide_analysis_packet.md`.

Canonical namespace: Hyperparameter Set 1 for fine-tuning and from-scratch; shared zero-shot from `reports/zero_shot/`; Week 4 embedding tables for representation analysis.

## What the oxide report is actually trying to prove

Oxide is the in-distribution control arm. The report should show that the pretrained formation-energy ALIGNN checkpoint already performs strongly on oxide zero-shot evaluation, that Set 1 fine-tuning stabilizes but never surpasses that zero-shot baseline, and that pretrained initialization is far better than training from scratch at the only two scratch-tested oxide data sizes. The oxide result is a control-side pretraining-value story, not a claim that supervised oxide fine-tuning improves the pretrained baseline.

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

## Oxide zero-shot evidence

| Canonical ID | Quantity | Exact value | Rounded prose value | Source |
|---|---|---:|---:|---|
| `CN_ZS_OXIDE_N_TEST` | Fixed oxide test size | `1484` | `1484` | `reports/zero_shot/zero_shot_summary.csv` |
| `CN_ZS_OXIDE_MAE` | Oxide zero-shot MAE | `0.03418360680813096` | `0.0342 eV/atom` | `reports/zero_shot/zero_shot_summary.csv` |

Draftable claim: The pretrained formation-energy ALIGNN model reaches `0.0342 eV/atom` MAE on the fixed oxide test set without any target-family fine-tuning, establishing a strong oxide control benchmark.

## Oxide fine-tuning evidence across N

Primary table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`.

| N | Runs | Train | Val | Test | Mean test MAE | Std test MAE | Mean best epoch | Zero-shot MAE | Transfer gain vs zero-shot |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 10 | 5 | 5 | 5 | 1484 | `0.04173159822912616` | `0.01111565197074509` | `1.0` | `0.03418360680813096` | `-0.007547991420995194` |
| 50 | 5 | 45 | 5 | 1484 | `0.05229857842801289` | `0.014787255005441039` | `18.5` | `0.03418360680813096` | `-0.018114971619881924` |
| 100 | 5 | 90 | 10 | 1484 | `0.04649868449619833` | `0.008637291877644603` | `20.0` | `0.03418360680813096` | `-0.012315077688067368` |
| 200 | 5 | 180 | 20 | 1484 | `0.04570075810414355` | `0.00861267260326788` | `39.0` | `0.03418360680813096` | `-0.011517151296012586` |
| 500 | 5 | 450 | 50 | 1484 | `0.042962743089354855` | `0.006232012753750299` | `39.0` | `0.03418360680813096` | `-0.008779136281223891` |
| 1000 | 5 | 900 | 100 | 1484 | `0.04169220256934826` | `0.005333258733114451` | `35.5` | `0.03418360680813096` | `-0.007508595761217297` |

Writing notes:

- "Transfer gain vs zero-shot" is negative for every oxide `N`; fine-tuning does not beat zero-shot.
- The `N=10` row carries `zero_shot_checkpoint_at_low_N` because `mean_best_epoch = 1.0`.
- Genuine oxide optimization begins at `N=50`, where `mean_best_epoch = 18.5`.
- The best fine-tuned mean is `N=1000`, `0.0416922026 +/- 0.0053332587 eV/atom`, still worse than zero-shot by `0.0075085958 eV/atom`.
- Cross-seed variability decreases from `0.0111156520` at `N=10` to `0.0053332587` at `N=1000`.

## Oxide from-scratch comparison evidence

Primary table: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`.

Scope: from-scratch oxide baselines exist only at `N=50` and `N=500`.

| N | Runs | Train | Val | Test | From-scratch MAE | From-scratch std | Fine-tune MAE | Zero-shot MAE | Scratch minus fine-tune | Scratch gain vs zero-shot |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 50 | 5 | 45 | 5 | 1484 | `0.5560532795358512` | `0.05234908833632355` | `0.05229857842801289` | `0.03418360680813096` | `0.50375470110783831` | `-0.5218696727277202` |
| 500 | 5 | 450 | 50 | 1484 | `0.2643359895387973` | `0.022803815863399742` | `0.042962743089354855` | `0.03418360680813096` | `0.221373246449442445` | `-0.23015238273066632` |

Draftable claim: At both scratch-tested oxide data sizes, pretrained fine-tuning is far lower in error than training from scratch, with transfer-benefit gaps of `0.504 eV/atom` at `N=50` and `0.221 eV/atom` at `N=500`.

## Oxide parity plot notes

Main parity figures:

- `FIG_S1_PARITY_OXIDE_N10`: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N10.png`
- `FIG_S1_PARITY_OXIDE_N1000`: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N1000.png`

| Figure | Memo | On-figure MAE | RMSE | R^2 | Summary mean MAE | Summary std | Mean best epoch | Main note |
|---|---|---:|---:|---:|---:|---:|---:|---|
| `FIG_S1_PARITY_OXIDE_N10` | `fig06_oxide_lowN_parity_memo.md` | `0.0391` | `0.0699` | `0.9944` | `0.0417315982` | `0.0111156520` | `1.0` | Near-pretrained low-`N` checkpoint view. |
| `FIG_S1_PARITY_OXIDE_N1000` | `fig07_oxide_highN_parity_memo.md` | `0.0383` | `0.0706` | `0.9943` | `0.0416922026` | `0.0053332587` | `35.5` | Genuine high-`N` optimization and tighter cross-seed behavior. |

Aggregation guardrail: parity plot MAEs use seed-averaged predictions; summary-table MAEs are averages over individual seed MAEs. Quote both only if the distinction is explicit.

Appendix parity figures:

| Appendix figure | File |
|---|---|
| `FIG_S1_PARITY_OXIDE_N50` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_OXIDE_N50.png` |
| `FIG_S1_PARITY_OXIDE_N100` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_OXIDE_N100.png` |
| `FIG_S1_PARITY_OXIDE_N200` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_OXIDE_N200.png` |
| `FIG_S1_PARITY_OXIDE_N500` | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_S1_PARITY_OXIDE_N500.png` |

## Oxide figure memo references

| Figure label | Memo file | Source/copy path | Use |
|---|---|---|---|
| `FIG_SCHEMATIC` | `fig01_study_design_schematic_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_SCHEMATIC.png` | Optional study framing. |
| `FIG_S1_LC_OXIDE` | `fig02_oxide_learning_curve_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_LC_OXIDE.png` | Main oxide fine-tuning curve. |
| `FIG_ZS_COMPARISON` | `fig04_zero_shot_family_comparison_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_ZS_COMPARISON.png` | Optional oxide context; main for combined/nitride. |
| `FIG_TRANSFER_BENEFIT` | `fig05_transfer_benefit_comparison_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.png` | Combined-paper synthesis; scope `N=50` and `N=500`. |
| `FIG_S1_COMP_OXIDE` | `fig05a_oxide_comparison_plot_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_COMP_OXIDE.png` | Main oxide scratch comparison. |
| `FIG_S1_PARITY_OXIDE_N10` | `fig06_oxide_lowN_parity_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N10.png` | Main low-`N` parity. |
| `FIG_S1_PARITY_OXIDE_N1000` | `fig07_oxide_highN_parity_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N1000.png` | Main high-`N` parity. |
| `FIG_EA_6A_PCA` | `fig10_embedding_pca_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6A_PCA.png` | Optional embedding bridge. |
| `FIG_EA_6B_TSNE` | `fig11_embedding_tsne_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6B_TSNE_P30.png` | Optional or appendix bridge. |
| `FIG_EA_6C_UMAP` | `fig12_embedding_umap_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6C_UMAP_N30.png` | Optional or appendix bridge. |
| `FIG_EA_6D_BOXPLOT` | `fig13_nitride_distance_error_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_BOXPLOT.png` | Combined/nitride mechanism only. |
| `FIG_EA_6D_SCATTER` | `fig13b_nitride_distance_error_scatter_memo.md` | `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_SCATTER.png` | Combined/nitride mechanism only. |

## Oxide embedding-analysis notes

For the oxide standalone report, keep this short. The evidence can support a bridge statement that pretrained embeddings separate oxide and nitride families, but the detailed distance-error argument is not an oxide main result.

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

Nitride distance-to-oxide-reference numbers, for combined-paper context only:

| Metric | Value | Source |
|---|---:|---|
| Oxide reference pool size | `13507` | `reports/week4_embedding_analysis/subset_counts.csv` |
| Nitride test size for distance-error test | `242` | `nitride_distance_error_stats.csv` |
| Hard/easy group size | `49` hard, `49` easy | `nitride_distance_error_stats.csv` |
| `last_alignn_pool` kNN5 Spearman correlation | `0.34276416031728496` | `nitride_distance_error_stats.csv` |
| Spearman FDR q-value | `0.00012855857271415716` | `nitride_distance_error_stats.csv` |
| Hard-minus-easy mean 5NN oxide distance gap | `0.8167619384662306` | `nitride_distance_error_stats.csv` |
| Hard/easy mean-gap FDR q-value | `0.00017998200179982003` | `nitride_distance_error_stats.csv` |

Embedding guardrails:

- Use `last_alignn_pool` as the main layer.
- Treat PCA, t-SNE, and UMAP projections as descriptive, not statistical proof.
- Do not claim embedding distance causes prediction error.
- Do not put `pre_head` or `last_gcn_pool` in the main text as co-equal layers.

## Strongest canonical numbers for oxide

| Claim need | Number to quote |
|---|---|
| Zero-shot control benchmark | `0.0342 eV/atom` on `n=1484`. |
| Best fine-tuned Set 1 oxide mean | `0.0417 +/- 0.0053 eV/atom` at `N=1000`. |
| Fine-tuning vs zero-shot conclusion | Best fine-tuned mean is `0.0075 eV/atom` worse than zero-shot. |
| Low-N caveat | `N=10` has `mean_best_epoch = 1.0`. |
| First genuine adaptation point | `N=50`, `mean_best_epoch = 18.5`. |
| Fine-tuning stability improvement | Std narrows from `0.0111` at `N=10` to `0.0053` at `N=1000`. |
| Scratch at `N=50` | `0.5561 +/- 0.0523 eV/atom`. |
| Scratch at `N=500` | `0.2643 +/- 0.0228 eV/atom`. |
| Transfer benefit at `N=50` | `0.5038 eV/atom` in favor of fine-tuning. |
| Transfer benefit at `N=500` | `0.2214 eV/atom` in favor of fine-tuning. |
| Embedding family separation | `last_alignn_pool` 15-NN family purity `0.9655`; logistic AUC `0.9994`. |

## Recommended main figures and tables for oxide

Main figures:

| Figure | Placement recommendation | Why |
|---|---|---|
| `FIG_S1_LC_OXIDE` | Main text | Primary fine-tuning-across-`N` evidence. |
| `FIG_S1_PARITY_OXIDE_N10` | Main text, paired | Low-`N` parity plus checkpoint caveat. |
| `FIG_S1_PARITY_OXIDE_N1000` | Main text, paired | High-`N` genuine optimization endpoint. |
| `FIG_S1_COMP_OXIDE` | Main text | Strongest oxide pretraining-over-scratch figure. |
| `FIG_SCHEMATIC` | Optional main text | Useful if the report needs a visual protocol overview. |
| `FIG_ZS_COMPARISON` | Optional main text | Useful only if oxide report includes cross-family baseline context. |
| `FIG_EA_6A_PCA` | Optional bridge or appendix | Use only if embedding bridge needs a visual anchor. |

Main tables:

| Table label | Source | Placement recommendation |
|---|---|---|
| `TAB_ZS_SUMMARY` | `reports/zero_shot/zero_shot_summary.csv` | Main text or inline quote. |
| `TAB_S1_FT_SUMMARY_BY_N` | `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | Main text. |
| `TAB_S1_FS_SUMMARY` | `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | Main text. |
| `TAB_METHODS_DATASET_SPLITS` | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md` | Methods. |
| `TAB_METHODS_EXPERIMENT_SCOPE` | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_EXPERIMENT_SCOPE_v1.md` | Methods. |
| `TAB_EA_FAMILY_SEPARATION` | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | Appendix or combined-paper Results IV. |

## Recommended appendix figures for oxide

| Appendix group | Files |
|---|---|
| Intermediate oxide parity | `FIG_S1_PARITY_OXIDE_N50.png`, `FIG_S1_PARITY_OXIDE_N100.png`, `FIG_S1_PARITY_OXIDE_N200.png`, `FIG_S1_PARITY_OXIDE_N500.png` in `reports/final_paper_factory/02_figure_memos/appendix_figures/` |
| Oxide fine-tuning training curves | `reports/Hyperparameter Set 1/Training Curves/Finetuning/oxide_training_curve_grid.png` |
| Oxide from-scratch training curves | `reports/Hyperparameter Set 1/Training Curves/From Scratch/oxide_training_curve_grid.png` |
| t-SNE sensitivity | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_TSNE_P15.png`; `FIG_EA_TSNE_P50.png` |
| UMAP sensitivity | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_UMAP_N15.png`; `FIG_EA_UMAP_N50.png` |
| Alternative embedding layers | `reports/final_paper_factory/02_figure_memos/appendix_figures/FIG_EA_PCA_PRE_HEAD.png`; `FIG_EA_PCA_LAST_GCN_POOL.png` |
| Optional element embeddings | `FIG_EA_ELEMENT_PCA.png`; `FIG_EA_ELEMENT_TSNE.png`; `FIG_EA_ELEMENT_UMAP.png` |

## Non-claims

- Do not claim oxide fine-tuning improves over oxide zero-shot under Set 1.
- Do not claim `N=10` proves low-data adaptation; it is a `mean_best_epoch = 1.0` checkpoint.
- Do not claim scratch comparisons at untested `N`.
- Do not claim the embedding plots prove causality.
- Do not claim cross-hyperparameter conclusions from the Set 1 main results packet.
