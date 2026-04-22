# Oxide Revision Verification

**Verification target:** revised oxide standalone report section-input files  
**Date:** 2026-04-22  
**Verifier:** Codex

This pass checks whether the revision actually fixed the major scientific-writing issues without damaging the evidence base.

**Passed checks**

1. Over-strong source-distribution claims were materially softened.
- The v1 claim that oxides are "well represented in this source distribution" is gone.
- The revised framing is now project-design language with an explicit disclaimer:
- `oxide_analysis_document_v2.md:19` says the oxide arm is the in-distribution control condition "by project design" and adds, "We do not make independent claims about the exact chemical composition of the pretraining corpus."
- `oxide_results_section_draft_v2.md:23` uses the same control-arm framing and the same pretraining-corpus disclaimer.
- `oxide_analysis_document_v2.md:170` also explicitly forbids characterizing the checkpoint as chemically oxide-specific.

2. Early Results wording no longer overstates "ceiling" claims.
- The major benchmark-framing fixes are real:
- `oxide_results_section_draft_v2.md:17` now says "best Set 1 oxide benchmark" instead of "in-distribution ceiling."
- `oxide_results_section_draft_v2.md:25` now says "best observed oxide performance under Set 1."
- `oxide_results_section_draft_v2.md:29` now says "does not surpass" the zero-shot benchmark rather than "does not cross the ceiling."
- The same softening is reflected in the analysis memo:
- `oxide_analysis_document_v2.md:26-30,46-59,155-159`
- The benchmark claim is now scoped correctly to the tested Set 1 protocol.

3. Pretrained-vs-scratch is now clearly the central oxide-side evidence for transfer value.
- This is now explicit in both files, not merely implied:
- `oxide_analysis_document_v2.md:25,89-116,154,176`
- `oxide_results_section_draft_v2.md:5,15,60-79,99`
- The revised Results draft now structurally builds toward Section 3.4 as the oxide report's main transfer-value result, which is the right scientific emphasis.

4. The parity-plot discussion is tighter and shorter.
- In the Results draft, the old parity block plus surrounding parity-linked interpretation ran longer and mixed two jobs together. The revised parity subsection is cleaner and shorter in local word count:
- old block sampled from `oxide_results_section_draft.md`: 239 words
- new block sampled from `oxide_results_section_draft_v2.md`: 228 words
- In the analysis memo, the parity support shrank from 117 words to 102 words while keeping the key aggregation caveat.
- The revised parity handling is better bounded:
- `oxide_results_section_draft_v2.md:54-58`
- `oxide_analysis_document_v2.md:85`

5. The oxide embedding subsection now has a self-contained oxide payoff.
- The revision clearly fixes the old "handoff to nitride" problem.
- `oxide_analysis_document_v2.md:132-145` now leads with a positive oxide-side finding and explicitly says, "This is a real oxide-specific finding, not a handoff."
- `oxide_results_section_draft_v2.md:81-89` now states the oxide-side embedding result as a self-contained representation-level finding, with the nitride-facing mechanism pushed back into the uncertainty boundary where it belongs.

6. The overall oxide identity is now clear and coherent.
- The revised files now present oxide as:
- the control arm
- the best-case transfer-learning reference condition
- scientifically important without forcing artificial drama
- The clearest anchors are:
- `oxide_analysis_document_v2.md:5`
- `oxide_results_section_draft_v2.md:5`
- `oxide_analysis_document_v2.md:159`
- `oxide_results_section_draft_v2.md:107`

7. No measured values were changed incorrectly.
- Zero-shot values match `reports/zero_shot/zero_shot_summary.csv`:
- oxide test MAE `0.0341836068`, rounded in prose as `0.0342`
- Fine-tuning values match `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`:
- `N=10`: `0.0417315982 +/- 0.0111156520`, `mean_best_epoch = 1.0`
- `N=50`: `0.0522985784 +/- 0.0147872550`, `mean_best_epoch = 18.5`
- `N=500`: `0.0429627431 +/- 0.0062320128`, `mean_best_epoch = 39.0`
- `N=1000`: `0.0416922026 +/- 0.0053332587`, `mean_best_epoch = 35.5`
- From-scratch values match `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`:
- `N=50`: `0.5560532795`
- `N=500`: `0.2643359895`
- Derived transfer gaps are also consistent with `canonical_numbers_v2.md`:
- `0.5037547011` at `N=50`
- `0.2213732464` at `N=500`
- Embedding values match `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`:
- oxide 15-NN purity `0.9871518419` -> `0.9872`
- oxide silhouette `0.2545637433` -> `0.2546`
- nitride silhouette `0.1453358383` -> `0.1453`
- family AUC `0.9993623443` -> `0.9994`
- Parity numbers match the figure memos:
- `FIG_S1_PARITY_OXIDE_N10`: MAE `0.0391`, RMSE `0.0699`, `R^2 = 0.9944`
- `FIG_S1_PARITY_OXIDE_N1000`: MAE `0.0383`, RMSE `0.0706`, `R^2 = 0.9943`

8. No new checkpoint-distribution overclaims were introduced.
- The strongest unsupported corpus-composition claims from v1 were removed.
- The revised files consistently avoid saying the checkpoint was trained on oxides specifically or that oxide prevalence in the corpus has been independently established.
- The new wording keeps the oxide arm grounded in project design rather than asserted checkpoint composition.

**Failed checks**

- None.

**Ambiguous checks**

1. A small citation-boundary blur remains in the Results draft.
- `oxide_results_section_draft_v2.md:23` attaches JARVIS / JARVIS-Leaderboard citations to a sentence whose main substantive point is project design: that oxide functions as the in-distribution control arm in this study.
- This is not a checkpoint-distribution overclaim, but it does slightly blur the distinction between external provenance and our study design.

2. One rhetorical "ceiling" phrase survives in the embedding subsection.
- `oxide_analysis_document_v2.md:142`
- `oxide_results_section_draft_v2.md:85`
- In both places, "essentially ceiling level" refers to the family-AUC being near 1.0, not to the zero-shot performance benchmark. This is much less problematic than the old zero-shot-ceiling framing, but it is still elevated language.

**Any remaining scientific-writing risks**

- The strongest remaining style risk is not factual but tonal: the control-arm framing is now good, but phrases like "chemistry-aligned control task" and the `~25x` ratio can still read rhetorically sharpened if the final prose is not handled carefully.
- The line at `oxide_results_section_draft_v2.md:23` would be cleaner if the project-design point were stated without external citations, then followed by a separate provenance sentence if needed.
- The embedding subsection is now self-contained and much better, but it still uses a nitride comparison (`oxide silhouette 0.2546 vs nitride 0.1453`) as one of its three payoff bullets. That is evidence-backed and acceptable, but it should stay framed as calibration rather than competitive drama.

**Final verdict**

`ready for next review`

The revision pass fixed the major scientific-writing problems. The corpus-composition overclaims were removed, the zero-shot benchmark language was properly scoped, pretrained-vs-scratch is now the oxide paper's actual scientific center of gravity, the parity discussion is cleaner, and the embedding subsection now contributes a real oxide-side result instead of mainly forwarding to nitride. The remaining issues are minor rhetorical hygiene issues, not reasons for another mandatory patch before the next review.
