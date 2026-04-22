# Figure Memo: Fig. 04 Zero-Shot Family Comparison

## Metadata

- Figure label: `FIG_ZS_COMPARISON`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_ZS_COMPARISON.png`
- Canonical source path: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_ZS_COMPARISON.png`
- Linked table: `reports/zero_shot/zero_shot_summary.csv`
- Model: `jv_formation_energy_peratom_alignn`
- Report membership: `nitride | combined | oxide_optional`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure compares the pretrained ALIGNN model's zero-shot test MAE on the two chemical families, with no parameter updates. The oxide bar shows a zero-shot MAE of `0.0342 eV/atom` on `1484` test structures, and the nitride bar shows a zero-shot MAE of `0.0695 eV/atom` on `242` test structures.

The figure therefore presents the simplest family-level baseline contrast in the project: the same pretrained checkpoint evaluated directly on the oxide control test set and the nitride out-of-distribution test set.

The linked zero-shot summary table gives the underlying canonical values:

- Oxide: `n_test = 1484`, `mae_eV_per_atom = 0.0341836068`
- Nitride: `n_test = 242`, `mae_eV_per_atom = 0.0695420150`

## Justified Interpretation

The safest interpretation is that a substantial family-dependent performance gap is already present at the pretrained starting point. Before any fine-tuning, the pretrained model performs much better on oxides than on nitrides.

Because oxides are the in-distribution control family and nitrides are the out-of-distribution test family in the study framing, this figure is consistent with a domain-shift disadvantage for nitrides that exists prior to any supervised adaptation. That is the main value of the panel: it shows that the nitride penalty is not introduced by fine-tuning behavior alone.

This figure is also important as a reference point for the rest of the paper. The zero-shot values shown here are the baseline against which the later fine-tuning learning curves, parity plots, and transfer-benefit comparisons are interpreted.

## Non-Claims / Cautions

- This figure does not explain why nitride zero-shot performance is worse; it shows the gap, not the mechanism.
- This figure does not establish anything about fine-tuning dynamics, data efficiency, or adaptation onset; that requires the learning-curve figures.
- This figure does not compare fine-tuning against scratch; that requires the `N=50` and `N=500` comparison plots.
- This figure does not prove that embedding-space shift causes the zero-shot gap; that requires the embedding analyses.
- This figure shows single fixed-test-set MAE values and no uncertainty intervals, so it should not be overread as a full statistical analysis by itself.
- This figure should not be used to compare hyperparameter settings; zero-shot here is a direct checkpoint evaluation, not a training sweep.

## Caption Draft

Figure X. Zero-shot comparison for oxide and nitride formation-energy prediction. The pretrained ALIGNN checkpoint (`jv_formation_energy_peratom_alignn`) is evaluated directly on the fixed oxide and nitride test sets without fine-tuning. Zero-shot test MAE is lower for oxides (`0.0342 eV/atom`, `n=1484`) than for nitrides (`0.0695 eV/atom`, `n=242`), indicating a substantial family-dependent performance gap already at the pretrained starting point.

## Results Paragraph Draft

Figure X compares zero-shot test MAE for the oxide and nitride families using the pretrained ALIGNN checkpoint without any supervised adaptation. The oxide zero-shot MAE is `0.0342 eV/atom` on `1484` test structures, whereas the nitride zero-shot MAE is `0.0695 eV/atom` on `242` test structures. Thus, the nitride family starts from a substantially weaker pretrained baseline than the oxide control family. This establishes the project's baseline family gap before any fine-tuning and motivates the later analysis of whether supervised adaptation or embedding-space geometry helps explain that difference.

## Discussion Paragraph Draft

This zero-shot comparison is one of the cleanest baseline figures in the study because it isolates the pretrained starting point. No parameters are updated, so the observed oxide-versus-nitride gap reflects how the same pretrained model generalizes to the two families before any target-family supervision is introduced. In the broader paper, that makes this figure the correct starting anchor for the domain-shift story: the nitride difficulty is already visible at zero-shot, and later results must therefore be interpreted as attempts to recover from a pre-existing family mismatch rather than as the source of that mismatch.

## Role In Report

- Main-text baseline comparison figure for the nitride standalone report.
- Main-text family-comparison anchor for the combined paper before the learning-curve and embedding sections.
- Optional early-results figure for the oxide standalone report when the cross-family zero-shot contrast is useful as control context.
- Reference-point figure: later fine-tuning and scratch comparisons are interpreted relative to these two zero-shot baselines.
