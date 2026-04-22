# Nitride Revision Verification

**Date:** 2026-04-23

**Files verified:**
- `reports/final_paper_factory/03_section_inputs/nitride_analysis_document_v2.md`
- `reports/final_paper_factory/03_section_inputs/nitride_results_section_draft_v2.md`
- `reports/final_paper_factory/03_section_inputs/nitride_revision_changelog.md`

**Reference files checked during verification:**
- `reports/final_paper_factory/03_section_inputs/nitride_analysis_packet.md`
- `reports/final_paper_factory/03_section_inputs/nitride_results_packet.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv`
- `reports/final_paper_factory/03_section_inputs/oxide_analysis_packet.md`
- `reports/final_paper_factory/03_section_inputs/oxide_results_packet.md`
- `reports/final_paper_factory/02_figure_memos/fig13_nitride_distance_error_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig13b_nitride_distance_error_scatter_memo.md`

---

## Passed checks

### 1. Source-distribution and representational-mismatch wording was softened

**Pass.** The active revised prose in `nitride_analysis_document_v2.md` and `nitride_results_section_draft_v2.md` no longer uses the over-strong phrases:
- "oxide-heavy chemistries dominate"
- "purest behavioral signature"
- "this is why nitride belongs as the OOD arm"

The replacement language is appropriately bounded:
- "consistent with an oxide-skewed reference regime rather than a uniform coverage of chemistries"
- "cleanest behavioral indicator of a family-level shift under this protocol"
- "nitride functions as the OOD arm in this study"
- "geometric indicator consistent with a representation-space shift, not as mechanistic proof"

The old phrases appear only in `nitride_revision_changelog.md` as quoted examples of removed v1 language. That is acceptable for an audit/changelog file and does not affect the active report prose.

### 2. Oxide is now used explicitly as the control comparator at transition points

**Pass.** The revised documents now use oxide as a control anchor at the three key transitions:

- **Zero-shot family penalty:** nitride `0.0695 eV/atom` vs oxide `0.0342 eV/atom`, described as roughly `2x` at the pretrained starting point.
- **Low-N inertness vs oxide adaptation:** nitride remains operationally inert through `N <= 200`, while oxide begins genuine optimization by `N = 50` with `mean_best_epoch = 18.5` and later values in the `35.5-39.0` range.
- **Embedding-space comparison:** nitride embeddings are described as distinguishable but less cohesive than the oxide control region, supported by lower nitride silhouette and 15-NN purity.

The oxide transition values match the oxide packet and `canonical_numbers_v2`.

### 3. Four-step domain-shift arc is clearly visible

**Pass.** Both revised files now visibly organize the nitride story as:

1. zero-shot penalty,
2. inert `N <= 200`,
3. genuine but incomplete high-N adaptation,
4. embedding-space geometry consistent with that penalty.

This arc appears in the opening thesis/storyline, subsection headings, and closing synthesis/summary. The Results draft also preserves the arc through section labels `4.1` through `4.7`.

### 4. Scratch section is scientifically careful and supporting, not central

**Pass.** The scratch comparison is explicitly labeled supporting evidence in both revised files. The text preserves the key scientific guardrails:

- Scratch baselines exist only at `N = 50` and `N = 500`.
- The `N = 50` gap is pretrained-initialization advantage, not fine-tuning adaptation, because the fine-tuned row has `mean_best_epoch = 1.0`.
- Only the `N = 500` gap is a clean adapted-vs-scratch comparison.
- The scratch result confirms pretraining value but does not replace the headline OOD/domain-shift result.

### 5. Caveats were tightened

**Pass.** The repeated caveats have been consolidated into labeled caveats:

- **C1:** not "oxide-pretrained"
- **C2:** nitride `N <= 200` is not meaningful adaptation
- **C3:** `N = 50` scratch gap is initialization advantage, not adaptation gain
- **C4:** embedding distance is correlational, not causal

The caveats are then referenced economically rather than re-argued in every subsection.

### 6. Measured values were preserved

**Pass.** No incorrect measured-value changes were found. Checked values include:

- Zero-shot: nitride `0.0695`, oxide `0.0342`; test sizes `242` and `1484`.
- Nitride fine-tuning: low-N rows `0.0874`, `0.1173`, `0.1722`, `0.1392`; high-N rows `0.0977`, `0.0907`; best epochs `1.0`, `40.5`, `45.0`.
- Parity metrics: `0.0828 / 0.1203 / 0.9841` at `N = 10`; `0.0829 / 0.1220 / 0.9837` at `N = 1000`.
- Scratch rows: `0.6914 +/- 0.0163`, `0.3683 +/- 0.0233`; gaps `0.5741`, `0.2706`.
- Embedding family-separation metrics: overall silhouette `0.2392`, oxide `0.2546`, nitride `0.1453`; overall 15-NN purity `0.9655`, oxide `0.9872`, nitride `0.8331`; AUC `0.9994`.
- Distance-error metrics: hard/easy means `4.5988` and `3.7821`; gap `0.8168`; Spearman `0.3428`; Pearson `0.2770`; q-values rounded as `1.8 x 10^-4` and `1.3 x 10^-4`.

All checked values match the section packets and canonical-number pack after expected rounding.

### 7. No clear new unsupported literature claims were introduced

**Pass, with reviewer-signoff caveats below.** The citation placeholders are consistent with the v1 citation set plus the results-draft addition of transfer-learning citations already present in the analysis document. The revised prose generally makes claims more bounded than v1, especially around source distribution, OOD framing, and embedding causality.

---

## Failed checks

None.

---

## Ambiguous checks

### A. One terminology inconsistency remains

Mostly the revised files use "domain-shift penalty" consistently, but `nitride_analysis_document_v2.md` still contains one sentence saying "the nitride penalty survives even after Step 3's genuine adaptation." The next sentence uses "domain-shift penalty persists despite adaptation," so the meaning is clear, but this is a small cleanup candidate if strict terminology uniformity is desired.

### B. "Oxide-skewed reference regime" still needs source-level sign-off

The wording is much safer than "oxide-heavy chemistries dominate," but it remains an interpretive phrase tied to cited dataset/literature context. The changelog already flags this for human reviewer sign-off. If the cited references do not explicitly support this exact framing, revise to an even narrower phrasing.

### C. "Without being trained to" could be read too broadly

The intended meaning is that the model was not trained with a family-label objective. A reader could misread it as "not trained on nitrides/oxides at all," which would conflict with the broad JARVIS pretraining context. The changelog already proposes a safer rewrite.

### D. Alternative distance definitions are referenced but not expanded

The Results draft says the distance-error direction is stable under centroid and Mahalanobis definitions "see appendix." This is supported by the section packet's appendix-figure recommendation, but the active Results section does not show those values. This is acceptable if the appendix includes those panels/tables.

---

## Any remaining scientific-writing risks

- The revised files are now scientifically safer, but the introduction/framing still leans on literature claims about dataset composition and transfer behavior. Those should be checked when final citations are resolved.
- The word "headline" is editorially useful but should stay aligned with the final Discussion's actual thesis.
- The Results draft is currently strong and readable, but if this becomes a formal manuscript section, the literature-heavy interpretive language should stay mostly outside Results.
- The old over-strong phrases are preserved in the changelog for audit transparency. That is fine, but avoid copying the changelog text into report prose.

---

## Final verdict

**ready for next review**

The revision pass fixed the major scientific-writing issues. No blocking failures were found. The remaining items are minor reviewer-signoff or wording-polish risks rather than reasons for another required patch.
