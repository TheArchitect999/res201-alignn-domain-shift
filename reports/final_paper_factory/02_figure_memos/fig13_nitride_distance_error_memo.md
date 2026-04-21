# Figure Memo: Fig. 13 Nitride Distance-Error Link

## Metadata

- Figure label: `FIG_EA_6D_BOXPLOT`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_BOXPLOT.png`
- Canonical source path: `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_hard_easy_boxplot.png`
- Linked table: `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- Embedding source: `last_alignn_pool`
- Distance metric: `oxide_knn5_mean_distance`
- Error metric: `absolute_zero_shot_error`
- Analysis space: `raw_256d_embedding_vectors`
- Nitride test set size: `242`
- Oxide reference pool size: `13507`
- Hard group: top `20%` by absolute zero-shot error (`n=49`)
- Easy group: bottom `20%` by absolute zero-shot error (`n=49`)
- Companion figure if needed: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6D_KNN5_SCATTER.png`
- Report membership: `nitride | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure compares, within the nitride test set, the mean embedding-space distance to each structure's `5` nearest oxide neighbors in the pretrained ALIGNN `last_alignn_pool` representation. The y-axis is mean `5`NN oxide distance in the raw `256`-dimensional embedding space, not prediction error. Nitrides are split into two tail groups by absolute zero-shot prediction error: an `Easy` group defined as the bottom `20%` (`n=49`) and a `Hard` group defined as the top `20%` (`n=49`). The middle `60%` of nitrides is not shown in this boxplot.

The canonical distance-error table gives the following values for this exact configuration:

- Hard-group mean distance: `4.599`
- Easy-group mean distance: `3.782`
- Mean hard-minus-easy distance difference: `0.817` (95% CI `0.475-1.160`)
- Hard-group median distance: `4.647`
- Easy-group median distance: `3.774`
- Median hard-minus-easy distance difference: `0.873` (95% CI `0.416-1.286`)
- One-sided permutation p-value for the mean difference: `0.0001`
- Benjamini-Hochberg FDR-adjusted p-value for the mean difference: `0.00018`

The same table also reports the continuous full-sample association across all `242` nitrides for this same distance metric:

- Spearman correlation between absolute zero-shot error and mean `5`NN oxide distance: `0.343` (95% CI `0.221-0.460`)
- Pearson correlation: `0.277` (95% CI `0.174-0.389`)
- One-sided permutation p-value for both correlations: `0.0001`

## Justified Interpretation

The safest interpretation is that, within the nitride test family, the hardest nitrides tend to sit farther from the oxide-reference region of pretrained embedding space than the easiest nitrides. The boxplot shows this at the tail-group level, and the raw table confirms that the group difference is not just visual: the hard-minus-easy mean distance gap is `0.817` with a positive confidence interval.

This figure is stronger than the family-level PCA, t-SNE, and UMAP panels because it links representation geometry directly to prediction difficulty inside the nitride set itself. The full-sample Spearman correlation of `0.343` shows that the pattern is not confined to the plotted tails. That makes the defensible claim more specific than "nitrides are shifted from oxides": nitride prediction difficulty increases on average as nitride structures lie farther from the oxide-reference neighborhood in the pretrained representation.

The correct framing is still correlational rather than causal. The figure supports a geometric correlate of domain-shift difficulty, not proof that distance alone determines error. But within the project's logic, this is the cleanest representational evidence that embedding-space mismatch is meaningfully related to which nitride structures the pretrained model struggles with most.

## Non-Claims / Cautions

- This figure does not prove that larger oxide-reference distance causes larger prediction error; it shows association, not causation.
- This figure does not show perfect separation between hard and easy nitrides; the two distributions still overlap.
- This figure does not support the claim that every hard nitride is farther than every easy nitride; it supports a group-level tendency only.
- This figure does not show the full nitride distribution by itself, because the middle `60%` of nitrides is omitted from the boxplot.
- This figure does not establish the full functional form of the distance-error relationship by itself; the companion scatter is the better visual for that.
- This figure does not compare fine-tuning against scratch, low `N` against high `N`, or one hyperparameter setting against another.
- This figure does not establish an oxide-side baseline effect; it is a within-nitride analysis defined relative to an oxide reference pool.
- This figure should not be used to describe the pretrained checkpoint as "oxide-pretrained"; "oxide-reference region" is the correct distance-context term.

## Caption Draft

Figure X. Harder nitrides sit farther from the oxide-reference region in pretrained embedding space. For each nitride test structure, the mean Euclidean distance in the raw `256`-dimensional `last_alignn_pool` embedding to its `5` nearest oxide neighbors in a reference pool of `13507` oxides was computed. Nitrides were split by absolute zero-shot prediction error into `Easy` (bottom `20%`, `n=49`) and `Hard` (top `20%`, `n=49`) groups. The hard group has a larger mean `5`NN oxide distance than the easy group, with a hard-minus-easy mean difference of `0.817` (95% CI `0.475-1.160`, one-sided permutation `p=0.0001`, FDR-adjusted `p=0.00018`). Across all `242` nitrides, absolute zero-shot error is also positively associated with mean `5`NN oxide distance (Spearman `rho = 0.343`, 95% CI `0.221-0.460`). The panel is interpreted as correlational evidence consistent with a geometric account of domain-shift difficulty, not as a causal test.

## Results Paragraph Draft

To test whether position relative to the oxide-reference region predicts nitride difficulty within the pretrained representation, we computed for each nitride test structure the mean Euclidean distance in the raw `256`-dimensional `last_alignn_pool` embedding to its `5` nearest oxide neighbors in a reference pool of `13507` oxides (Figure X). Nitrides in the top `20%` of absolute zero-shot error (`Hard`, `n=49`) lie farther from this oxide-reference region than nitrides in the bottom `20%` (`Easy`, `n=49`). The hard-group mean distance is `4.599`, compared with `3.782` for the easy group, giving a hard-minus-easy mean difference of `0.817` (95% CI `0.475-1.160`, one-sided permutation `p=0.0001`, FDR-adjusted `p=0.00018`). The corresponding median difference is `0.873` (95% CI `0.416-1.286`, `p=0.0001`). The effect is not limited to the plotted tails: across all `242` nitrides, absolute zero-shot error is positively associated with mean `5`NN oxide distance, with Spearman `rho = 0.343` (95% CI `0.221-0.460`) and Pearson `r = 0.277` (95% CI `0.174-0.389`), both with one-sided permutation `p=0.0001`. Thus, nitrides that sit farther from the oxide-reference region in pretrained space tend to be the nitrides the pretrained model predicts worst.

## Discussion Paragraph Draft

This figure is the most direct mechanistic support for the domain-shift interpretation in the project. The PCA, t-SNE, and UMAP panels show that oxides and nitrides occupy different regions of pretrained space; this figure goes one step further by showing that, within nitrides themselves, prediction difficulty tracks distance from the oxide-reference region. That makes the embedding argument much more specific: the nitride penalty is not just a family-level visualization effect, but is linked to where a nitride sits relative to the oxide-side reference manifold used by the distance metric. At the same time, the overlap between the easy and hard groups and the moderate, not near-perfect, full-sample correlation mean the effect should be framed as one contributor to nitride difficulty rather than a complete explanation. In the combined paper and the nitride standalone report, this is the figure that closes the loop between behavioral evidence and representational evidence.

## Role In Report

- Main-text mechanism figure for Results IV in the combined paper: nitride error versus oxide-reference distance.
- Main-text representational-evidence figure for the nitride standalone report, where it provides the strongest within-family geometric support for the domain-shift interpretation.
- Primary `fig13` memo anchor if both `FIG_EA_6D_KNN5_BOXPLOT` and `FIG_EA_6D_KNN5_SCATTER` are used.
- If the scatter companion is also shown, use this boxplot as the hard-versus-easy effect-size panel and the scatter as the continuous-association companion.
