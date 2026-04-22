# Phase 9 Results Revision Changelog

**Original file:** `combined_paper_results_III_and_IV_draft_v1.md`
**Revised file:** `combined_paper_results_III_and_IV_draft_v2.md`
**Revision notes:** `phase9_revision_notes.md`
**Date:** 2026-04-23
**Phase:** 9C fix list applied to Phase 9B deliverable

---

## Summary

Six scientific-writing fixes were applied to the v1 draft of Results III and Results IV. The v1 file is preserved unchanged. The v2 file incorporates all six fixes.

---

## Revision 1 — Raw-space metrics made primary; PCA/t-SNE/UMAP demoted to descriptive support

**What changed.**
Section IV.B was rewritten end to end. The v1 sentence asserting that PCA and t-SNE/UMAP panels show "visually distinct oxide and nitride regions" with the oxide region "appearing visually more compact" was deleted. Any visual-compactness, visual-asymmetry, or visual inter-family distance claim was removed.

The IV opening paragraph and IV.A now both contain explicit guards stating that all quantitative claims are computed in the raw 256-dimensional `last_alignn_pool` space. IV.B now derives family-separation and asymmetry claims exclusively from raw-space metrics: overall silhouette `0.2392`, per-family silhouettes `0.2546`/`0.1453`, Davies–Bouldin `1.8290`, 15-NN family purity `0.9655`/`0.9872`/`0.8331`, and logistic-regression AUC `0.9994`. The three projection panels (FIG_EA_6A_PCA, FIG_EA_6B_TSNE, FIG_EA_6C_UMAP) are retained as descriptive visual support only, with the explicit guard: "No claim about family compactness, family asymmetry, or inter-family distance in Section IV is grounded on the projections themselves."

**Why it changed.**
PCA, t-SNE, and UMAP do not preserve global inter-cluster geometry; axes, inter-cluster distances, cluster sizes, and apparent densities in these projections are not metric quantities in the original 256-D space. Scientific claims must rest on the raw-space metrics, not on visual impressions from lossy projections.

---

## Revision 2 — Softened test-set-size wording in III.A

**What changed.**
Section III.A, "What pattern is consistent" paragraph. The v1 sentence "The gap is not a reflection of test-set size; both tests are drawn from the canonical split protocol and both use the same fixed checkpoint" was replaced.

v2 replacement: "The comparison is not attributable to a different checkpoint or a different evaluation protocol: both families are evaluated with the same pretrained model on fixed held-out splits produced by the canonical split logic. The two test sets differ in size (`1484` oxides and `242` nitrides), so the sampling uncertainty on each family's zero-shot MAE is not identical; this may affect how tightly each zero-shot value is pinned, but it does not change the direction of the observed gap."

**Why it changed.**
The v1 formulation was an absolute denial of any test-set-size effect, which is stronger than the evidence supports. The v2 formulation correctly identifies what the comparison is attributable to (same checkpoint, same protocol) and explicitly acknowledges that the size difference affects sampling uncertainty — while maintaining that it does not change the direction of the gap.

---

## Revision 3 — Transfer-benefit caveat moved earlier in III.C

**What changed.**
Section III.C was restructured. The critical interpretation caveats were moved from the "What is uncertain" block to a dedicated "Critical interpretation caveats, stated up front" block placed immediately after the bar values are listed. Three numbered caveats were made explicit:

1. Numerically taller nitride bars do not indicate more efficient transfer on nitrides (arithmetic is inflated by a weaker scratch anchor, not by better adaptation).
2. The nitride `N = 50` bar measures pretrained-initialization advantage over scratch, not low-data adaptation (nitride mean best epoch at `N = 50` is `1.0`; the first clean cross-family comparison is at `N = 500`).
3. Scope is limited to `N = 50` and `N = 500`; no transfer-benefit statement is made elsewhere on the curve.

The "What pattern is consistent" heading was renamed to "What pattern is consistent, with the caveats in place" to make it structurally impossible to read the pattern statement without having absorbed the caveats first.

**Why it changed.**
Placing caveats after the pattern statement allows readers to form a first impression from the raw bar heights before encountering the correction. Moving caveats to immediately after the bar values prevents the misreading that taller nitride bars signal more efficient transfer on nitrides — a misreading that would corrupt the cross-family comparison.

---

## Revision 4 — Section III.E compressed

**What changed.**
Section III.E ("Bridge to Results IV") was reduced from approximately 180 words (two paragraphs) to approximately 75 words (one paragraph), a reduction of approximately 58%. The list-style restatement of zero-shot gap size, oxide adaptation timing, nitride inertness, transfer benefit, and high-N persistence was removed because that content is already carried by the five-beat structure of III.A–III.D and the IV.E synthesis paragraph. v2 retains one compact synthesis sentence and one clean bridge sentence.

**Why it changed.**
The v1 III.E duplicated material established in III.A–III.D and in the IV.E synthesis. Redundancy in a bridge paragraph adds word count without adding evidence or argument, and it creates a risk that readers treat the restatement as an additional claim rather than a summary.

---

## Revision 5 — Alternative-distance / appendix dependency verified and removed

**What changed.**
A targeted search confirmed that the specific sentence described in the fix list — referencing centroid and Mahalanobis distance robustness and pointing to an appendix — did not appear in the v1 draft. However, a separate forward reference to "Appendix-level Set-2 results" in Section III.B "What is uncertain" was identified. That reference was softened in v2 to: "No claim is made here about alternative hyperparameter settings; the behavioral pattern described is specific to the canonical protocol."

v2 does not introduce any new centroid, Mahalanobis, or appendix dependencies. The "Known draft-stage caveats" block mentions possible future appendix placement of figures, but no numerical value in Sections III or IV depends on any appendix.

**Why it changed.**
The combined paper does not yet have a stable appendix section. Forward references to appendix content that does not yet have a stable anchor create fragile dependencies and may imply that supporting analysis exists when it has not been integrated into the canonical namespace.

---

## Revision 6 — Explanatory wording toned down in IV.B, IV.D, and IV.E

**What changed.**
Several sentences in Sections IV.B, IV.D, and IV.E that used production verbs or causal-sounding phrasing were replaced with correlational language.

Removed from v1:
- IV.B: "The asymmetry between oxide and nitride cohesion is the feature most directly aligned with the behavioral story in Section III: the region that the model treats less uniformly is also the region on which it shows the larger zero-shot MAE and the more brittle fine-tuning response." Replaced with: "Raw-space metrics and behavioral MAE curves are consistent; they describe the same contrast from two different measurement surfaces."
- IV.D: "which places the representation itself, rather than only the regression head, inside the domain-shift story." Softened to: "bringing the representation itself — and not only the downstream regression head — into view as a geometric correlate of the domain-shift picture."
- IV.E: "In the frozen representation that produces those outputs" → "In the frozen representation from which those outputs are computed" (removes causal production verb).
- IV.E: "the structures that are predicted worst at zero-shot are the ones that sit farthest from the oxide-reference region" → "within nitrides, zero-shot error co-varies with distance from the oxide-reference region" (restores correlational phrasing).

Canonical vocabulary adopted throughout v2: "geometric correlate", "consistent with", "aligned with the behavioral asymmetry", "representation-space counterpart", "co-varies with". No instance of "explains the penalty", "produces the behavior", or "proves the mechanism" remains.

**Why it changed.**
The embedding analysis is correlational, not mechanistic. Phrasing that implies the representation produces, drives, or explains the behavioral penalty overstates what a geometric correlation can support. Every claim must be constrained to what the evidence demonstrates: the behavioral penalty and the representation-space geometry are consistent, but the consistency is correlational, not causal.

---

## Files affected

| File | Action |
|---|---|
| `combined_paper_results_III_and_IV_draft_v1.md` | Preserved unchanged (do not modify) |
| `combined_paper_results_III_and_IV_draft_v2.md` | New file — Phase 9C fix list applied |
| `phase9_revision_notes.md` | New file — detailed change log and sign-off annotations |
| `phase9_results_revision_changelog.md` | This file |

## Known remaining items (not in scope for Phase 9C)

- All `[CITE: ...]` placeholders deferred to Phase 11 (intro/abstract/titles) and Phase 12 (assembly).
- Standardize "less organized" to "less cohesive" across IV.B, IV.D, and IV.E — deferred to Phase 9D sign-off.
- Bootstrap CIs on zero-shot MAE values — requires canonical number support not yet in packet extracts.
- Every number in the evidence-provenance table to be cross-checked against `canonical_numbers_v2.csv` before Phase 12 assembly pass.
