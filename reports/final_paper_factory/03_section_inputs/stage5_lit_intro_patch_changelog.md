# Stage 5 Literature + Introduction Patch — Changelog

**Date:** 2026-04-22
**Patch scope:** Focused correction pass on citation logic, provenance hierarchy, and gap-claim safety before introduction prose drafting begins.
**Originals preserved:** `literature_claim_map.md` (unchanged); `introduction_paragraph_plan.md` (unchanged — this is already the v2 blueprint).

---

## Files created

| File | Supersedes |
|---|---|
| `literature_claim_map_v2.md` | `literature_claim_map.md` |
| `introduction_paragraph_plan_v3.md` | `introduction_paragraph_plan.md` (v2 blueprint) |

---

## Fix-by-fix record

---

### FIX A — JARVIS Provenance Anchor

**Severity:** Important issue

**What changed.**

*In `literature_claim_map_v2.md`:*
- The Scholarly Anchors table JARVIS row was restructured with an explicit three-tier hierarchy:
  - **Primary (dataset/repository provenance):** JARVIS 2020 — Choudhary et al., "The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design," *npj Computational Materials* 6, 173. (File not yet in `paper_sources/`; flagged for acquisition.)
  - **Secondary (broader ecosystem/pretrained infrastructure):** JARVIS 2025.
  - **Contextual (benchmarking/leaderboard framing only):** JARVIS-Leaderboard 2024.
- L4 was rewritten to make JARVIS 2020 the primary provenance anchor, JARVIS 2025 secondary, and JARVIS-Leaderboard 2024 contextual only.
- A JARVIS 2020 file-status note was added below the Scholarly Anchors table.

*In `introduction_paragraph_plan_v3.md`:*
- The P2 local-source mapping was rewritten with explicit per-use guidance: JARVIS 2020 for dataset/repository sentences; JARVIS 2025 for ecosystem/pretrained-infrastructure sentences; JARVIS-Leaderboard 2024 only for leaderboard/benchmark sentences.
- A "JARVIS citation note for P2" block was added to make the rule easy to apply at drafting time.
- The §5 citation essentiality table was split into three JARVIS rows (primary / secondary / contextual) to make the hierarchy visible.
- The §6 local-source table was updated accordingly.

**Why it changed.**
The JARVIS 2025 and JARVIS-Leaderboard 2024 papers are appropriate for ecosystem and benchmark framing, but neither is the canonical provenance source for the JARVIS dataset and repository that the pretrained checkpoints derive from. Using them as the primary dataset anchor would be a citation-precision error. JARVIS 2020 is the founding paper for the repository and DFT dataset.

**Residual action required.** JARVIS 2020 is not yet in `paper_sources/`. It must be obtained before the final manuscript is assembled. All planning references to it are marked "(to be obtained)."

---

### FIX B — Transfer-Learning Anchor Hierarchy

**Severity:** Important issue

**What changed.**

*In `literature_claim_map_v2.md`:*
- The Scholarly Anchors Transfer learning row was restructured with an explicit three-tier hierarchy:
  - **Primary:** Lee & Asahi 2021.
  - **Secondary (low-data property transfer):** Kim et al. 2024 — now explicitly named for the first time in this file.
  - **Contextual (domain adaptation / shifted-target framing):** Hu et al. 2024.
- L5 writing note was extended to explicitly state that Hu et al. 2024 is not the default lead citation for generic transfer-learning sentences and that Lee & Asahi 2021 must lead.

*In `introduction_paragraph_plan_v3.md`:*
- P3 sentence 1 now states explicitly: "Lee & Asahi 2021 is the canonical primary anchor and should lead."
- Kim et al. 2024 is explicitly named and its role clarified: secondary anchor for property-specific or scarce-data transfer framing.
- Hu et al. 2024 is explicitly demoted: contextual support for domain-adaptation framing, not the default lead.
- The §6 local-source table for the transfer-learning placeholder was reformatted as Primary / Secondary / Contextual to mirror the hierarchy in the claim map.
- The §7 anti-patterns section was extended with: "Hu et al. as default transfer-learning lead" explicitly named as a forbidden pattern.

**Why it changed.**
The previous version listed Lee & Asahi and Hu et al. side-by-side with no hierarchy, creating risk that a later drafter would default to whichever was more familiar or most recently read. Hu et al. 2024 is a domain-adaptation paper; using it as the generic transfer-learning citation front-loads framing that belongs further in the paragraph. Kim et al. 2024 was already in the §6 source list but was not named in the main claim-map table, making it easy to overlook.

---

### FIX C — Gap Sentence Protection

**Severity:** Critical issue

**What changed.**

*In `introduction_paragraph_plan_v3.md`:*
- A "Gap protection note (Link E)" block was added immediately after the motivation chain table in §1. It states explicitly:
  - The claimed gap is a gap in *evaluation design*, not a claim that OOD or transfer learning in materials is unexplored.
  - Forbidden style example: "Prior materials-ML literature has not examined domain shift."
  - Preferred style example: "What remains less standardized is a clean evaluation design built around a single pretrained checkpoint, a chemistry-family shift, and a data-efficiency comparison."
- P3 sentence 4 now includes an inline "Anti-pattern for sentence 4" block repeating the forbidden vs. preferred contrast.
- The drafting-readiness checklist (§8) item 2 was updated to include: "…without claiming that domain shift in materials is unstudied?"
- §7 anti-patterns was extended with "Overbroad gap claim" as an explicit named pattern.

**Why it changed.**
An overbroad gap claim ("nobody has studied OOD in materials ML") would be factually wrong, would invite rejection from reviewers who know the literature, and would undermine the papers that the introduction itself cites (Omee et al. 2024, Li et al. 2025). The gap is real but narrow: a specific evaluation design is the missing element, not awareness of the phenomenon. This protection is critical because the broad form of the claim is a natural attractor when drafting under time pressure.

---

### FIX D — Matbench Remains Optional

**Severity:** Polish issue

**What changed.**

*In `introduction_paragraph_plan_v3.md`:*
- P2 optional-sentence note was tightened: "Include only if Methods or later framing genuinely needs broader benchmark context. Do not add this sentence to appear scholarly."
- The §5 citation essentiality table Matbench row label was updated to "(Matbench — optional background)" to make the status unambiguous.
- A sentence was added to the §6 Matbench note: "Matbench should appear only if later Methods or framing genuinely requires broader benchmark context — not for scholarly signaling."
- §7 anti-patterns was extended with "Forcing Matbench into P2" as an explicit named pattern.

*In `literature_claim_map_v2.md`:*
- The Materials-data ecosystem background row was updated to add: "Do not force Matbench into the paper to appear scholarly."
- The Working Boundary section was updated to include: "Benchmark and ecosystem papers (Matbench, JARVIS-Leaderboard) are optional background, not required core evidence for the paper's thesis."

**Why it changed.**
The existing files already handled this well. The patch makes it harder for a drafter under pressure to rationalize adding Matbench as a quick way to "ground" the paper in the community's benchmark landscape. The introduction should stand on its own research design logic, not on conspicuous citation of widely known benchmarks.

---

### FIX E — Literature / Project / Question Boundary

**Severity:** Important issue

**What changed.**

*In `literature_claim_map_v2.md`:*
- The §2 Project-Specific Motivation header was updated with an explicit operational rule: "A sentence cannot slide from the project column to the literature column by adding a citation placeholder."
- The Working Boundary section was updated to reinforce: "These three categories are operational, not decorative."

*In `introduction_paragraph_plan_v3.md`:*
- A "Sentence classification reminder" block was added to P4 noting that every sentence in P4 should be classifiable as project design or our question, not as literature.
- The §8 drafting-readiness checklist item 4 now explicitly names the three categories: Literature / Project-design / Our-question.

**Why it changed.**
The existing documents already maintained this discipline, but the rules were stated as guidance rather than as operational constraints. The patch tightens the wording so that later drafters understand that the category of a sentence determines its citation behavior, and that adding a citation placeholder cannot change the category.

---

### FIX F — Small Execution Cleanup

**Severity:** Polish issue

**What changed.**

*In `introduction_paragraph_plan_v3.md`:*
- §7 anti-patterns section was extended from 7 items to 9 items:
  - "Overbroad gap claim" added (see FIX C).
  - "Hu et al. as default transfer-learning lead" added (see FIX B).
  - "Forcing Matbench into P2" added (see FIX D).
- No content was weakened or removed from the existing anti-patterns.

*In `literature_claim_map_v2.md`:*
- The version note block at the top makes the patch scope transparent without bloating the file.

**Why it changed.**
The existing anti-patterns list covered the major structural risks but did not name the new citation-hierarchy risks introduced by the FIX A and FIX B changes. Adding them closes the loop.

---

## Changelog summary (required items)

| Item | Status |
|---|---|
| JARVIS 2020 is now the primary provenance anchor | Implemented in both files. File not yet in `paper_sources/` — must be obtained before submission. |
| Lee & Asahi 2021 is now the primary transfer-learning anchor | Confirmed and made explicit in both files. |
| Kim et al. 2024 is now explicitly included as secondary support | Added to Scholarly Anchors table, L5, P3 sentence 1, and §6 local-source table. |
| Hu et al. 2024 is now contextual rather than default | Demoted in both files; anti-pattern added to prevent reversion. |
| The gap is explicitly protected from overbroad novelty claims | Gap protection note added in §1, P3 anti-pattern block added, §7 anti-pattern entry added, checklist item 2 updated. |
| Matbench remains optional | Optional status tightened in both files; anti-pattern added. |

---

## Unresolved items before intro drafting

1. **JARVIS 2020 not in `paper_sources/`.** The primary dataset/repository provenance anchor needs to be obtained (Choudhary et al. 2020, *npj Computational Materials* 6, 173) before manuscript submission. The planning files reference it correctly; the physical file is missing.
2. **Matbench / JARVIS-Leaderboard in P2 still deferred.** The decision on whether to include the optional P2 sentence about broader benchmark infrastructure depends on how Methods is written. This remains intentionally open per §9 of the blueprint.
3. **Chen et al. 2019 vs CGCNN-only in P1.** Still deferred. Pick one approach and apply consistently at drafting time.

---

## Pack readiness verdict

**Safe for intro drafting.** The citation hierarchy is defensible, the gap claim is bounded, and the three-column separation (literature / project / question) is operationally reinforced. The one outstanding acquisition item (JARVIS 2020) does not block drafting — it must be resolved before submission.
