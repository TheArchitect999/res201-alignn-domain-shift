# Figure Memo: Fig. 03 Nitride Learning Curve

## Metadata

- Figure label: `FIG_S1_LC_NITRIDE`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_LC_NITRIDE.png`
- Canonical source path: `reports/Hyperparameter Set 1/Learning Curves/Nitride Learning Curve - Hyperparameter Set 1.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `nitride | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT_Figure_Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude_Figure_Memo.txt`

## What The Figure Shows

This figure shows the nitride fine-tuning learning curve under the canonical Hyperparameter Set 1 setting. The x-axis is fine-tuning size `N = 10, 50, 100, 200, 500, 1000`, and the y-axis is test MAE in eV/atom on the fixed nitride test set (`n_test = 242`). The blue line is the mean test MAE across 5 runs, the shaded region is `+/- 1` standard deviation across runs, and the red dashed line marks the nitride zero-shot baseline (`0.0695 eV/atom`, more precisely `0.0695420150` in the linked summary table).

The linked summary table gives the following mean fine-tuned test MAEs: `0.0874` (`N=10`), `0.1173` (`N=50`), `0.1722` (`N=100`), `0.1392` (`N=200`), `0.0977` (`N=500`), and `0.0907` (`N=1000`). The corresponding mean best epochs are `1.0`, `1.0`, `1.0`, `1.0`, `40.5`, and `45.0`.

## Justified Interpretation

The safest interpretation is that nitride zero-shot performance is stronger than every fine-tuned mean produced under the canonical setup. The curve worsens sharply from `N=10` through `N=100`, then partially recovers at `N=500` and `N=1000`, but it never descends to the zero-shot baseline.

The mean best epoch values split the curve into two regimes. For `N <= 200`, the selected checkpoint is always `epoch 1`, indicating that the low-data nitride runs do not progress into a stable multi-epoch adaptation regime. These rows can be described as operationally inert or early-checkpoint fine-tuning, but they should not be described as preserving zero-shot performance, because all four rows remain worse than the zero-shot baseline.

At `N=500` and `N=1000`, the mean best epoch rises to `40.5` and `45.0`, respectively. That is the first clear sign of real multi-epoch nitride adaptation under Set 1. Even there, however, the mean test MAEs (`0.0977` and `0.0907 eV/atom`) remain above zero-shot, so larger nitride sample sizes reduce the damage without surpassing the pretrained baseline.

This is consistent with nitrides serving as the out-of-distribution family in the study. Relative to the oxide control arm, nitride fine-tuning is less stable, more variance-prone in the low- to mid-data regime, and slower to enter a genuine adaptation regime.

## Non-Claims / Cautions

- This figure does not show that nitride fine-tuning is beneficial in absolute terms. It is worse than zero-shot at every sampled `N`.
- This figure alone does not prove the cause is representation-space domain shift; that requires the embedding figures and tables.
- This figure alone does not support any fine-tuning-versus-from-scratch claim; that requires the nitride comparison plot and from-scratch summary.
- This figure should not be used to claim that low-`N` nitride checkpoints preserve the zero-shot model exactly. The evidence supports early-checkpoint selection (`mean_best_epoch = 1.0`), but the MAEs are still worse than zero-shot.
- This figure does not justify a firm saturation claim. Performance improves after `N=100`, but even `N=1000` remains above zero-shot.
- The shaded variability bands do not justify significance claims between nearby `N` values.
- This figure does not establish the oxide-versus-nitride contrast by itself; that requires the oxide learning curve or the direct comparison section.

## Caption Draft

Figure X. Nitride fine-tuning learning curve under Hyperparameter Set 1. Mean test MAE (eV/atom) across 5 runs is shown versus fine-tuning size `N = 10, 50, 100, 200, 500, 1000`, with shading indicating `+/- 1` standard deviation across runs. The red dashed line marks the nitride zero-shot baseline (`0.0695 eV/atom`) on the same test set. Fine-tuned nitride performance remains worse than zero-shot at every sampled `N`, with the largest degradation and variance in the low- to mid-data regime. Mean best epoch equals `1.0` for `N <= 200`, while `N=500` and `N=1000` are the first settings that show sustained multi-epoch adaptation, although neither recovers the zero-shot baseline.

## Results Paragraph Draft

Figure X shows the nitride fine-tuning trajectory under the canonical Set 1 configuration. The nitride zero-shot baseline is `0.0695 eV/atom`, and every fine-tuned mean remains above that value across the full sampled range. Mean test MAE rises from `0.0874 eV/atom` at `N=10` to `0.1173 eV/atom` at `N=50` and peaks at `0.1722 eV/atom` at `N=100`, then decreases to `0.1392 eV/atom` at `N=200`, `0.0977 eV/atom` at `N=500`, and `0.0907 eV/atom` at `N=1000`. Variability is especially large in the low- and mid-data regime, with standard deviation reaching `0.0996 eV/atom` at `N=100`, before narrowing to `0.0135 eV/atom` at `N=1000`. The mean best epoch remains `1.0` for `N=10`, `50`, `100`, and `200`, then rises to `40.5` at `N=500` and `45.0` at `N=1000`, indicating that genuine multi-epoch nitride adaptation begins only at the largest two sample sizes tested. Even so, all transfer-gain values remain negative relative to zero-shot, so the largest nitride fine-tuning runs still do not recover the pretrained baseline under Set 1.

## Discussion Paragraph Draft

The nitride learning curve is the clearest behavioral evidence that transfer becomes less efficient under chemical-family mismatch in this study. In contrast to the oxide control arm, the nitride arm shows strong low-data degradation, very large seed sensitivity in the middle of the curve, and only partial recovery once `N` reaches `500` and `1000`. The low-`N` rows are best interpreted as early-checkpoint or operationally inert fine-tuning: validation repeatedly selects `epoch 1`, yet the resulting models still underperform the nitride zero-shot baseline. This means the issue is not merely that fine-tuning fails to improve enough; under the canonical setup, it initially moves the model into a worse regime before larger sample sizes allow partial recovery. The later rise in mean best epoch and the reduced variance at `N=500` and `N=1000` show that the model can begin adapting to nitride chemistry when more labeled data is available, but the failure to beat zero-shot even at `N=1000` indicates that the out-of-distribution penalty remains substantial.

## Role In Report

- Main-text anchor for the nitride standalone report Results subsections on low-`N` inertness and adaptation onset at high `N`.
- Main-text anchor for Results II in the combined paper, where nitrides serve as the out-of-distribution arm.
- Key comparison axis for Results III in the combined paper when contrasted directly with the oxide learning curve.
- Important guardrail figure for wording discipline: low-`N` nitride should be described as early-checkpoint / effectively inert behavior that still underperforms zero-shot, not as successful adaptation.
