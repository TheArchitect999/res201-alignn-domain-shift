# Figure Memo: Fig. 05A Oxide Comparison Plot

## Metadata

- Figure label: `FIG_S1_COMP_OXIDE`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_COMP_OXIDE.png`
- Canonical source path: `reports/Hyperparameter Set 1/Comparison Plots/Oxide Comparison Plot - Hyperparameter Set 1.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- Supporting fine-tune table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `oxide | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure compares oxide fine-tuning and oxide training from scratch under Hyperparameter Set 1 at the two sample sizes where from-scratch baselines were run: `N=50` and `N=500`. The blue line shows the fine-tune mean test MAE with a `+/- 1 std` band across 5 runs, the orange line shows the from-scratch mean test MAE with its own `+/- 1 std` band across 5 runs, and the dashed red line marks the oxide zero-shot baseline (`0.0342 eV/atom`, more precisely `0.0341836068` in the linked fine-tuning summary).

The canonical summary tables give the following values:

- Fine-tune at `N=50`: `0.0523 +/- 0.0148 eV/atom`
- Fine-tune at `N=500`: `0.0430 +/- 0.0062 eV/atom`
- From scratch at `N=50`: `0.5561 +/- 0.0523 eV/atom`
- From scratch at `N=500`: `0.2643 +/- 0.0228 eV/atom`

The figure therefore compares three oxide baselines on the same test set: zero-shot, fine-tuned, and from-scratch, with scratch available only at `N=50` and `N=500`.

## Justified Interpretation

The safest interpretation is that pretrained initialization provides a very large practical advantage over random initialization on the oxide control family. At both sampled scratch data sizes, the fine-tuned model is far lower in test MAE than the from-scratch model, and it also has a smaller uncertainty band.

The figure also shows an important nuance already visible in the oxide learning curve. Fine-tuning strongly outperforms from scratch, but it still does not cross the oxide zero-shot baseline at either `N=50` or `N=500`. This means the main value of pretraining on oxides under Set 1 is already present in the pretrained starting point, while supervised fine-tuning mainly preserves that advantage over scratch rather than improving beyond zero-shot.

Across the two sampled `N` values, both methods improve as more labeled oxide data is added. However, the from-scratch curve drops much more sharply than the fine-tune curve. That supports a conservative control-arm reading: oxide scratch training benefits strongly from more data, but within the sampled range it still remains much worse than the pretrained route.

## Non-Claims / Cautions

- This figure does not show that oxide fine-tuning is the best oxide strategy overall; oxide zero-shot remains lower than both fine-tune points shown here.
- This figure does not support any scratch-versus-fine-tune claim outside `N=50` and `N=500`, because from-scratch baselines do not exist at `N=10`, `100`, `200`, or `1000`.
- This figure alone does not establish anything about nitrides; that requires the nitride comparison plot or the direct comparison section.
- This figure does not show the asymptotic behavior of scratch training, because only two `N` values are sampled.
- This figure does not identify the mechanism behind the pretraining advantage; embedding and cross-family evidence are needed for that.
- This figure does not justify cross-hyperparameter conclusions; it is specific to the canonical Set 1 configuration.

## Caption Draft

Figure X. Oxide fine-tune versus from-scratch comparison under Hyperparameter Set 1. Mean test MAE (eV/atom) is shown for oxide fine-tuning and oxide training from scratch at the two sample sizes where from-scratch baselines were run (`N=50` and `N=500`), with shaded bands indicating `+/- 1 std` across 5 runs. The dashed red line marks the oxide zero-shot baseline (`0.0342 eV/atom`). Fine-tuning is far lower in MAE than training from scratch at both sampled data sizes, indicating strong pretraining value on the in-distribution oxide family, although the zero-shot baseline remains below both fine-tuned points.

## Results Paragraph Draft

Figure X compares oxide fine-tuning against oxide training from scratch at the two sampled scratch data sizes, `N=50` and `N=500`. At `N=50`, the fine-tuned mean test MAE is `0.0523 +/- 0.0148 eV/atom`, whereas the from-scratch mean is `0.5561 +/- 0.0523 eV/atom`. At `N=500`, the fine-tuned mean improves to `0.0430 +/- 0.0062 eV/atom`, while the from-scratch mean decreases to `0.2643 +/- 0.0228 eV/atom`. Thus, increasing labeled oxide data improves both methods, but the pretrained route remains far superior at both sampled points. However, the oxide zero-shot baseline (`0.0342 eV/atom`) remains below the fine-tuned means at both `N=50` and `N=500`, indicating that the largest practical gain in the oxide arm comes from pretraining relative to scratch, not from surpassing the pretrained baseline through fine-tuning.

## Discussion Paragraph Draft

This oxide comparison plot provides some of the clearest evidence in the project that pretraining is highly valuable when the target chemistry is relatively familiar. Relative to random initialization, the pretrained model yields much lower error at both sampled oxide data sizes and does so with smaller run-to-run variability. That is the expected control-side outcome for an in-distribution family. At the same time, the figure also reinforces the oxide zero-shot ceiling seen elsewhere in the repo: supervised fine-tuning under Set 1 preserves a large advantage over scratch, but does not improve beyond the already strong pretrained baseline. In the broader paper, that makes this figure the correct oxide-side anchor for pretraining value and the natural companion to the later nitride comparison plot.

## Role In Report

- Main-text from-scratch comparison figure for the oxide standalone report.
- Main-text Results I figure in the combined paper for quantifying pretraining value on the control task.
- Oxide-side companion to the later nitride comparison plot in the transfer-benefit discussion.
- Scope-guard figure: all scratch comparisons here are limited to `N=50` and `N=500`.
