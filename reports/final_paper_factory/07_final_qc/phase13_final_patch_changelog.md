# Phase 13 Final Patch Changelog

Date: 2026-04-24

Source versions: `oxide_polished_v2.md`, `nitride_polished_v2.md`, `combined_paper_polished_v2.md`
Output versions: `oxide_polished_v3.md`, `nitride_polished_v3.md`, `combined_paper_polished_v3.md`

---

## oxide_polished_v3.md

### Critical fixes
None (all critical items were combined-paper-only).

### Minor language tightening (G)
| Location | Old wording | New wording |
|---|---|---|
| §3.4 | "It is not — by a very large margin." | "It is not — by a substantial margin." |
| §4.3 | "the pretrained representation works as advertised is what allows..." | "the pretrained representation performs as transfer learning predicts is what allows..." |
| §4.3 | "the case the pretrained model was, in practice, prepared for." | "the in-distribution regime the pretrained model handles reliably." |
| §5 (Conclusion) | "the regime the model was prepared for" | "the in-distribution regime the model already covers" |
| §5 (Conclusion) | "what transfer working as advertised looks like" | "what successful in-distribution transfer looks like" |

### Not changed
- All numbers, figure markers, table markers, and `[CITE: ...]` placeholders preserved exactly.
- Front-matter, acknowledgements, and references placeholders retained as-is (deferred to citation stage).

---

## nitride_polished_v3.md

### Critical/Important fixes

**B. Nitride conclusion fix**

Location: §5. Conclusion, final paragraph.

Old sentence (QC report Important issue 1):
> "Chemically distant targets require substantially more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do."

New sentence:
> "…adaptation begins later, the residual gap above the family's own zero-shot baseline is larger at every tested budget, and the best genuinely-adapted configuration still sits above that baseline — a pattern that project planning should treat as the default expectation rather than the exception when targeting chemistry-distant families under a standard fine-tuning protocol."

Why: The original sentence made a cross-family threshold comparison (nitride requires more data to beat pretrained than oxide) that the oxide control does not support — oxide fine-tuning never beats the oxide zero-shot baseline within the tested N range either. The replacement uses only within-family evidence that is directly supported.

**E. Pretraining-regime inference softened**

Location: §3.1, under caveat C1.

Old: "its composition is consistent with a pretraining regime more aligned with oxides than nitrides."
New: "we note only that the observed zero-shot family gap is consistent with the corpus having broader coverage of oxide-like than nitride-like chemistry, without characterizing the corpus composition in detail."

Why: The original sentence makes an inference about the training corpus that later limitation language (§4.6) says cannot be characterized in detail. The replacement is consistent with the observed gap without over-specifying the corpus.

### Minor language tightening (G)
None in nitride beyond the two fixes above.

### Not changed
- Nitride conclusion paragraph 1 (all four-faceted evidence summary) preserved exactly.
- Assembly note already removed in v2.
- Internal handover paragraph already removed in v2.
- `discrete transition` → `sharp transition` already applied in v2.
- Expanded figure label references already applied in v2.
- All numbers, figure markers, table markers, and `[CITE: ...]` placeholders preserved exactly.

---

## combined_paper_polished_v3.md

### Critical fixes (A)

Already applied in v2 (assembly note, internal handover, evidence provenance block all removed). No additional critical material found in the v2 → v3 pass.

### Important fixes

**C. Internal citation-token cleanup**

| Token | Location | Replacement |
|---|---|---|
| `[CITE: ALIGNN_PAPER]` | §V preamble | `[CITE: ALIGNN foundational paper]` |
| `[CITE: JARVIS_INFRA]` | §V preamble | `[CITE: JARVIS dataset/repository paper]` |
| `[CITE: PROJECT_BRIEF]` | §V.A (III.A zero-shot gap) | Removed; sentence recast as "consistent with the study design that treats oxides as in-distribution… as stated in §2.1." |
| `[CITE: KIM2024; LEE_ASAHI2021]` | §V.C (III.C transfer-benefit) | `[CITE: Lee & Asahi 2021; Kim et al. 2024]` |
| `[CITE: WEEK2_ASSIGNMENT]` | §VI.A (Implementation) | `[CITE: van der Maaten & Hinton 2008; McInnes et al. 2018]` |

**D. Raw-space-only wording fix**

Location: §VI.A (formerly §IV.A).

Old: "**All statistical claims in this section are computed in that raw 256-D space.**"
New: "**All inferential claims in this section are computed in that raw 256-D space.** The PCA explained-variance values reported immediately below (18.13 % and 9.47 %) are projection-derived descriptors, not raw-space statistics."

Also changed "statistical claims" to "inferential claims" in the section-opening sentence to match.

**E. Pretraining-regime inference softened**

Location: §4.1 (combined paper), under caveat C1.

Old: "its composition is consistent with a pretraining regime more aligned with oxides than nitrides."
New: "we note only that the observed zero-shot family gap is consistent with the corpus having broader coverage of oxide-like than nitride-like chemistry, without characterizing the corpus composition in detail."

**F. Subsection numbering harmonization**

Scheme adopted: all-Arabic for §V (Results III) and §VI (Results IV) subsections, matching the existing Arabic scheme in §III (Results I) and §IV (Results II). Discussion §VII converted to Arabic as well.

| Section | Old labels | New labels |
|---|---|---|
| §VI (Results IV) | IV.A, IV.B, IV.C, IV.D, IV.E | VI.A, VI.B, VI.C, VI.D, VI.E |
| §VII (Discussion) | VII.A through VII.I | 7.1 through 7.9 |

§III (Results I) and §IV (Results II) retain their existing 3.x and 4.x Arabic scheme.
§V (Results III) retains its III.A–III.E labels (these refer to the Results-III ordinal, and are distinguishable from document §III by context).

Cross-references updated:
- `§§VII.B–VII.E` → `§§7.2–7.5`; `§VII.F` → `§7.6`; `§VII.G` → `§7.7`
- `§§IV.B–VI.C` cross-refs updated after Results IV rename
- `§IV.C` used as 5NN distance anchor → updated to `§VI.C`
- `§§V and VI` replace former `§§III and IV` in VI.E synthesis paragraph
- §VI preamble: "§III characterizes..." → "The direct comparison section above (§V) characterizes..."
- "Results §IV" in §7.6 → "Results §VI"
- §VI.D cross-ref: `§§III.A–III.D` → `§§5.1–5.4 (Results III)`

### Minor language tightening (G)
- §VII.A abstract sentence: no additional changes; the existing tone is already tight.
- "smooth adaptation" in the abstract is intentionally retained pending Phase 13C scientific verdict.

### Not changed
- §V (Results III) subsection labels III.A–III.E retained (they refer to Results-III ordinal, not document §III).
- All numbers, figure markers `[INSERT FIGURE ... HERE]`, table markers `[INSERT TABLE ... HERE]` preserved exactly.
- Standard scholarly `[CITE: ...]` placeholders preserved throughout.
- Front-matter, acknowledgements, and references placeholders retained (deferred to citation stage).
- Combined paper conclusion sentence about "moving below a pretrained baseline" retained (deferred to Phase 13C scientific review).
