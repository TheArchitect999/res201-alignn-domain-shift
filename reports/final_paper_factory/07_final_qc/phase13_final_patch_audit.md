---
name: Phase 13 Final Patch Audit
description: Independent audit of the v2 to v3 final patch package against final QC closure requirements.
type: project
---

# Phase 13 Final Patch Audit

Audit date: 2026-04-24

Scope audited:
- `04_drafts/phase12_full_manuscripts/oxide_polished_v2.md` -> `oxide_polished_v3.md`
- `04_drafts/phase12_full_manuscripts/nitride_polished_v2.md` -> `nitride_polished_v3.md`
- `04_drafts/phase12_full_manuscripts/combined_paper_polished_v2.md` -> `combined_paper_polished_v3.md`
- QC guidance in `07_final_qc/`

Method used:
- direct `git diff --no-index --word-diff` comparison on each v2/v3 manuscript pair
- figure-marker and table-marker inventory comparison
- targeted scans for internal review material and internal workflow citation tokens
- spot-check of the current embedding figure namespace in `figure_inventory_v2.csv` and `figure_queue.csv`

## Remaining critical issues

None.

The hard QC failures from the prior round are closed in the manuscripts. In particular, `combined_paper_polished_v3.md` no longer contains the assembly note, the internal "Citation placeholders used in Results" block, `Evidence provenance for review`, or `Known draft-stage caveats to resolve before assembly`.

## Remaining important issues

1. `combined_paper_polished_v3.md:440` still retains the unsupported cross-family baseline-threshold claim.
   - Current wording still says that the chemistry-shifted regime is one in which "the labelled-data cost of moving below a pretrained baseline is substantially higher than chemistry-aligned task experience would predict".
   - That remains weaker than the v2 nitride overclaim, but it is still not fully supported by the oxide control, because the oxide arm also does not move below its own zero-shot baseline within the tested `N` range.
   - This is the only important scientific issue from final QC that remains open in the manuscript package.

## Minor issues

1. `combined_paper_polished_v3.md` still uses a mixed subsection style.
   - Results III remains `III.A` through `III.E`, while Results IV is `VI.A` through `VI.E`, and Discussion is `7.1` through `7.9`.
   - This is readable and not a scientific-integrity issue, but it is still a mild manuscript-packaging inconsistency.

2. Front-matter, acknowledgements, references, and standard scholarly `[CITE: ...]` placeholders remain across the manuscripts.
   - These are expected at this stage and are not counted as failures in this audit.

## File-by-file findings

### `oxide_polished_v3.md`

- The v2 -> v3 diff is limited to wording-tightening edits at lines 117, 174, 204, and 208.
- No grounded numbers changed.
- Figure markers are unchanged: 8 in v2, 8 in v3, with no identifier drift.
- Table markers are unchanged: 6 in v2, 6 in v3, with no identifier drift.
- Citation placeholders are unchanged in count and type: 21 in v2, 21 in v3.
- No internal workflow citation tokens were introduced or retained.
- Scientific coherence is preserved. The file remains manuscript-facing for the final citation / Word stage.

### `nitride_polished_v3.md`

- The two important scientific fixes landed cleanly:
  - the corpus-alignment inference is softened and properly scoped at line 102
  - the unsupported "beat a pretrained baseline" conclusion claim is removed and replaced with within-family evidence-bounded wording at line 244
- No grounded numbers changed.
- Figure markers are unchanged: 12 in v2, 12 in v3, with no identifier drift.
- Table markers are unchanged: 7 in v2, 7 in v3, with no identifier drift.
- Citation placeholders are unchanged in count and type: 19 in v2, 19 in v3.
- No internal workflow citation tokens remain in the scientific prose.
- Scientific coherence is preserved. The conclusion is now aligned with what the oxide control actually supports.

### `combined_paper_polished_v3.md`

- The critical manuscript-cleanup items are closed.
  - No matches remain for `assembly note`
  - No matches remain for `Citation placeholders used in Results`
  - No matches remain for `Evidence provenance for review`
  - No matches remain for `Known draft-stage caveats to resolve before assembly`
- The internal citation-token cleanup is closed.
  - Tokens removed or recast from v2: `ALIGNN_PAPER`, `JARVIS_INFRA`, `PROJECT_BRIEF`, `KIM2024; LEE_ASAHI2021`, `WEEK2_ASSIGNMENT`
  - No uppercase-and-underscore workflow-style `[CITE: ...]` tokens remain in the scientific prose
- The raw-space wording issue is fixed at line 323.
  - The Results IV implementation paragraph now limits the claim to inferential claims and explicitly exempts the PCA explained-variance header as projection-derived.
- The "more aligned with oxides than nitrides" inference is softened and properly scoped at line 181.
- No grounded numbers changed.
  - The only numeric churn in the diff is section and cross-reference renumbering.
  - Scientific values, dataset counts, MAE values, embedding metrics, and PCA variance values are unchanged.
- Figure markers are unchanged: 29 in v2, 29 in v3, with no identifier drift.
- Table markers are unchanged: 16 in v2, 16 in v3, with no identifier drift.
- Citation placeholder count changes from 30 to 29 because one internal workflow citation (`PROJECT_BRIEF`) is removed during sentence recasting; the remaining placeholders are standard scholarly `[CITE: ...]` tokens.
- One important issue remains open: the conclusion sentence at line 440 still overreaches the oxide-controlled comparison.

## Package-level findings

- The earlier embedding-figure namespace inconsistency noted in final QC is closed in the current repo state.
  - `00_source_of_truth/figure_inventory_v2.csv:30-34` now uses `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, and `FIG_EA_6D_SCATTER`.
  - `02_figure_memos/figure_queue.csv:13-17` uses the same suffixed identifiers.
- No evidence of grounded-number drift was found in any manuscript diff.
- No figure-marker or table-marker corruption was found in any manuscript diff.

## Exact final fixes if needed

1. Patch `combined_paper_polished_v3.md:440`.
   - Replace only the clause beginning `the labelled-data cost of moving below a pretrained baseline ...`
   - Recast it to the same within-family, evidence-bounded logic already used successfully in `nitride_polished_v3.md:244`.
   - The supported ingredients already exist in the manuscript and should be reused:
     - later adaptation onset on nitrides than on oxides
     - a larger residual nitride-above-zero-shot gap at every tested budget
     - persistence above nitride zero-shot even at `N = 1 000`

2. Optional packaging cleanup:
   - If the final Word-stage manuscript wants one numbering scheme everywhere, convert the remaining `III.A` to `III.E` subsection labels in Results III to the same Arabic style used elsewhere.

## Final verdict

**patch once more before final citation/Word stage**

Reason:
- Audit checks 1-9 pass.
- Audit check 10 is almost fully satisfied, but the remaining combined-paper conclusion sentence at line 440 still leans beyond the oxide-controlled evidence.
- Once that one sentence is patched, the manuscript package is ready for the final citation / Word stage.
