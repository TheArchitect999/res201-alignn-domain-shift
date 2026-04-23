# Nitride Fix List

Target file: `04_drafts/phase12_full_manuscripts/nitride_polished_v2.md`

Overall status:
- Core nitride numbers are stable.
- The main domain-shift argument is intact.
- The largest remaining problem is a conclusion sentence that overstates the cross-family comparison.

## Important

1. Remove draft-stage placeholders and assembly artifacts before any submission-facing export.
   - `nitride_polished_v2.md:5`
   - `nitride_polished_v2.md:7`
   - `nitride_polished_v2.md:9`
   - `nitride_polished_v2.md:252`
   - `nitride_polished_v2.md:256`

2. Remove the internal handover paragraph at the end of Results.
   - `nitride_polished_v2.md:186`
   - `Citation placeholders used in Results` is an internal workflow note, not manuscript prose.

3. Recast the last sentence of the Conclusion to avoid an unsupported cross-family threshold claim.
   - `nitride_polished_v2.md:248`
   - Current problem: it says chemically distant targets require substantially more labelled data to beat a pretrained baseline than chemistry-aligned targets do.
   - Why this is not supported: the oxide control also does not beat its own zero-shot baseline within the tested `N` range.
   - Safer replacement logic: nitride adapts later, remains farther above its own zero-shot baseline, and stays worse in absolute MAE under the tested protocol.

4. Either support or soften the "pretraining regime more aligned with oxides than nitrides" sentence.
   - `nitride_polished_v2.md:104`
   - As written, it is an inference about source-distribution alignment, but the manuscript later says the training corpus is not chemically characterized in detail.

5. Harmonize embedding figure namespace with the repo's final assembly namespace.
   - `nitride_polished_v2.md:130-144`
   - Same issue as oxide: manuscript labels align with `figure_queue.csv`, but not with `figure_inventory_v2.csv`.

## Minor

1. Replace `discrete transition` with a less ambiguous term.
   - `nitride_polished_v2.md:125`
   - Suggested alternatives: `sharp transition`, `step-wise shift`

2. Replace generic appendix references with explicit anchors.
   - `nitride_polished_v2.md:148`
   - `nitride_polished_v2.md:218`

3. Group shorthand `FIG_EA_6A/6B/6C/6D` is not a concrete figure anchor.
   - `nitride_polished_v2.md:184`

## No-fix / passed items

- No numeric drift found in zero-shot, fine-tuning, from-scratch, or embedding results.
- No Set 2 / Set 3 robustness claims leaked into the nitride narrative.
- The low-`N` inertness claim is properly bounded to Set 1.
- Embedding interpretation remains correlational rather than causal.
- The nitride Discussion clearly distinguishes the low-`N` issue from a generic small-data story by comparing against oxide.
