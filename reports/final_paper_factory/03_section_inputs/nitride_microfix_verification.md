# Nitride Micro-Fix Verification

**Date:** 2026-04-23

**Scope reviewed:** `nitride_analysis_document_v3.md`, `nitride_results_section_draft_v3.md`, and `nitride_microfix_changelog.md`.

## Check Results

1. **Source-distribution phrasing remains evidence-bounded:** pass. The live v3 prose uses "a pretraining regime more aligned with oxides than nitrides" and keeps "oxide-pretrained" only as a negated caveat. "Oxide-skewed reference regime" appears only in changelog before/rationale text, not as live v3 wording.

2. **"Without being trained to" replacement:** pass for live v3 prose. Both v3 documents use "without being explicitly supervised on family labels." The older phrase appears only in changelog before/rationale text documenting the replacement.

3. **"Domain-shift penalty" as main term:** pass. The previous shorthand instances ("zero-shot family penalty," "embedding-space geometry consistent with the penalty," "the penalty survives," and "persistence of the penalty") have been standardized in the live v3 prose.

4. **Measured values changed:** pass. Diffing v2 against v3 shows only title/wording edits and no changes to MAE, standard deviations, `mean_best_epoch`, embedding separation statistics, distance-error statistics, confidence intervals, q-values, or sample counts.

## Verdict

clean and ready
