# Stage 6 Methods Handoff v2

**Status: UPDATED — Phase 6 closure pass applied 2026-04-22.**  
**Supersedes:** `STAGE6_METHODS_HANDOFF.md` and `PHASE6_METHODS_BUILD_NOTES.md`  
**Purpose:** This is the active launcher document for prose drafting of the Methods sections. The methods evidence pack has been closed and is now ready for prose drafting.

**Latest-only rule:** Always use the highest-versioned file. This v2 handoff supersedes v1 for all active drafting.

---

## A. Active Methods Pack — Prose-Drafting Ready

The following files constitute the closed Phase 6 methods pack. Load these for prose drafting.

### 1. Methods skeleton and report-specific notes (v2 — ACTIVE)

| Role | File | Status |
|---|---|---|
| Shared methods backbone | `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton_v2.md` | CLOSED — prose-drafting ready |
| Oxide-specific methods notes | `reports/final_paper_factory/03_section_inputs/oxide_methods_notes_v2.md` | CLOSED — prose-drafting ready |
| Nitride-specific methods notes | `reports/final_paper_factory/03_section_inputs/nitride_methods_notes_v2.md` | CLOSED — prose-drafting ready |
| Combined-paper methods notes | `reports/final_paper_factory/03_section_inputs/combined_methods_notes_v2.md` | CLOSED — prose-drafting ready |

**Superseded (do not use for drafting):** `shared_methods_skeleton.md`, `oxide_methods_notes.md`, `nitride_methods_notes.md`, `combined_methods_notes.md`

### 2. Methods tables (v1 — materialized as of Phase 6 closure)

| Table label | MD file | CSV file |
|---|---|---|
| TAB_METHODS_DATASET_SPLITS | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.md` | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_DATASET_SPLITS_v1.csv` |
| TAB_METHODS_EXPERIMENT_SCOPE | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_EXPERIMENT_SCOPE_v1.md` | `reports/final_paper_factory/03_section_inputs/TAB_METHODS_EXPERIMENT_SCOPE_v1.csv` |

Both tables are manuscript-facing artifacts derived from repo source files. They replace the placeholder references in the v1 methods files.

### 3. Embedding appendix-notes file (new in Phase 6 closure)

| Role | File |
|---|---|
| Appendix-facing and figure-note embedding details | `reports/final_paper_factory/03_section_inputs/embedding_methods_appendix_notes_v1.md` |

This file holds PCA/t-SNE/UMAP parameter sensitivity details, overlay-policy details, bootstrap/permutation operational notes, and layer-by-layer extraction notes that exceed what a main-text Methods section needs. Main-text methods files reference this file; they do not reproduce it.

---

## B. Authority Files — Unchanged From v1

These files remain unchanged from the v1 handoff and continue to govern prose drafting.

### Section blueprints (v3 — still active)

| Report | Blueprint |
|---|---|
| Oxide standalone | `reports/final_paper_factory/01_blueprints/oxide_report_blueprint_v3.md` |
| Nitride standalone | `reports/final_paper_factory/01_blueprints/nitride_report_blueprint_v3.md` |
| Combined paper | `reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md` |
| Cross-report identity control | `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md` |

### Canonical numbers (v2 — still active)

| File | Role |
|---|---|
| `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md` | Human-readable canonical number summary |
| `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv` | Full-precision authoritative table |
| `reports/final_paper_factory/00_source_of_truth/claim_to_number_source_map_v2.csv` | Path-level traceability |

### Source-of-truth memo (v2 — still active)

`reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`

### Table inventory (v2 — still active)

`reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv`

### Figure memos (unchanged)

`reports/final_paper_factory/02_figure_memos/figure_memo_index.md` plus all current memo files listed in STAGE6_METHODS_HANDOFF.md §A.4.

### Citation and claim-boundary controls (v3/v2 — still active)

- `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
- `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`

---

## C. Frozen Drafting Decisions (summary)

All decisions listed below were unresolved TODOs in the v1 methods pack. They are now frozen.

| Decision | Frozen value |
|---|---|
| Repeated-run convention | Mean ± SD across five seeds (all three report streams) |
| Seed wording in main text | "five random seeds" |
| Explicit seed IDs | In implementation/appendix notes only: {0, 1, 2, 3, 4} |
| Model-spec presentation | Compact paragraph in main Methods; no standalone architecture subsection |
| JARVIS citation | `[CITE: JARVIS 2020 dataset/repository paper]` |
| ALIGNN citation | `[CITE: ALIGNN foundational paper]` |
| Split provenance wording | Factual, repo-grounded: "original JARVIS benchmark split identities" |
| Oxynitride term | Brief parenthetical on first mention; no separate definition subsection |
| Zero-shot model-name in prose | "pretrained formation-energy ALIGNN model" |
| L1Loss / criterion discrepancy | State in implementation details that training uses L1Loss despite legacy config field |
| Embedding main-text layer | `last_alignn_pool` |
| Embedding appendix layers | `pre_head`, `last_gcn_pool` (near-duplicates; not independent probes) |
| PCA/t-SNE/UMAP granular parameters | In `embedding_methods_appendix_notes_v1.md`; main text states method names and primary settings only |
| Methods / Results boundary | Protected — low-N nitride interpretation is Results/Discussion only |
| oxide_reference_pool rationale | Definitional sentence in Methods; causal interpretation in Results |

---

## D. Latest-Only Rule (updated)

**Do not use these superseded files for prose drafting:**

Methods pack superseded:
- `shared_methods_skeleton.md`
- `oxide_methods_notes.md`
- `nitride_methods_notes.md`
- `combined_methods_notes.md`
- `STAGE6_METHODS_HANDOFF.md`
- `PHASE6_METHODS_BUILD_NOTES.md`

All other superseded files from STAGE6_METHODS_HANDOFF.md §B remain superseded.

---

## E. Report-Specific Input Bundles for Prose Drafting

### Oxide standalone

Required:
- `shared_methods_skeleton_v2.md`
- `oxide_methods_notes_v2.md`
- `TAB_METHODS_DATASET_SPLITS_v1.md`
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.md`
- `embedding_methods_appendix_notes_v1.md` (for embedding bridge / appendix notes)
- `oxide_report_blueprint_v3.md`
- `canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `table_inventory_v2.csv`
- `source_of_truth_memo_v2.md`
- Figure memos: `fig01`, `fig02`, `fig05a`, `fig06`, `fig07`

### Nitride standalone

Required:
- `shared_methods_skeleton_v2.md`
- `nitride_methods_notes_v2.md`
- `TAB_METHODS_DATASET_SPLITS_v1.md`
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.md`
- `embedding_methods_appendix_notes_v1.md`
- `nitride_report_blueprint_v3.md`
- `canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `table_inventory_v2.csv`
- `source_of_truth_memo_v2.md`
- Figure memos: `fig01`, `fig03`, `fig04`, `fig05b`, `fig08`, `fig09`, `fig10`, `fig11`, `fig12`, `fig13`, `fig13b`

### Combined paper

Required:
- `shared_methods_skeleton_v2.md`
- `combined_methods_notes_v2.md`
- `TAB_METHODS_DATASET_SPLITS_v1.md`
- `TAB_METHODS_EXPERIMENT_SCOPE_v1.md`
- `embedding_methods_appendix_notes_v1.md`
- `combined_paper_blueprint_v3.md`
- `shared_vs_unique_content_map_v3.md`
- `canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `table_inventory_v2.csv`
- `source_of_truth_memo_v2.md`
- All current figure memos

---

## F. Prose Drafting Constraints (unchanged from v1 + closure additions)

1. Do not invent results.
2. Do not insert outcome language into Methods.
3. Do not call the checkpoint "oxide-pretrained".
4. Do not move nitride low-N interpretation into Methods.
5. Do not weaken the Stage 5 citation hierarchy.
6. Do not broaden domain-shift claims in Methods.
7. Preserve report differentiation: oxide lighter on embedding; nitride fuller; combined most complete.
8. Use mean ± SD for all repeated-run summaries.
9. Use "five random seeds" in main text; seed IDs {0,1,2,3,4} in implementation/appendix notes only.
10. Keep `last_alignn_pool` as the main-text embedding layer.
11. Keep from-scratch scope explicit: only N = 50 and N = 500.
12. Do not describe MAE trends, adaptation claims, or family-performance gaps in Methods.
