# Phase 6 Maintenance Cleanup Verification

**Verification target:** small Phase 6 maintenance cleanup  
**Date:** 2026-04-22  
**Verifier:** Codex

This pass checks whether the cleanup fixed workflow and polish issues without changing scientific content.

**Passed checks**

1. `table_inventory_v2.csv` now includes both missing Methods tables.
- `TAB_METHODS_DATASET_SPLITS` is present at [table_inventory_v2.csv](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv:26).
- `TAB_METHODS_EXPERIMENT_SCOPE` is present at [table_inventory_v2.csv](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv:27).
- `git diff` shows these as additive inventory registrations only; no older rows were altered.

2. Stage 6 handoff routing is now consistent and no longer confusing.
- [STAGE6_METHODS_HANDOFF.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF.md:3) is now a redirect stub rather than a missing file.
- The stub explicitly points readers to [STAGE6_METHODS_HANDOFF_v2.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF.md:9).
- [STAGE6_METHODS_HANDOFF_v2.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF_v2.md:4) explicitly says it supersedes the old handoff, and [STAGE6_METHODS_HANDOFF_v2.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF_v2.md:7) applies a latest-only rule.

3. `TAB_METHODS_DATASET_SPLITS_v1.md` now uses more cautious split-provenance wording than the older `JARVIS benchmark split` label.
- The manuscript-facing table rows now use `Original JARVIS split manifest` at [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:16) and [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:17).
- The explanatory note ties that wording to the concrete manifest `provided:manifests/dft_3d_formation_energy_peratom_splits.csv` at [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:21).
- The maintenance changelog records this as a wording-tightening step, not a scientific change, at [phase6_maintenance_cleanup_changelog.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/phase6_maintenance_cleanup_changelog.md:37).

4. No numeric values, run counts, or scientific logic changed.
- The only tracked diff in the cleanup set is the addition of two inventory rows in `table_inventory_v2.csv`.
- The counts in [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:16) and [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:17) still match:
- `data_shared/oxide/summaries/summary.json`: 14991 / 11960 / 1547 / 1484 / 13507 / 499
- `data_shared/nitride/summaries/summary.json`: 2288 / 1837 / 209 / 242 / 2046 / 0
- The cleanup changelog explicitly limits itself to maintenance and states `Scientific content changed: None` at [phase6_maintenance_cleanup_changelog.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/phase6_maintenance_cleanup_changelog.md:3) and [phase6_maintenance_cleanup_changelog.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/phase6_maintenance_cleanup_changelog.md:64).

5. No citation hierarchy drift was introduced.
- [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:21) still uses `[CITE: JARVIS 2020 dataset/repository paper]` for dataset and split provenance.
- [STAGE6_METHODS_HANDOFF_v2.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF_v2.md:95) and [STAGE6_METHODS_HANDOFF_v2.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF_v2.md:96) still preserve the JARVIS 2020 / ALIGNN foundational-paper placeholder pair.
- No new JARVIS 2025, leaderboard, or other alternative citation routing was introduced in the cleanup files.

6. The cleanup is purely maintenance, and Phase 7 can proceed.
- The changes are limited to inventory registration, redirect restoration, and wording polish.
- No methods design, report differentiation, run coverage, seed convention, or embedding protocol was changed.
- The cleanup changelog characterizes the pass as `Non-blocking maintenance cleanup before Phase 7 prose drafting` at [phase6_maintenance_cleanup_changelog.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/phase6_maintenance_cleanup_changelog.md:4).

**Failed checks**

- None.

**Any remaining minor issues**

- [TAB_METHODS_DATASET_SPLITS_v1.md](/C:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md:21) still uses the phrase `original JARVIS benchmark split identities` in the explanatory prose. This is more careful than the old table label and is tied to the manifest path, so it is not misleading, but if the cleanup goal was to remove `benchmark` terminology from that file entirely, one residual mention remains.
- Several of the Phase 6 files in this cleanup set are still not committed in git. That is a version-control state issue, not a content issue.

**Final verdict**

`ready to proceed to Phase 7`

The cleanup behaves as intended: it fixes workflow completeness and wording precision without changing scientific content.
