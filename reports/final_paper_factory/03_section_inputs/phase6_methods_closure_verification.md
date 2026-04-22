# Phase 6 Methods Closure Verification

**Verification target:** patched Phase 6 methods-pack closure pass  
**Date:** 2026-04-22  
**Verifier:** Codex

This report checks drafting-readiness, not just factual plausibility. The standard used here is whether the pack is a stable writing base for Methods prose.

**Passed checks**

1. Manuscript-blocking TODOs are closed in the active v2 methods files.
- No `TODO` markers remain in `shared_methods_skeleton_v2.md`, `oxide_methods_notes_v2.md`, `nitride_methods_notes_v2.md`, or `combined_methods_notes_v2.md`.
- `phase6_methods_closure_changelog.md:33-40` records closure of the repeated-run and seed-wording TODOs that were previously manuscript-blocking.

2. Repeated-run reporting is frozen to mean +/- SD across seeds.
- `shared_methods_skeleton_v2.md:10,310-313`
- `oxide_methods_notes_v2.md:22,100`
- `nitride_methods_notes_v2.md:22,106`
- `combined_methods_notes_v2.md:22,119`
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.md:28`
- `STAGE6_METHODS_HANDOFF_v2.md:91,181`

3. Main-text seed wording is frozen to "five random seeds."
- `shared_methods_skeleton_v2.md:11,313`
- `combined_methods_notes_v2.md:23,119`
- `phase6_methods_closure_changelog.md:39-40,202`
- `STAGE6_METHODS_HANDOFF_v2.md:92,182`

4. JARVIS / ALIGNN citation placeholders remain aligned with the Stage 5 hierarchy.
- The active methods files use JARVIS 2020 for dataset/repository provenance and ALIGNN foundational-paper placeholders for model provenance:
- `shared_methods_skeleton_v2.md:14-15,84-85,134,167,196,279`
- `oxide_methods_notes_v2.md:45-46,94`
- `nitride_methods_notes_v2.md:51-52,100`
- `combined_methods_notes_v2.md:52-53,80,113`
- This matches the Stage 5 authority hierarchy:
- `literature_claim_map_v3.md:21,52-53`
- `citation_needed_list_v2.md:44-45,90-114`
- `introduction_paragraph_plan_v4.md:71,74-77,189-211`

5. `TAB_METHODS_DATASET_SPLITS_v1` and `TAB_METHODS_EXPERIMENT_SCOPE_v1` were materialized and are consistent with their stated source files.
- Dataset-splits table:
- `TAB_METHODS_DATASET_SPLITS_v1.md:6,42,48-49`
- `TAB_METHODS_DATASET_SPLITS_v1.csv` matches `data_shared/oxide/summaries/summary.json` and `data_shared/nitride/summaries/summary.json`.
- Verified counts:
- oxide: total 14991, train 11960, val 1547, test 1484, pool 13507, oxynitrides 499
- nitride: total 2288, train 1837, val 209, test 242, pool 2046, oxynitrides 0
- Experiment-scope table:
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.md:6-9,21,27-28`
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.csv` matches the Set 1 run sources and canonical counts.
- Verified run counts:
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv`: 60 rows
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv`: 20 rows
- `canonical_numbers_v2.md:30-31,65`

6. From-scratch scope is explicit and limited to `N = 50` and `N = 500`.
- `shared_methods_skeleton_v2.md:76,150,243`
- `oxide_methods_notes_v2.md:89,119,159`
- `nitride_methods_notes_v2.md:95,193,232`
- `combined_methods_notes_v2.md:210,251`
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.md:21,27`
- `STAGE6_METHODS_HANDOFF_v2.md:184`
- `canonical_numbers_v2.md:65`

7. The main-text embedding protocol is compressed appropriately, and detailed operational settings were moved to an appendix-facing support file.
- Main-text / notes layer:
- `shared_methods_skeleton_v2.md:329-345`
- `oxide_methods_notes_v2.md:25,105`
- `nitride_methods_notes_v2.md:26-28,165-171`
- `combined_methods_notes_v2.md:28,175-181`
- Appendix-facing support layer:
- `embedding_methods_appendix_notes_v1.md:3`
- `STAGE6_METHODS_HANDOFF_v2.md:35-39,102-103,134,148,162`
- `phase6_methods_closure_changelog.md:109-122,164,231`

8. Oxide / nitride / combined differentiation remains intact.
- Oxide notes keep embedding treatment brief and contextual:
- `oxide_methods_notes_v2.md:25,105`
- Nitride notes retain the fuller embedding protocol and nitride-specific hard/easy operational definitions:
- `nitride_methods_notes_v2.md:26-28,120,165-171`
- Combined notes remain the most complete and neutral cross-family Methods base:
- `combined_methods_notes_v2.md:13,22-28,119,175-181,189-190`
- `phase6_methods_closure_changelog.md:119-122`

9. `STAGE6_METHODS_HANDOFF_v2` correctly points future drafting to the new active files.
- Supersession and active-file routing are explicit:
- `STAGE6_METHODS_HANDOFF_v2.md:4,7`
- New methods tables and appendix notes are registered:
- `STAGE6_METHODS_HANDOFF_v2.md:30-39`
- Drafting bundles point to the v2 methods files plus the new methods tables and appendix notes:
- `STAGE6_METHODS_HANDOFF_v2.md:132-167`
- Frozen drafting rules are restated clearly:
- `STAGE6_METHODS_HANDOFF_v2.md:181-184`

**Failed checks**

- No manuscript-blocking failures were found in the active v2 methods files or the new methods tables.

**Ambiguous checks**

1. The literal-string version of the banned-language check is only partially satisfied.
- No positive manuscript-facing methods statements make nitride inertness claims, MAE-trend claims, outcome-comparison claims, oxide-pretrained claims, or embedding-as-proof claims.
- However, several active notes files still contain those exact phrases inside explicit negative guardrails:
- `shared_methods_skeleton_v2.md:29,181,351-352`
- `nitride_methods_notes_v2.md:32,179-180,197`
- `combined_methods_notes_v2.md:13,189-190`
- Assessment: substantively safe for prose drafting, but not a literal absence of those strings.

2. The authority pack is not fully synchronized.
- `STAGE6_METHODS_HANDOFF_v2.md` clearly supersedes the old handoff (`STAGE6_METHODS_HANDOFF_v2.md:4`), but `reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF.md` is currently missing even though it was named in the requested authority pack for this verification pass.
- `table_inventory_v2.csv` still lists older canonical tables and JSON summaries, but it does not yet register `TAB_METHODS_DATASET_SPLITS` or `TAB_METHODS_EXPERIMENT_SCOPE`.
- Assessment: this is an authority-indexing inconsistency, not a methods-content blocker, as long as future drafting uses `STAGE6_METHODS_HANDOFF_v2.md` as the entry point.

3. The closure changelog still records a few unresolved non-blocking items.
- `phase6_methods_closure_changelog.md:76,249`
- These concern hardware/runtime documentation and optional literature-positioning details beyond the core Methods authority chain.
- Assessment: not blocking for Methods prose under the current brief and citation policy.

**Any remaining issues before prose drafting**

- Use `STAGE6_METHODS_HANDOFF_v2.md` as the only routing file for future Methods drafting.
- If you want the authority pack to be fully synchronized, add `TAB_METHODS_DATASET_SPLITS` and `TAB_METHODS_EXPERIMENT_SCOPE` to `table_inventory_v2.csv`.
- Either restore `STAGE6_METHODS_HANDOFF.md` for archival traceability or remove it from any authority-pack checklists so the pack no longer names a missing file.
- Keep the guardrail lines in the notes files, but do not treat them as manuscript prose.

**Final verdict**

`ready for methods prose drafting`

Rationale: the active v2 methods bundle is no longer just a scaffold. The blocking TODOs are closed, the repeated-run convention and seed wording are frozen, the methods tables now exist as concrete artifacts, from-scratch scope is explicit, the embedding protocol is split correctly between main text and appendix support, and the oxide / nitride / combined differentiation is intact. The remaining issues are authority-pack synchronization and literal guardrail wording, not instability in the Methods writing base itself.
