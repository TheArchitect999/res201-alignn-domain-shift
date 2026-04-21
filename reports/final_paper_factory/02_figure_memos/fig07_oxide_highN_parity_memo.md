# Figure Memo: Fig. 07 Oxide High-N Parity Plot

## Metadata

- Figure label: `FIG_S1_PARITY_OXIDE_N1000`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N1000.png`
- Canonical source path: `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=1000.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `oxide | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is the oxide parity plot for Hyperparameter Set 1 at fine-tuning size `N=1000`. Each point is a test-set oxide, with the x-axis showing true formation energy and the y-axis showing the predicted formation energy from the mean prediction across 5 seeds (`0, 1, 2, 3, 4`). The dashed red line is the ideal parity line `y = x`.

The figure itself reports `MAE = 0.0383 eV/atom`, `RMSE = 0.0706 eV/atom`, and `R^2 = 0.9943`. The linked summary table gives the canonical oxide `N=1000` row as `mean_test_mae = 0.0417 eV/atom`, `std_test_mae = 0.0053 eV/atom`, `mean_best_epoch = 35.5`, and oxide zero-shot MAE `= 0.0342 eV/atom` on the same test set.

As with the oxide `N=10` parity panel, the figure MAE and the summary-table MAE describe different aggregations. The figure's `0.0383` is computed on predictions averaged across seeds first, whereas the summary table's `0.0417` is the arithmetic mean of the individual seed-level MAEs.

## Justified Interpretation

The figure shows that oxide predictions remain very close to parity at the largest labeled-data setting used in the main text. Most points track the parity line tightly across the full oxide target range, and there is no obvious systematic bias.

This panel is meaningfully different from the `N=10` oxide parity plot in one important way: it reflects a genuinely fine-tuned model rather than a near-pretrained checkpoint. The linked summary table reports `mean_best_epoch = 35.5` at `N=1000`, compared with `1.0` at `N=10`, so the model has undergone sustained multi-epoch optimization.

At the same time, the parity improvement is modest in headline error terms. The on-figure MAE changes only from `0.0391 eV/atom` at `N=10` to `0.0383 eV/atom` at `N=1000`, and the per-seed mean MAE changes only from `0.0417` to `0.0417 eV/atom` to three decimals. The clearer improvement is reproducibility: the per-seed MAE standard deviation contracts from `0.0111` at `N=10` to `0.0053 eV/atom` at `N=1000`.

The safest overall interpretation is therefore that, for the oxide control arm, large-`N` fine-tuning stabilizes outcomes across seeds and preserves strong pointwise agreement with ground truth, but does not materially improve on the already strong oxide zero-shot baseline under Set 1.

## Non-Claims / Cautions

- This figure does not show that oxide `N=1000` fine-tuning beats oxide zero-shot. The linked summary table shows oxide zero-shot remains better.
- This figure should not be used to claim a dramatic accuracy improvement over the oxide `N=10` parity panel; the visible and numerical changes are modest.
- This figure alone does not establish oxide-versus-nitride domain shift; that requires the nitride high-`N` parity panel and/or the direct comparison section.
- This figure does not support any fine-tuning-versus-from-scratch claim; from-scratch comparisons do not exist at `N=1000`.
- The reported `R^2 = 0.9943` should not be treated as the main performance claim without the MAE/RMSE context.
- The figure averages predictions across seeds, so it does not display per-structure seed-to-seed uncertainty directly.
- The figure does not identify the cause of the remaining scatter; it shows prediction quality, not mechanism.

## Caption Draft

Figure X. Oxide parity plot at fine-tuning size `N=1000` under Hyperparameter Set 1. Each point shows the mean prediction across 5 seeds plotted against the true formation energy for the oxide test set, and the dashed red line indicates ideal parity. On the ensemble-mean predictions, the figure reports `MAE = 0.0383 eV/atom`, `RMSE = 0.0706 eV/atom`, and `R^2 = 0.9943`. The linked fine-tuning summary gives `mean_best_epoch = 35.5` and `std_test_mae = 0.0053 eV/atom` at this setting, indicating a genuinely fine-tuned and more reproducible oxide model, although the corresponding per-seed mean MAE remains above the oxide zero-shot baseline.

## Results Paragraph Draft

Figure X shows the oxide high-`N` parity view for Hyperparameter Set 1 at `N=1000`. The ensemble-mean predictions across 5 seeds follow the ideal parity line closely over the oxide test set, with on-figure metrics of `MAE = 0.0383 eV/atom`, `RMSE = 0.0706 eV/atom`, and `R^2 = 0.9943`. The canonical fine-tuning summary for the same setting reports a per-seed mean test MAE of `0.0417 +/- 0.0053 eV/atom`, which remains above the oxide zero-shot MAE of `0.0342 eV/atom`; the gap between `0.0383` and `0.0417` reflects the difference between seed-averaged predictions and the average of seed-level MAEs. Relative to the oxide `N=10` parity panel, the main change is not a large shift in headline MAE but a transition to a genuine multi-epoch fine-tuning regime (`mean_best_epoch = 35.5` versus `1.0`) and a tighter across-seed error distribution (`0.0053` versus `0.0111 eV/atom`). Thus, the high-`N` oxide panel indicates stronger reproducibility and still-strong pointwise agreement, but not a crossover below oxide zero-shot.

## Discussion Paragraph Draft

The oxide `N=1000` parity plot closes the oxide parity pair by showing what the control arm looks like after substantial supervised adaptation. The result is visually very strong, but its main scientific value is not that it reveals a qualitatively new accuracy regime. Instead, it shows that once oxide fine-tuning moves beyond the low-`N` checkpoint caveat, the model converges to a similarly accurate but more reproducible solution. This is consistent with the broader oxide learning-curve result: oxides are already well aligned with the pretrained representation, so additional labeled oxide data mainly tightens consistency across runs rather than unlocking a large improvement over zero-shot. In the report, this makes the `N=1000` parity panel the correct high-`N` companion to the `N=10` panel and an appropriate control-side reference for later contrast with the nitride high-`N` behavior.

## Role In Report

- Main-text high-`N` parity panel for the oxide standalone report, paired with `FIG_S1_PARITY_OXIDE_N10`.
- Supporting visual evidence in Results I of the combined paper, integrated into the oxide fine-tuning subsection.
- Control-side endpoint figure: shows that large-`N` oxide fine-tuning yields a genuinely optimized and more reproducible model, while still remaining bounded by the oxide zero-shot ceiling.
- High-data reference for later comparison with the nitride high-`N` parity panel.
