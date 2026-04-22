# Phase 6 Maintenance Cleanup Changelog

**Date:** 2026-04-22  
**Type:** Non-blocking maintenance cleanup before Phase 7 prose drafting.  
**Scientific content changed:** None.

---

## A. `table_inventory_v2.csv` — Two Methods Tables Added

**File:** `reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv`

**What changed:** Appended two new rows at the end of the CSV:
- `TAB_METHODS_DATASET_SPLITS` — points to `TAB_METHODS_DATASET_SPLITS_v1.md` / `.csv`; category `methods_tables`; scope `shared`; section `methods`; status `main_text_candidate`.
- `TAB_METHODS_EXPERIMENT_SCOPE` — points to `TAB_METHODS_EXPERIMENT_SCOPE_v1.md` / `.csv`; category `methods_tables`; scope `shared`; section `methods`; status `main_text_candidate`.

**Why:** Both tables were materialized as standalone files during the Phase 6 closure pass but were not yet registered in the table inventory. The inventory is an authority file used to locate and audit all manuscript-facing tables; missing entries create a gap that would require manual correction later. Adding them now keeps the inventory complete before Phase 7 begins.

**Scientific logic changed:** No. Table counts and content are unchanged; only the inventory registration was missing.

---

## B. `STAGE6_METHODS_HANDOFF.md` — Archival Redirect Stub Created

**File:** `reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF.md` (new, lightweight)

**What changed:** Created a minimal redirect stub at the bare name `STAGE6_METHODS_HANDOFF.md`. The file contains no methods content; it exists solely to tell any reader or process that loads the old name to use `STAGE6_METHODS_HANDOFF_v2.md` instead.

**Why:** The Phase 6 closure pass created `STAGE6_METHODS_HANDOFF_v2.md` as the active launcher but left no file at the original bare name. Authority checklists and workflow references that use the bare name would silently find nothing. A redirect stub at the old name eliminates that gap without duplicating content.

**Scientific logic changed:** No. The stub is navigation-only; all methods decisions remain in `STAGE6_METHODS_HANDOFF_v2.md`.

---

## C. `TAB_METHODS_DATASET_SPLITS_v1.md` — Split Wording Tightened

**File:** `reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md`

**What changed:** In the manuscript-facing table, the "Split source" column value was changed from:

> `JARVIS benchmark split`

to:

> `Original JARVIS split manifest`

for both the oxide and nitride rows.

**Why:** "JARVIS benchmark split" implies a formally defined benchmark with standardized evaluation rules, which the repo evidence does not support. The actual split source recorded in both summary JSONs is `provided:manifests/dft_3d_formation_energy_peratom_splits.csv` — a manifest file applied before family filtering. "Original JARVIS split manifest" is faithful to that evidence and matches the cautious repo-grounded wording already used in the shared methods skeleton v2 ("original JARVIS benchmark split identities were preserved before family filtering"). This wording change also avoids any claim of benchmark formalism that a reviewer might challenge.

**Scientific logic changed:** No. Table counts, oxynitride treatment, family definitions, and all numeric values are unchanged. Only the caption wording for split provenance was made more precise.

---

## Summary

| Item | File | Change type | Scientific content changed |
|---|---|---|---|
| A | `table_inventory_v2.csv` | Added 2 missing rows | No |
| B | `STAGE6_METHODS_HANDOFF.md` | Created redirect stub | No |
| C | `TAB_METHODS_DATASET_SPLITS_v1.md` | Tightened split wording | No |
| D | `phase6_maintenance_cleanup_changelog.md` | Created (this file) | No |

This was a non-blocking maintenance cleanup. No scientific logic, run counts, numeric values, methods design, citation hierarchy, or report differentiation was altered. The Phase 6 methods pack approved for prose drafting remains intact and unchanged in substance.
