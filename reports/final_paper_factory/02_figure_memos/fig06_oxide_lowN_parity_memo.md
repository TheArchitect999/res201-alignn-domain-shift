# Figure Memo: Fig. 06 Oxide Low-N Parity Plot

## Metadata

- Figure label: `FIG_S1_PARITY_OXIDE_N10`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_PARITY_OXIDE_N10.png`
- Canonical source path: `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=10.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `oxide | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is the oxide parity plot for Hyperparameter Set 1 at fine-tuning size `N=10`. Each point is a test-set oxide, with the x-axis showing true formation energy and the y-axis showing the predicted formation energy from the mean prediction across 5 seeds (`0, 1, 2, 3, 4`). The dashed red line is the ideal parity line `y = x`.

The figure itself reports `MAE = 0.0391 eV/atom`, `RMSE = 0.0699 eV/atom`, and `R^2 = 0.9944`. The linked summary table gives the canonical oxide `N=10` row as `mean_test_mae = 0.0417 eV/atom`, `std_test_mae = 0.0111 eV/atom`, `mean_best_epoch = 1.0`, and oxide zero-shot MAE `= 0.0342 eV/atom` on the same test set.

These two MAE values should be kept distinct. The figure's `0.0391` is computed on predictions averaged across seeds first, whereas the summary table's `0.0417` is the arithmetic mean of the individual seed-level MAEs. Both are valid, but they describe different aggregations.

## Justified Interpretation

The figure shows that oxide predictions remain visually close to parity even in the smallest fine-tuning setting used in the main text. Most points track the parity line closely, and there is no obvious large-scale systematic bias across the oxide test distribution.

At the same time, this panel should be interpreted as a near-pretrained or low-motion checkpoint view rather than as evidence of strong low-data fine-tuning success. The linked summary table reports `mean_best_epoch = 1.0` at `N=10`, so the selected checkpoint corresponds to essentially the earliest stage of training. That makes this figure best understood as a visual audit of the pretrained model state under the oxide control condition, not as proof that `N=10` fine-tuning improves oxide performance.

The on-figure parity metrics are still scientifically useful. They show that the pretrained representation already captures the oxide energy landscape well enough to preserve strong pointwise agreement at low `N`. That is consistent with the intended role of oxides as the in-distribution control family.

The key guardrail is that visual parity quality does not override the learning-curve result. The canonical summary row still shows oxide `N=10` underperforming oxide zero-shot by `0.0075 eV/atom` in transfer-gain terms, so this panel should be described as strong visual alignment with ground truth despite the absence of a zero-shot improvement.

## Non-Claims / Cautions

- This figure does not show that oxide `N=10` fine-tuning beats oxide zero-shot. The linked summary table shows the opposite.
- This figure does not by itself show that `N=10` is better or worse than `N=50`, `N=100`, `N=500`, or `N=1000`; that requires the learning curve and the high-`N` parity companion.
- This figure alone does not establish oxide-versus-nitride domain shift; that requires the nitride parity plot and/or the learning-curve comparison.
- This figure does not support any fine-tuning-versus-from-scratch claim; from-scratch evidence is separate and does not exist at `N=10`.
- The reported `R^2 = 0.9944` should not be used alone as the main performance claim, because parity plots over a wide target range can look strong in `R^2` even when MAE remains the more operational metric.
- The figure averages predictions across seeds, so it does not display per-structure seed-to-seed uncertainty directly.
- The figure does not identify why particular points deviate from parity; it shows prediction quality, not mechanism.

## Caption Draft

Figure X. Oxide parity plot at fine-tuning size `N=10` under Hyperparameter Set 1. Each point shows the mean prediction across 5 seeds plotted against the true formation energy for the oxide test set, and the dashed red line indicates ideal parity. On the ensemble-mean predictions, the figure reports `MAE = 0.0391 eV/atom`, `RMSE = 0.0699 eV/atom`, and `R^2 = 0.9944`. Because the linked fine-tuning summary gives `mean_best_epoch = 1.0` at this setting, the panel is best interpreted as a near-pretrained low-`N` checkpoint view of the oxide control arm rather than as evidence that fine-tuning improves on oxide zero-shot.

## Results Paragraph Draft

Figure X shows the oxide low-`N` parity view for Hyperparameter Set 1 at `N=10`. The ensemble-mean predictions across 5 seeds follow the ideal parity line closely over the oxide test set, with on-figure metrics of `MAE = 0.0391 eV/atom`, `RMSE = 0.0699 eV/atom`, and `R^2 = 0.9944`. The canonical fine-tuning summary for the same setting reports a per-seed mean test MAE of `0.0417 +/- 0.0111 eV/atom`, which is slightly worse than the oxide zero-shot MAE of `0.0342 eV/atom`; the difference from the on-figure MAE reflects the fact that the parity panel evaluates seed-averaged predictions, whereas the summary row averages each seed's MAE separately. Visually, most oxide predictions remain tightly concentrated around the parity line, indicating that the model preserves the overall oxide energy structure well even at the smallest fine-tuning size shown in the main text. However, because `mean_best_epoch = 1.0`, this panel should be read as a near-pretrained low-`N` snapshot rather than as a clear fine-tuning gain.

## Discussion Paragraph Draft

The oxide `N=10` parity plot reinforces the interpretation of oxides as the in-distribution control arm. Even when the selected checkpoint reflects essentially the first epoch of training, the model still produces visually coherent oxide predictions with strong pointwise agreement to the ground truth. This suggests that the pretrained representation already captures much of the structure needed for oxide formation-energy prediction. The important caution is that qualitative parity should not be confused with a transfer gain: the oxide learning-curve summary still places the `N=10` result slightly above oxide zero-shot. In the broader report, this makes the panel useful as a low-data visual baseline and as the left-hand member of the planned low-/high-`N` oxide parity pair, but not as evidence that low-data fine-tuning itself improves oxide performance.

## Role In Report

- Main-text low-`N` parity panel for the oxide standalone report, paired with `FIG_S1_PARITY_OXIDE_N1000`.
- Supporting visual evidence in Results I of the combined paper, integrated into the oxide fine-tuning subsection.
- Visual checkpoint-caveat figure: shows that oxide predictions remain coherent at `N=10`, while the linked table still indicates no improvement over zero-shot.
- Control-side reference for later comparison with the nitride low-`N` parity panel.
