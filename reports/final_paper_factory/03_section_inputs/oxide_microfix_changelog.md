# Oxide Micro-Fix Changelog — v2 → v3

**Date:** 2026-04-22  
**Pass:** Phase 6 / Phase 7 micro-fix pass (rhetorical hygiene only)  
**Files produced:** `oxide_analysis_document_v3.md`, `oxide_results_section_draft_v3.md`  
**Files unchanged:** All v1 and v2 files are preserved exactly. No originals were overwritten.

---

## Scope statement

This pass applies phrase-level rhetorical fixes only. No measured values were changed, no structural sections were added or removed, no new scientific claims were introduced, and no existing claims were weakened or strengthened beyond what is explicitly documented below. The three-layer discipline, Methods/Results boundary, embedding-layer discipline, scratch-scope guardrails, and N = 10 lighter-flag language are all unchanged from v2.

---

## Changes applied

### FIX 1 — Split fused project-design + external-provenance sentence (Results draft only)

**File changed:** `oxide_results_section_draft_v3.md`  
**Location:** §3.1 "What the pattern is consistent with"

**Before (v2):**
> "The zero-shot result is consistent with the oxide arm functioning as the in-distribution control condition in this study [CITE: Choudhary et al. 2020 — JARVIS; CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]. We do not make separate claims here about the exact chemical composition of the pretraining corpus; oxides are the chemistry-aligned control arm by project design."

**After (v3):**
> "Oxides serve as the in-distribution control arm by project design. The pretrained model and training data used here derive from the JARVIS materials infrastructure [CITE: Choudhary et al. 2020 — JARVIS; CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]. We do not make separate claims about the exact chemical composition of the pretraining corpus."

**Rationale.** The v2 sentence fused a project-design statement (oxides are the in-distribution control arm) with a JARVIS infrastructure citation in a way that could be read as using the external citation to support the design claim, or as using the design claim to contextualize external coverage. Neither reading is what the sentence intended. The v3 split gives each idea its own sentence: the design claim stands alone without citation (it is a project-level statement), and the JARVIS citations attach to the narrower factual statement about where the pretrained model and training data come from. The disclaimer about pretraining corpus composition is retained verbatim in substance, with minor punctuation adjustment ("here" removed as redundant after the structural clarification).

**Note.** FIX 1 applies only to the Results draft. The analysis document's parallel passage in §1.2 carries the full disclaimer in its own paragraph and did not have the same fused-sentence problem; no change was made to `oxide_analysis_document_v3.md` for FIX 1.

---

### FIX 2a — Replace "essentially ceiling level" in analysis document embedding subsection

**File changed:** `oxide_analysis_document_v3.md`  
**Location:** §5.3, third implication sentence

**Before (v2):**
> "Third, the family label is recoverable at essentially ceiling level (AUC 0.9994), showing that the pretrained representation already organizes the test set along the oxide/non-oxide axis without any supervision on that axis."

**After (v3):**
> "Third, the family label is recoverable with near-perfect separability (AUC 0.9994), showing that the pretrained representation already organizes the test set along the oxide/non-oxide axis without any supervision on that axis."

**Rationale.** "Essentially ceiling level" uses "ceiling" in a different register than the §2/§3 ceiling wording that was deliberately softened in the v1→v2 revision — here it refers to classification ceiling rather than prediction-error ceiling. But the rhetorical elevation is the same problem: AUC 0.9994 is a strong number that speaks for itself. "Near-perfect separability" is more precise (it names the property: family label recovery is near-perfect), carries no ambiguity about which ceiling is meant, and is equally economical. No value or claim changes.

---

### FIX 2b — Replace "essentially ceiling level" in Results draft embedding subsection

**File changed:** `oxide_results_section_draft_v3.md`  
**Location:** §3.5 "What the evidence shows"

**Before (v2):**
> "Across the full test set, family labels are recoverable from the raw embeddings at essentially ceiling level: logistic-regression family AUC is **0.9994** and overall 15-NN family purity is 0.9655."

**After (v3):**
> "Across the full test set, family labels are recoverable from the raw embeddings with near-perfect separability: logistic-regression family AUC is **0.9994** and overall 15-NN family purity is 0.9655."

**Rationale.** Same as FIX 2a. The Results draft and analysis document use parallel phrasing at the embedding-subsection level; the replacement is applied symmetrically to both. No value or claim changes.

---

### FIX 3a — Add "under Set 1 at N = 500" scope qualifier to ~25× contrast in analysis document

**File changed:** `oxide_analysis_document_v3.md`  
**Location:** §4.3 "Why this is the central oxide result" paragraph

**Before (v2):**
> "…so the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark."

**After (v3):**
> "…so under Set 1 at N = 500 the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark."

**Rationale.** The ~25× figure is derived from a specific data point: (0.2214 eV/atom scratch-minus-fine-tune gap at N = 500) / (0.0088 eV/atom fine-tune-minus-zero-shot gap at N = 500) ≈ 25.2. The comparison is meaningful only at that point. The v2 sentence embedded it in a paragraph that named N = 500 in an earlier clause, but the concluding ~25× sentence could be read as a general claim across the studied range. The added "under Set 1 at N = 500" qualifier pins the rhetorical figure explicitly to the protocol and data point it derives from, consistent with the human-reviewer sign-off flag in `oxide_revision_notes.md` §3 item 2. The contrast and ratio are unchanged.

---

### FIX 3b — Add "under Set 1" scope qualifier to ~25× contrast in Results draft

**File changed:** `oxide_results_section_draft_v3.md`  
**Location:** §3.4 "What interpretation is justified"

**Before (v2):**
> "…at N = 500, fine-tuning sits 0.2214 eV/atom below scratch while sitting only 0.0088 eV/atom above zero-shot, so the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark."

**After (v3):**
> "…at N = 500 under Set 1, fine-tuning sits 0.2214 eV/atom below scratch while sitting only 0.0088 eV/atom above zero-shot, so the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark."

**Rationale.** Same as FIX 3a. The Results draft sentence already named N = 500 at the clause opening; "under Set 1" is added immediately after to make the protocol scope explicit. This is the lighter of the two FIX 3 edits (FIX 3a adds both "under Set 1" and "at N = 500"; FIX 3b adds only "under Set 1" because N = 500 was already present in the Results sentence). No value or claim changes.

---

## Summary table

| Fix ID | File | Location | Type | Characters changed |
|--------|------|----------|------|--------------------|
| FIX 1  | Results draft v3 | §3.1 "What the pattern is consistent with" | Sentence split / citation repositioning | ~3 sentences restructured |
| FIX 2a | Analysis document v3 | §5.3 third implication | Phrase replacement | "essentially ceiling level" → "near-perfect separability" |
| FIX 2b | Results draft v3 | §3.5 "What the evidence shows" | Phrase replacement | "essentially ceiling level" → "near-perfect separability" |
| FIX 3a | Analysis document v3 | §4.3 "Why this is the central oxide result" | Scope qualifier added | "so the transfer gain…" → "so under Set 1 at N = 500 the transfer gain…" |
| FIX 3b | Results draft v3 | §3.4 "What interpretation is justified" | Scope qualifier added | "at N = 500, fine-tuning…" → "at N = 500 under Set 1, fine-tuning…" |

---

## What was not changed

- All measured values are identical to v2.
- Document structure (section count, heading hierarchy, subsection order) is identical to v2 in both files.
- The ~25× ratio itself is unchanged; only the scope qualifier was added.
- All v1 and v2 files remain in `03_section_inputs/` without modification.
- The seven human-reviewer sign-off items listed in `oxide_revision_notes.md` §3 remain open; this pass does not resolve them (FIX 3 partially addresses item 2 by adding an explicit scope qualifier, but reviewer confirmation of the rhetorical figure itself is still required).
