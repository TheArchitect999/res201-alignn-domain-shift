# Figure Memo: Fig. 08 Nitride Low-N Parity Plot

## Metadata

- Figure label: `FIG_S1_PARITY_NITRIDE_N10`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N10.png`
- Canonical source path: `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=10.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `nitride | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is the nitride parity plot for Hyperparameter Set 1 at fine-tuning size `N=10`. Each point is a test-set nitride, with the x-axis showing true formation energy and the y-axis showing the predicted formation energy from the mean prediction across 5 seeds (`0, 1, 2, 3, 4`). The dashed red line is the ideal parity line `y = x`.

The figure itself reports `MAE = 0.0828 eV/atom`, `RMSE = 0.1203 eV/atom`, and `R^2 = 0.9841`. The linked summary table gives the canonical nitride `N=10` row as `mean_test_mae = 0.0874 eV/atom`, `std_test_mae = 0.0199 eV/atom`, `mean_best_epoch = 1.0`, and nitride zero-shot MAE `= 0.0695 eV/atom` on the same test set.

As with the oxide parity memos, the figure MAE and the summary-table MAE describe different aggregations. The figure's `0.0828` is computed on predictions averaged across seeds first, whereas the summary table's `0.0874` is the arithmetic mean of the individual seed-level MAEs.

## Justified Interpretation

The figure shows that low-`N` nitride predictions still retain the broad formation-energy trend, but with visibly looser pointwise agreement than the oxide control case. The point cloud broadly follows parity, yet the scatter is wider, especially in the positive-energy region, where several points sit noticeably below the ideal line.

This panel should be interpreted as an early-checkpoint or operationally inert nitride result rather than as a successful low-data fine-tuning outcome. The linked summary table reports `mean_best_epoch = 1.0` at `N=10`, so the selected checkpoint corresponds to essentially a one-epoch perturbation of the pretrained model. Importantly, even this near-pretrained parity view remains worse than nitride zero-shot: the canonical transfer gain is `-0.0179 eV/atom`, and both the on-figure ensemble MAE (`0.0828`) and the per-seed mean MAE (`0.0874`) sit above the nitride zero-shot MAE (`0.0695`).

The safest interpretation is therefore that the pretrained model still captures global nitride structure, but low-`N` nitride transfer is weaker and less accurate than the oxide control arm, and does not preserve the nitride zero-shot baseline under Set 1. That is consistent with nitrides serving as the out-of-distribution family in the project framing.

## Non-Claims / Cautions

- This figure does not show that nitride `N=10` fine-tuning beats nitride zero-shot. The linked summary table shows the opposite.
- This figure should not be used to claim total model collapse. The parity trend remains visible, so the problem is degraded pointwise accuracy, not complete breakdown.
- This figure alone does not establish oxide-versus-nitride domain shift; that requires the matched oxide `N=10` parity panel and/or the direct comparison section.
- This figure does not support any fine-tuning-versus-from-scratch claim; from-scratch evidence does not exist at `N=10`.
- The reported `R^2 = 0.9841` should not be treated as the main performance claim without the MAE/RMSE context.
- The figure averages predictions across seeds, so it does not display per-structure seed-to-seed uncertainty directly.
- The figure does not identify the mechanism behind the larger positive-energy scatter; that requires embedding and comparison analysis.

## Caption Draft

Figure X. Nitride parity plot at fine-tuning size `N=10` under Hyperparameter Set 1. Each point shows the mean prediction across 5 seeds plotted against the true formation energy for the nitride test set, and the dashed red line indicates ideal parity. On the ensemble-mean predictions, the figure reports `MAE = 0.0828 eV/atom`, `RMSE = 0.1203 eV/atom`, and `R^2 = 0.9841`. Because the linked fine-tuning summary gives `mean_best_epoch = 1.0` at this setting, the panel is best interpreted as a one-epoch or effectively inert low-`N` nitride checkpoint view; both the ensemble-mean and per-seed mean MAEs remain above the nitride zero-shot baseline.

## Results Paragraph Draft

Figure X shows the nitride low-`N` parity view for Hyperparameter Set 1 at `N=10`. The ensemble-mean predictions across 5 seeds follow the overall parity trend, with on-figure metrics of `MAE = 0.0828 eV/atom`, `RMSE = 0.1203 eV/atom`, and `R^2 = 0.9841`, but the scatter is visibly broader than in the matched oxide low-`N` panel. The canonical fine-tuning summary for the same setting reports a per-seed mean test MAE of `0.0874 +/- 0.0199 eV/atom`, which is above the nitride zero-shot MAE of `0.0695 eV/atom`; the difference from the on-figure MAE reflects the same seed-averaging effect seen in the oxide parity plots. The mean best epoch is `1.0`, indicating that this panel represents a one-epoch nitride checkpoint rather than a genuinely adapted low-data model. Visually, the largest deviations from parity appear in the positive-energy region, while the denser negative-to-near-zero region remains more tightly structured.

## Discussion Paragraph Draft

The nitride `N=10` parity plot is the visual counterpart of the low-`N` nitride learning-curve result. It shows that the model still preserves the broad nitride energy ordering, but does so with clearly weaker pointwise fidelity than the oxide control arm and without maintaining the nitride zero-shot baseline. This is the correct reading of low-`N` nitride inertness in the repo: not successful adaptation, and not exact zero-shot preservation, but an early-checkpoint regime that remains worse than zero-shot while still retaining global structure. In the broader report, this panel is useful because it makes the low-data domain-shift penalty visible in parity space and provides the nitride-side companion to the oxide `N=10` control reference.

## Role In Report

- Main-text low-`N` parity panel for the nitride standalone report, paired with `FIG_S1_PARITY_NITRIDE_N1000`.
- Supporting visual evidence in Results II of the combined paper, integrated into the nitride low-`N` inertness subsection.
- Visual guardrail figure for wording discipline: low-`N` nitride remains structured, but it is still an early-checkpoint regime that underperforms nitride zero-shot.
- Shift-side reference for later comparison with the oxide low-`N` parity panel.
