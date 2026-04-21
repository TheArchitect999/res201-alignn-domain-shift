# Figure Memo: Fig. 05B Nitride Comparison Plot

## Metadata

- Figure label: `FIG_S1_COMP_NITRIDE`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_COMP_NITRIDE.png`
- Canonical source path: `reports/Hyperparameter Set 1/Comparison Plots/Nitride Comparison Plot - Hyperparameter Set 1.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- Supporting fine-tune table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `nitride | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure compares nitride fine-tuning and nitride training from scratch under Hyperparameter Set 1 at the two sample sizes where from-scratch baselines were run: `N=50` and `N=500`. The blue line shows the fine-tune mean test MAE with a `+/- 1 std` band across 5 runs, the orange line shows the from-scratch mean test MAE with its own `+/- 1 std` band across 5 runs, and the dashed red line marks the nitride zero-shot baseline (`0.0695 eV/atom`, more precisely `0.0695420150` in the linked summaries).

The canonical summary tables give the following values:

- Fine-tune at `N=50`: `0.1173 +/- 0.0451 eV/atom`
- Fine-tune at `N=500`: `0.0977 +/- 0.0178 eV/atom`
- From scratch at `N=50`: `0.6914 +/- 0.0163 eV/atom`
- From scratch at `N=500`: `0.3683 +/- 0.0233 eV/atom`

The figure therefore compares three nitride reference levels on the same test set: zero-shot, fine-tuned, and from-scratch, with scratch available only at `N=50` and `N=500`.

## Justified Interpretation

The safest interpretation is that pretrained initialization provides a large practical advantage over random initialization on the nitride target family. At both sampled scratch data sizes, the fine-tuned model is far lower in test MAE than the from-scratch model.

This figure also requires an explicit low-`N` caveat. In the canonical fine-tuning summary, the nitride `N=50` checkpoint has `mean_best_epoch = 1.0`, so that point should be interpreted primarily as a pretrained-initialization advantage over scratch rather than as strong evidence of successful supervised adaptation. By contrast, `N=500` has `mean_best_epoch = 40.5`, making it the first clean nitride comparison in this figure between a genuinely fine-tuned model and a genuinely trained-from-scratch model.

The figure further shows that strong transfer benefit relative to scratch does not mean the nitride fine-tuned route surpasses the pretrained baseline. The nitride zero-shot line remains below both fine-tuned means shown here. That is the main difference from the oxide control comparison: pretraining remains highly valuable on nitrides, but the downstream nitride fine-tuning protocol still does not recover the zero-shot starting point.

One additional nuance is visible in the uncertainty bands. Fine-tune variability is much larger at `N=50` than at `N=500`, whereas the from-scratch variability is relatively similar across the two sampled sizes. That supports a conservative reading in which the low-`N` nitride regime is not only weakly adapted, but also less stable across runs.

## Non-Claims / Cautions

- This figure does not show that nitride fine-tuning beats the nitride zero-shot baseline; both fine-tuned means remain above zero-shot.
- This figure does not support presenting the `N=50` scratch-versus-fine-tune gap as a pure adaptation gain, because the fine-tuned checkpoint is effectively an epoch-1 model.
- This figure does not support any scratch-versus-fine-tune claim outside `N=50` and `N=500`, because from-scratch baselines do not exist at `N=10`, `100`, `200`, or `1000`.
- This figure alone does not establish why nitrides are harder; embedding and cross-family evidence are needed for the mechanism-level story.
- This figure does not show the asymptotic behavior of scratch training, because only two `N` values are sampled.
- This figure does not justify cross-hyperparameter conclusions; it is specific to the canonical Set 1 configuration.

## Caption Draft

Figure X. Nitride fine-tune versus from-scratch comparison under Hyperparameter Set 1. Mean test MAE (eV/atom) is shown for nitride fine-tuning and nitride training from scratch at the two sample sizes where from-scratch baselines were run (`N=50` and `N=500`), with shaded bands indicating `+/- 1 std` across 5 runs. The dashed red line marks the nitride zero-shot baseline (`0.0695 eV/atom`). Fine-tuning is far lower in MAE than training from scratch at both sampled data sizes, indicating strong practical pretraining value on the out-of-distribution nitride family. However, the `N=50` comparison should be read as a pretrained-initialization advantage over scratch because `mean_best_epoch = 1.0`, and the zero-shot baseline remains below both fine-tuned points.

## Results Paragraph Draft

Figure X compares nitride fine-tuning against nitride training from scratch at the two sampled scratch data sizes, `N=50` and `N=500`. At `N=50`, the fine-tuned mean test MAE is `0.1173 +/- 0.0451 eV/atom`, whereas the from-scratch mean is `0.6914 +/- 0.0163 eV/atom`. At `N=500`, the fine-tuned mean improves to `0.0977 +/- 0.0178 eV/atom`, while the from-scratch mean decreases to `0.3683 +/- 0.0233 eV/atom`. Thus, increasing labeled nitride data improves both methods, but the pretrained route remains much lower in MAE at both sampled points. At the same time, the nitride zero-shot baseline (`0.0695 eV/atom`) remains below both fine-tuned means. The low-`N` caveat is also important: the canonical fine-tuning summary gives `mean_best_epoch = 1.0` at `N=50` and `40.5` at `N=500`, so `N=50` is best interpreted as a pretrained-initialization advantage over scratch, while `N=500` is the first real adaptation comparison in this panel.

## Discussion Paragraph Draft

This nitride comparison plot is the clearest within-family evidence that pretraining remains highly valuable even under chemical-family shift. Relative to random initialization, the pretrained route yields much lower error at both sampled nitride data sizes. But the figure also shows why the nitride story cannot be framed as simple fine-tuning success. The zero-shot baseline remains better than both fine-tuned means, and the `N=50` point is effectively an epoch-1 checkpoint rather than a clean adapted model. In the broader paper, that makes this figure the correct nitride-side anchor for transfer benefit relative to scratch, while the nitride learning-curve and embedding figures carry the harder claim about reduced transfer efficiency under domain shift.

## Role In Report

- Main-text from-scratch comparison figure for the nitride standalone report.
- Main-text Results II figure in the combined paper for the nitride-side scratch-versus-pretrained contrast.
- Nitride-side companion to the oxide comparison plot in the transfer-benefit discussion.
- Scope-guard figure: all scratch comparisons here are limited to `N=50` and `N=500`, and the `N=50` point must be reported with the initialization-advantage caveat.
