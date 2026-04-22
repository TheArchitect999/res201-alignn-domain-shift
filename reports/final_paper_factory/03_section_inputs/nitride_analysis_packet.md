# Nitride Analysis Packet

Status: section-input packet for nitride report writing, assembled from the current v2/v3 source-of-truth files.
Companion file: `reports/final_paper_factory/03_section_inputs/nitride_results_packet.md`.

Use this packet with:

- `reports/final_paper_factory/01_blueprints/nitride_report_blueprint_v3.md`
- `reports/final_paper_factory/03_section_inputs/nitride_methods_notes_v2.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`
- `reports/final_paper_factory/02_figure_memos/figure_memo_index.md`
- `reports/final_paper_factory/02_figure_memos/figure_queue.md`

Canonical policy: the nitride report uses Hyperparameter Set 1 for main fine-tuning and from-scratch results. Zero-shot is the shared pretrained baseline from `reports/zero_shot/`. Set 2 and Set 3 are robustness-only namespaces.

## What the nitride report is actually trying to prove

The nitride report is the out-of-distribution test paper. It should prove that the pretrained formation-energy ALIGNN model starts from a clear nitride penalty relative to the oxide control, that low-`N` nitride fine-tuning is operationally inert through `N=200`, and that meaningful adaptation begins only at `N=500` and `N=1000` while still failing to recover the zero-shot baseline. It should also show that pretraining remains valuable relative to random initialization, but with the critical `N=50` caveat: that gap is pretrained-initialization advantage over scratch, not fine-tuning adaptation. The embedding section closes the loop by linking nitride difficulty to distance from the oxide-reference region in frozen pretrained space.

## Core nitride story

1. Zero-shot already shows the family penalty: nitride zero-shot MAE is `0.0695420150 eV/atom` on `242` test structures, roughly double the oxide zero-shot MAE of `0.0341836068 eV/atom`.
2. Fine-tuning never beats nitride zero-shot under Set 1.
3. Nitride fine-tuning is effectively inert at `N=10`, `50`, `100`, and `200`, because `mean_best_epoch = 1.0` at all four sizes.
4. Genuine nitride adaptation begins at `N=500` (`mean_best_epoch = 40.5`) and `N=1000` (`mean_best_epoch = 45.0`), but even these rows remain above zero-shot.
5. From-scratch training is much worse than the pretrained route at `N=50` and `N=500`, but from-scratch comparisons exist only at those two data sizes.
6. Embedding analysis is main-text evidence in the nitride report: frozen `last_alignn_pool` embeddings separate families, and nitride zero-shot error increases with mean 5-nearest-oxide-neighbor distance.

## Nitride zero-shot evidence

Primary source: `reports/zero_shot/zero_shot_summary.csv`.

| Evidence item | Canonical value | Use in prose |
|---|---:|---|
| Nitride fixed test size | `242` | Establishes evaluation scale. |
| Nitride zero-shot MAE | `0.06954201496284854 eV/atom` | Baseline for all nitride fine-tuning comparisons. |
| Oxide zero-shot comparator | `0.03418360680813096 eV/atom` | Shows the family-level penalty at the pretrained starting point. |
| Model | `jv_formation_energy_peratom_alignn` | Call it the "pretrained formation-energy ALIGNN model"; do not call it "oxide-pretrained." |
| Prediction source | `Results_Before_Correction/nitride/zero_shot/predictions.csv` | Appendix or audit support. |

Interpretation: zero-shot is the cleanest behavioral evidence that nitrides are harder for the pretrained model than oxides before any target-family training. In the nitride report, this should open the behavioral results act.

## Nitride fine-tuning evidence across N

Primary source: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`.

| N | Mean test MAE | Std test MAE | Mean best epoch | Gap vs zero-shot | Writing read |
|---:|---:|---:|---:|---:|---|
| 10 | `0.0874171976` | `0.0199057075` | `1.0` | `+0.0178751826` worse | Effective zero-shot checkpoint; not meaningful adaptation. |
| 50 | `0.1172923612` | `0.0450689082` | `1.0` | `+0.0477503463` worse | Effective zero-shot checkpoint; also has scratch-comparison caveat. |
| 100 | `0.1722424147` | `0.0995965318` | `1.0` | `+0.1027003997` worse | Worst mean and largest variance; still inert by checkpoint selection. |
| 200 | `0.1391924304` | `0.0676856345` | `1.0` | `+0.0696504154` worse | Still inert; no meaningful low-`N` adaptation through `N=200`. |
| 500 | `0.0976572126` | `0.0178367985` | `40.5` | `+0.0281151977` worse | First meaningful adaptation regime, but still worse than zero-shot. |
| 1000 | `0.0906513114` | `0.0134795322` | `45.0` | `+0.0211092964` worse | Best genuinely adapted high-`N` row, still above zero-shot. |

Narrative use: split the curve into two acts. The low-`N` act (`N <= 200`) is inert fine-tuning, not successful adaptation. The high-`N` act (`N=500`, `1000`) is real adaptation, but only partial recovery. Do not describe any nitride fine-tuning row as outperforming zero-shot.

## Nitride from-scratch comparison evidence

Primary sources:

- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`

Coverage guardrail: from-scratch nitride baselines exist only at `N=50` and `N=500`. Do not imply scratch comparisons at `N=10`, `100`, `200`, or `1000`.

| N | Fine-tune mean MAE | Mean best epoch | From-scratch mean MAE | From-scratch std | Scratch minus fine-tune | Writing read |
|---:|---:|---:|---:|---:|---:|---|
| 50 | `0.1172923612` | `1.0` | `0.6914345625` | `0.0163082230` | `0.5741422013` | Pretrained-initialization advantage over scratch, not fine-tuning adaptation. |
| 500 | `0.0976572126` | `40.5` | `0.3682740165` | `0.0233059278` | `0.2706168039` | Clean comparison where fine-tuned model has real adaptation. |

Narrative use: this section should say pretraining remains practically valuable for nitrides, because the pretrained route is far better than random initialization. It should also say that the `N=50` gap is semantically different from the `N=500` gap: `N=50` reflects initialization advantage because the selected checkpoint is effectively epoch 1, while `N=500` reflects a genuinely adapted fine-tuned model.

## Nitride parity plot notes

Primary figure memos:

- `reports/final_paper_factory/02_figure_memos/fig08_nitride_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig09_nitride_highN_parity_memo.md`

Main-text parity pair: `FIG_S1_PARITY_NITRIDE_N10` and `FIG_S1_PARITY_NITRIDE_N1000`.

| Figure | On-figure metrics | Linked summary row | Correct interpretation |
|---|---|---|---|
| `FIG_S1_PARITY_NITRIDE_N10` | `MAE = 0.0828`, `RMSE = 0.1203`, `R^2 = 0.9841` | `mean_test_mae = 0.0874`, `std = 0.0199`, `mean_best_epoch = 1.0` | Broad parity trend remains, but this is an early-checkpoint/inert low-`N` view that underperforms zero-shot. |
| `FIG_S1_PARITY_NITRIDE_N1000` | `MAE = 0.0829`, `RMSE = 0.1220`, `R^2 = 0.9837` | `mean_test_mae = 0.0907`, `std = 0.0135`, `mean_best_epoch = 45.0` | Genuine high-`N` adaptation and better reproducibility, but not a zero-shot recovery. |

Important aggregation note: parity figure MAEs are computed after averaging predictions across seeds, while the summary-table MAEs average individual seed MAEs. Keep those values distinct.

Use the parity pair to show that larger `N` changes the checkpoint regime and reproducibility more than it changes headline parity error. The `N=1000` panel is not oxide-like; it is a more stable but still shifted endpoint.

## Nitride figure memo references

| Memo | Figure label | Nitride report role |
|---|---|---|
| `fig01_study_design_schematic_memo.md` | `FIG_SCHEMATIC` | Optional Methods/Introduction framing. |
| `fig03_nitride_learning_curve_memo.md` | `FIG_S1_LC_NITRIDE` | Main behavioral figure for inert low-`N` regime and high-`N` adaptation onset. |
| `fig04_zero_shot_family_comparison_memo.md` | `FIG_ZS_COMPARISON` | Main zero-shot domain-shift baseline figure. |
| `fig05_transfer_benefit_comparison_memo.md` | `FIG_TRANSFER_BENEFIT` | Combined-paper synthesis; useful context but not required as nitride standalone main figure. |
| `fig05b_nitride_comparison_plot_memo.md` | `FIG_S1_COMP_NITRIDE` | Main nitride fine-tune vs from-scratch figure. |
| `fig08_nitride_lowN_parity_memo.md` | `FIG_S1_PARITY_NITRIDE_N10` | Main low-`N` parity snapshot with inert-checkpoint caveat. |
| `fig09_nitride_highN_parity_memo.md` | `FIG_S1_PARITY_NITRIDE_N1000` | Main high-`N` parity endpoint. |
| `fig10_embedding_pca_memo.md` | `FIG_EA_6A_PCA` | Main representational opening figure; family separation in raw pretrained space. |
| `fig11_embedding_tsne_memo.md` | `FIG_EA_6B_TSNE` | Main/companion local-neighborhood embedding view. |
| `fig12_embedding_umap_memo.md` | `FIG_EA_6C_UMAP` | Main/companion neighborhood embedding view. |
| `fig13_nitride_distance_error_memo.md` | `FIG_EA_6D_BOXPLOT` | Primary mechanism figure: hard nitrides farther from oxide-reference region. |
| `fig13b_nitride_distance_error_scatter_memo.md` | `FIG_EA_6D_SCATTER` | Continuous-association companion for all 242 nitrides. |

## Nitride embedding-analysis notes

Primary sources:

- `reports/week4_embedding_analysis/final_results_summary.md`
- `reports/week4_embedding_analysis/final_methods_summary.md`
- `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- `reports/week4_embedding_analysis/subset_counts.csv`

Main-text embedding layer: `last_alignn_pool`. `pre_head` and `last_gcn_pool` are appendix-support layers only.

### Family separation in frozen pretrained space

Use the fixed-test `last_alignn_pool` raw 256D metrics as the quantitative anchor:

| Metric | Value | Writing use |
|---|---:|---|
| Overall silhouette | `0.2392490544` | Families are separated in raw pretrained space. |
| Oxide silhouette | `0.2545637433` | Oxide region is more cohesive than nitride. |
| Nitride silhouette | `0.1453358383` | Nitride region is less cohesive. |
| Overall 15-NN family purity | `0.9655465431` | Local neighborhoods are strongly family-structured. |
| Oxide 15-NN family purity | `0.9871518419` | Oxide neighborhoods are especially pure. |
| Nitride 15-NN family purity | `0.8330578512` | Nitride neighborhoods are less pure, matching the shift narrative. |
| Logistic family AUC | `0.9993623443` | Family labels are nearly perfectly recoverable from frozen embeddings. |
| Davies-Bouldin index | `1.8289881054` | Secondary cluster-quality statistic; do not lead with it. |

Projection guardrail: PCA, t-SNE, and UMAP are descriptive support. Quote raw-space metrics, not visual cluster distances.

### Nitride error versus oxide-reference distance

This is the strongest nitride representational result. It uses nitride absolute zero-shot error and the oxide reference pool.

| Evidence item | Value | Writing use |
|---|---:|---|
| Nitride test structures | `242` | Full sample for distance-error association. |
| Oxide reference pool | `13507` | All oxide train+val pool structures used as reference region. |
| Hard/easy group sizes | `49` hard, `49` easy | Top/bottom 20% by nitride absolute zero-shot error. |
| Hard-group mean 5NN oxide distance | `4.5988141847` | Hard nitrides sit farther from oxide reference. |
| Easy-group mean 5NN oxide distance | `3.7820522463` | Easy nitrides sit closer to oxide reference. |
| Hard-minus-easy mean gap | `0.8167619385` | Main boxplot effect size. |
| Mean-gap 95% CI | `0.4745924078` to `1.1596977522` | Positive interval; supports group-level tendency. |
| Mean-gap FDR q-value | `0.0001799820` | Strong statistical support after correction. |
| Spearman correlation | `0.3427641603` | Continuous full-sample association. |
| Spearman 95% CI | `0.2213574115` to `0.4597133751` | Moderate positive association. |
| Spearman FDR q-value | `0.0001285586` | Strong statistical support after correction. |

Interpretation: nitrides farther from oxide-reference neighborhoods in pretrained `last_alignn_pool` space tend to have larger zero-shot errors. This is correlational evidence for a geometric domain-shift account, not a causal proof.

## Strongest canonical numbers for nitride

Use these in Results and Discussion:

- Nitride zero-shot: `0.0695420150 eV/atom` on `242` test structures.
- Oxide comparator zero-shot: `0.0341836068 eV/atom` on `1484` test structures.
- Best Set 1 nitride fine-tuned mean: `0.0874171976 +/- 0.0199057075 eV/atom` at `N=10`, but this is an effective zero-shot checkpoint (`mean_best_epoch = 1.0`), not adaptation.
- Best genuinely adapted nitride row: `0.0906513114 +/- 0.0134795322 eV/atom` at `N=1000`, `mean_best_epoch = 45.0`.
- All nitride fine-tuning rows remain worse than zero-shot; even `N=1000` is `0.0211092964 eV/atom` worse.
- Low-`N` inertness: `mean_best_epoch = 1.0` at `N=10`, `50`, `100`, and `200`.
- Adaptation onset: `mean_best_epoch = 40.5` at `N=500`; `45.0` at `N=1000`.
- From-scratch nitride at `N=50`: `0.6914345625 +/- 0.0163082230 eV/atom`.
- From-scratch nitride at `N=500`: `0.3682740165 +/- 0.0233059278 eV/atom`.
- Nitride transfer benefit over scratch: `0.5741422013 eV/atom` at `N=50` with initialization-advantage caveat; `0.2706168039 eV/atom` at `N=500`.
- Raw embedding family separation, `last_alignn_pool`: 15-NN family purity `0.9655465431`; logistic AUC `0.9993623443`.
- Distance-error mechanism, `last_alignn_pool` kNN5: Spearman `0.3427641603`, FDR q-value `0.0001285586`; hard-minus-easy mean gap `0.8167619385`, FDR q-value `0.0001799820`.

## Recommended main figures and tables for nitride

Main figures:

| Priority | Figure | Recommendation |
|---:|---|---|
| 1 | `FIG_ZS_COMPARISON` | Required; establishes nitride zero-shot domain-shift penalty. |
| 2 | `FIG_S1_LC_NITRIDE` | Required; main fine-tuning trajectory and inertness/adaptation-onset evidence. |
| 3 | `FIG_S1_PARITY_NITRIDE_N10` and `FIG_S1_PARITY_NITRIDE_N1000` | Use as paired low-/high-`N` parity views. |
| 4 | `FIG_S1_COMP_NITRIDE` | Required; pretraining-over-scratch evidence with `N=50` caveat. |
| 5 | `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP` | Main representational family-separation panel set, if space allows; PCA can lead. |
| 6 | `FIG_EA_6D_BOXPLOT` | Required if only one mechanism panel is chosen. |
| 7 | `FIG_EA_6D_SCATTER` | Recommended companion if space allows; shows continuous full-sample association. |
| 8 | `FIG_SCHEMATIC` | Optional in Introduction or Methods. |

Main tables:

| Table | Recommendation |
|---|---|
| `TAB_ZS_SUMMARY` | Main text or inline quote; include nitride and oxide rows. |
| `TAB_S1_FT_SUMMARY_BY_N` | Required for inertness and adaptation-onset subsections. |
| `TAB_S1_FS_SUMMARY` | Required for scratch comparison. |
| `TAB_EA_FAMILY_SEPARATION` | Required or strongly recommended for representational evidence. |
| `TAB_EA_DISTANCE_ERROR_STATS` | Required for the distance-error mechanism. |
| `TAB_METHODS_DATASET_SPLITS` | Methods table; supports nitride counts and split provenance. |
| `TAB_METHODS_EXPERIMENT_SCOPE` | Methods table; supports run-count and from-scratch coverage limitations. |

## Recommended appendix figures for nitride

| Appendix item | Figure(s) | Use |
|---|---|---|
| Intermediate nitride parity progression | `FIG_S1_PARITY_NITRIDE_N50`, `FIG_S1_PARITY_NITRIDE_N100`, `FIG_S1_PARITY_NITRIDE_N200`, `FIG_S1_PARITY_NITRIDE_N500` | Supports low-`N` inertness through `N=200` and onset at `N=500`. |
| Nitride fine-tuning training curves | `reports/Hyperparameter Set 1/Training Curves/Finetuning/nitride_training_curve_grid.png` | Per-run optimization support. |
| Nitride from-scratch training curves | `reports/Hyperparameter Set 1/Training Curves/From Scratch/nitride_training_curve_grid.png` | Appendix support for scratch runs. |
| Embedding projection sensitivity | `FIG_EA_TSNE_P15`, `FIG_EA_TSNE_P50`, `FIG_EA_UMAP_N15`, `FIG_EA_UMAP_N50` | Shows projection robustness around canonical t-SNE/UMAP settings. |
| Alternative embedding layers | `FIG_EA_PCA_PRE_HEAD`, `FIG_EA_PCA_LAST_GCN_POOL` | Appendix only; do not treat as co-equal with `last_alignn_pool`. |
| Hard/easy nitride context | `FIG_EA_PCA_HARD_EASY` | Appendix context for hard/easy grouping. |
| Distance metric robustness | `FIG_EA_CENTROID_BOXPLOT`, `FIG_EA_MAHAL_BOXPLOT` | Supports canonical kNN5 result with alternative distance definitions. |
| Element embeddings | `FIG_EA_ELEMENT_PCA`, `FIG_EA_ELEMENT_TSNE`, `FIG_EA_ELEMENT_UMAP` | Optional low-priority appendix context. |

## Drafting guardrails

- Do not claim nitride fine-tuning beats zero-shot.
- Do not describe `N <= 200` nitride rows as successful adaptation.
- Every use of `CN_TRANSFER_BENEFIT_NITRIDE_N50` must say "pretrained-initialization advantage over scratch, not fine-tuning adaptation."
- Do not imply from-scratch comparisons exist outside `N=50` and `N=500`.
- Do not describe the checkpoint as "oxide-pretrained."
- Do not claim embedding distance causes nitride error; frame it as a correlational geometric indicator.
- Do not put `pre_head` or `last_gcn_pool` in the main text as co-equal embedding layers.
- Do not use Set 2 or Set 3 as main evidence unless the section is explicitly labeled robustness.
