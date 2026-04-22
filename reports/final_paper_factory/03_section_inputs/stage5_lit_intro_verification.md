# Stage 5 Literature / Introduction Pack Verification

Date: 2026-04-22

Scope verified:
- `reports/final_paper_factory/03_section_inputs/literature_claim_map_v2.md`
- `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v3.md`
- `reports/final_paper_factory/03_section_inputs/stage5_lit_intro_patch_changelog.md`

Additional repo-state check performed because drafting safety depends on it:
- `paper_sources/` file inventory
- `reports/final_paper_factory/03_section_inputs/citation_needed_list.md`

## Passed Checks

1. `PASS` — JARVIS 2020 is now the primary provenance / dataset anchor in the patched logic.
   Evidence:
   - `literature_claim_map_v2.md:19,53`
   - `introduction_paragraph_plan_v3.md:13,72,76,190,210`
   - `stage5_lit_intro_patch_changelog.md:30-45,159`

2. `PASS` — JARVIS 2025 and JARVIS-Leaderboard 2024 remain secondary / contextual rather than sole primary provenance anchors.
   Evidence:
   - `literature_claim_map_v2.md:19,53,94`
   - `introduction_paragraph_plan_v3.md:13,77-78,191-192`
   - `stage5_lit_intro_patch_changelog.md:31-43`

3. `PASS` — Lee & Asahi 2021 is explicitly restored as the primary transfer-learning anchor.
   Evidence:
   - `literature_claim_map_v2.md:21,54`
   - `introduction_paragraph_plan_v3.md:14,92,213`
   - `stage5_lit_intro_patch_changelog.md:57-65,160`

4. `PASS` — Kim et al. 2024 is now explicitly present as strong secondary support.
   Evidence:
   - `literature_claim_map_v2.md:21,54`
   - `introduction_paragraph_plan_v3.md:14,92,213`
   - `stage5_lit_intro_patch_changelog.md:58,64,161`

5. `PASS` — Hu et al. 2024 is demoted to contextual support for domain-adaptation / shifted-target wording rather than generic vanilla transfer-learning lead.
   Evidence:
   - `literature_claim_map_v2.md:21,54`
   - `introduction_paragraph_plan_v3.md:14,92,94,213,231`
   - `stage5_lit_intro_patch_changelog.md:59-70,162`

6. `PASS` — The gap statement remains narrow and specific.
   Required elements are all present:
   - single pretrained checkpoint
   - chemistry-family split
   - data-efficiency curve
   - no broad claim that "materials OOD is unexplored"
   Evidence:
   - `introduction_paragraph_plan_v3.md:32,39-43,95,230`
   - `stage5_lit_intro_patch_changelog.md:77-92,163`

7. `PASS` — The gap statement remains non-cited as a characterization of the literature rather than being falsely attributed to a source.
   Evidence:
   - `introduction_paragraph_plan_v3.md:43,95`

8. `PASS` — Matbench / broader benchmark infrastructure remains optional rather than required in the introduction.
   Evidence:
   - `literature_claim_map_v2.md:20,94`
   - `introduction_paragraph_plan_v3.md:16,73,195,197,215,232,257`
   - `stage5_lit_intro_patch_changelog.md:102-108,164`

9. `PASS` — The distinction between literature claims, project design, and research questions remains explicit and operational, not merely stylistic.
   Evidence:
   - `literature_claim_map_v2.md:46,60-76,92`
   - `introduction_paragraph_plan_v3.md:34-35,101-114`
   - `stage5_lit_intro_patch_changelog.md:119-128,165`

10. `PASS` — Anti-pattern protection remains in place.
   Specifically confirmed:
   - no `oxide-pretrained` wording
   - no tutorial-as-primary-citation
   - no embedding-as-proof wording
   - no result smuggling into the introduction
   Evidence:
   - `literature_claim_map_v2.md:34,68,70`
   - `introduction_paragraph_plan_v3.md:18,80,119,127,223-232`

## Failed Checks

The ten requested literature-logic checks above pass. The failures are supplemental drafting-safety failures that still matter before real intro drafting starts.

1. `FAIL` — The patched files still state that JARVIS 2020 is missing / "to be obtained," but the file is now physically present in `paper_sources/`.
   Verified present:
   - `paper_sources/Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design.pdf`
   Stale text remains at:
   - `literature_claim_map_v2.md:19,24,53`
   - `introduction_paragraph_plan_v3.md:76,210,244,258`
   - `stage5_lit_intro_patch_changelog.md:30,45,159,170`
   Why this matters:
   - The hierarchy is correct, but the pack still tells drafters the primary provenance anchor is unavailable. That is now false and should not remain in a drafting-safe pack.

2. `FAIL` — Stage 5 still contains an adjacent citation-planning file that can reintroduce the old JARVIS logic.
   Conflicting file:
   - `citation_needed_list.md:34,38`
   Problem:
   - Methods M1 / M5 still treat JARVIS 2025 and JARVIS-Leaderboard 2024 as the operative provenance choices and do not surface JARVIS 2020 as the primary repository / dataset anchor.
   Additional drift:
   - `citation_needed_list.md:3,11,15,26,72` still points to obsolete `introduction_blueprint_v2.md` naming.
   Why this matters:
   - `introduction_paragraph_plan_v3.md:183` explicitly says placeholders reuse wording already established in `citation_needed_list.md` and `literature_claim_map_v2.md`.
   - That means a later drafter can still pick up the wrong JARVIS provenance logic from the neighboring file even if the patched trio itself is correct.

## Ambiguous Checks

1. `AMBIGUOUS BY DESIGN` — P1 source choice remains open between CGCNN-only and CGCNN plus Chen et al. 2019.
   Evidence:
   - `introduction_paragraph_plan_v3.md:205-206,256`
   Assessment:
   - This does not threaten the corrected hierarchy. It is a drafting-consistency choice, not a citation-logic defect.

2. `AMBIGUOUS BY DESIGN` — The optional P2 benchmark-context sentence remains deferred until Methods is written.
   Evidence:
   - `introduction_paragraph_plan_v3.md:73,215,257`
   Assessment:
   - This is acceptable so long as the optional status remains respected. It should not be resolved by forcing Matbench or JARVIS-Leaderboard into the intro for appearance only.

## Remaining Issues Before Intro Drafting

1. Remove or update every stale "JARVIS 2020 missing / to be obtained" note in the three patched files now that the paper is present locally.

2. Sync `citation_needed_list.md` to the same JARVIS hierarchy as the patched files, or explicitly remove it from the drafting path.
   Minimum required fix:
   - Methods provenance rows must make JARVIS 2020 the primary dataset / repository anchor.
   - JARVIS 2025 must stay ecosystem-level.
   - JARVIS-Leaderboard 2024 must stay benchmark / leaderboard-only.

3. Remove obsolete references to `introduction_blueprint_v2.md` if `introduction_paragraph_plan_v3.md` is now the authoritative introduction-planning file.

4. After those fixes, run one short cross-file consistency pass across:
   - `literature_claim_map_v2.md`
   - `introduction_paragraph_plan_v3.md`
   - `citation_needed_list.md`
   - `stage5_lit_intro_patch_changelog.md`

## Final Verdict

`NOT READY`

Reason:
- The requested literature-logic corrections were successfully implemented in the patched trio.
- However, the pack is not yet safely execution-ready because:
  - the patched files still contain stale statements that JARVIS 2020 is missing even though it now exists locally, and
  - an adjacent Stage 5 citation file still carries the old JARVIS hierarchy and obsolete cross-references, which can reintroduce the exact provenance-citation error this patch was meant to prevent.

If those two issues are cleaned up, the pack should become ready for intro drafting without any further conceptual rewrite.
