# Oxide Analysis Packet

Status: section-input packet for oxide report writing.
Companion file: `reports/final_paper_factory/03_section_inputs/oxide_results_packet.md`.

Use this packet with:

- `reports/final_paper_factory/01_blueprints/oxide_report_blueprint_v3.md`
- `reports/final_paper_factory/03_section_inputs/oxide_methods_notes_v2.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`

Canonical policy: the oxide report uses Hyperparameter Set 1 for main fine-tuning and from-scratch results. Zero-shot is a shared pretrained baseline from `reports/zero_shot/`. Set 2 and Set 3 are robustness-only namespaces.

## What the oxide report is actually trying to prove

The oxide report is the control-arm paper. It should prove that the pretrained formation-energy ALIGNN model already performs strongly on an in-distribution oxide test set, that oxide fine-tuning becomes more stable and genuinely optimized once `N >= 50`, and that pretrained initialization massively outperforms random initialization at the two scratch-tested data sizes. The punchline is not "fine-tuning beats zero-shot." It does not. The punchline is that oxides are already well served by the pretrained model, and the oxide arm supplies the stable reference point against which nitride domain shift can be interpreted.

## Core oxide story

1. Zero-shot establishes a strong oxide benchmark: `0.0341836068 eV/atom` on `1484` test structures.
2. Fine-tuning never beats zero-shot under Set 1, but the trajectory recovers from the low-data penalty after `N=50` and becomes more stable by `N=1000`.
3. The `N=10` oxide point is a near-pretrained checkpoint (`mean_best_epoch = 1.0`), so it is a low-motion baseline, not evidence of meaningful low-data adaptation.
4. From-scratch training is dramatically worse than the pretrained route at both available scratch sizes (`N=50` and `N=500`), which is the cleanest oxide-side evidence for pretraining value.
5. Embedding analysis should appear only as a brief bridge in the oxide standalone report: pretrained embeddings separate oxide and nitride families, while the detailed distance-error mechanism belongs in the combined or nitride report.

## Oxide zero-shot evidence

Primary source: `reports/zero_shot/zero_shot_summary.csv`.

| Evidence item | Canonical value | Use in prose |
|---|---:|---|
| Oxide fixed test size | `1484` | Establishes the evaluation scale. |
| Oxide zero-shot MAE | `0.03418360680813096 eV/atom` | Strong in-distribution benchmark; all Set 1 oxide fine-tuning rows remain above this line. |
| Model | `jv_formation_energy_peratom_alignn` | Call it the "pretrained formation-energy ALIGNN model"; do not call it "oxide-pretrained." |
| Prediction source | `Results_Before_Correction/oxide/zero_shot/predictions.csv` | Appendix or audit support, not usually needed in main text. |

Interpretation: zero-shot is not just a baseline; it is the performance ceiling observed in the canonical oxide experiments. The oxide report should treat it as the benchmark that fine-tuning tries, and fails, to exceed.

## Oxide fine-tuning evidence across N

Primary source: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`.

| N | Mean test MAE | Std test MAE | Mean best epoch | Gap vs zero-shot | Writing read |
|---:|---:|---:|---:|---:|---|
| 10 | `0.0417315982` | `0.0111156520` | `1.0` | `+0.0075479914` worse | Near-pretrained checkpoint; do not call this meaningful adaptation. |
| 50 | `0.0522985784` | `0.0147872550` | `18.5` | `+0.0181149716` worse | First genuine optimization, but worst mean MAE. |
| 100 | `0.0464986845` | `0.0086372919` | `20.0` | `+0.0123150777` worse | Recovery from the `N=50` low-data penalty. |
| 200 | `0.0457007581` | `0.0086126726` | `39.0` | `+0.0115171513` worse | Continued recovery with sustained optimization. |
| 500 | `0.0429627431` | `0.0062320128` | `39.0` | `+0.0087791363` worse | Approaches zero-shot but does not beat it. |
| 1000 | `0.0416922026` | `0.0053332587` | `35.5` | `+0.0075085958` worse | Best fine-tuned mean and most stable high-N endpoint, still above zero-shot. |

Narrative use: write the curve as "recovery and stabilization," not "monotonic improvement over zero-shot." The strongest fair claim is that oxide fine-tuning becomes active after the `N=10` checkpoint caveat and becomes more reproducible at larger `N`, but the pretrained zero-shot model remains best under the canonical setting.

## Oxide from-scratch comparison evidence

Primary sources:

- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`

Coverage guardrail: from-scratch oxide baselines exist only at `N=50` and `N=500`. Do not imply scratch comparisons at `N=10`, `100`, `200`, or `1000`.

| N | Fine-tune mean MAE | From-scratch mean MAE | From-scratch std | Scratch minus fine-tune | Writing read |
|---:|---:|---:|---:|---:|---|
| 50 | `0.0522985784` | `0.5560532795` | `0.0523490883` | `0.5037547011` | Massive pretraining advantage in low-data oxide regime. |
| 500 | `0.0429627431` | `0.2643359895` | `0.0228038159` | `0.2213732464` | Scratch improves with more data but remains far behind the pretrained route. |

Narrative use: this is the strongest oxide-side evidence for pretraining value. It also makes the zero-shot result easier to explain: the pretrained model already has oxide-relevant structure, so fine-tuning preserves a large advantage over scratch even when it does not improve beyond zero-shot.

## Oxide parity plot notes

Primary figure memos:

- `reports/final_paper_factory/02_figure_memos/fig06_oxide_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig07_oxide_highN_parity_memo.md`

Main-text parity pair: `FIG_S1_PARITY_OXIDE_N10` and `FIG_S1_PARITY_OXIDE_N1000`.

| Figure | On-figure metrics | Linked summary row | Correct interpretation |
|---|---|---|---|
| `FIG_S1_PARITY_OXIDE_N10` | `MAE = 0.0391`, `RMSE = 0.0699`, `R^2 = 0.9944` | `mean_test_mae = 0.0417`, `std = 0.0111`, `mean_best_epoch = 1.0` | Visually strong parity at the smallest `N`, but best read as a near-pretrained checkpoint view. |
| `FIG_S1_PARITY_OXIDE_N1000` | `MAE = 0.0383`, `RMSE = 0.0706`, `R^2 = 0.9943` | `mean_test_mae = 0.0417`, `std = 0.0053`, `mean_best_epoch = 35.5` | Genuine high-N fine-tuning with tighter run-to-run behavior, but still not below zero-shot. |

Important aggregation note: the parity figure MAEs are computed after averaging predictions across seeds, while the summary-table MAEs average individual seed MAEs. Keep those values distinct.

Use the parity pair to show error structure and reproducibility, not to replace the learning-curve table. The `N=10` and `N=1000` panels look similarly strong because zero-shot already works well on oxides; the main difference is that `N=1000` reflects real multi-epoch optimization and lower cross-seed variability.

## Oxide figure memo references

| Memo | Figure label | Oxide report role |
|---|---|---|
| `fig01_study_design_schematic_memo.md` | `FIG_SCHEMATIC` | Optional framing figure for Introduction or Methods. |
| `fig02_oxide_learning_curve_memo.md` | `FIG_S1_LC_OXIDE` | Main fine-tuning-across-`N` figure. |
| `fig04_zero_shot_family_comparison_memo.md` | `FIG_ZS_COMPARISON` | Optional cross-family context; use sparingly in oxide standalone. |
| `fig05_transfer_benefit_comparison_memo.md` | `FIG_TRANSFER_BENEFIT` | Combined-paper comparison only; can inform discussion, not needed as oxide main figure. |
| `fig05a_oxide_comparison_plot_memo.md` | `FIG_S1_COMP_OXIDE` | Main oxide fine-tune vs from-scratch figure. |
| `fig06_oxide_lowN_parity_memo.md` | `FIG_S1_PARITY_OXIDE_N10` | Main low-`N` parity snapshot with checkpoint caveat. |
| `fig07_oxide_highN_parity_memo.md` | `FIG_S1_PARITY_OXIDE_N1000` | Main high-`N` parity endpoint. |
| `fig10_embedding_pca_memo.md` | `FIG_EA_6A_PCA` | Optional short embedding bridge; raw metrics anchor family separation. |
| `fig11_embedding_tsne_memo.md` | `FIG_EA_6B_TSNE` | Optional or appendix bridge; local-neighborhood view only. |
| `fig12_embedding_umap_memo.md` | `FIG_EA_6C_UMAP` | Optional or appendix bridge; descriptive support only. |
| `fig13_nitride_distance_error_memo.md` | `FIG_EA_6D_BOXPLOT` | Combined/nitride mechanism figure; do not make it an oxide standalone result. |
| `fig13b_nitride_distance_error_scatter_memo.md` | `FIG_EA_6D_SCATTER` | Combined/nitride continuous-association companion; not an oxide standalone main figure. |

## Oxide embedding-analysis notes

Primary sources:

- `reports/week4_embedding_analysis/final_results_summary.md`
- `reports/week4_embedding_analysis/final_methods_summary.md`
- `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`

Main-text embedding layer: `last_alignn_pool`. `pre_head` and `last_gcn_pool` are appendix-support layers only.

Main oxide-report role: a short bridge that confirms the pretrained representation separates oxide and nitride families. Do not reproduce the full domain-shift mechanism in the oxide standalone report.

Strong family-separation numbers from the fixed-test `last_alignn_pool` raw 256D embeddings:

| Metric | Value | Writing use |
|---|---:|---|
| Overall silhouette | `0.2392490544` | Families are separated in raw pretrained space. |
| Oxide silhouette | `0.2545637433` | Oxide region is more cohesive than nitride in this layer. |
| Nitride silhouette | `0.1453358383` | Nitride region is less cohesive. |
| Overall 15-NN family purity | `0.9655465431` | Local neighborhoods are strongly family-structured. |
| Oxide 15-NN family purity | `0.9871518419` | Oxide local neighborhoods are especially pure. |
| Nitride 15-NN family purity | `0.8330578512` | Nitride neighborhoods are less pure, supporting the shift interpretation. |
| Logistic family AUC | `0.9993623443` | Family labels are nearly perfectly recoverable from frozen embeddings. |
| Davies-Bouldin index | `1.8289881054` | Secondary cluster-quality statistic; do not lead with it. |

Distance-error mechanism note: the strongest distance-error analysis is nitride-facing. It uses an oxide reference pool of `13507` oxide train+val structures and shows that harder nitrides are farther from their 5 nearest oxide neighbors in `last_alignn_pool` space. This is useful background for the combined paper, but the oxide report should only forward-reference it.

Projection guardrail: PCA, t-SNE, and UMAP plots are descriptive visual support. Quote quantitative claims from raw 256D tables, not from 2D projection geometry.

## Strongest canonical numbers for oxide

Use these in Results and Discussion:

- Oxide zero-shot: `0.0341836068 eV/atom` on `1484` test structures.
- Best Set 1 oxide fine-tuned mean: `0.0416922026 +/- 0.0053332587 eV/atom` at `N=1000`.
- Best fine-tuned oxide row is still `0.0075085958 eV/atom` worse than zero-shot.
- Oxide `N=10` checkpoint caveat: `mean_best_epoch = 1.0`; treat as near-pretrained low-motion checkpoint.
- Oxide adaptation starts after that caveat: `mean_best_epoch = 18.5` at `N=50`, then `20.0`, `39.0`, `39.0`, and `35.5` at larger `N`.
- Oxide fine-tuning variability narrows from `0.0111156520` at `N=10` to `0.0053332587` at `N=1000`.
- From-scratch oxide at `N=50`: `0.5560532795 +/- 0.0523490883 eV/atom`.
- From-scratch oxide at `N=500`: `0.2643359895 +/- 0.0228038159 eV/atom`.
- Oxide transfer benefit over scratch: `0.5037547011 eV/atom` at `N=50`; `0.2213732464 eV/atom` at `N=500`.
- Raw embedding family separation, `last_alignn_pool`: 15-NN family purity `0.9655465431`; logistic AUC `0.9993623443`.

## Recommended main figures and tables for oxide

Main figures:

| Priority | Figure | Recommendation |
|---:|---|---|
| 1 | `FIG_S1_LC_OXIDE` | Required; main fine-tuning trajectory. |
| 2 | `FIG_S1_PARITY_OXIDE_N10` and `FIG_S1_PARITY_OXIDE_N1000` | Use as a paired low-/high-`N` parity view. |
| 3 | `FIG_S1_COMP_OXIDE` | Required; strongest pretraining-over-scratch evidence. |
| 4 | `FIG_SCHEMATIC` | Optional in Introduction or Methods if the report needs visual orientation. |
| 5 | `FIG_ZS_COMPARISON` | Optional; use only if the oxide report needs cross-family context. |
| 6 | `FIG_EA_6A_PCA` | Optional bridge only; do not let embedding analysis take over the oxide report. |

Main tables:

| Table | Recommendation |
|---|---|
| `TAB_ZS_SUMMARY` | Include or quote the oxide row. |
| `TAB_S1_FT_SUMMARY_BY_N` | Required for the fine-tuning subsection. |
| `TAB_S1_FS_SUMMARY` | Required for scratch comparison. |
| `TAB_METHODS_DATASET_SPLITS` | Methods table; supports oxide counts and split provenance. |
| `TAB_METHODS_EXPERIMENT_SCOPE` | Methods table; supports run-count and from-scratch coverage limitations. |
| `TAB_EA_FAMILY_SEPARATION` | Optional, preferably appendix or combined-paper context. |

## Recommended appendix figures for oxide

| Appendix item | Figure(s) | Use |
|---|---|---|
| Intermediate oxide parity progression | `FIG_S1_PARITY_OXIDE_N50`, `FIG_S1_PARITY_OXIDE_N100`, `FIG_S1_PARITY_OXIDE_N200`, `FIG_S1_PARITY_OXIDE_N500` | Show the full parity progression without crowding main text. |
| Oxide fine-tuning training curves | `reports/Hyperparameter Set 1/Training Curves/Finetuning/oxide_training_curve_grid.png` | Per-run training behavior if reviewers ask about optimization. |
| Oxide from-scratch training curves | `reports/Hyperparameter Set 1/Training Curves/From Scratch/oxide_training_curve_grid.png` | Appendix support for scratch instability and convergence. |
| Embedding projection sensitivity | `FIG_EA_TSNE_P15`, `FIG_EA_TSNE_P50`, `FIG_EA_UMAP_N15`, `FIG_EA_UMAP_N50` | Show projection robustness if the oxide bridge includes embedding context. |
| Alternative embedding layers | `FIG_EA_PCA_PRE_HEAD`, `FIG_EA_PCA_LAST_GCN_POOL` | Appendix only; do not treat as co-equal with `last_alignn_pool`. |
| Element embeddings | `FIG_EA_ELEMENT_PCA`, `FIG_EA_ELEMENT_TSNE`, `FIG_EA_ELEMENT_UMAP` | Optional low-priority appendix context. |

## Drafting guardrails

- Do not claim oxide fine-tuning beats zero-shot.
- Do not frame oxide `N=10` as successful low-data adaptation; it is flagged by `mean_best_epoch = 1.0`.
- Do not imply from-scratch results exist beyond `N=50` and `N=500`.
- Do not describe the checkpoint as "oxide-pretrained."
- Do not let nitride-specific embedding distance-error evidence become an oxide standalone result.
- Do not quote projection distances or visual cluster sizes as raw-space statistics.
- Do not use Set 2 or Set 3 as main evidence unless the section is explicitly labeled robustness.
