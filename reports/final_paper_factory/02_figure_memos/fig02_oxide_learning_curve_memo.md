# Figure Memo: Fig. 02 Oxide Learning Curve

## Metadata

- Figure label: `FIG_S1_LC_OXIDE`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_S1_LC_OXIDE.png`
- Canonical source path: `reports/Hyperparameter Set 1/Learning Curves/Oxide Learning Curve - Hyperparameter Set 1.png`
- Linked table: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Report membership: `oxide | combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure shows the oxide fine-tuning learning curve under the canonical Hyperparameter Set 1 setting. The x-axis is fine-tuning size `N = 10, 50, 100, 200, 500, 1000`, and the y-axis is test MAE in eV/atom on the fixed oxide test set (`n_test = 1484`). The blue line is the mean test MAE across 5 runs, the shaded region is `+/- 1` standard deviation across runs, and the red dashed line marks the oxide zero-shot baseline (`0.0342 eV/atom`, more precisely `0.0341836068` in the linked summary table).

The linked summary table gives the following mean fine-tuned test MAEs: `0.0417` (`N=10`), `0.0523` (`N=50`), `0.0465` (`N=100`), `0.0457` (`N=200`), `0.0430` (`N=500`), and `0.0417` (`N=1000`). The corresponding mean best epochs are `1.0`, `18.5`, `20.0`, `39.0`, `39.0`, and `35.5`.

## Justified Interpretation

The safest interpretation is that oxide zero-shot performance is already strong under the canonical setup, and fine-tuning does not improve on that zero-shot baseline at any sampled `N`. The worst fine-tuned mean appears at `N=50`, after which the curve improves steadily through `N=1000`, but the fine-tuned mean remains above the zero-shot line throughout.

This supports the intended role of oxides as the in-distribution control family. Under Set 1, the pretrained model already starts from a strong oxide error level, so added supervised fine-tuning mainly reduces the degradation seen in the smaller-data regime rather than surpassing zero-shot.

The `N=10` point should be interpreted carefully. Its mean best epoch is `1.0`, so the result is consistent with validation selecting a near-pretrained checkpoint rather than a strongly adapted low-data model. That makes the `N=10` row a weak basis for claims about genuine low-data adaptation, even though its mean MAE is better than the `N=50` through `N=500` rows.

Across the sampled range, oxide fine-tuning also becomes more stable with more data: the across-run standard deviation decreases from `0.0111` at `N=10` to `0.0053` at `N=1000`.

## Non-Claims / Cautions

- This figure does not show that oxide fine-tuning beats oxide zero-shot. It does not.
- This figure alone does not establish oxide-versus-nitride domain shift; that requires the nitride learning curve and/or direct oxide-nitride comparison.
- This figure alone does not show transfer-learning benefit versus from-scratch training; that requires the oxide comparison plot and from-scratch summary.
- This figure does not justify a firm saturation claim. The curve improves at larger `N`, but the best fine-tuned mean is still above zero-shot.
- The `N=10` point should not be overread as successful low-data adaptation, because `mean_best_epoch = 1.0` indicates minimal movement from the pretrained state.
- The shaded variability bands do not justify significance claims between nearby `N` values.
- This figure does not identify the mechanism behind the observed behavior; embedding analysis and scratch comparisons are needed for that.

## Caption Draft

Figure X. Oxide fine-tuning learning curve under Hyperparameter Set 1. Mean test MAE (eV/atom) across 5 runs is shown versus fine-tuning size `N = 10, 50, 100, 200, 500, 1000`, with shading indicating `+/- 1` standard deviation across runs. The red dashed line marks the oxide zero-shot baseline (`0.0342 eV/atom`) on the same test set. Fine-tuned oxide performance improves after the low-data regime but remains above the zero-shot baseline at every sampled `N`, indicating that the pretrained model already provides a strong in-distribution starting point for oxides under the canonical setting.

## Results Paragraph Draft

Figure X shows the oxide fine-tuning trajectory under the canonical Set 1 configuration. The oxide zero-shot baseline is `0.0342 eV/atom`, and every fine-tuned mean remains above that value across the full sampled range. Mean test MAE rises from `0.0417 eV/atom` at `N=10` to a worst value of `0.0523 eV/atom` at `N=50`, then decreases progressively to `0.0417 eV/atom` at `N=1000`. The `N=10` row should be interpreted with caution because `mean_best_epoch = 1.0`, whereas the larger-`N` rows show genuine optimization activity (`18.5` to `39.0` mean best epochs). Across the same range, the across-run standard deviation narrows from `0.0111` to `0.0053 eV/atom`, indicating more stable fine-tuning behavior at larger `N`. Overall, the oxide curve shows gradual recovery from low-data degradation with increasing labeled data, but not improvement beyond the already strong zero-shot baseline.

## Discussion Paragraph Draft

In the oxide control arm, the main value of pretraining appears in the strength of the initial zero-shot model rather than in post hoc fine-tuning gains under Set 1. Because oxides are the in-distribution family in this study, a strong zero-shot result is scientifically important: it indicates that the pretrained representation already captures oxide-relevant structure well enough that additional supervised adaptation provides little headroom for improvement. The curve still matters because it shows how the model responds once labeled oxide data is introduced. Fine-tuning is least favorable in the small-data regime, then becomes smoother and less variable as `N` increases, which is consistent with oxide being the easier adaptation case relative to the out-of-distribution family. That cross-family comparison, however, should be made explicitly against the nitride trajectory rather than inferred from the oxide curve alone.

## Role In Report

- Main-text anchor for the oxide standalone report Results subsection on fine-tuning across `N`.
- Main-text anchor for Results I in the combined paper, where oxide is established as the in-distribution control arm.
- Later comparison axis for Results III in the combined paper when contrasted directly with the nitride learning curve.
- Not sufficient on its own for scratch-comparison claims or full domain-shift claims; those require additional figures.
