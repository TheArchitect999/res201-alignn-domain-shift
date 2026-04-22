# Figure Memo: Fig. 05 Transfer-Benefit Comparison

## Metadata

- Figure label: `FIG_TRANSFER_BENEFIT`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.png`
- Canonical source path: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.png`
- Linked tables:
  - `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
  - `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Definition shown in figure: `transfer benefit = scratch MAE - fine-tuned MAE`
- Report membership: `combined`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure compares the transfer benefit of pretraining across the oxide and nitride families at the only two sample sizes where from-scratch baselines were run: `N=50` and `N=500`. The plotted quantity is defined as `scratch MAE - fine-tuned MAE`, so a larger positive bar indicates a larger improvement from starting with pretrained weights rather than random initialization.

The four plotted bar values are:

- Oxide, `N=50`: `0.504 eV/atom`
- Nitride, `N=50`: `0.574 eV/atom` with an explicit caveat marker
- Oxide, `N=500`: `0.221 eV/atom`
- Nitride, `N=500`: `0.271 eV/atom`

These values are consistent with the canonical Set 1 summary tables:

- Oxide, `N=50`: scratch `0.5561` minus fine-tune `0.0523` = `0.5038`
- Nitride, `N=50`: scratch `0.6914` minus fine-tune `0.1173` = `0.5741`
- Oxide, `N=500`: scratch `0.2643` minus fine-tune `0.0430` = `0.2214`
- Nitride, `N=500`: scratch `0.3683` minus fine-tune `0.0977` = `0.2706`

The footnote on the nitride `N=50` bar states that this value reflects pretrained initialization advantage under the canonical analysis and should not be overinterpreted as strong fine-tuning adaptation.

## Justified Interpretation

The safest interpretation is that pretraining provides a large positive advantage over random initialization in both families at both matched data sizes. That is the main result this figure is designed to show.

The second justified pattern is that transfer benefit is larger at `N=50` than at `N=500` for both families. This is consistent with the usual transfer-learning expectation that pretrained initialization matters most in the smaller-data regime and that the scratch route closes part of the gap as more labeled data becomes available.

The most important caution is how to read the cross-family ordering. The nitride bars are slightly taller than the oxide bars at both `N` values, but that does not mean nitrides adapt better overall. It means the scratch-to-fine-tune gap is larger in absolute MAE terms for nitrides at these matched points. Because the nitride scratch baseline is worse than the oxide scratch baseline at both `N=50` and `N=500`, the nitride transfer-benefit bars are mechanically inflated by a weaker random-initialization anchor.

The nitride `N=50` caveat is essential. Under the canonical analysis, that point is a pretrained-initialization advantage over scratch, not a clean adaptation-success result. The figure itself already flags this, and the memo should preserve that exact reading.

## Non-Claims / Cautions

- This figure does not show that nitrides transfer more effectively than oxides in a broader scientific sense; the taller nitride bars reflect a worse scratch baseline, not better final performance quality.
- This figure does not support any claim outside `N=50` and `N=500`, because from-scratch baselines do not exist at `N=10`, `100`, `200`, or `1000`.
- This figure does not compare zero-shot against fine-tuning directly; it is only about fine-tune versus scratch.
- This figure does not show that nitride `N=50` is strong fine-tuning adaptation; the footnote explicitly warns that it reflects initialization advantage.
- This figure does not explain the mechanism behind the family difference; embedding analyses are needed for that.
- This figure has no uncertainty bars, so family-level bar-height differences should not be overread as a standalone statistical comparison.

## Caption Draft

Figure X. Transfer benefit of pretraining for oxide and nitride formation-energy prediction at `N=50` and `N=500`. Transfer benefit is defined as `scratch MAE - fine-tuned MAE`, so larger values indicate a larger improvement from pretrained initialization relative to random initialization at matched training-set size. Pretraining provides a substantial positive benefit in both families at both data sizes, with larger gains in the smaller-data regime. The nitride `N=50` bar is marked with a caveat because, under the canonical analysis, it reflects pretrained initialization advantage over scratch rather than strong fine-tuning adaptation.

## Results Paragraph Draft

Figure X compares the transfer benefit of pretraining across oxide and nitride families at the two sample sizes where from-scratch baselines were run. For oxides, the transfer benefit is `0.504 eV/atom` at `N=50` and `0.221 eV/atom` at `N=500`. For nitrides, the corresponding values are `0.574 eV/atom` at `N=50` and `0.271 eV/atom` at `N=500`. Thus, pretrained initialization substantially outperforms random initialization in both families, and the absolute benefit is larger in the smaller-data regime for both. The nitride `N=50` bar requires a specific interpretation guardrail: although the improvement over scratch is large, the canonical analysis indicates that this low-`N` nitride result is best read as pretrained initialization advantage rather than strong fine-tuning adaptation.

## Discussion Paragraph Draft

This figure clarifies an important nuance in the domain-shift story. Pretraining is clearly valuable not only for oxides but also for nitrides, because the fine-tuned route is much better than training from scratch at the matched `N=50` and `N=500` budgets. However, the slightly larger transfer-benefit bars for nitrides should not be misread as cleaner or more successful transfer. Instead, they show that nitrides suffer more when starting from random initialization, so pretrained initialization prevents a larger loss. That is fully consistent with a domain-shift account: the out-of-distribution family still profits from pretraining in practical terms, but it remains harder overall and does not exploit fine-tuning as cleanly as the oxide control arm, especially in the low-data regime.

## Role In Report

- Main-text cross-family comparison figure for Results III in the combined paper.
- Shared summary figure for the question: how much does pretraining help relative to scratch, and how does that matched-budget help compare across families.
- Companion synthesis figure to `fig05a_oxide_comparison_plot_memo.md` and `fig05b_nitride_comparison_plot_memo.md`.
- Scope-guard figure: all claims here are strictly limited to `N=50` and `N=500`, with the nitride `N=50` initialization-advantage caveat carried explicitly.
