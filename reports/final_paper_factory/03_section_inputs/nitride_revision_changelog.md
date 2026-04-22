# Nitride Section-Input Revision Changelog

**Date placed in paper factory:** 2026-04-23  
**Prepared by:** Phase 6 / Phase 7 revision pass

---

## Files in this revision set

| Role | Original file | Revised file | Action |
|---|---|---|---|
| Nitride analysis memo | `nitride_analysis_document.md` | `nitride_analysis_document_v2.md` | Revised — original preserved |
| Nitride Results draft | `nitride_results_section_draft.md` | `nitride_results_section_draft_v2.md` | Revised — original preserved |
| Revision audit notes | *(new)* | `nitride_revision_notes.md` | New companion file |
| This changelog | *(new)* | `nitride_revision_changelog.md` | New |

**Original files status:** `nitride_analysis_document.md` and `nitride_results_section_draft.md` remain in `03_section_inputs/` and were not overwritten.

---

## Summary of what changed and why

### Theme 1 — Source-distribution / mismatch wording softened

**What changed.**  
v1 contained phrases asserting that "oxide-heavy chemistries dominate" the pretraining corpus and describing the zero-shot result as "the purest behavioral signature of a family-level representational mismatch." These phrases appeared in `nitride_analysis_document.md` §1 and `nitride_results_section_draft.md` §4.1.

v2 revisions:
- "oxide-heavy chemistries dominate" → "consistent with an oxide-skewed reference regime rather than a uniform coverage of chemistries"
- "purest behavioral signature of a family-level representational mismatch" → "the cleanest behavioral indicator of a family-level shift under this protocol"
- "This is why nitride belongs as the OOD arm of the study." → "This is why nitride functions as the OOD arm in this study."
- "representational correlate of the behavioral nitride penalty" → "representational correlate of the behavioral domain-shift penalty"

An explicit disclaimer was added to `nitride_analysis_document_v2.md` §1b (Caveats block, **C1**): "The pretrained formation-energy ALIGNN model is not described as 'oxide-pretrained.' The JARVIS-DFT pretraining corpus includes nitrides; it is consistent with an oxide-skewed reference regime, not an oxide-exclusive one."

**Why.**  
The original phrasing overclaimed knowledge of the JARVIS pretraining corpus composition and overstated the strength of the domain-shift interpretation. Saying corpora are "consistent with an oxide-skewed reference regime" is what the cited evidence (Dunn2020_Matbench, Choudhary2020_JARVIS) can support without direct corpus-statistics access. The revised wording is grounded in what the project can actually claim at the level of behavioral evidence, not third-party dataset internals.

---

### Theme 2 — Stronger oxide-control comparisons at key transition points

**What changed.**  
v1 used oxide as a comparator in a general sense but did not anchor the comparison precisely at the transitions between Steps. v2 adds or sharpens three oxide-as-control anchors:

1. **After §4.1 / §2 (zero-shot).** The anchor "Nitride starts at roughly 2× the oxide zero-shot MAE" was already present in v1 but is now tagged as a forward-reference transition into §§4.2–4.5.

2. **After §4.2 / §3.1 (low-N inertness) — new in v2.** Added sentence: "Unlike oxide, which begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5`, rising to 35.5–39.0 at N ≥ 200), nitride remains operationally inert through N = 200." This uses canonical oxide mean-best-epoch values already in `canonical_numbers_v2.md` and makes the Step 2 asymmetry explicit rather than leaving it to inference.

3. **In embedding subsection (§4.4 / §4.1 — sharpened in v2).** The nitride region is now described consistently as "distinguishable but less cohesive than the oxide control region" rather than the looser v1 phrasing "less internally cohesive," which lacked an explicit comparator.

Oxide is never elevated to a parallel narrative; it appears only as a control anchor where it sharpens the domain-shift reading.

**Why.**  
The oxide arm is the in-distribution control; its behavioral profile is evidence, not background. Making the three asymmetries (zero-shot gap, adaptation-onset gap, cohesion gap) explicit at their natural transition points makes the nitride OOD story internally self-consistent rather than relying on the reader to perform the comparison.

---

### Theme 3 — Explicit four-step domain-shift arc made the spine of both documents

**What changed.**  
v1 organized both documents as a sequence of analysis sections without an overarching numbered arc. The domain-shift narrative was present but not stated as a unified thesis up front.

v2 makes the four-step arc explicit throughout:

*Analysis document v2:*
- §1 (Scientific thesis) now opens with a numbered four-step thesis block naming all four steps as numbered items: (1) zero-shot family penalty, (2) low-N fine-tuning inertness, (3) genuine but incomplete high-N adaptation, (4) embedding-space geometry consistent with the penalty.
- Subsection headings in §§2, 3.1, 3.2, 4.1, 4.2 now begin "**Step 1 —**", "**Step 2 —**", etc.
- §6 (Synthesis) is restructured as a step-by-step restatement of the arc, ending on Step 4 followed by the supporting-evidence layer.
- Transition sentences at the end of each step forward-reference the next step or back-reference the previous, making the arc visible in connective tissue.

*Results draft v2:*
- Scope header names the four steps as "(Step 1, §4.1)", "(Step 2, §4.2)", etc. and identifies §4.4–4.5 as Step 4a and 4b.
- Subsection headings use parallel language: "Step 1 — zero-shot evaluation establishes a nitride domain-shift penalty," "Step 2 — low-N nitride fine-tuning is operationally inert," etc.
- §4.7 (Summary) is restructured as a step-by-step restatement with a supporting-layer paragraph after Step 4.

*Structural reordering:*
The analysis document's old §§4 (scratch) and §5 (embeddings) were **swapped** in v2 so embeddings close the four-step arc (Step 4, §4) before scratch is introduced (§5, supporting evidence). In the Results draft, scratch moves to §4.6 so the main-text reading order matches the arc.

**Why.**  
The scientific contribution of the nitride arm is the four-step arc itself: each step is evidence of a different aspect of domain shift, and the arc as a unit is more compelling than the individual steps read in isolation. Without an explicit spine, a reader could mistake the document for a standard learning-curve analysis (fine-tuning helps, scratch is worse) rather than an OOD-specific finding (the penalty survives every available intervention). The arc framing makes the OOD claim the organizing idea rather than a conclusion appended at the end.

---

### Theme 4 — Scratch repositioned as supporting evidence, not a parallel main claim

**What changed.**  
v1 placed the scratch comparison as one of the co-equal analytical sections, with roughly symmetric rhetorical weight to the fine-tuning trajectory and embedding analysis.

v2 repositions it as explicit supporting evidence:

*Analysis document v2:*
- Scratch section moved to §5 (after the full Steps 1–4 arc is complete) and retitled "Supporting evidence — pretrained initialization vs training from scratch."
- §5 opens with: "This section is deliberately positioned as support for Steps 1–4, not as a parallel main claim."
- A new closing paragraph ("Role in the overall reading") contrasts "pretraining helps on nitrides" (a standard transfer-learning result, **secondary**) with "the domain-shift penalty persists despite adaptation" (the OOD-specific finding, **headline**).

*Results draft v2:*
- Equivalent subsection (§4.6) labeled "Supporting evidence" in its heading.
- Contains an explicit "Relationship to the main arc" paragraph that makes the same distinction and names the central OOD finding as the domain-shift penalty surviving Step 3 adaptation.

All scratch numbers, caveats (**C3**), and scope limits (N = 50 and N = 500 only) are preserved unchanged.

**Why.**  
"Pretraining beats scratch on nitrides" is a standard and expected transfer-learning result. The OOD-specific finding — that the domain-shift penalty persists even after genuine high-N adaptation begins — does not depend on the scratch comparison and is undermined in rhetorical weight if the scratch result is treated as co-equal. Placing scratch last and labeling it explicitly as supporting evidence keeps the reader's attention on the four-step arc, where the novel scientific content lives.

---

### Theme 5 — Tighter caveats and unified terminology

**What changed.**

*Caveats consolidated:*  
v1 embedded caveat paragraphs (what we are not claiming) repeatedly throughout each section, adding length without improving clarity. v2 consolidates the four key caveats into a single early block (analysis document §1b; Results draft scope header) with numbered labels:
- **C1** — checkpoint not described as "oxide-pretrained"
- **C2** — low-N `mean_best_epoch = 1.0` is not meaningful adaptation
- **C3** — N = 50 scratch gap is initialization advantage, not adaptation gain, because the fine-tuned side has `mean_best_epoch = 1.0`
- **C4** — embedding distance is correlational, not causal

Subsequent sections invoke caveats by label (e.g., "under **C3**") rather than re-arguing them. Approximately six redundant caveat paragraphs were removed without dropping any substantive guardrail.

*Terminology unified:*  
- Primary term throughout both files is now **"domain-shift penalty"**.
- "Family-level OOD penalty" is retained as a sparing secondary phrase where variation aids readability.
- "Representational mismatch" is no longer used as a headline description of zero-shot results; it appears only once in framing to name the concept.
- "OOD-penalty picture" (v1 §6) is replaced with "four-step domain-shift story" (v2 §6).

**Why.**  
Repeated caveat paragraphs dilute the narrative without providing new information to a careful reader. The labeled-caveat system from v2 preserves every guardrail while removing the defensive overhead. Terminological consistency ("domain-shift penalty" throughout) is necessary for a standalone report whose reader should not have to track which of several phrases for the same concept applies where.

---

## What was not changed

- **All measured values are preserved exactly.** No number was added, changed, or removed across either document. All zero-shot, fine-tuning, from-scratch, and embedding statistics match the source packets and `canonical_numbers_v2.md`.
- **The five-move subsection template preserved in the Results draft.** Each Results subsection continues to follow: *what is being compared → what the figure/table shows → consistent pattern → justified interpretation → what remains uncertain*.
- **Three-layer discipline preserved.** Both documents continue to separate literature context, our implementation, and our findings within each section.
- **Figure and table references unchanged.** All `TAB_*` and `FIG_*` placeholders are preserved as in v1.
- **Citation placeholders unchanged.** No new citations were invented; no existing placeholders were removed.
- **Appendix-only status of `pre_head` and `last_gcn_pool` unchanged.** `last_alignn_pool` remains the only main-text embedding layer in both documents.
- **From-scratch coverage scope unchanged.** Every mention of scratch explicitly states that baselines exist only at N = 50 and N = 500.
- **Parity-plot / summary-table MAE aggregation distinction preserved.** Both files continue to quote both values separately and label the structural difference explicitly.

---

## Items flagged for human reviewer sign-off (from nitride_revision_notes.md)

The following items are grounded in the evidence but involve interpretive judgment that a human reviewer should confirm before finalization:

1. **Analysis doc §1 — "oxide-skewed reference regime" wording.** If the cited references (`Dunn2020_Matbench`, `Choudhary2020_JARVIS`) do not explicitly use this language, the sentence should be revised to match the sources exactly.
2. **Analysis doc §1 and §6 — "consistent with" framing.** If a reviewer finds the repeated use of "consistent with" too hedged or too repetitive, some instances could be varied to "compatible with" or "aligns with."
3. **Analysis doc §4.1 — "without being trained to" phrase.** Could be misread as over-interpretation; rewrite candidate: "The pretrained model, trained only on formation energy, has developed a representation that also places oxides and nitrides in distinguishable regions."
4. **Results draft §4.6 — "headline OOD result" sentence.** Is an editorial prioritization that must be kept in sync with whatever the Discussion ultimately foregrounds as the main claim.
5. **Oxide adaptation-onset numbers inside §4.2.** The specific values (`mean_best_epoch = 18.5`, `35.5–39.0`) come from `canonical_numbers_v2.md` and must be kept in sync if the oxide arm is recomputed.

Full detail on each item is in `nitride_revision_notes.md`.
