# Figure Memo: Fig. 13B Nitride Distance-Error Scatter

## Metadata

- Figure label: `FIG_EA_6D_SCATTER`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_SCATTER.png`
- Canonical source path: `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_vs_abs_error.png`
- Linked table: `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- Embedding source: `last_alignn_pool`
- Distance metric: `oxide_knn5_mean_distance`
- Error metric: `absolute_zero_shot_error`
- Analysis space: `raw_256d_embedding_vectors`
- Nitride test set size: `242`
- Oxide reference pool size: `13507`
- Easy group: bottom `20%` by absolute zero-shot error (`n=49`)
- Middle group: middle `60%` by absolute zero-shot error (`n=144`)
- Hard group: top `20%` by absolute zero-shot error (`n=49`)
- Companion figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_BOXPLOT.png`
- Report membership: `nitride | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure plots, for all `242` nitride test structures, absolute zero-shot prediction error against mean distance to the `5` nearest oxide neighbors in the pretrained ALIGNN `last_alignn_pool` embedding space. The x-axis is mean `5`NN oxide distance in the raw `256`-dimensional embedding space, and the y-axis is nitride absolute zero-shot error in `eV/atom`.

Each point is one nitride structure, colored by the same error grouping used in the companion boxplot:

- `Easy`: bottom `20%` by absolute zero-shot error (`n=49`)
- `Middle`: middle `60%` (`n=144`)
- `Hard`: top `20%` by absolute zero-shot error (`n=49`)

The panel reports the two canonical full-sample association statistics for this exact configuration:

- Spearman `rho = 0.343` (95% CI `0.221-0.460`)
- Pearson `r = 0.277` (95% CI `0.174-0.389`)
- One-sided permutation p-value for both correlations: `0.0001`
- Benjamini-Hochberg FDR-adjusted p-value for both correlations: `0.00013`

The linked table also reports the companion hard-versus-easy tail contrast for the same metric:

- Hard-minus-easy mean distance difference: `0.817` (95% CI `0.475-1.160`)
- Hard-minus-easy median distance difference: `0.873` (95% CI `0.416-1.286`)

## Justified Interpretation

The safest interpretation is that nitride zero-shot difficulty is positively associated with distance from the oxide-reference region in the pretrained embedding space. The upward trend line and the positive full-sample correlations show that nitrides farther from oxide-side reference neighborhoods tend, on average, to incur larger zero-shot errors.

This scatter is valuable because it shows the full continuous relationship across all `242` nitrides, not just the tail contrast. Easy nitrides remain near very low error across a range of distances, the middle `60%` fill the transition region, and hard nitrides occupy the higher-error part of the plot more often at larger distances. That makes the claim more specific than a family-level visualization result: within nitrides themselves, representational displacement from the oxide-reference region is meaningfully related to prediction difficulty.

The correct framing is still correlational rather than causal. The association is positive and statistically robust, but it is not deterministic. The scatter visibly shows overlap in distance across the easy, middle, and hard groups, so oxide-reference distance is best interpreted as a geometric risk indicator of nitride difficulty rather than a complete explanation of per-structure error.

## Non-Claims / Cautions

- This figure does not prove that larger oxide-reference distance causes larger nitride error; it shows association, not causation.
- This figure does not support the claim that oxide-reference distance is the only or dominant determinant of nitride error.
- This figure does not show perfect discrimination between easy and hard nitrides; the three groups overlap in distance.
- This figure does not support the claim that every nitride far from oxides is hard, or every nitride close to oxides is easy.
- This figure does not justify reading a precise functional law off the plotted regression line; the line is a visual summary, not a mechanistic model.
- This figure is specific to absolute zero-shot error; it does not establish the same relationship for fine-tuned error.
- This figure does not compare fine-tuning against scratch, low `N` against high `N`, or one hyperparameter setting against another.
- This figure should not be used to describe the pretrained checkpoint as "oxide-pretrained"; "oxide-reference region" is the correct distance-context term.

## Caption Draft

Figure X. Nitride zero-shot error versus oxide-reference embedding distance in pretrained space. Each point is one nitride test structure, plotted by mean distance in the raw `256`-dimensional `last_alignn_pool` embedding to its `5` nearest oxide neighbors in a reference pool of `13507` oxides (x-axis) and by absolute zero-shot prediction error in `eV/atom` (y-axis). Points are colored by error group: `Easy` (bottom `20%`, `n=49`), `Middle` (`n=144`), and `Hard` (top `20%`, `n=49`). The positive full-sample associations, Spearman `rho = 0.343` (95% CI `0.221-0.460`) and Pearson `r = 0.277` (95% CI `0.174-0.389`), indicate that nitrides farther from the oxide-reference region tend to exhibit larger zero-shot errors. The panel is interpreted as correlational evidence consistent with a geometric account of domain-shift difficulty, not as a causal test.

## Results Paragraph Draft

Figure X shows the continuous relationship between nitride zero-shot difficulty and distance from the oxide-reference region in pretrained space. For all `242` nitride test structures, we plotted absolute zero-shot error against mean `5`NN oxide distance in the raw `256`-dimensional `last_alignn_pool` embedding. The overall association is positive, with Spearman `rho = 0.343` (95% CI `0.221-0.460`) and Pearson `r = 0.277` (95% CI `0.174-0.389`), both with one-sided permutation `p=0.0001` and FDR-adjusted `p=0.00013`. Easy nitrides (bottom `20%` by error) cluster near very low error across a moderate range of distances, whereas hard nitrides (top `20%`) occupy visibly larger error values and appear more often at larger oxide-reference distances, with the middle `60%` filling the transition region. This continuous view is consistent with the companion hard-versus-easy boxplot, which reports a hard-minus-easy mean distance difference of `0.817` (95% CI `0.475-1.160`). Together, these results indicate that nitrides farther from oxide neighborhoods in the pretrained representation tend to be harder for the pretrained model to predict accurately.

## Discussion Paragraph Draft

This scatter panel is one of the strongest mechanistic figures in the project because it turns the embedding story into a direct error-linked relationship. The PCA, t-SNE, and UMAP panels show that oxides and nitrides occupy different regions of pretrained space, but this panel shows that within nitrides themselves, increasing distance from the oxide-reference region is associated with increasing zero-shot difficulty. That makes the domain-shift interpretation more concrete: the nitride penalty is not just a cluster-visualization observation, but is tied to a measurable representation-space statistic. At the same time, the moderate rather than near-perfect correlation and the visible group overlap keep the claim appropriately bounded. The defensible conclusion is that oxide-reference distance is a meaningful correlational indicator of nitride difficulty, not a complete causal explanation of per-structure error.

## Role In Report

- Main-text continuous-association companion to `fig13_nitride_distance_error_memo.md` in Results IV of the combined paper.
- Main-text mechanistic support figure for the nitride standalone report when the continuous distance-error relationship is preferred over the tail-contrast boxplot.
- Companion memo for the `FIG_EA_6D` family when both the boxplot and scatter are included.
- Best used alongside the boxplot: the boxplot emphasizes effect size between hard and easy tails, while this scatter shows the full-sample relationship across all `242` nitrides.
