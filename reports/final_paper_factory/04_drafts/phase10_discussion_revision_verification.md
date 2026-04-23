# Phase 10 Discussion Revision Verification

Date: 2026-04-23

Scope verified:
- `combined_paper_discussion_conclusion_draft_v2.md`
- `nitride_discussion_conclusion_draft_v2.md`
- `oxide_discussion_conclusion_draft_v2.md`
- `phase10_discussion_revision_changelog.md`

Evidence basis:
- v2 drafts listed above
- v1-to-v2 diffs for the three Discussion/Conclusion drafts
- canonical Set 1 summaries in `reports/Hyperparameter Set 1/Summaries/`
- zero-shot summary in `reports/zero_shot/zero_shot_summary.csv`
- final-paper Results packets and Results v3 drafts in `03_section_inputs/`
- Stage 5 literature/citation guardrails in `literature_claim_map_v3.md`

## Passed Checks

1. **Alternative schedules are no longer ruled out.**

The major overclaim is fixed. The combined and nitride drafts now repeatedly bind the nitride fine-tuning result to the canonical Set 1 protocol and tested N range. The strongest claims are qualified with language such as "under the canonical protocol," "within the tested schedule and N range," "not resolved by the schedule tested here," and "whether a different schedule could..." The limitations sections are especially clear. No manuscript now claims that nitride fine-tuning is intrinsically incapable of beating zero-shot under alternative schedules.

2. **Discussion openings are now mostly interpretive rather than Results recaps.**

The combined opening now states the comparative answer first and maps the Discussion structure instead of replaying Results I-IV. The oxide opening now frames the control-arm question and answer, then explains what the Discussion will resolve. The nitride opening also leads with the domain-shift interpretation, although it remains the most number-bearing of the three and is listed below as borderline rather than failed.

3. **Practical implications are explicitly bounded.**

This is fixed across all three manuscripts. Practical language is scoped to formation energy per atom, JARVIS `dft_3d` splits, the pretrained formation-energy ALIGNN checkpoint, Hyperparameter Set 1, and the tested N range. The combined draft also separates chemistry-aligned and chemistry-shifted workflow profiles, which makes the scope easier for a reviewer to see.

4. **Numeric replay has been reduced.**

The v2 drafts are shorter and substantially less table-like than v1. Word counts decreased in all three files, and the combined and nitride Conclusions no longer read as full compressed Results tables. The remaining numbers are mostly decisive anchors rather than long lists.

5. **Embedding interpretation remains correlational and non-causal.**

This check passes. The drafts use "geometric correlate," "representation-space counterpart," "consistent with," "aligned with," and "co-varies." They explicitly reject causal proof and mechanism-proof readings. PCA, t-SNE, and UMAP are still described as descriptive visual support only, with quantitative embedding claims reserved for raw 256-D `last_alignn_pool` space.

6. **The combined discussion is visibly comparative.**

This is fixed. The combined draft explicitly contrasts chemistry-aligned oxide behavior with chemistry-shifted nitride behavior, separates oxide and nitride workflow profiles in practical implications, and uses the oxide control to interpret nitride OOD response rather than stacking two standalone discussions.

7. **The nitride low-N issue is no longer treated as generic small-data noise.**

This is fixed strongly. Nitride Section 5.3 opens with the oxide control discriminator and states that oxide under the same canonical protocol does not show the same low-N inertness. This directly addresses the small-data alternative.

8. **The oxide control arm now has a clear scientific role.**

This is fixed. The oxide draft no longer says merely that oxide is easier. It states that oxide defines the best-case transfer regime and supplies the reference condition that makes the nitride domain-shift interpretation possible.

9. **Measured values were not changed incorrectly.**

No incorrect value changes were found against the canonical manuscript sources. The v2 numbers match the final-paper Results packets, `canonical_numbers`, Set 1 fine-tuning/from-scratch summaries, and zero-shot summary, allowing ordinary rounding. Examples checked include transfer gaps, zero-shot MAEs, mean best epochs, test-set sizes, embedding AUC/purity/silhouette values, and distance-error statistics.

Important context: the open `reports/week2/finetune_summary_by_N.csv` contains older 3-seed values and does not match the manuscript numbers. The source-of-truth manifest marks `reports/week2/` as historical provenance only, while the drafts correctly use `reports/Hyperparameter Set 1/Summaries/`.

10. **No new unsupported literature claims were introduced in the manuscript prose.**

No new manuscript-level unsupported literature claim was found. The v2 drafts mostly narrow claims rather than broaden them, and the removed nitride chemistry-specific wording from combined v1 improves supportability. The remaining external claims are attached to existing citation placeholders and stay within the literature-claim map's broad boundaries.

## Failed Checks

No hard scientific-writing check failed in the revised manuscript drafts.

The only audit-record issue is in the changelog, not the manuscript text: the changelog says citation placeholders were unchanged from v1 to v2, but a literal diff shows small citation-placeholder changes and moves. This does not appear to introduce an unsupported manuscript claim, but the changelog statement is not strictly accurate.

## Ambiguous Checks

1. **Nitride Discussion opening is interpretive but still somewhat numeric.**

Nitride Section 5.1 is far better than v1, but it still carries several numeric anchors in the opening paragraph: 2x zero-shot gap, `mean_best_epoch = 1.0`, N = 10 through 200, and N = 500/1000. It does not replay long MAE lists, so this is not a failure, but it is the closest remaining case to a Results recap.

2. **Oxide Conclusion still opens with several measured values.**

The oxide Conclusion now follows the question-answer-implication structure, but its first paragraph still includes two transfer gaps, zero-shot MAE, family AUC, and oxide silhouette. This is defensible as a compact control-arm answer, but it is more number-heavy than the combined and nitride Conclusions.

3. **Some practical phrasing is strong but adequately bounded.**

Phrases such as "dominant data-efficiency lever," "non-negotiable baseline," "default expectation," and "much more labelled data" are acceptable because they are surrounded by regime and protocol bounds. They would become overclaims if reused in the Abstract or Introduction without the same scoping.

4. **"Prepared for" and "works as advertised" are useful but informal.**

The oxide draft uses these phrases to mark the control regime. They help manuscript identity, but a reviewer could ask for more formal wording if the surrounding Methods do not clearly define why oxide is the aligned/control arm.

## Remaining Scientific-Writing Risks

- Keep all future Abstract/Introduction wording explicitly protocol-bounded. The v2 Discussion sections are careful, but their memorable closing phrases could be overgeneralized later.
- Keep "pretrained network has organized" and "representation already encodes" paired with the current correlational caveats. Without those caveats, the language could sound more mechanistic than intended.
- If the changelog is used as an audit document, patch its "citation placeholders unchanged" statement. The manuscript prose is okay; the changelog record is the issue.
- Do not use `reports/week2/finetune_summary_by_N.csv` as a manuscript number source. It is historical/provenance material and conflicts with the canonical five-seed Set 1 summaries.

## Final Verdict

**Ready for next review.**

The Phase 10 revision pass fixed the major scientific-writing issues: schedule overclaims are bounded, Discussion openings are mostly argumentative, practical implications are scoped, embedding language remains correlational, the combined manuscript is genuinely comparative, and the standalone manuscript identities are distinct. One optional cleanup pass could further de-numerify the nitride opening and oxide Conclusion and correct the changelog's citation-placeholder statement, but no manuscript-blocking scientific-writing failure remains.
