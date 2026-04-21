# Figure Memo: Fig. 09 Nitride High-N Parity Plot

## Metadata

- Figure label: `FIG_S1_PARITY_NITRIDE_N1000`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_NITRIDE_N1000.png`
- Canonical source path: `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=1000.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `nitride | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is the nitride parity plot for Hyperparameter Set 1 at fine-tuning size `N=1000`. Each point is a test-set nitride, with the x-axis showing true formation energy and the y-axis showing the predicted formation energy from the mean prediction across 5 seeds (`0, 1, 2, 3, 4`). The dashed red line is the ideal parity line `y = x`.

The figure itself reports `MAE = 0.0829 eV/atom`, `RMSE = 0.1220 eV/atom`, and `R^2 = 0.9837`. The linked summary table gives the canonical nitride `N=1000` row as `mean_test_mae = 0.0907 eV/atom`, `std_test_mae = 0.0135 eV/atom`, `mean_best_epoch = 45.0`, and nitride zero-shot MAE `= 0.0695 eV/atom` on the same test set.

As with the other parity memos, the figure MAE and the summary-table MAE describe different aggregations. The figure's `0.0829` is computed on predictions averaged across seeds first, whereas the summary table's `0.0907` is the arithmetic mean of the individual seed-level MAEs.

## Justified Interpretation

The figure shows that high-`N` nitride predictions still preserve the broad formation-energy trend, but remain visibly noisier than the oxide control case. The point cloud follows parity overall, yet there is still noticeable scatter, especially in the moderate-to-high positive-energy region.

Unlike the `N=10` nitride parity plot, this panel reflects a genuinely fine-tuned model in checkpoint terms. The linked summary table reports `mean_best_epoch = 45.0` at `N=1000`, compared with `1.0` at `N=10`, so the model has clearly entered a multi-epoch adaptation regime.

At the same time, the headline parity error is essentially unchanged from the nitride `N=10` case. The on-figure MAE is `0.0829 eV/atom` here versus `0.0828` at `N=10`, while the per-seed mean MAE is `0.0907 eV/atom` here versus `0.0874` at `N=10`. The clearer improvement is reduced seed variability: the per-seed MAE standard deviation contracts from `0.0199` at `N=10` to `0.0135 eV/atom` at `N=1000`.

The safest overall interpretation is therefore that high-`N` nitride fine-tuning becomes genuine and more reproducible, but still does not recover nitride zero-shot accuracy under Set 1. This is consistent with nitrides remaining the harder, out-of-distribution family in the project framing.

## Non-Claims / Cautions

- This figure does not show that nitride `N=1000` fine-tuning beats nitride zero-shot. The linked summary table shows nitride zero-shot remains better.
- This figure should not be used to claim a dramatic accuracy improvement over the nitride `N=10` parity panel; the headline parity metrics are nearly unchanged.
- This figure alone does not establish oxide-versus-nitride domain shift; that requires the matched oxide `N=1000` parity panel and/or the direct comparison section.
- This figure does not support any fine-tuning-versus-from-scratch claim; from-scratch comparisons do not exist at `N=1000`.
- The reported `R^2 = 0.9837` should not be treated as the main performance claim without the MAE/RMSE context.
- The figure averages predictions across seeds, so it does not display per-structure seed-to-seed uncertainty directly.
- The figure does not identify the mechanism behind the persistent positive-energy scatter; that requires embedding and comparison analysis.

## Caption Draft

Figure X. Nitride parity plot at fine-tuning size `N=1000` under Hyperparameter Set 1. Each point shows the mean prediction across 5 seeds plotted against the true formation energy for the nitride test set, and the dashed red line indicates ideal parity. On the ensemble-mean predictions, the figure reports `MAE = 0.0829 eV/atom`, `RMSE = 0.1220 eV/atom`, and `R^2 = 0.9837`. The linked fine-tuning summary gives `mean_best_epoch = 45.0` and `std_test_mae = 0.0135 eV/atom` at this setting, indicating a genuinely fine-tuned and somewhat more reproducible nitride model, although both the ensemble-mean and per-seed mean MAEs remain above the nitride zero-shot baseline.

## Results Paragraph Draft

Figure X shows the nitride high-`N` parity view for Hyperparameter Set 1 at `N=1000`. The ensemble-mean predictions across 5 seeds follow the overall parity trend, with on-figure metrics of `MAE = 0.0829 eV/atom`, `RMSE = 0.1220 eV/atom`, and `R^2 = 0.9837`, but the scatter remains visibly broader than in the matched oxide high-`N` panel. The canonical fine-tuning summary for the same setting reports a per-seed mean test MAE of `0.0907 +/- 0.0135 eV/atom`, which remains above the nitride zero-shot MAE of `0.0695 eV/atom`; the gap between `0.0829` and `0.0907` reflects the difference between seed-averaged predictions and the average of seed-level MAEs. Relative to the nitride `N=10` parity panel, the main change is not a large shift in headline MAE but a transition to a genuine multi-epoch fine-tuning regime (`mean_best_epoch = 45.0` versus `1.0`) and a tighter across-seed error distribution (`0.0135` versus `0.0199 eV/atom`). Thus, the high-`N` nitride panel indicates real adaptation and better reproducibility, but still no recovery below nitride zero-shot.

## Discussion Paragraph Draft

The nitride `N=1000` parity plot closes the nitride parity pair by showing what the shifted arm looks like after substantial supervised adaptation. The important result is not that the panel becomes oxide-like. Instead, it shows that even after moving from a one-epoch checkpoint at `N=10` to a multi-epoch checkpoint at `N=1000`, the nitride parity error remains broadly similar and still worse than nitride zero-shot. This means the nitride problem is not only a low-data or undertraining artifact. Under the canonical setup, adding much more labeled nitride data mainly yields a more reproducible version of a still-imperfect nitride predictor. In the report, that makes this figure the correct high-`N` companion to the nitride `N=10` panel and a strong bridge to the broader domain-shift interpretation, especially when contrasted with the much tighter oxide high-`N` parity view.

## Role In Report

- Main-text high-`N` parity panel for the nitride standalone report, paired with `FIG_S1_PARITY_NITRIDE_N10`.
- Supporting visual evidence in Results II of the combined paper, integrated into the nitride adaptation-onset subsection.
- Shift-side endpoint figure: shows that high-`N` nitride fine-tuning becomes a real multi-epoch regime, but still remains bounded above nitride zero-shot and visibly weaker than oxide.
- High-data reference for later comparison with the oxide high-`N` parity panel.
