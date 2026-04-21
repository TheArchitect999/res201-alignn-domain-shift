# Phase 1 Patch Verification

Date: 2026-04-21  
Verifier: Codex  
Scope: local verification of the patched `*_v2` Phase 1 source-of-truth pack only

## Verification basis

- Read directly:
  - `master_evidence_manifest_v2.md`
  - `source_of_truth_memo_v2.md`
  - `figure_inventory_v2.csv`
  - `table_inventory_v2.csv`
  - `claim_support_map_v2.csv`
  - `phase1_patch_changelog.md`
- Checked CSV headers and specific rows programmatically.
- Checked promoted parity-plot paths against the actual files on disk.
- Checked repo state with `git status --short --untracked-files=all`.

## Passed checks

### 1. Set 1 remains the canonical main-results namespace

Passed.

Evidence:
- `master_evidence_manifest_v2.md` lists `Results_Hyperparameter_Set_1/` as the main-results namespace.
- `source_of_truth_memo_v2.md` opens its decision rationale with `Canonical main-results namespace: Results_Hyperparameter_Set_1/`.
- `claim_support_map_v2.csv` row `DEC_01` states the same mapping and ties it directly to the project brief setting.

### 2. PDF ambiguity in the memo has been removed or softened appropriately

Passed.

Evidence:
- `source_of_truth_memo_v2.md` no longer frames the canonical-setting decision as uncertain because of PDF extraction limits.
- `claim_support_map_v2.csv` row `DEC_01` now says: `Project brief directly specifies this setting. Repo docs confirm independently. No extraction uncertainty.`
- No `paper_sources/RES201_Project.pdf` extraction caveat remains in the memo.

### 3. Placeholder rows were added for the missing planned figures

Passed, semantically.

Evidence:
- `figure_inventory_v2.csv` contains:
  - `FIG_SCHEMATIC` with category `study_design_schematic`
  - `FIG_ZS_COMPARISON` with category `zero_shot_comparison`
  - `FIG_TRANSFER_BENEFIT` with category `transfer_benefit_across_families`
- All three are marked `main_text_status = to_be_created`.
- All three also have `report_scope` and `paper_section` populated.

Note:
- The semantic placeholders exist and close the missing-row issue.
- Two category names are not exact string matches to the wording in the request (`zero_shot_oxide_vs_nitride_comparison`, `direct_transfer_benefit_across_families`), but the intended figures are clearly represented.

### 5. CLM_04 includes the early-stopping caveat

Passed.

Evidence:
- `claim_support_map_v2.csv` row `CLM_04` now includes:
  - `At N=10 the mean_best_epoch=1.0 across all five runs; the selected checkpoint is effectively the pretrained zero-shot state and does not represent useful small-N adaptation.`

### 6. subset_counts.csv is no longer treated as a normal main-text candidate

Passed.

Evidence:
- `table_inventory_v2.csv` row `TAB_EA_SUBSET_COUNTS` now has `main_text_status = methods_support`.
- `master_evidence_manifest_v2.md` explicitly says:
  - `Subset counts table (subset_counts.csv) - methods support only; not a paper table`

### 7. source_of_truth_memo_v2.md is split into the required sections

Passed.

Evidence:
- `source_of_truth_memo_v2.md` contains exactly these top-level sections:
  - `## Decision rationale`
  - `## Empirical caveats`
  - `## Writing guardrails`

### 8. master_evidence_manifest_v2.md now functions as the authoritative policy document

Passed.

Evidence:
- The file begins with:
  - `This is the authoritative evidence-policy document for the RES201 paper phase.`
- Its document hierarchy table identifies it as:
  - `Authoritative artifact inventory and tier classification`
- It also contains the explicit zero-shot namespace policy and the Tier 1 / Tier 2 policy split.

### 9. figure_inventory_v2.csv and table_inventory_v2.csv contain report_scope and paper_section

Passed.

Evidence:
- `figure_inventory_v2.csv` headers include `report_scope` and `paper_section`.
- `table_inventory_v2.csv` headers include `report_scope` and `paper_section`.
- Programmatic check found no rows missing either field in either CSV.

### 10. No experimental result artifact was edited or overwritten

Passed, based on current repo state.

Evidence:
- `git status --short --untracked-files=all` shows only six untracked Phase 1 patch files:
  - `claim_support_map_v2.csv`
  - `figure_inventory_v2.csv`
  - `master_evidence_manifest_v2.md`
  - `phase1_patch_changelog.md`
  - `source_of_truth_memo_v2.md`
  - `table_inventory_v2.csv`
- No tracked files under result or report artifact namespaces are currently marked modified.

## Failed checks

None as narrowly stated by the checklist.

## Ambiguous checks

### 4. The four specified parity plots are now promoted to main_text_candidate

Ambiguous.

What passed:
- `figure_inventory_v2.csv` contains all four promoted rows:
  - `FIG_S1_PARITY_OXIDE_N10`
  - `FIG_S1_PARITY_OXIDE_N1000`
  - `FIG_S1_PARITY_NITRIDE_N10`
  - `FIG_S1_PARITY_NITRIDE_N1000`
- All four have `main_text_status = main_text_candidate`.

What failed operationally:
- All four promoted rows point to non-existent files.
- The actual parity filenames on disk contain a comma before `N=...`, for example:
  - `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1, N=10.png`
- The v2 rows omit that comma, for example:
  - `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=10.png`

Impact:
- The promotion is real in classification terms.
- The promoted entries are not yet usable as reliable figure references for later phases until the four paths are corrected.

## Any remaining issues before Phase 2 or Phase 4

### Remaining issues

1. The four promoted parity rows need path correction.
   - This is the only material defect found in the patched pack.
   - It should be fixed before Phase 4 because figure memo generation depends on exact file resolution.

2. The three placeholder figures still have `preferred_path = to_be_created`.
   - This is expected and already documented in the changelog.
   - It is not a Phase 1 failure, but it remains a real dependency before figure production.

3. The placeholder category names are semantically correct but not fully normalized to the longer requested phrasing for two rows.
   - This is not blocking.
   - It only matters if a later automation step expects exact controlled strings rather than semantic equivalents.

4. The memo/manifest authority split is workable but intentionally divided.
   - The manifest is authoritative for inventory and tiering.
   - The memo still carries decision rationale and guardrails.
   - This is consistent with the current document hierarchy and is not blocking.

## Final verdict

**Not ready**

Reason:
- The Phase 1 patch pass substantially improved the pack and closed most important issues.
- However, the four newly promoted parity entries in `figure_inventory_v2.csv` currently reference non-existent files, so the pack is not yet operationally safe for downstream figure-driven phases without a small corrective patch.
