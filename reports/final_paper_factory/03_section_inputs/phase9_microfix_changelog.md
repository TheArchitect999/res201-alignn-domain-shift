# Phase 9 Micro-fix Changelog — Results III / Results IV Wording Cleanup

**Source file:** `combined_paper_results_III_and_IV_draft_v2.md`
**Output file:** `combined_paper_results_III_and_IV_draft_v3.md`
**Date:** 2026-04-23
**Type:** Wording-only micro-fix — no structural edits, no value changes, no new claims

---

## Scope confirmation

- Lines changed: 3 (lines 67, 87, 109)
- Substitutions made: 4
- Sections modified: III.E (line 67), IV.B (line 87), IV.D (line 109)
- No measured values altered
- No section structure altered
- No scientific claims added or removed
- Projection guardrails in IV.A, IV.B, and IV.C preserved verbatim

---

## Fix 1 — Remove residual causal-sounding phrasing in III.E (line 67)

**Location:** Section III.E "Bridge to Results IV", closing sentence.

**v2 (before):**
> does the frozen pretrained representation **that produces these outputs** contain geometric structure consistent with the observed penalty?

**v3 (after):**
> does the frozen pretrained representation **from which these outputs are computed** contain geometric structure consistent with the observed penalty?

**Why:** "that produces these outputs" carries a production/causal implication — as if the representation is the active agent generating the behavioral outcomes. "From which these outputs are computed" situates the representation as the setting in which computation occurs, which is consistent with the correlational framing used throughout Sections IV.B, IV.D, and IV.E. This aligns with the phrasing already adopted in IV.E ("In the frozen representation from which those outputs are computed").

---

## Fix 2 — Soften "localize relative difficulty to individual structures" in IV.D (line 109)

**Location:** Section IV.D "What the embedding analysis adds beyond MAE and learning curves", third bullet-clause.

**v2 (before):**
> so the embedding analysis can **localize relative difficulty to individual structures** in a way that aggregate MAE cannot.

**v3 (after):**
> so the embedding analysis can **provide a within-family geometric correlate of relative difficulty across structures** in a way that aggregate MAE cannot.

**Why:** "Localize relative difficulty to individual structures" can read as a stronger explanatory claim — implying the embedding identifies or diagnoses the source of difficulty at the per-structure level. The replacement phrase "provide a within-family geometric correlate of relative difficulty across structures" makes explicit that the embedding analysis yields a correlational geometric indicator, not a mechanism, and that the relationship holds across the population (consistent with the Spearman and Pearson correlations reported in IV.C). The replacement matches the canonical phrase "correlational geometric indicator" used in IV.C.

---

## Fix 3 — Standardize "less/more organized" to "less/more cohesive" (lines 87 and 109)

### Fix 3a — IV.B line 87

**Location:** Section IV.B "What pattern is consistent", second pattern sentence.

**v2 (before):**
> the nitride region is distinguishable from oxides but internally **less organized** than the oxide region.

**v3 (after):**
> the nitride region is distinguishable from oxides but internally **less cohesive** than the oxide region.

### Fix 3b — IV.D line 109

**Location:** Section IV.D "What the embedding analysis adds beyond MAE and learning curves", second bullet-clause.

**v2 (before):**
> the oxide region is more internally **organized** than the nitride region

**v3 (after):**
> the oxide region is more internally **cohesive** than the nitride region

**Why (both):** "Less/more organized" and "less/more cohesive" describe the same raw-space property (internal tightness of the family cluster as measured by per-family silhouette and 15-NN purity), but "organized" is informal and potentially ambiguous. "Cohesive" is the term already used in IV.A, IV.B "What interpretation is justified", IV.D, and IV.E for this property. Standardizing to "cohesive" throughout ensures the paper uses a single consistent term for the same geometric concept. This standardization was flagged as a pending item in `phase9_revision_notes.md` (Remaining ambiguity item 1, "less organized" → "less cohesive" deferred to Phase 9D).

---

## Confirmation checklist

| Constraint | Status |
|---|---|
| No measured values changed | Confirmed — diff contains only word-level substitutions |
| No section structure changed | Confirmed — section headings, paragraph count, and ordering identical to v2 |
| No new scientific claims added | Confirmed — all four substitutions are wording adjustments to existing sentences |
| Scientific meaning unchanged | Confirmed — each substitution preserves the same logical content with tighter correlational framing |
| Projection guardrails preserved | Confirmed — IV.A, IV.B, and IV.C guardrail sentences are verbatim identical to v2 |
| v2 file untouched | Confirmed — v3 is a separate file; v2 was not modified |

---

## Full diff summary (lines changed)

| Line | Fix | v2 phrase | v3 phrase |
|---|---|---|---|
| 67 | FIX 1 | `that produces these outputs` | `from which these outputs are computed` |
| 87 | FIX 3a | `internally less organized than` | `internally less cohesive than` |
| 109 | FIX 3b | `more internally organized than` | `more internally cohesive than` |
| 109 | FIX 2 | `localize relative difficulty to individual structures` | `provide a within-family geometric correlate of relative difficulty across structures` |
