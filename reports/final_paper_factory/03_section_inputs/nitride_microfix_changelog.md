# Nitride Micro-Fix Changelog — v2 → v3

**Date:** 2026-04-23  
**Pass:** Phase 6 / Phase 7 micro-fix pass (rhetorical hygiene only)  
**Files produced:** `nitride_analysis_document_v3.md`, `nitride_results_section_draft_v3.md`  
**Files unchanged:** All v1 and v2 files are preserved exactly. No originals were overwritten.

---

## Scope statement

This pass applies phrase-level rhetorical fixes only. No measured values were changed, no structural sections were added or removed, no new scientific claims were introduced, and no existing claims were weakened or strengthened beyond what is explicitly documented below. The four-step domain-shift arc, three-layer discipline, Methods/Results boundary, embedding-layer discipline, scratch-scope guardrails, and all caveats (C1–C4) are unchanged from v2.

---

## Changes applied

### FIX 1 — Narrow "oxide-skewed reference regime" to a more evidence-bounded phrase

**Locations changed:**

| File | Section | Context |
|---|---|---|
| `nitride_analysis_document_v3.md` | §1 "Literature-grounded claims" | First occurrence of the phrase |
| `nitride_analysis_document_v3.md` | §1b Caveats, **C1** | Second occurrence of the phrase |
| `nitride_results_section_draft_v3.md` | §4.1 "What remains uncertain" | Single occurrence in the Results draft |

**Before (v2):**
> "…consistent with an oxide-skewed reference regime rather than a uniform coverage of chemistries…"

> (§1b / C1): "…it is consistent with an oxide-skewed reference regime, not an oxide-exclusive one."

> (Results §4.1): "…its composition is consistent with an oxide-skewed reference regime."

**After (v3):**
> "…consistent with a pretraining regime more aligned with oxides than nitrides…"

> (§1b / C1): "…it is consistent with a pretraining regime more aligned with oxides than nitrides, not an oxide-exclusive one."

> (Results §4.1): "…its composition is consistent with a pretraining regime more aligned with oxides than nitrides."

**Rationale.** "Oxide-skewed reference regime" is directionally accurate but names a corpus property ("oxide-skewed") that is an inference from behavioral evidence rather than directly measured. "A pretraining regime more aligned with oxides than nitrides" makes the same directional claim while keeping the framing in the register of what the evidence shows — the pretrained model performs better on oxides — rather than asserting corpus statistics that require external citation sign-off to defend precisely. The scientific content is unchanged: the claim is that the pretraining regime favors oxides over nitrides, not that nitrides are absent from the corpus.

---

### FIX 2 — Replace "without being trained to" with "without being explicitly supervised on family labels"

**Locations changed:**

| File | Section | Context |
|---|---|---|
| `nitride_analysis_document_v3.md` | §4.1 "Interpretation" | Single occurrence in the analysis document |
| `nitride_results_section_draft_v3.md` | §4.4 "Justified interpretation" | Parallel occurrence in the Results draft |

**Before (v2, analysis document §4.1):**
> "The pretrained network has, without being trained to, built a representation in which oxides and nitrides occupy distinguishable regions."

**After (v3, analysis document §4.1):**
> "The pretrained network has, without being explicitly supervised on family labels, built a representation in which oxides and nitrides occupy distinguishable regions."

**Before (v2, Results draft §4.4):**
> "The pretrained network has developed a representation in which oxides and nitrides occupy distinguishable regions, without being trained to do so."

**After (v3, Results draft §4.4):**
> "The pretrained network, without being explicitly supervised on family labels, has built a representation in which oxides and nitrides occupy distinguishable regions."

**Rationale.** "Without being trained to" is ambiguous: a reader could interpret it as claiming the model was not trained on these chemistries at all, rather than simply that family-label classification was not a training objective. "Without being explicitly supervised on family labels" is unambiguous — the model was trained on formation energy, and the family-separating structure in the representation emerged without a dedicated classification objective. The scientific meaning is preserved; the potential misreading is closed.

---

### FIX 3 — Standardize stray "nitride penalty" instance to "domain-shift penalty"

**Locations changed:**

| File | Section | Context |
|---|---|---|
| `nitride_analysis_document_v3.md` | §4.2 "Interpretation" | One instance in the within-nitride error paragraph |
| `nitride_results_section_draft_v3.md` | §4.5 "Justified interpretation" | Parallel instance in the Results draft |

**Before (v2, analysis document §4.2 "Interpretation"):**
> "This is the geometric counterpart of the Step 1 family gap: the penalty is not only a family-level average but scales with how unlike the oxide region a given nitride is in pretrained feature space."

**After (v3, analysis document §4.2 "Interpretation"):**
> "This is the geometric counterpart of the Step 1 family gap: the domain-shift penalty is not only a family-level average but scales with how unlike the oxide region a given nitride is in pretrained feature space."

**Before (v2, Results draft §4.5 "Justified interpretation"):**
> "Together, §4.4 and §4.5 make Step 4 of the arc: the behavioral penalty from §§4.1–4.3 has a consistent representation-space correlate."

**After (v3, Results draft §4.5 "Justified interpretation"):**
> "Together, §4.4 and §4.5 make Step 4 of the arc: the behavioral domain-shift penalty from §§4.1–4.3 has a consistent representation-space correlate."

**Additional instance — analysis document §6 (Consolidated reading):**

**Before (v2):**
> "Step 1 — zero-shot gap. The pretrained model is already about twice as inaccurate on nitrides as on oxides. The penalty exists before any fine-tuning."

**After (v3):**
> "Step 1 — zero-shot gap. The pretrained model is already about twice as inaccurate on nitrides as on oxides. The domain-shift penalty exists before any fine-tuning."

**Rationale.** The v2 revision notes targeted "domain-shift penalty" as the unified primary term throughout both files. These instances used the abbreviated "the penalty" or "behavioral penalty" in sentences where "domain-shift penalty" fits without awkwardness. The replacements maintain consistency with the primary term. No scientific content changes.

---

## Summary table

| Fix ID | File | Location | Change |
|--------|------|----------|--------|
| FIX 1a | Analysis document v3 | §1 "Literature-grounded claims" | "oxide-skewed reference regime" → "pretraining regime more aligned with oxides than nitrides" |
| FIX 1b | Analysis document v3 | §1b Caveats, C1 | Same phrase replacement |
| FIX 1c | Results draft v3 | §4.1 "What remains uncertain" | Same phrase replacement |
| FIX 2a | Analysis document v3 | §4.1 "Interpretation" | "without being trained to" → "without being explicitly supervised on family labels" |
| FIX 2b | Results draft v3 | §4.4 "Justified interpretation" | "without being trained to do so" → "without being explicitly supervised on family labels" |
| FIX 3a | Analysis document v3 | §4.2 "Interpretation" | "the penalty" → "the domain-shift penalty" |
| FIX 3b | Analysis document v3 | §6 Step 1 | "The penalty exists" → "The domain-shift penalty exists" |
| FIX 3c | Results draft v3 | §4.5 "Justified interpretation" | "the behavioral penalty" → "the behavioral domain-shift penalty" |

---

## Confirmation

- **No measured values changed.** All MAE, std, mean_best_epoch, embedding separation statistics, distance–error statistics, CIs, and FDR q-values are identical to v2.
- **Only wording-level edits made.** No sections added, removed, or reordered. No citations added or removed. No new claims introduced.
- **All v1 and v2 files preserved.** `nitride_analysis_document.md`, `nitride_analysis_document_v2.md`, `nitride_results_section_draft.md`, and `nitride_results_section_draft_v2.md` remain in `03_section_inputs/` without modification.
- **Human sign-off items from `nitride_revision_notes.md` §4 remain open.** This pass does not resolve them; FIX 1 partially addresses item 4.1 by softening the corpus-composition wording, but reviewer confirmation is still required.
