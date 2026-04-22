# Stage 6 Methods Handoff

Purpose: this is the Phase 6 launcher file for Claude Pro. It consolidates the latest valid input set for methods drafting, marks superseded files that must not be used, and separates original brief context from repo-resolved project constraints.

This handoff is for the **Claude Pro prompt in REPORT_PLAN Phase 6**:

> Use Prompt T2 with:
> - `shared_methods_skeleton.md`
> - report-specific methods notes
> - project brief context

Because the reusable `Prompt T2` also asks for section blueprint, canonical numbers, figure memos, table list, source-of-truth memo, and project brief context, this handoff includes the full expanded evidence pack rather than the minimal three-file prompt.

---

## A. Active Phase 6 Authority Files

These are the current files Claude Pro should load first. Treat them as the active Phase 6 authority unless a later-versioned replacement appears.

### 1. Methods skeleton pack

Required for all three report streams.

| Role | File | Why it is active |
|---|---|---|
| Shared methods backbone | `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton.md` | Created for Phase 6; current repo-grounded scaffold |
| Oxide-specific methods notes | `reports/final_paper_factory/03_section_inputs/oxide_methods_notes.md` | Current oxide-specific methods pack |
| Nitride-specific methods notes | `reports/final_paper_factory/03_section_inputs/nitride_methods_notes.md` | Current nitride-specific methods pack |
| Combined-paper methods notes | `reports/final_paper_factory/03_section_inputs/combined_methods_notes.md` | Current combined-paper methods pack |

### 2. Section blueprints

Use only the `v3` blueprints.

| Report | Active blueprint | Why it is active |
|---|---|---|
| Oxide standalone | `reports/final_paper_factory/01_blueprints/oxide_report_blueprint_v3.md` | Latest oxide structure and guardrails |
| Nitride standalone | `reports/final_paper_factory/01_blueprints/nitride_report_blueprint_v3.md` | Latest nitride structure and guardrails |
| Combined paper | `reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md` | Latest combined-paper structure and guardrails |
| Cross-report identity control | `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md` | Latest reuse and differentiation guardrails |

### 3. Canonical numbers

Use `v2`, not the earlier version.

| Role | File | Why it is active |
|---|---|---|
| Human-readable canonical number summary | `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md` | Latest patched narrative summary |
| Full-precision authoritative table | `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv` | Latest authoritative numeric backbone |
| Traceability support | `reports/final_paper_factory/00_source_of_truth/claim_to_number_source_map_v2.csv` | Useful when Claude needs path-level provenance |

### 4. Figure memos

Use the index plus the complete current memo set. The index is the control file; the individual memos are the actual figure-specific evidence.

| Role | File |
|---|---|
| Figure-memo control index | `reports/final_paper_factory/02_figure_memos/figure_memo_index.md` |
| Optional QA check | `reports/final_paper_factory/02_figure_memos/figure_memo_audit.md` |

Current complete memo set:

- `reports/final_paper_factory/02_figure_memos/fig01_study_design_schematic_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig02_oxide_learning_curve_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig03_nitride_learning_curve_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig04_zero_shot_family_comparison_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig05_transfer_benefit_comparison_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig05a_oxide_comparison_plot_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig05b_nitride_comparison_plot_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig06_oxide_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig07_oxide_highN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig08_nitride_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig09_nitride_highN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig10_embedding_pca_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig11_embedding_tsne_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig12_embedding_umap_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig13_nitride_distance_error_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig13b_nitride_distance_error_scatter_memo.md`

### 5. Table list

Use the patched `v2` inventory.

| Role | File | Why it is active |
|---|---|---|
| Table inventory | `reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv` | Latest table inventory; supersedes `table_inventory.csv` |

### 6. Source-of-truth memo

| Role | File | Why it is active |
|---|---|---|
| Decision record for canonical paper-phase rules | `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md` | Latest canonical decision memo |

### 7. Project brief context

Use the original brief file plus the repo-resolved brief context below.

| Role | File | Notes |
|---|---|---|
| Original project brief | `paper_sources/RES201_Project.pdf` | Original file is present locally, but no text-extraction tool is available in this environment |
| Operating plan that restates the Phase 6 Claude workflow | `REPORT_PLAN.txt` | Contains Prompt T2 and Phase 6 execution rule |
| Week 1 brief-derived deliverables and filtering rules | `reports/week1_report.tex` | Restates subset, split, fixed test-set, and zero-shot deliverables from the brief |
| Week 2 brief-derived deliverables and seed rule | `reports/week2_report.tex` | Restates fine-tuning deliverables and minimum/preferred seed policy from the brief |
| Brief-resolved paper-phase decisions | `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md` | Encodes the brief-specified main hyperparameter setting and final paper structure |

---

## B. Latest-Only Rule

The files below are superseded for Phase 6 and should not guide Claude Pro when newer versions exist.

### Superseded blueprints

- `oxide_report_blueprint.md`
- `nitride_report_blueprint.md`
- `combined_paper_blueprint.md`
- `shared_vs_unique_content_map.md`

Use the `v3` versions instead.

### Superseded source-of-truth and numbers files

- `canonical_numbers.md`
- `canonical_numbers.csv`
- `claim_to_number_source_map.csv`
- `source_of_truth_memo.md`
- `table_inventory.csv`

Use the `v2` versions instead.

### Superseded Stage 5 citation/planning files

- `literature_claim_map.md`
- `literature_claim_map_v2.md`
- `citation_needed_list.md`
- `introduction_paragraph_plan.md`
- `introduction_paragraph_plan_v3.md`

For claim-boundary and citation discipline, use:

- `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
- `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`

---

## C. Project Brief Context, Resolved Carefully

The original brief PDF exists locally but was not text-extracted in this environment. The following brief constraints are still safe because they are explicitly restated and frozen in repo documents.

### Brief constraints resolved with high confidence

- The **main experimental setting** is `epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`.
- The paper phase must produce **three deliverables**:
  - oxide standalone report
  - nitride standalone report
  - combined paper
- The **combined paper structure** is brief-specified:
  - Introduction
  - Methods
  - Results I (oxide)
  - Results II (nitride)
  - Results III (direct comparison)
  - Results IV (embedding analysis)
  - Discussion
  - Conclusion
  - References
- The abstract must be a **single paragraph** and should stay **under 250 words**.

### Week 1 brief-derived requirements

From `reports/week1_report.tex`, the brief-derived Week 1 deliverables include:

- oxide subset filtered and confirmed
- nitride subset filtered and confirmed, with oxynitrides excluded from the nitride arm
- original JARVIS split IDs applied before family filtering
- fixed oxide and nitride test sets
- pretrained checkpoint loaded
- oxide zero-shot MAE reported
- nitride zero-shot MAE reported

Week 1 also restates the filtering rule clearly:

- oxide arm: any material containing `O`
- nitride arm: materials containing `N` and not `O`
- oxynitrides excluded from the nitride arm
- oxynitrides may remain in the oxide arm because the brief defines oxides by `O` presence

### Week 2 brief-derived requirements

From `reports/week2_report.tex`, the brief-derived Week 2 deliverables include:

- all oxide fine-tuning runs completed
- an oxide MAE table
- an oxide learning-curve plot
- all nitride fine-tuning runs completed
- a nitride MAE table
- a nitride learning-curve plot

The same Week 2 brief-derived section also states:

- multiple random seeds should be used
- three seeds are a minimum target
- five seeds are the preferred target

### Project-brief context that matters specifically for Phase 6 methods

- The methods sections must treat Set 1 as the canonical main-results namespace because it matches the brief-specified `50 / 1e-4 / 16` setting.
- Oxide is the intended **control** arm.
- Nitride is the intended **cross-family / shifted** arm.
- From-scratch comparisons exist only where they were actually run. Do not imply scratch baselines at missing `N` values.

---

## D. Table-Source Resolution Notes For Methods

The blueprints use manuscript-facing table labels that do not always correspond to one already-frozen standalone CSV. Claude should know the underlying source files.

### `TAB_METHODS_DATASET_SPLITS`

Not a standalone frozen CSV yet. Build this methods table from:

- `data_shared/oxide/summaries/summary.json`
- `data_shared/nitride/summaries/summary.json`

This table should cover:

- family totals
- train/val/test/pool counts
- split provenance
- oxynitride inclusion/exclusion rule

### `TAB_METHODS_EXPERIMENT_SCOPE`

Not a standalone frozen CSV yet. Build this methods table from:

- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`

This table should cover:

- fine-tuning run counts
- from-scratch run counts
- `N` coverage
- seed coverage
- explicit statement that from-scratch exists only at `N = 50` and `N = 500`

---

## E. Report-Specific Input Bundles

These are the most practical Claude-loading bundles for Phase 6.

### Oxide standalone methods bundle

Required:

- `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton.md`
- `reports/final_paper_factory/03_section_inputs/oxide_methods_notes.md`
- `reports/final_paper_factory/01_blueprints/oxide_report_blueprint_v3.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`
- `reports/final_paper_factory/02_figure_memos/figure_memo_index.md`
- `reports/final_paper_factory/02_figure_memos/fig01_study_design_schematic_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig02_oxide_learning_curve_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig05a_oxide_comparison_plot_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig06_oxide_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig07_oxide_highN_parity_memo.md`

Recommended support:

- `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md`
- `reports/final_paper_factory/02_figure_memos/fig04_zero_shot_family_comparison_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig10_embedding_pca_memo.md`
- `paper_sources/RES201_Project.pdf`
- `REPORT_PLAN.txt`
- `reports/week1_report.tex`
- `reports/week2_report.tex`

### Nitride standalone methods bundle

Required:

- `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton.md`
- `reports/final_paper_factory/03_section_inputs/nitride_methods_notes.md`
- `reports/final_paper_factory/01_blueprints/nitride_report_blueprint_v3.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`
- `reports/final_paper_factory/02_figure_memos/figure_memo_index.md`
- `reports/final_paper_factory/02_figure_memos/fig01_study_design_schematic_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig03_nitride_learning_curve_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig04_zero_shot_family_comparison_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig05b_nitride_comparison_plot_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig08_nitride_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig09_nitride_highN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig10_embedding_pca_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig11_embedding_tsne_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig12_embedding_umap_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig13_nitride_distance_error_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig13b_nitride_distance_error_scatter_memo.md`

Recommended support:

- `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md`
- `paper_sources/RES201_Project.pdf`
- `REPORT_PLAN.txt`
- `reports/week1_report.tex`
- `reports/week2_report.tex`

### Combined-paper methods bundle

Required:

- `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton.md`
- `reports/final_paper_factory/03_section_inputs/combined_methods_notes.md`
- `reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md`
- `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`
- `reports/final_paper_factory/02_figure_memos/figure_memo_index.md`
- all current figure memo files listed in Section A.4

Recommended support:

- `paper_sources/RES201_Project.pdf`
- `REPORT_PLAN.txt`
- `reports/week1_report.tex`
- `reports/week2_report.tex`

---

## F. Additional High-Value Control Files

These are not part of the minimal Prompt T2 list, but they are relevant and should be supplied if Claude Pro starts drifting on citation discipline, claim boundaries, or report differentiation.

| Role | File |
|---|---|
| Claim-boundary authority | `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md` |
| Practical methods/discussion citation helper | `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md` |
| Stage 5 drafting control layer | `reports/final_paper_factory/03_section_inputs/STAGE5_DRAFTING_HANDOFF.md` |
| Figure memo QA | `reports/final_paper_factory/02_figure_memos/figure_memo_audit.md` |
| Source-of-truth audit | `reports/final_paper_factory/00_source_of_truth/source_of_truth_audit.md` |

Important note:

- `RES201_Project.pdf`, `REPORT_PLAN.txt`, the blueprints, and the repo planning docs are **internal guidance**, not default manuscript citations.
- For manuscript citations, Claude should defer to `literature_claim_map_v3.md` and `citation_needed_list_v2.md`.

---

## G. Copy-Paste Claude Pro Prompt

Use this as the Phase 6 prompt shell after attaching the relevant files.

```text
You are writing a research-report methods section from a frozen evidence pack.

Inputs:
- section blueprint
- canonical numbers
- figure memos
- table list
- source-of-truth memo
- project brief context
- shared methods skeleton
- report-specific methods notes

Task:
Write a polished methods draft.

Constraints:
1. Separate clearly:
   - literature-grounded claims
   - our implementation details
   - our experimental setup
2. Do not invent results.
3. Do not overstate conclusions.
4. Use the evidence pack as the single source of truth.
5. Keep the tone formal, precise, and publication-like.
6. Leave citation placeholders where needed: [CITE: ...]
7. If something is unclear, keep a TODO marker instead of guessing.
8. Use only the latest files listed in STAGE6_METHODS_HANDOFF.md; ignore superseded versions.
9. Treat internal project-brief files as planning inputs, not default manuscript citations.
10. Keep Set 1 as the canonical main experimental setting: epochs = 50, learning_rate = 1e-4, batch_size = 16.
11. Keep from-scratch scope explicit: only N = 50 and N = 500.
12. Keep main-text embedding language centered on last_alignn_pool unless the appendix is explicitly being described.
13. Do not write MAE trends, adaptation claims, or other experimental findings into the Methods section.

Output:
- methods section draft
- 3–5 sentence author note explaining the strongest grounded points and the main unresolved TODOs
```

---

## H. Practical Usage Rule

For Phase 6 methods, the actual drafting priority should be:

1. methods skeleton pack
2. report blueprint `v3`
3. source-of-truth memo `v2`
4. canonical numbers `v2`
5. table inventory `v2`
6. project brief context pack
7. figure memos
8. citation / claim-boundary controls

Figure memos and result tables are supporting evidence for terminology consistency and section anchoring. They are not the primary authorship authority for the methods narrative.
