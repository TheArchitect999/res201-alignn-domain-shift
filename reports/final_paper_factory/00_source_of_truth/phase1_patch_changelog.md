# Phase 1 Patch Changelog

Date: 2026-04-21  
Authored by: Claude Code (Phase 1 audit and patch pass)  
Originals preserved: all v1 files remain unmodified.

---

## Files created

| File | Resolves |
|---|---|
| `source_of_truth_memo_v2.md` | Fixes 1 + 7 + 8 |
| `master_evidence_manifest_v2.md` | Fixes 5 + 6 + 8 + 11 |
| `figure_inventory_v2.csv` | Fixes 2 + 3 + 9 + 10 + 11 + 12 |
| `table_inventory_v2.csv` | Fixes 6 + 9 + 10 |
| `claim_support_map_v2.csv` | Fixes 1 (partial) + 4 + 5 |
| `phase1_patch_changelog.md` | This document |

---

## Changes by file

### source_of_truth_memo_v2.md

**Fix 1 — PDF-extraction ambiguity removed (Critical)**  
Original memo said: *"The local paper_sources/RES201_Project.pdf file could not be text-extracted with available tools. The canonical-setting decision therefore relies on the explicit user brief plus repo docs..."*  
This phrasing implied uncertainty about the canonical setting. The project brief explicitly states the main setting; the PDF-extraction limitation was an implementation note, not a scientific caveat. Replaced with a direct statement: *"The project brief specifies the main experimental setting directly: epochs = 50, learning_rate = 1e-4, batch_size = 16."*  

**Fix 1 (cont.) — Paper structure is brief-specified (Important)**  
Added explicit statement that the final paper structure (three deliverables, Results I–IV order, abstract word limit) is specified directly by the project brief. This prevents Phase 3–11 from treating the structure as a design decision.

**Fix 7 — Restructured into explicit subsections (Polish)**  
Original memo was a loosely ordered list. v2 has three clear subsections: *Decision rationale*, *Empirical caveats*, and *Writing guardrails*. This makes the document navigable during writing phases when looking for a specific rule.

**Fix 8 — Shortened; points to manifest for artifact lists (Polish)**  
Removed the long "Main-Text Candidates" and "Appendix Or Robustness Only" lists from the memo. These are now canonical in `master_evidence_manifest_v2.md`. The memo is now a decision and rules document only.

---

### master_evidence_manifest_v2.md

**Fix 5 — Zero-shot namespace policy note added (Critical)**  
Added an explicit policy sentence: *"Zero-shot is treated as a shared pretrained baseline outside the fine-tuning namespace hierarchy. Its authoritative files remain in `reports/zero_shot/` and `Results_Before_Correction/` while Set 1 governs fine-tuning and from-scratch reporting."* Added in both the *Canonical decisions* section and the *Guardrails* section for visibility.

**Fix 6 — subset_counts.csv demoted (Important)**  
Removed `reports/week4_embedding_analysis/subset_counts.csv` from the "What Belongs In Main Text" list. Subset counts (242 nitride, 1484 oxide, balanced-pool counts) are methods-level provenance. They do not warrant a paper table but should be cited in methods. Now classified as `methods_support` in `table_inventory_v2.csv`.

**Fix 8 — Designated as authoritative evidence-policy document (Polish)**  
Added a *Document hierarchy* table at the top clarifying the roles of all Phase 1 documents. The manifest is now the authoritative artifact inventory; the memo is the decision record.

**Fix 11 — Main-text selectivity tightened (Important)**  
Separated main-text items into Tier 1 (non-negotiable) and Tier 2 (pending figure memo confirmation). Added explicit note: *"Tier 2 does not automatically enter main text. Each item requires a figure memo before promotion is confirmed."* This prevents the Phase 4 figure memo factory from treating every listed item as already decided.

---

### figure_inventory_v2.csv

**Fix 2 — Three placeholder rows added (Critical)**  
Added rows for figures that are required by the REPORT_PLAN core figure list but do not yet exist as repo artifacts:
- `FIG_SCHEMATIC`: study design schematic; `main_text_status = to_be_created`; `paper_section = methods`
- `FIG_ZS_COMPARISON`: zero-shot oxide vs nitride comparison figure; `main_text_status = to_be_created`; to be generated from `zero_shot_summary.csv`
- `FIG_TRANSFER_BENEFIT`: direct transfer-benefit across families; `main_text_status = to_be_created`; may be adapted from S1 comparison plots

Without these entries the Phase 4 figure memo queue would silently miss three REPORT_PLAN-required figures.

**Fix 3 — Four parity plots promoted to main_text_candidate (Critical)**  
Added four new individual rows with exact filenames:
- `FIG_S1_PARITY_OXIDE_N10`: oxide N=10 parity plot
- `FIG_S1_PARITY_OXIDE_N1000`: oxide N=1000 parity plot
- `FIG_S1_PARITY_NITRIDE_N10`: nitride N=10 parity plot (note: CLM_04 context applies)
- `FIG_S1_PARITY_NITRIDE_N1000`: nitride N=1000 parity plot

`FIG_S1_PARITY_COLLECTION` remains as `appendix_support` covering all 12 plots. The four promoted entries are distinct rows pointing to exact PNG/PDF filenames, confirmed on disk.

**Fix 9 — Added `report_scope` and `paper_section` columns (Important)**  
All rows now include:
- `report_scope`: one of `oxide / nitride / combined / shared`
- `paper_section`: one of `methods / results_oxide / results_nitride / results_comparison / results_embedding / discussion / appendix`

This allows the Phase 3 blueprint and Phase 4 figure memo factory to filter figures by report and section automatically.

**Fix 10 — Terminology standardized (Polish)**  
Four appendix sensitivity figures (`FIG_EA_APP_TSNE15`, `FIG_EA_APP_TSNE50`, `FIG_EA_APP_UMAP15`, `FIG_EA_APP_UMAP50`) had `main_text_status = appendix_only`. Changed to `appendix_support` to match the controlled vocabulary used everywhere else. Controlled vocabulary is now: `main_text_candidate / methods_support / appendix_support / robustness_only / provenance_only / to_be_created`.

**Fix 11 — Main-text selectivity (Polish)**  
Added context notes to learning curve and comparison plot entries to make their main-text claim explicit ("Fine-tuning never beats zero-shot reference line"). Makes the figure inventory itself a light scientific anchor, not just a path registry.

**Fix 12 — File-level precision improved (Polish)**  
Embedding appendix sensitivity figures and collection entries had empty `alternate_path_or_manifest` fields. Added `reports/week4_embedding_analysis/README.md` as the alternate anchor for all EA collection entries. This gives the Phase 4 figure memo factory a navigable starting point for each collection rather than a bare directory path.

Training curve collection entries were updated to include the JSON manifest as `alternate_path_or_manifest` where available.

---

### table_inventory_v2.csv

**Fix 6 — subset_counts.csv demoted to methods_support (Important)**  
`TAB_EA_SUBSET_COUNTS` changed from `appendix_support` to `methods_support`. The table records counts for the fixed-test balanced pool and oxide-reference subsets. This is methods-level provenance, not a paper-visible table.

**Fix 9 — Added `report_scope` and `paper_section` columns (Important)**  
Consistent with figure_inventory_v2.csv. All 24 table rows now have `report_scope` and `paper_section`.

**Fix 10 — Terminology standardized (Polish)**  
Two dataset-context rows (`TAB_CTX_OXIDE_SUMMARY_JSON`, `TAB_CTX_NITRIDE_SUMMARY_JSON`) had `main_text_status = appendix_context`. This value was outside the controlled vocabulary. Changed to `methods_support`.

---

### claim_support_map_v2.csv

**Fix 1 (partial) — DEC_01 note updated (Important)**  
DEC_01 note changed from *"Project brief PDF text was not extractable locally but user context and repo docs agree"* to *"Project brief directly specifies this setting. Repo docs confirm independently. No extraction uncertainty."* Removes the ambiguity that implied the canonical setting was inferred rather than specified.

**Fix 4 — CLM_04 annotated with N=10 caveat (Critical)**  
CLM_04 notes extended to include: *"At N=10 the mean_best_epoch=1.0 across all five runs; the selected checkpoint is effectively the pretrained zero-shot state and does not represent useful small-N adaptation."*  
This is the most important number-accuracy fix: without this annotation a writer could misread the lowest nitride fine-tune MAE at N=10 as evidence for effective small-N fine-tuning, when it actually reflects no meaningful weight updates.

CLM_04 `primary_figure_ids` also updated to reference the promoted parity plot entries `FIG_S1_PARITY_NITRIDE_N10` and `FIG_S1_PARITY_NITRIDE_N1000`.

**Fix 5 — DEC_02 added for zero-shot namespace split (Critical)**  
New row `DEC_02` added: *"Zero-shot is treated as a shared pretrained baseline outside the fine-tuning namespace hierarchy; its authoritative files remain in reports/zero_shot/ and Results_Before_Correction/ while Set 1 governs fine-tuning and from-scratch reporting."*  
This decision is now recorded in the claim map alongside the namespace decision, making it searchable and traceable for future audits.

---

## Unresolved items for manual review

| Item | Type | Action needed |
|---|---|---|
| FIG_SCHEMATIC | Figure to create | Decide format (draw.io / tikz / PowerPoint). Create file and update `preferred_path` in figure_inventory before Phase 4. |
| FIG_ZS_COMPARISON | Figure to create | Decide chart type (bar chart vs scatter). Generate from `reports/zero_shot/zero_shot_summary.csv`. Update `preferred_path` before Phase 4. |
| FIG_TRANSFER_BENEFIT | Figure to create | Decide whether to create a new panel or adapt the two S1 comparison plots. Update `preferred_path` before Phase 4. |
| CLM_04 nitride N=10 result | Scientific framing | The mean_best_epoch=1.0 finding is now annotated but requires explicit prose treatment in the nitride results section to avoid misleading readers. Assign to nitride section writer. |
| Set 1 vs Set 2/3 numerical tension | Scientific framing | Set 2 and Set 3 are closer to zero-shot than Set 1. The paper must frame Set 1 results with this context. No fix needed in the evidence pack; this is a prose-level task for Phases 7–8. |

None of the unresolved items block Phase 2 (canonical numbers extraction). All must be resolved before Phase 4 (figure memo factory) begins.
