# Final QC Report

Date: 2026-04-24

Scope audited:
- `04_drafts/phase12_full_manuscripts/oxide_polished_v2.md`
- `04_drafts/phase12_full_manuscripts/nitride_polished_v2.md`
- `04_drafts/phase12_full_manuscripts/combined_paper_polished_v2.md`

Primary source-of-truth files checked:
- `00_source_of_truth/canonical_numbers_v2.md`
- `00_source_of_truth/canonical_numbers_v2.csv`
- `00_source_of_truth/figure_inventory_v2.csv`
- `00_source_of_truth/table_inventory_v2.csv`
- `reports/zero_shot/zero_shot_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- `reports/final_paper_factory/02_figure_memos/fig06_oxide_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig07_oxide_highN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig08_nitride_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig09_nitride_highN_parity_memo.md`
- `reports/week4_embedding_analysis/pca_notes.md`

## Passed checks

- No measured value drift was found in the three polished manuscripts for the core canonical numbers:
  - zero-shot MAE and test-set sizes
  - Set 1 fine-tuning means, standard deviations, and mean best epochs
  - Set 1 from-scratch means and transfer-benefit arithmetic
  - main-text embedding metrics from `last_alignn_pool`
  - nitride distance-error statistics
- Spot-checks on non-table numeric values also passed:
  - parity-figure MAE / RMSE / R^2 values
  - PCA variance header values in the combined manuscript
- No accidental dependence on Set 2 / Set 3 robustness results was found in the scientific body.
- The oxide, nitride, and combined manuscripts remain broadly aligned on the main scientific story:
  - oxide is the chemistry-aligned control
  - nitride shows delayed adaptation and a persistent residual penalty under Set 1
  - embedding language is mostly correlational rather than causal
- No `TODO`, `TBD`, `TK`, `XXX`, or `FIXME` markers were found.
- No table-ID mismatches were found against `table_inventory_v2.csv`.
- Oxide and nitride standalone reports do not show problematic Results/Discussion duplication; the high-overlap text is concentrated in shared Introduction/Methods boilerplate.

## Critical issues

1. `combined_paper_polished_v2.md` still contains internal review-only material and should not be treated as manuscript-facing in its current state.
   - `combined_paper_polished_v2.md:9` - assembly note
   - `combined_paper_polished_v2.md:264` - internal "Citation placeholders used in Results" handover block
   - `combined_paper_polished_v2.md:372-382` - `Evidence provenance for review`
   - `combined_paper_polished_v2.md:384-390` - `Known draft-stage caveats to resolve before assembly`
   - This is a hard QC failure, not a style preference.

## Important issues

1. Nitride Conclusion overclaims the cross-family "beats the pretrained baseline" threshold.
   - `nitride_polished_v2.md:248`
   - Current wording: "Chemically distant targets require substantially more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do."
   - Problem: the oxide control does not beat its own zero-shot baseline within the tested `N` range either (`oxide_polished_v2.md:83`, `170`, `192`, `196`).
   - Safer comparative claim: nitride adapts later, remains farther above its own zero-shot baseline, and stays worse in absolute MAE under the tested protocol.

2. The combined manuscript still carries internal or non-literature citation tokens that are not in a submission-ready scholarly register.
   - `combined_paper_polished_v2.md:268` - `ALIGNN_PAPER`, `JARVIS_INFRA`
   - `combined_paper_polished_v2.md:277` - `PROJECT_BRIEF`
   - `combined_paper_polished_v2.md:306` - `KIM2024; LEE_ASAHI2021`
   - `combined_paper_polished_v2.md:327` - `WEEK2_ASSIGNMENT`
   - `PROJECT_BRIEF` and `WEEK2_ASSIGNMENT` in particular read as internal project artifacts, not literature citations.

3. Embedding figure namespace is still inconsistent across manuscript text and source-of-truth inventory.
   - Manuscript text uses `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER`
   - `figure_queue.csv` supports those exact labels, but `figure_inventory_v2.csv` still lists `FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C`, `FIG_EA_6D`
   - A repo-level assembly sweep is needed so the final figure namespace is single-valued.

4. `combined_paper_polished_v2.md` makes a raw-space-only claim that is too absolute for the text immediately below it.
   - `combined_paper_polished_v2.md:323-327`
   - The section says every quantitative claim in Results IV is computed in raw 256-D space, then immediately gives PCA explained-variance numbers (`18.13`, `9.47`, `27.60`) which are projection-derived quantities.
   - This should be narrowed to "every inferential claim" or should explicitly exempt the PCA variance header.

5. The phrase "a pretraining regime more aligned with oxides than nitrides" is still an inference that needs either support or softer wording.
   - `nitride_polished_v2.md:104`
   - `combined_paper_polished_v2.md:183`
   - This sits awkwardly beside later limitation language that says the training corpus is not chemically characterized in detail.

6. Formal manuscript placeholders still remain across all three polished drafts.
   - front-matter placeholders at lines 5 and 7 in all three files
   - acknowledgements and references placeholders at the ends of all three files
   - unresolved `[CITE: ...]` tokens throughout all three files
   - These are expected for a draft, but they are still final-QC blockers for any submission-facing export.

## Minor issues

1. Generic appendix references remain unanchored.
   - `oxide_polished_v2.md:110`
   - `nitride_polished_v2.md:148`, `218`
   - `combined_paper_polished_v2.md:226`, `432`
   - "see appendix" is not yet tied to a specific appendix figure/table namespace.

2. `discrete transition` is still a wording risk.
   - `nitride_polished_v2.md:125`
   - `combined_paper_polished_v2.md:203`
   - In this context, `sharp transition` or `step-wise shift` would avoid the "quantized" reading.

3. Group shorthand such as `FIG_EA_6A/6B/6C/6D` is not a concrete anchor.
   - `nitride_polished_v2.md:184`
   - `combined_paper_polished_v2.md:262`

4. A few sentences remain slightly more promotional than necessary for final scientific prose.
   - Examples: `very large margin`, `works as advertised`, `prepared for`
   - This is not a factual error, but the final copy-edit pass should tighten those spots.

## Remaining scientific-writing risks

- The nitride and combined drafts are careful on embedding causality overall, but phrases like "the pretrained network has organized the test set along the oxide/nitride axis" are still a bit stronger than strictly necessary. The safer register is geometric/separability language rather than network-intent language.
- The combined abstract's "smooth adaptation" wording for oxide is a little smoother than the actual curve shape, which includes the `N = 50` penalty before monotonic recovery.
- The oxide and nitride papers keep legitimately shared Introduction/Methods language. That is not currently an identity problem, but a journal copy-editor could still ask for modest differentiation in the background paragraphs.

## Phase 13B Claude Code audit additions

The following items were added or clarified by the Phase 13B audit (`phase13b_claude_code_audit.md`).

**Path integrity:** All 13 source-of-truth paths cited in this report were verified as present. No broken paths.

**Figure namespace fix direction (Important issue 3):** Update `figure_inventory_v2.csv` rows for `FIG_EA_6A/6B/6C/6D` to the suffixed scheme (`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`/`FIG_EA_6D_SCATTER`). No manuscript changes required; the manuscripts and `figure_queue.csv` already use the suffixed labels.

**New minor issue — combined paper subsection numbering inconsistency:** Results I (§III) and Results II (§IV) use Arabic subsection numbers (`3.1`, `4.2`, etc.), while Results III (§V), Results IV (§VI), and Discussion (§VII) use Roman+alpha (`III.A`, `VII.B`, etc.). This must be harmonized to one scheme before JURI template insertion. The Roman+alpha scheme is more self-consistent with the Roman section numerals already in use.

**Fix list confirmation:** All three fix lists are practical, accurately line-numbered, and complete. One clarification on combined fix list critical item 3: the deletion block runs from the `## Evidence provenance for review` heading through the last line of the "Known draft-stage caveats" block, ending just before the `## VII. Discussion` heading.

---

## Overall judgment

Final verdict: **needs one more patch**

Reason:
- The numbers are stable.
- The scientific core is mostly coherent.
- But the combined draft still contains review-only material, the combined citation namespace is not cleaned up, the nitride conclusion still makes one comparative claim that the oxide control does not actually support, and the combined paper has a subsection numbering inconsistency to resolve before JURI template packaging.
