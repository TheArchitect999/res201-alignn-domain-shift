# Combined Fix List

Target file: `04_drafts/phase12_full_manuscripts/combined_paper_polished_v2.md`

Overall status:
- Numerically stable.
- Comparatively strong scientific spine.
- Not yet clean enough to serve as the manuscript-facing version because it still contains internal review material and citation-namespace drift.

## Critical

1. Remove the assembly note.
   - `combined_paper_polished_v2.md:9`

2. Remove the internal Results handover paragraph.
   - `combined_paper_polished_v2.md:264`

3. Remove the full internal review appendix at the end of Results.
   - `combined_paper_polished_v2.md:372-382` - `Evidence provenance for review`
   - `combined_paper_polished_v2.md:384-390` - `Known draft-stage caveats to resolve before assembly`

## Important

1. Clean up non-final citation tokens in the scientific body.
   - `combined_paper_polished_v2.md:268` - `ALIGNN_PAPER`, `JARVIS_INFRA`
   - `combined_paper_polished_v2.md:277` - `PROJECT_BRIEF`
   - `combined_paper_polished_v2.md:306` - `KIM2024; LEE_ASAHI2021`
   - `combined_paper_polished_v2.md:327` - `WEEK2_ASSIGNMENT`
   - `PROJECT_BRIEF` and `WEEK2_ASSIGNMENT` should not remain in a paper draft.

2. Resolve the raw-space-only wording conflict in Results IV.A.
   - `combined_paper_polished_v2.md:323-327`
   - The section says every quantitative claim is computed in raw 256-D space, then gives PCA explained-variance numbers.
   - Recommended fix: narrow the raw-space sentence to inferential claims, or explicitly exempt the PCA variance header.

3. Soften or support the sentence inferring a pretraining regime more aligned with oxides than nitrides.
   - `combined_paper_polished_v2.md:183`
   - This is an interpretive inference, but the manuscript later says the corpus is not chemically characterized in detail.

4. Check the final conclusion sentence against the oxide-control wording.
   - `combined_paper_polished_v2.md:464`
   - Current phrasing about the cost of "moving below a pretrained baseline" leans beyond what the oxide control itself demonstrates inside the tested `N` range.
   - Safer closing logic: emphasize earlier adaptation onset on oxide, later onset on nitride, and the larger residual nitride gap.

5. Harmonize embedding figure namespace with the repo's final assembly namespace.
   - `combined_paper_polished_v2.md:206-222`
   - `combined_paper_polished_v2.md:330-348`
   - Manuscript text uses the suffixed figure IDs; `figure_inventory_v2.csv` still uses the unsuffixed `FIG_EA_6A` / `6B` / `6C` / `6D` scheme.

## Minor

1. Replace `discrete transition` with a less ambiguous term.
   - `combined_paper_polished_v2.md:203`

2. Replace shorthand group figure references with concrete anchors.
   - `combined_paper_polished_v2.md:262` - `FIG_EA_6A/6B/6C/6D`

3. Replace generic appendix references with explicit appendix anchors.
   - `combined_paper_polished_v2.md:226`
   - `combined_paper_polished_v2.md:432`

4. Consider tightening `smooth adaptation` in the Abstract.
   - `combined_paper_polished_v2.md:13`
   - It is not false, but it slightly smooths over the oxide `N = 50` penalty before the later monotonic recovery.

## No-fix / passed items

- Core oxide and nitride numbers match the canonical sources.
- The combined Discussion is genuinely comparative rather than just two standalones pasted together.
- No Set 2 / Set 3 robustness narrative leaked into the main combined argument.
- Embedding causality guardrails are mostly intact.
