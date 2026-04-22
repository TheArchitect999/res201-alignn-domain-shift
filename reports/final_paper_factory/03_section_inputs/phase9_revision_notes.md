# Phase 9 Revision Notes — Combined Paper Results III and IV

Scope: change log and review annotations for the v1 → v2 revision of `combined_paper_results_III_and_IV_draft.md`.
Applied: Phase 9C fix list (six fixes).
Delivered: `combined_paper_results_III_and_IV_draft_v2.md`.

---

## Biggest scientific-writing changes

### 1. Raw 256-D metrics are now the sole basis for family-separation claims (FIX 1, highest priority)

**Where changed.** Section IV.B was rewritten end to end. A sentence was also added to the IV opening paragraph ("Every quantitative claim in Section IV is computed in the raw 256-dimensional `last_alignn_pool` space...") and to IV.A ("**All statistical claims in this section are computed in the raw 256-dimensional space.**") so the constraint is stated before the first figure reference.

**What was removed.** The v1 sentence "The PCA panel (FIG_EA_6A_PCA) and the t-SNE and UMAP companion panels (FIG_EA_6B_TSNE, FIG_EA_6C_UMAP) show visually distinct oxide and nitride regions across all three projection methods, with the oxide region appearing visually more compact than the nitride region" has been deleted. Any implied visual-compactness, visual-asymmetry, or visual-distance claim has been removed.

**What replaced it.** In v2, the family-separation and asymmetry claims are derived exclusively from raw 256-D metrics: overall silhouette `0.2392`, per-family silhouettes `0.2546`/`0.1453`, Davies–Bouldin `1.8290`, 15-NN family purity `0.9655`/`0.9872`/`0.8331`, and logistic-regression family AUC `0.9994`. The projection panels appear only as descriptive visual support with the following explicit guard: "No claim about family compactness, family asymmetry, or inter-family distance in Section IV is grounded on the projections themselves."

**What was kept.** One concise sentence noting that the PCA, t-SNE, and UMAP panels are "broadly consistent with the raw-space pattern" and are included as descriptive visual support. This meets the fix-list requirement to keep the triptych as illustration without giving it evidentiary weight.

### 2. The categorical test-set-size sentence in III.A is softened (FIX 2)

**Where changed.** Section III.A, "What pattern is consistent" paragraph.

**What was removed.** v1: "The gap is not a reflection of test-set size; both tests are drawn from the canonical split protocol and both use the same fixed checkpoint."

**What replaced it.** v2: "The comparison is not attributable to a different checkpoint or a different evaluation protocol: both families are evaluated with the same pretrained model on fixed held-out splits produced by the canonical split logic. The two test sets differ in size (`1484` oxides and `242` nitrides), so the sampling uncertainty on each family's zero-shot MAE is not identical; this may affect how tightly each zero-shot value is pinned, but it does not change the direction of the observed gap."

This rephrases the protocol guarantee as what the comparison *is* attributable to (same checkpoint, same protocol) rather than as an absolute denial of any size effect, and explicitly notes that sample-size differences affect uncertainty without changing the gap's direction.

### 3. Transfer-benefit caveat moved to immediately after bar values (FIX 3)

**Where changed.** Section III.C was re-ordered. The structure is now: what is being compared → what the figure shows (bar values) → **Critical interpretation caveats, stated up front** → pattern → interpretation → uncertainty.

**What is new.** A dedicated "Critical interpretation caveats, stated up front" block is placed immediately after the bar values are listed. It contains three numbered points:

1. "Numerically taller nitride bars do not indicate more efficient transfer on nitrides" — with the explicit reason that the nitride scratch anchor is weaker and the nitride fine-tuned endpoint is worse, so the arithmetic is inflated by the scratch side.
2. "The nitride `N = 50` bar is pretrained-initialization advantage over scratch, not low-data adaptation" — with the explicit reason that the nitride mean best epoch at `N = 50` is `1.0`, and the explicit consequence that `N = 500` is the first clean cross-family comparison.
3. "Scope is limited to `N = 50` and `N = 500`" — no transfer-benefit statement is made elsewhere on the curve.

"What pattern is consistent" was renamed to "What pattern is consistent, with the caveats in place" so that no downstream claim can be read without the caveats having been absorbed first.

### 4. Section III.E compressed (FIX 4)

**Where changed.** Section III.E ("Bridge to Results IV").

**Magnitude.** v1 III.E was two paragraphs, ≈ 180 words, with noticeable restatement of material already established in III.A–III.D (zero-shot gap size, oxide adaptation timing, nitride inertness, transfer benefit, and persistence at high `N`). v2 III.E is a single paragraph, ≈ 75 words. Reduction is ≈ 58%, well beyond the fix-list target of 20–30%. The justification for going further is that the list-style restatement in v1 duplicated content already carried by the five-beat structure of III.A–III.D and by the IV.E synthesis paragraph.

**What was kept.** One compact synthesis sentence ("pretraining helps in both families, but it does not close the family gap for nitrides under the canonical protocol") and one clean bridge sentence setting up Results IV.

### 5. Alternative-distance / appendix dependency check (FIX 5)

**Verdict.** The specific sentence described in the fix list — "the distance–error direction is stable under centroid and Mahalanobis distance definitions and points to the appendix" — does **not** appear in the v1 draft. The file was searched for `centroid`, `mahalanobis`, `robustness`, and `appendix`; no dangling distance-definition claim was found.

**What was still addressed.** The v1 draft did contain one line in Section III.B "What is uncertain" that mentioned "Appendix-level Set-2 results and the embedding analysis in Section IV both speak to robustness, but none of them supports the claim that nitride low-`N` fine-tuning has been exhausted." Although Set-2 results exist in `robustness_numbers_appendix.csv`, the combined paper does not yet have a stable appendix section, so this reference was softened in v2 to: "No claim is made here about alternative hyperparameter settings; the behavioral pattern described is specific to the canonical protocol." This removes the only forward-reference to an appendix in the two sections.

**No other appendix dependencies introduced.** v2 Section IV.C does not reference centroid or Mahalanobis robustness. The "Known draft-stage caveats" block does reference possible future appendix placement of III.D parity panels and of the t-SNE/UMAP panels, but those are drafting instructions for later phases, not scientific claims, and no numerical value in Sections III or IV depends on any appendix.

### 6. Explanatory phrasing toned down in IV.B, IV.D, and IV.E (FIX 6)

**Removed (v1 → v2).**

- v1 IV.B: "The asymmetry between oxide and nitride cohesion is the feature most directly aligned with the behavioral story in Section III: the region that the model treats less uniformly is also the region on which it shows the larger zero-shot MAE and the more brittle fine-tuning response." — dropped. The v2 version says only that "Raw-space metrics and behavioral MAE curves are consistent; they describe the same contrast from two different measurement surfaces." This is a consistency statement, not an explanatory one.
- v1 IV.D: "which places the representation itself, rather than only the regression head, inside the domain-shift story." — softened to "bringing the representation itself — and not only the downstream regression head — into view as a geometric correlate of the domain-shift picture."
- v1 IV.E: "In the frozen representation that produces those outputs" — softened to "In the frozen representation from which those outputs are computed" (avoids the production verb, which is slightly causal).
- v1 IV.E: "the structures that are predicted worst at zero-shot are the ones that sit farthest from the oxide-reference region" — softened to "within nitrides, zero-shot error co-varies with distance from the oxide-reference region" (restores the correlational phrasing used elsewhere in IV.C).

**Preserved canonical phrases.** v2 uses the preferred vocabulary consistently: "geometric correlate", "consistent with", "aligned with the behavioral asymmetry", "representation-space counterpart", "co-varies with". No instance of "explains the penalty", "produces the behavior", or "proves the mechanism" remains.

---

## Remaining ambiguity

1. **Sample-size footnote in III.A.** v2 explicitly notes that the oxide (`n = 1484`) and nitride (`n = 242`) test sets differ in size and that this may affect uncertainty. The current drafts do not report a confidence interval on either zero-shot MAE value, and `zero_shot_summary.csv` does not appear to carry bootstrap CIs in the packet extracts provided. If the reviewer wants a quantitative uncertainty statement (rather than a qualitative one), this would need canonical number support.
2. **What "aligned with the direction of the behavioral asymmetry" means operationally.** In Sections IV.B and IV.D, v2 uses this phrase to connect the oxide vs nitride raw-space cohesion gap to the oxide vs nitride behavioral MAE gap. The connection is qualitative-directional only: both go the same way (oxide more organized / oxide lower error). No quantitative link is asserted. Reviewer should confirm this level of coupling is sufficient for the combined-paper voice; if tighter coupling is desired, Section IV would need an additional analysis tying a raw-space metric per-structure to MAE per-structure, which does not currently exist as a canonical number.
3. **Logistic-regression AUC framing.** v2 states that AUC `0.9994` shows family-label recoverability, not a mechanism of formation-energy error. This is the correct reading of what a family-label classifier measures, but a strict reader might still want this caveat repeated in IV.D where the same number is reused. v2 does not repeat the caveat in IV.D to avoid redundancy; reviewer should decide whether a short repeat is warranted.
4. **III.C caveat styling.** v2 uses a numbered block immediately after the bar values, which is stylistically slightly heavier than the five-beat prose used elsewhere in Results. The trade-off is that the numbering makes it impossible to misread bar heights. If the combined-paper voice prefers flat prose, the three numbered points can be collapsed into a single paragraph at the cost of some structural clarity.

---

## Sentences that need human sign-off

The following sentences are scientifically defensible on the current packets but carry enough interpretive weight that a human reviewer should read them directly before the draft moves to Phase 9D.

- **III.A, "What pattern is consistent":** "The comparison is not attributable to a different checkpoint or a different evaluation protocol: both families are evaluated with the same pretrained model on fixed held-out splits produced by the canonical split logic." — Sign-off question: is this phrasing acceptable given that the checkpoint is a broad JARVIS-trained ALIGNN and not explicitly trained to handle either family as a hold-out target?
- **III.C, caveat point 2:** "The `N = 50` nitride bar measures the advantage of starting from that pretrained state instead of from random initialization; it does not measure successful target-family fine-tuning." — Sign-off question: does this match the project's intended framing exactly, or should the wording be "does not measure fine-tuning adaptation on the target family"? The two phrasings are equivalent, but the discussion section may commit to one.
- **IV.B, "What pattern is consistent":** "...by per-family silhouette (`0.2546` vs `0.1453`) and by per-family 15-NN family purity (`0.9872` vs `0.8331`), the nitride region is distinguishable from oxides but internally less organized than the oxide region." — Sign-off question: the phrase "less organized" is informal; acceptable alternatives include "less cohesive" (used elsewhere in the draft) or "less internally structured". Recommendation: standardize to "less cohesive" across Sections IV.B, IV.D, and IV.E at Phase 9D.
- **IV.C, "What interpretation is justified":** "The 5NN oxide-reference distance is a correlational geometric indicator of nitride prediction difficulty." — Sign-off question: is "correlational geometric indicator" the canonical phrase the paper will use throughout? Same phrase appears in the embedding packet's recommended caption logic, so adopting it here should be low risk, but it propagates to the Discussion and Conclusion.
- **IV.E, synthesis:** "The behavioral penalty and the representation-space geometry are consistent, but the consistency is correlational, not causal: the frozen representation is the setting in which the penalty is measured, not a proven source of it." — Sign-off question: this is the last interpretive sentence in Results IV and will be the one most quoted by Discussion. The phrasing is deliberately restrained; reviewer should confirm it is restrained enough, or suggest even tighter wording if the Discussion section will carry the interpretive weight.

---

## Changes the reviewer should NOT request (already handled)

- "Raw 256-D metrics should carry the family-separation claim." — Already enforced in v2 IV.B; a single-sentence visual-support note is the only projection-based statement remaining.
- "The III.A sentence about test-set size is too absolute." — Already softened.
- "The III.C caveat should not be hidden at the bottom." — Already moved to immediately after bar values.
- "III.E is repetitive." — Already compressed by ≈ 58%.
- "There should be no dangling centroid/Mahalanobis appendix reference." — The sentence did not exist in v1; v2 also does not contain it. The one remaining appendix-adjacent forward reference (Set-2 results in III.B) has been removed.
- "IV.B/IV.D/IV.E should not sound like the representation explains the behavior." — Already retoned; explanatory verbs and causal-sounding phrasing have been removed. The canonical phrases "correlational", "co-varies with", "consistent with", "aligned with the direction of", "geometric correlate", and "representation-space counterpart" are used throughout.
