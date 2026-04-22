# Stage 5 Literature / Introduction Consistency Verification

Date: 2026-04-22

Scope verified:
- `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
- `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v4.md`
- `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`
- `reports/final_paper_factory/03_section_inputs/stage5_lit_intro_consistency_changelog.md`

Repo-state verified against:
- `paper_sources/Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design.pdf`

## Passed Checks

1. `PASS` — `literature_claim_map_v3.md` no longer says JARVIS 2020 is missing or "to be obtained."
   Evidence:
   - `literature_claim_map_v3.md:5`
   - `literature_claim_map_v3.md:21`
   - `literature_claim_map_v3.md:53`

2. `PASS` — `introduction_paragraph_plan_v4.md` no longer says JARVIS 2020 is missing or "to be obtained."
   Evidence:
   - `introduction_paragraph_plan_v4.md:15`
   - `introduction_paragraph_plan_v4.md:75`
   - `introduction_paragraph_plan_v4.md:209`

3. `PASS` — The changelog no longer presents JARVIS 2020 as currently unavailable.
   Evidence:
   - `stage5_lit_intro_consistency_changelog.md:4`
   - `stage5_lit_intro_consistency_changelog.md:133-146`
   - `stage5_lit_intro_consistency_changelog.md:166`
   Note:
   - The changelog still quotes old stale phrases when documenting what was removed, but it treats those as resolved historical state, not current repo state.

4. `PASS` — All revised files now treat JARVIS 2020 as physically present and as the primary provenance / dataset anchor.
   Evidence:
   - Repo state: `paper_sources/Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf`
   - `literature_claim_map_v3.md:21,53`
   - `introduction_paragraph_plan_v4.md:15,71,75,189,209`
   - `citation_needed_list_v2.md:15,44,48,90,114`
   - `stage5_lit_intro_consistency_changelog.md:68-78,134`

5. `PASS` — JARVIS 2025 remains secondary for broader ecosystem / pretrained-infrastructure context.
   Evidence:
   - `literature_claim_map_v3.md:21,53`
   - `introduction_paragraph_plan_v4.md:71,76,190`
   - `citation_needed_list_v2.md:44,48,91,114`
   - `stage5_lit_intro_consistency_changelog.md:68,73,78`

6. `PASS` — JARVIS-Leaderboard 2024 remains contextual only for benchmark / leaderboard framing.
   Evidence:
   - `literature_claim_map_v3.md:21,53,94`
   - `introduction_paragraph_plan_v4.md:77,191,256`
   - `citation_needed_list_v2.md:44,92,97,114`
   - `stage5_lit_intro_consistency_changelog.md:68,78`

7. `PASS` — `citation_needed_list_v2.md` is now synchronized with the repaired JARVIS hierarchy and no longer reintroduces the old provenance error.
   Evidence:
   - `citation_needed_list_v2.md:15`
   - `citation_needed_list_v2.md:44`
   - `citation_needed_list_v2.md:48`
   - `citation_needed_list_v2.md:90-92`
   - `citation_needed_list_v2.md:114`

8. `PASS` — Obsolete references to older intro-planning files were removed or updated where they mattered operationally.
   Evidence:
   - `citation_needed_list_v2.md:3,5,17,34,88`
   - `literature_claim_map_v3.md:7`
   - `stage5_lit_intro_consistency_changelog.md:82,103,106,136`
   Note:
   - Historical mentions of older files remain in the changelog as change-history, which is acceptable.

9. `PASS` — The transfer-learning hierarchy remains intact.
   Required ordering confirmed:
   - Lee & Asahi 2021 primary
   - Kim et al. 2024 secondary
   - Hu et al. 2024 contextual only
   Evidence:
   - `literature_claim_map_v3.md:23,54`
   - `introduction_paragraph_plan_v4.md:91,93,212,230`
   - `citation_needed_list_v2.md:65,66,70,115`

10. `PASS` — The corrected drafting logic was preserved.
   Specifically confirmed:
   - narrow evaluation-design gap
   - introduction remains result-free
   - Matbench remains optional
   - literature / project-design / our-question boundary remains explicit
   - anti-pattern protections remain in place
   Evidence:
   - Narrow gap: `introduction_paragraph_plan_v4.md:31,42,94`
   - Result-free intro: `introduction_paragraph_plan_v4.md:17,225`
   - Matbench optional: `literature_claim_map_v3.md:22,94`; `introduction_paragraph_plan_v4.md:17,72,194,196,214,231`; `citation_needed_list_v2.md:97`
   - Boundary explicit: `literature_claim_map_v3.md:7,46,92`; `introduction_paragraph_plan_v4.md:113`; `citation_needed_list_v2.md:5`
   - Anti-pattern protection: `introduction_paragraph_plan_v4.md:224-231`; `citation_needed_list_v2.md:107-115`

## Failed Checks

None.

## Ambiguous Checks

1. `AMBIGUOUS BY DESIGN` — The P1 choice between CGCNN-only versus CGCNN plus Chen et al. 2019 remains open.
   Evidence:
   - `introduction_paragraph_plan_v4.md:255`
   Assessment:
   - This is a drafting-consistency choice, not a hierarchy or provenance blocker.

2. `AMBIGUOUS BY DESIGN` — The optional P2 Matbench / broader benchmarking sentence remains deferred until Methods is written.
   Evidence:
   - `introduction_paragraph_plan_v4.md:72,214,256`
   Assessment:
   - This is acceptable because the optional status is explicit and consistently protected across files.

3. `AMBIGUOUS BUT NON-BLOCKING` — Older superseded Stage 5 files still exist in the directory.
   Assessment:
   - This is not a blocker because the active files now carry explicit authority notes and supersedes pointers.
   - It remains worth telling future drafters to use the active set only:
     - `literature_claim_map_v3.md`
     - `introduction_paragraph_plan_v4.md`
     - `citation_needed_list_v2.md`

## Remaining Issues Before Intro Drafting

No remaining drafting-safety blockers were found in the revised consistency-pass files.

Non-blocking open choices:
- Decide later whether P1 uses CGCNN only or CGCNN plus Chen et al. 2019.
- Decide later whether P2 includes the optional broader benchmark-context sentence.
- Keep drafters on the active v3 / v4 / v2 files rather than superseded older Stage 5 variants.

## Final Verdict

`READY FOR INTRO DRAFTING`

Reason:
- JARVIS 2020 is physically present and consistently treated as the primary provenance anchor across the active Stage 5 pack.
- JARVIS 2025 and JARVIS-Leaderboard 2024 are consistently demoted to their proper secondary / contextual roles.
- `citation_needed_list_v2.md` is now aligned with the repaired hierarchy and no longer provides a backdoor to the old provenance mistake.
- The transfer-learning hierarchy, narrow gap framing, result-free introduction rule, optional Matbench status, literature / project / question boundary, and anti-pattern protections all remain intact across the active files.
