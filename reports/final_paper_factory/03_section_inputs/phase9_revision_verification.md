# Phase 9 Revision Verification

**Date:** 2026-04-23  
**Files verified:** `combined_paper_results_III_and_IV_draft_v2.md`; `phase9_results_revision_changelog.md`  
**Verification target:** Phase 9 combined Results III / Results IV revision pass.

## Passed Checks

1. **Raw 256D family-separation metrics are now primary.**  
   Pass. Results IV now states that all quantitative claims are computed in raw 256D `last_alignn_pool` space. IV.B grounds family separation in silhouette, Davies-Bouldin, 15-NN family purity, and logistic-regression AUC.

2. **PCA / t-SNE / UMAP are descriptive support only.**  
   Pass. IV.A and IV.B explicitly say projections are descriptive, non-metric, and not used for compactness, asymmetry, inter-family distance, or numerical claims.

3. **III.A test-set-size wording is softened.**  
   Pass. The categorical v1 sentence was replaced with language acknowledging unequal sampling uncertainty from `1484` oxide vs `242` nitride test structures.

4. **III.C transfer-benefit caveat appears early enough.**  
   Pass. The caveats now appear immediately after the bar values and before any pattern interpretation. The nitride bar-height warning and the nitride `N = 50` initialization-advantage caveat are both explicit.

5. **III.E is shorter and still bridges to Results IV.**  
   Pass. III.E was reduced from `164` words in v1 to `72` words in v2 and now gives one compact synthesis plus one bridge question for Results IV.

6. **Alternative-distance / appendix dependency removed.**  
   Pass. No centroid/Mahalanobis alternative-distance claim or unsupported appendix dependency appears in IV.C. The only appendix mentions are draft-stage placement notes, not evidence dependencies.

7. **IV.B and IV.E use safer correlational phrasing.**  
   Pass. IV.B and IV.E now use phrases such as "aligned with," "consistent," "co-varies," "correlational," and "not causal," rather than mechanism-proving language.

8. **Measured values did not change incorrectly.**  
   Pass. The v1-to-v2 diff shows no incorrect changes to the core measured values. Added CI values in IV.B match the embedding packet/source metrics. Zero-shot, fine-tuning, transfer-benefit, parity, PCA variance, and distance-error values align with the source packets.

9. **No new unsupported literature claims introduced.**  
   Pass. The citation placeholders and literature-framed transfer sentence are carried forward from v1 or remain placeholder-scoped. No new unsupported literature claim was introduced by the revision pass.

## Failed Checks

None.

## Ambiguous Checks

- **Citation placeholders remain unresolved.** This is expected per the draft note and changelog, but final manuscript assembly must replace `[CITE: ...]` placeholders with the project reference list.
- **Zero-shot uncertainty remains qualitative.** III.A now acknowledges unequal sampling uncertainty, but bootstrap CIs for zero-shot MAE are not yet part of the canonical number set.

## Remaining Scientific-Writing Risks

- A minor causal-sounding phrase remains outside the exact IV.B/IV.E target: III.E asks whether the representation "produces these outputs," and the Results IV opener says the section examines the representation "that produces them." This is not a checklist failure because IV.B and IV.E were fixed, but a later polish pass could change both to "from which those outputs are computed."
- IV.D still says the embedding analysis can "localize relative difficulty to individual structures." The surrounding text is correlational and safe, but this phrase should be watched in final prose so it does not become too explanatory.
- The changelog's known item about standardizing "less organized" to "less cohesive" remains open. The draft is scientifically safe, but stylistic consistency would improve with that cleanup.

## Final Verdict

ready for next review
