# Oxide Section-Input Revision Changelog

**Date placed in paper factory:** 2026-04-22  
**Prepared by:** Phase 6 / Phase 7 revision pass

---

## Files in this revision set

| Role | Original file | Revised file | Action |
|---|---|---|---|
| Oxide analysis memo | `oxide_analysis_document.md` | `oxide_analysis_document_v2.md` | Revised — original preserved |
| Oxide Results draft | `oxide_results_section_draft.md` | `oxide_results_section_draft_v2.md` | Revised — original preserved |
| Revision audit notes | *(new)* | `oxide_revision_notes.md` | New companion file |
| This changelog | *(new)* | `oxide_revision_changelog.md` | New |

**Original files status:** `oxide_analysis_document.md` and `oxide_results_section_draft.md` remain in `03_section_inputs/` and were not overwritten.

---

## Summary of what changed and why

### Theme 1 — Source-distribution wording softened

**What changed.**  
v1 contained phrases asserting that oxides are "well represented in this source distribution," that the target is "a chemically familiar target within the source distribution," and that the pretrained model "is already well-matched to oxide formation-energy prediction" because of its pretraining corpus composition. These phrases appeared in `oxide_analysis_document.md` §1.2 and `oxide_results_section_draft.md` §3.1.

v2 removes every such phrase. Replacements:
- "oxides are well represented in this source distribution" → "oxides are the chemistry-aligned control arm as defined by this project"
- "chemically familiar target within the source distribution" → "the oxide arm functioning as the in-distribution control condition in this study"
- Removed implied claim that the pretraining corpus explains the zero-shot result

An explicit disclaimer was added to `oxide_analysis_document_v2.md` §1.2: "We do not make independent claims about the exact chemical composition of the pretraining corpus."

The `oxide_results_section_draft_v2.md` §3.1 "What the pattern is consistent with" paragraph carries a compressed version of the same disclaimer: "We do not make separate claims here about the exact chemical composition of the pretraining corpus; oxides are the chemistry-aligned control arm by project design."

**Why.**  
The original phrasing overclaimed knowledge of the JARVIS pretraining corpus composition. The pretrained checkpoint was not documented as oxide-dominant in the project evidence files; asserting that oxides are "well represented" in the source distribution makes a characterization of a third-party dataset that the project does not control or verify. The revised wording is grounded in what the project can actually claim: oxides are the in-distribution control arm by design, which is a project-level statement rather than a claim about external data.

---

### Theme 2 — Ceiling wording softened

**What changed.**  
v1 used the phrase "performance ceiling" as a heading and throughout §3.1 body text in `oxide_results_section_draft.md`. Specifically:
- §3.1 heading: "Zero-shot oxide performance sets the in-distribution ceiling"
- §3.1 body: "in-distribution control benchmark and, under Set 1, as a practical performance ceiling"
- §3.2 heading: "recovers toward, but does not cross, the zero-shot ceiling"
- §3.5 summary: "the zero-shot baseline defining the performance ceiling"

v2 revisions:
- §3.1 heading → "Zero-shot oxide performance establishes the best Set 1 oxide benchmark"
- §3.1 body → "best observed oxide performance under Set 1 — a baseline not surpassed under the canonical fine-tuning or from-scratch protocols"
- §3.2 heading → "converges toward, but does not surpass, the zero-shot benchmark"
- §3.6 summary uses "zero-shot benchmark" not "ceiling"

The word "ceiling" is retained in `oxide_analysis_document_v2.md` §3's section title and one interpretive paragraph where it is explicitly scoped to Set 1 ("consistent with convergence toward the zero-shot ceiling"), since some editorial use of the term is defensible where the scope qualifier is present.

**Why.**  
"Ceiling" implies a hard theoretical maximum, which this result does not support. The observation is that under the Set 1 protocol with the tested range of N, fine-tuning does not surpass zero-shot. It does not establish that zero-shot is an optimum. A different protocol, more data, or unfreezing different layers might produce a different outcome. "Best observed performance under Set 1" and "benchmark not surpassed" are accurate; "ceiling" is not.

---

### Theme 3 — Pretrained-vs-scratch comparison made the central result

**What changed.**  
v1 treated the scratch comparison as one of four co-equal sections in both the analysis memo and the Results draft. The §1.3 findings list in `oxide_analysis_document.md` placed zero-shot first, fine-tuning second, and the scratch gap third. The §3.5 summary in `oxide_results_section_draft.md` opened with zero-shot (item i) and listed the scratch result third (item iii).

v2 makes the scratch comparison the anchor result throughout:

*Analysis document v2:*
- §1.3 findings list reordered: scratch gap is listed **first** ("Pretrained initialization dominates random initialization by a large margin at both oxide scratch-tested sizes"), zero-shot second, fine-tuning third, embedding fourth.
- §4.3 (Pretrained-vs-scratch findings) opens with: "This comparison is the oxide arm's clearest on-family signature of transfer value, and it is the result the oxide report is built around."
- §4.3 closes with a "why this is the central oxide result" paragraph quantifying the contrast (0.221 eV/atom gap to scratch vs 0.009 eV/atom gap to zero-shot at N = 500).
- §6 Synthesis is reordered to lead with the scratch-gap result.

*Results draft v2:*
- Introductory paragraph in §3 now explicitly names §3.4 as "the central on-oxide transfer-value result."
- §3.4 is given a dedicated transition paragraph that explains why Sections 3.1–3.3 were building toward this comparison.
- §3.4 heading is extended: "Pretrained initialization dominates random initialization at both scratch-tested data sizes — the central on-oxide transfer-value result."
- §3.6 summary reordered: scratch-gap result is item (i); zero-shot benchmark is item (ii); fine-tuning trajectory is item (iii).

**Why.**  
The oxide arm's scientifically strongest claim is not that pretrained zero-shot is good (that may just reflect source-distribution alignment, which is disclaimed in Theme 1). The strongest claim is that the pretrained representation delivers a very large labelled-data saving relative to random initialization even when fine-tuning cannot improve on zero-shot. That claim does not depend on corpus composition assumptions. Reordering both documents to lead with this result makes the oxide paper's contribution cleaner and makes the comparison to the nitride arm more meaningful.

---

### Theme 4 — Parity discussion tightened and given a clean subsection

**What changed.**  
v1 embedded the parity-plot discussion inside §3.2 (fine-tuning) in `oxide_results_section_draft.md`, running three sentences that re-explained the MAE aggregation difference and included an appendix cross-reference mid-paragraph.

v2 extracts the parity discussion into its own subsection (§3.3), which:
- Has a single focused "what is compared / what the evidence shows and what it means / what is uncertain" structure.
- Compresses the body to four sentences plus one technical note on MAE aggregation.
- Moves the appendix cross-reference to the "what is compared" opening sentence.
- Makes no new numerical claims beyond what §3.2 already establishes.

This change also shifts the Results structure from four subsections (v1) to five subsections (v2), matching `oxide_report_blueprint_v3.md` rows 3–7.

**Why.**  
Parity plots have a specific, bounded role — they give a structure-level check on the fine-tuning endpoint quality — and that role is clearest when the parity discussion is scoped to its own subsection. Embedding the discussion in §3.2 forced the fine-tuning narrative to carry two different kinds of evidence (aggregate MAE and pointwise structure) simultaneously, which made the paragraph hard to read. The separate §3.3 is shorter and more clearly bounded.

---

### Theme 5 — Embedding subsection given a positive oxide-specific payoff

**What changed.**  
v1's embedding subsection in both documents spent its first paragraph on what the section does *not* do: "It does not prove that oxide-region cohesion is why zero-shot works"; "the strongest distance-error result… belongs to the nitride or combined paper." The positive oxide-side finding was stated, but it came after and was structurally subordinated to the non-claims.

v2 reverses this structure in both files:

*Analysis document v2 §5.3:*
- Opens with the positive finding: "in the pretrained representation, oxides form a cohesive, locally pure region."
- Enumerates three concrete oxide-specific implications: (i) oxide local neighbourhoods have negligible cross-family contamination (15-NN purity 0.9872); (ii) the oxide region is internally more coherent than the nitride region (oxide silhouette 0.2546 vs nitride 0.1453); (iii) the family label is recoverable at essentially ceiling level without supervision on that axis (AUC 0.9994).
- Adds a "What this adds to the oxide report" paragraph: "This is a real oxide-specific finding, not a handoff."
- The non-claims are kept but trimmed to a single "What this does not claim" paragraph.

*Results draft v2 §3.5:*
- Mirrors the same three-implication structure in the "What the pattern is consistent with" paragraph.
- "What interpretation is justified" explicitly names this as "a self-contained representation-level finding" and "a real oxide-specific result for the oxide standalone report."
- Non-claims remain in "What is uncertain," now clearly scoped as after the positive finding.

**Why.**  
A standalone oxide report needs to be scientifically self-contained. If the embedding subsection leads with what it does not do, the oxide paper's own embedding section reads as a placeholder for the combined paper, not as a contribution. The positive finding is real — oxide 15-NN purity 0.9872 and family AUC 0.9994 are strong numbers that support a representation-level statement about the oxide arm — and it deserves to lead. The non-claims remain present but as bounding statements rather than as the structural focus.

---

### Theme 6 — Oxide control-arm identity made explicit upfront

**What changed.**  
v1 opened `oxide_analysis_document.md` as a neutral analysis memo without a stated report identity. `oxide_results_section_draft.md` began with a standard boilerplate "Section role" header and moved directly into describing the Results preamble.

v2 adds explicit identity statements at the top of both files:

*Analysis document v2:*
- Preamble now includes: "**Identity of the oxide paper.** The oxide report is a control-arm paper. Its contribution is disciplined in-distribution evidence that calibrates the broader study's claims about pretraining value and data efficiency. It is neither a dramatic failure case nor a breakthrough result. Its scientific weight comes from being the clean reference condition against which the nitride arm's domain-shift penalty is measured."

*Results draft v2:*
- "Report identity" paragraph added before the evidence base statement: "The oxide report is the in-distribution control arm of the broader study. Its contribution is disciplined, chemistry-aligned reference evidence for the nitride arm's domain-shift analysis; it is not a dramatic failure case or a breakthrough result."
- The §3 introductory paragraph now names the five-part structure and explicitly flags §3.4 as "the central on-oxide transfer-value result."

**Why.**  
The oxide paper's narrative coherence depends on the reader understanding upfront that the central finding is a transfer-value measurement on an in-distribution control task, not a best-in-class oxide prediction result and not a failure story. Without that framing, the zero-shot-ceiling observation reads as disappointing (fine-tuning never beats zero-shot) rather than as the expected control behavior. The identity statement re-frames the expected reading direction before the reader encounters any numbers.

---

## What was not changed

- **All measured values are preserved exactly.** No number was added, changed, or removed across either document. The embedding metric precision (e.g., 0.9872 for oxide 15-NN purity) matches the source packets rather than the rounded prose in `canonical_numbers_v2.md`.
- **Three-layer discipline preserved.** Both documents continue to separate literature context, our implementation, and our findings within each section.
- **N = 10 lighter-flag language preserved.** The lighter `zero_shot_checkpoint_at_low_N` wording is retained, consistent with the canonical numbers file's designation (lighter than the nitride `effective_zero_shot_checkpoint` flag).
- **Scratch scope guardrails unchanged.** Every mention of scratch explicitly states that baselines exist only at N = 50 and N = 500.
- **Embedding-layer discipline unchanged.** `last_alignn_pool` is the only main-text layer; `pre_head` and `last_gcn_pool` are not cited.
- **Citation hierarchy unchanged.** Placeholder form and citation set are consistent with Stage 5 authority files.

---

## Items flagged for human reviewer sign-off (from oxide_revision_notes.md)

The following items are grounded in the evidence but involve interpretive judgment that a human reviewer should confirm before finalization:

1. Analysis document §1 identity paragraph — editorial tone of "neither a dramatic failure case nor a breakthrough result" needs author approval.
2. "Roughly 25× the residual gap" figure in §4.3 / §3.4 — correct ratio but is a rhetorical construction; reviewer should confirm it belongs in the final manuscript.
3. "Flattening" vs "saturation" language choice — reviewer should confirm preferred final terminology.
4. §3.4 extended heading — may need trimming to match final report's heading style.
5. Three-implication framing in embedding subsection — item (ii) compares against nitride silhouette; confirm that is appropriate for the standalone oxide report.
6. Summary ordering (scratch first) — reviewer should confirm the re-ordered summary reads as intended.
7. Citation placeholders — all `[CITE: …]` markers need final matching by a human reviewer; in particular the primary ALIGNN citation form.

Full detail on each item is in `oxide_revision_notes.md`.
