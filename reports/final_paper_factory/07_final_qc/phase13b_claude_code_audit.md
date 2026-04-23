# Phase 13B — Claude Code Audit

Date: 2026-04-24

Auditor: Claude Code (Phase 13B role per REPORT_PLAN.txt)

Scope:
- `04_drafts/phase12_full_manuscripts/oxide_polished_v2.md`
- `04_drafts/phase12_full_manuscripts/nitride_polished_v2.md`
- `04_drafts/phase12_full_manuscripts/combined_paper_polished_v2.md`
- `07_final_qc/final_qc_report.md`
- `07_final_qc/oxide_fix_list.md`
- `07_final_qc/nitride_fix_list.md`
- `07_final_qc/combined_fix_list.md`
- `07_final_qc/cross_report_overlap_audit.md`

---

## 1. Path integrity

All 13 source-of-truth paths listed in the QC report's header were verified against the repo.

| Path cited in QC report | Status |
|---|---|
| `00_source_of_truth/canonical_numbers_v2.md` | ✓ exists |
| `00_source_of_truth/canonical_numbers_v2.csv` | ✓ exists |
| `00_source_of_truth/figure_inventory_v2.csv` | ✓ exists |
| `00_source_of_truth/table_inventory_v2.csv` | ✓ exists |
| `reports/zero_shot/zero_shot_summary.csv` | ✓ exists |
| `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | ✓ exists |
| `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | ✓ exists |
| `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | ✓ exists |
| `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv` | ✓ exists |
| `reports/week4_embedding_analysis/pca_notes.md` | ✓ exists |
| `02_figure_memos/fig06_oxide_lowN_parity_memo.md` | ✓ exists |
| `02_figure_memos/fig07_oxide_highN_parity_memo.md` | ✓ exists |
| `02_figure_memos/fig08_nitride_lowN_parity_memo.md` | ✓ exists |
| `02_figure_memos/fig09_nitride_highN_parity_memo.md` | ✓ exists |

No broken paths. All figure memo paths are present. The `embedding_methods_appendix_notes_v1.md` file referenced in both the nitride and combined manuscripts is located at `03_section_inputs/embedding_methods_appendix_notes_v1.md` — the manuscripts do not give an explicit path, which is acceptable for a manuscript-facing reference.

All figure labels used in the manuscripts (`FIG_SCHEMATIC`, `FIG_ZS_COMPARISON`, `FIG_S1_LC_OXIDE`, `FIG_S1_LC_NITRIDE`, `FIG_S1_PARITY_*`, `FIG_S1_COMP_*`, `FIG_TRANSFER_BENEFIT`, `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER`) are all present in `figure_queue.csv` with status `exists`.

---

## 2. Confirmation of QC report critical and important issues

All critical and important issues identified in the QC report were independently confirmed.

### Critical — confirmed

**C1. Combined paper internal-review material:**
- `combined_paper_polished_v2.md:9` — assembly note present ✓
- `combined_paper_polished_v2.md:264` — "Citation placeholders used in Results" internal handover paragraph present ✓
- `combined_paper_polished_v2.md:372-382` — "Evidence provenance for review" table present ✓
- `combined_paper_polished_v2.md:384-390` — "Known draft-stage caveats to resolve before assembly" block present ✓

All four instances confirmed. This is a hard QC failure for any submission-facing export of the combined draft.

### Important — confirmed

**I1. Nitride conclusion overclaiming:**
`nitride_polished_v2.md:248` confirmed: "Chemically distant targets require substantially more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do." Oxide fine-tuning never beats the oxide zero-shot benchmark within the tested N range either, so the cross-family comparison embedded in this sentence is not supported by the oxide control arm. Confirmed as important.

**I2. Combined paper non-final citation tokens:**
- `combined_paper_polished_v2.md:268` — `[CITE: ALIGNN_PAPER]`, `[CITE: JARVIS_INFRA]` confirmed ✓
- `combined_paper_polished_v2.md:277` — `[CITE: PROJECT_BRIEF]` confirmed ✓
- `combined_paper_polished_v2.md:306` — `[CITE: KIM2024; LEE_ASAHI2021]` confirmed ✓
- `combined_paper_polished_v2.md:327` — `[CITE: WEEK2_ASSIGNMENT]` confirmed ✓

`PROJECT_BRIEF` and `WEEK2_ASSIGNMENT` should be resolved to either a suppressed internal citation or removed before any version circulated outside the project team.

**I3. Embedding figure namespace inconsistency:**
Confirmed. Manuscripts and `figure_queue.csv` use suffixed labels (`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`). `figure_inventory_v2.csv` uses unsuffixed labels (`FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C`, `FIG_EA_6D`). See §3 below for the fix direction.

**I4. Raw-space-only wording conflict (combined paper §IV.A):**
`combined_paper_polished_v2.md:327` says "All statistical claims in this section are computed in that raw 256-D space" but the same section immediately provides PCA explained-variance numbers (18.13 %, 9.47 %, 27.60 %), which are projection-derived quantities. Confirmed. The sentence should be narrowed to "All *inferential* claims in this section…" or the PCA header values should be explicitly exempted.

**I5. "Pretraining regime more aligned" inference:**
`nitride_polished_v2.md:104` and `combined_paper_polished_v2.md:183` confirmed. Both sites state the corpus is consistent with being more aligned with oxides than nitrides, while later limitation sections say the corpus is not chemically characterized in detail. The wording should be softened to remove the directional alignment inference, or the basis for it should be made explicit.

**I6. Formal manuscript placeholders:**
Front-matter, acknowledgements, and references placeholders confirmed across all three files. All `[CITE: ...]` tokens confirmed present throughout. Expected for a draft; QC report correctly marks them as submission blockers.

### Minor — confirmed

All four minor issues in the QC report (`see appendix` unanchored references, `discrete transition` wording, `FIG_EA_6A/6B/6C/6D` shorthand, promotional phrasing) confirmed at the cited lines.

---

## 3. Figure namespace: fix direction

The QC report correctly identifies the namespace conflict but does not specify which label set should be treated as canonical. This audit adds the fix direction:

**Canonical namespace to adopt: the suffixed scheme from `figure_queue.csv`.**

Rationale:
- All three manuscripts already use the suffixed labels consistently.
- `figure_queue.csv` is the assembly-phase figure registry and uses suffixed labels throughout.
- The unsuffixed `FIG_EA_6A / 6B / 6C / 6D` in `figure_inventory_v2.csv` is the older evidence-phase label.

**Required action:** Update `figure_inventory_v2.csv` rows 30–33 to replace `FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C`, `FIG_EA_6D` with `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, and `FIG_EA_6D_BOXPLOT` / `FIG_EA_6D_SCATTER` respectively. No manuscript text changes required for this item.

---

## 4. New finding: combined paper subsection numbering inconsistency

Not flagged in the original QC report. The combined paper uses three different subsection numbering conventions across its sections:

| Section | Numbering style |
|---|---|
| §III Results I — Oxide | Arabic: `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6` |
| §IV Results II — Nitride | Arabic: `4.1`, `4.2`, … `4.7` |
| §V Results III — Direct comparison | Roman+alpha: `III.A`, `III.B`, `III.C`, `III.D`, `III.E` |
| §VI Results IV — Embedding analysis | Roman+alpha: `IV.A`, `IV.B`, `IV.C`, `IV.D`, `IV.E` |
| §VII Discussion | Roman+alpha: `VII.A`, `VII.B`, … `VII.I` |

This is a structural inconsistency that will require resolution before JURI template insertion. Classification: **minor** (no scientific claim is affected), but it must be harmonized before packaging. The most coherent choice would be to apply one scheme throughout: either all Arabic (`2.1`, `2.2`, …) or all Roman-Roman (`III.A`, `IV.B`, …). Given that the manuscript sections already use Roman numerals (`II. Methodology`, `III. Results I`, etc.), the Roman+alpha scheme for subsections is more self-consistent.

---

## 5. Fix list practicalibility assessment

All three fix lists are practical. Each fix item carries:
- specific line numbers referencing the polished draft
- a description of the current problem
- an explicit direction or reword logic for the fix

The following notes apply:

**Oxide fix list:** Clean and complete. No additions needed. The "important" and "minor" classification is proportionate to the actual severity of each item.

**Nitride fix list:** Complete and correct. Item 3 (recast conclusion sentence at line 248) provides the right repair logic — shift from a cross-family threshold claim to a within-family statement about later adaptation onset and larger residual gap. That rewrite is fully self-contained and does not require changes to any other section.

One clarification on nitride fix list item 2: the internal "Citation placeholders used in Results" paragraph (line 186) ends the §3.7 summary and should be deleted in its entirety. The preceding §3.7 summary paragraph is clean and should be retained.

**Combined fix list:** Complete. One additional note on critical item 3 (remove evidence provenance and caveats blocks): the deletion boundary should be from the `## Evidence provenance for review` heading through the last line of "Known draft-stage caveats to resolve before assembly" including the trailing blank line, before the `## VII. Discussion` heading begins. This removes the full internal block without touching any Discussion content.

---

## 6. Overlap audit assessment

The cross-report overlap audit is sound in method and verdict.

**Confirmed findings:**
- Results/Discussion/Conclusion prose is not duplicated between oxide and nitride standalones. This holds on inspection: the oxide report centers pretraining-vs-scratch value and the reference-condition role; the nitride report centers the domain-shift arc and low-N inertness. The Discussions answer different scientific questions.
- The high-overlap Introduction and Methods paragraphs are legitimate shared protocol text and do not constitute scientific-identity duplication.
- The verdict (Pass) is correct.

**One methodological note:** The audit explicitly scoped out the combined paper from the oxide-vs-nitride comparison (correctly, since the combined paper by design incorporates and expands both standalone narratives). The nitride standalone's §3.7 summary arc and the combined paper's §4.7 summary arc are near-identical text — this is expected design, not a standalone duplication problem.

**Remaining low overlap risk not previously noted:** The first two Introduction paragraphs of the oxide standalone, the nitride standalone, and the combined paper's §I are close to verbatim. If all three documents were submitted to the same venue simultaneously, this shared boilerplate would require differentiation. For sequential or separate submission, it is currently acceptable.

---

## 7. Refined overall verdict

The QC report's "needs one more patch" verdict is upheld and confirmed.

**What the patch must address (ranked):**

| Priority | Item | Action |
|---|---|---|
| Critical | Combined paper internal material (lines 9, 264, 372-390) | Delete those blocks |
| Important | Nitride conclusion cross-family threshold claim (line 248) | Recast per fix list item 3 |
| Important | Combined paper citation token cleanup (lines 268, 277, 306, 327) | Replace or suppress tokens |
| Important | Combined paper raw-space-only wording (line 327) | Narrow to "inferential claims" |
| Important | "Pretraining regime more aligned" softening (nitride:104, combined:183) | Soften inference |
| Important | Nitride internal handover paragraph (line 186) | Delete |
| Minor | Figure namespace: update `figure_inventory_v2.csv` | Rename 4 rows to suffixed labels |
| Minor | Combined paper subsection numbering harmonization | Standardize to one scheme |
| Minor | Appendix references anchoring (oxide:110, nitride:148/218, combined:226/432) | Add explicit IDs |
| Minor | `discrete transition` wording (nitride:125, combined:203) | Replace with `sharp transition` |
| Minor | `FIG_EA_6A/6B/6C/6D` shorthand (nitride:184, combined:262) | Expand to full suffixed labels |

After the critical and important fixes are applied, the three drafts will be scientifically sound and submission-facing clean. The minor fixes are quality improvements that should be completed before JURI template insertion.

**Go condition:** Apply the critical and important fixes above, then the drafts can move into Phase 13C (ChatGPT final scientific verdict) and JURI template packaging.
