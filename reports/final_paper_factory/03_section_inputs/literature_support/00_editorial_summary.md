# Editorial Summary — Heavy Polish Pass (v2 → v2.1 / v3 → v3.1)

This summary accompanies the seven edited files. Each file was revised for flow and density without altering scientific content, numbers, hedging verbs, or citation placeholders.

---

## Scope of the pass

| Output file | Source | Pass intensity |
|---|---|---|
| `01_methods_prose_edited.md` | `methods_prose_drafts_v1.md` | Medium (shared protocol language harmonized across three reports) |
| `02_oxide_results_edited.md` | `oxide_results_section_draft_v3.md` | Heavy (five-bullet templates dissolved into prose) |
| `03_nitride_results_edited.md` | `nitride_results_section_draft_v3.md` | Heavy (caveat banner consolidated; four-step arc preserved) |
| `04_combined_results_III_IV_edited.md` | `combined_paper_results_III_and_IV_draft_v3.md` | Heavy (subsection templates collapsed) |
| `05_oxide_discussion_conclusion_edited.md` | `oxide_discussion_conclusion_draft_v2.md` | Medium-heavy (opening de-recapped; limitations compressed) |
| `06_nitride_discussion_conclusion_edited.md` | `nitride_discussion_conclusion_draft_v2.md` | Medium-heavy (§5.1 tightened; §5.5 restructured) |
| `07_combined_discussion_conclusion_edited.md` | `combined_paper_discussion_conclusion_draft_v2.md` | Medium-heavy (§V.A tightened; §V.G profile-based reorganization) |

---

## Highest-value wording improvements

- **Opening synthesis paragraphs replace mini-recaps.** In all three Discussion sections, §4.1 / §5.1 / §V.A now lead with the interpretive claim rather than restating Results. The result is that readers meet the paper's thesis immediately and encounter supporting evidence as confirmation, not as a second walk through the numbers.
- **Subsection-template scaffolding collapsed.** The repeated "What is being compared / What the figure shows / Consistent pattern / Interpretation justified / What remains uncertain" pentuplet in the Results drafts was removed; its content is retained as flowing prose with explicit verbs ("We compare…", "The pattern is consistent with…", "We do not claim…"). Readers now meet one coherent paragraph per finding instead of five labeled sub-paragraphs.
- **Caveat banners consolidated.** The nitride Results section moved its four running caveats (**C1–C4**) into a single scope note at the top of §4, each thereafter referenced by label. The oxide Discussion's three-rule drafting guardrail was compressed into one opening paragraph. This removes the most visible boilerplate without losing any hedge.
- **Methods harmonized across the three reports.** The shared partial-update paragraph, the shared split-protocol paragraph, the shared `mean_best_epoch` definition, and the shared L1Loss / `criterion: "mse"` note now read word-for-word identical across the oxide, nitride, and combined Methods. This lets the combined paper's Methods serve as a single source of truth and makes the standalone reports look like excerpts rather than parallel drafts.
- **"What the embedding view adds" elevated from pedagogy to finding.** In both §IV.D of the combined Results and §5.4 of the nitride Discussion, the paragraph now leads with the three concrete things the embedding analysis adds (linear-probe AUC, raw-space asymmetry, within-family distance–error correlate) rather than with a procedural framing sentence. Readers see the contribution before the explanation.
- **Practical-implications subsections re-sliced by workflow, not by family.** The combined §V.G now reads as two clean profiles — chemistry-aligned and chemistry-shifted — plus one spanning indicator. Every scoped caveat is stated once, at the top, not re-stated inside each bullet. This is the single largest compression in the Discussion pass (roughly 20 % shorter without losing any content).
- **Limitations restructured from paragraph-with-bold-labels into italic-label prose.** All three Limitations subsections now read as continuous prose with italicized inline labels, which is more publication-idiomatic and faster to scan than the original bold-header-then-paragraph format.
- **Voice harmonized.** The oxide and nitride standalones now have matching voice: the oxide "reference condition" language in §4.3 mirrors the nitride "domain-shift signature" language in §5.3, and the combined synthesis picks up both cleanly in §V.A. This makes the three-paper package feel like one project rather than three separately-drafted deliverables.
- **Transitions tightened.** All in-text forward and backward cross-references now use the typography `§X.Y` rather than mixed `Section X.Y` / `Results §X.Y` / `Results X.Y`. The combined paper's §III → §IV and §IV → §V transitions are now one sentence each and explicitly frame what the next section adds beyond the current one.
- **Numbers moved to interpretive positions.** In several paragraphs the key number was previously buried mid-paragraph; it now anchors the sentence. Example: the oxide §3.4 transfer-benefit paragraph now ends "the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark," which reads as the conclusion rather than as a mid-paragraph observation.
- **Recap-style paragraphs in the nitride Discussion compressed.** §5.2 paragraphs 2 and 3 of the original were read as separate panels; they are now a two-beat interpretation of the same evidence (pretraining beats scratch; the two gaps mean different things), which is the scientifically important distinction.

---

## What was deliberately not changed

- Every number, every figure anchor, every table anchor.
- Every `[CITE: …]` placeholder, in exactly the position where the drafts put it.
- The four-step domain-shift arc in the nitride Results (§§4.1–4.5 plus supporting §4.6).
- The five-part structure of the oxide Results (§§3.1–3.5).
- The six-subsection structure of the combined paper Discussion (§§V.A–V.I).
- The "pretrained formation-energy ALIGNN model" phrasing — never "oxide-pretrained".
- The hedging verbs around embeddings ("is consistent with," "supports the interpretation that," "correlational geometric indicator").
- The PCA/t-SNE/UMAP caveats attached to every embedding claim.
- The nitride `N = 50` caveat (**C3**) wherever the `N = 50` scratch gap is invoked.
- The `C1–C4` caveat labels in the nitride Results.

---

## Sentences still needing human sign-off

These were flagged during the pass as places where the existing wording is defensible but sits at the edge of the project's claim-boundary policy. They are not recommended to change unilaterally; they are flagged for the author to confirm.

1. **Combined §V.F, paragraph 3, final sentence.** "Every quantitative claim in the embedding section is computed in the raw 256-D `last_alignn_pool` space." This is load-bearing for the manuscript's claim-boundary policy. Please verify it is true of every numeric sentence in Results §IV — including the 18.13 % / 9.47 % PCA variance numbers in §IV.A, which are projection quantities and could be read as an exception. If the PCA variance is considered "raw-space enough" to fall under the blanket statement, no change needed; if not, add "apart from the informational PCA variance header in §IV.A" as a parenthetical.

2. **Nitride §5.3, second paragraph, sentence "The candidate that survives this control is a domain-shift reading: the pretrained initialization sits in a region of parameter space that, for the nitride distribution, is not a basin the canonical optimizer can productively descend from…"** This metaphor ("basin," "productively descend from") is geographic rather than statistical. It is consistent with standard optimization vocabulary, but it comes close to mechanism language. Author should confirm they are happy with this phrasing or prefer the more neutral "a region the canonical optimizer does not productively leave at the tested low-`N` budgets."

3. **Combined §V.E, last sentence of paragraph 1.** "Three empirical features of the nitride arm are consistent with treating chemical distance as the operative source of difficulty under the canonical protocol [CITE: Omee et al. 2024; Li et al. 2025 — OOD; Hu et al. 2024]." The phrase "operative source of difficulty" is a hair stronger than "consistent with a representation-space shift" used elsewhere. Please confirm this stronger phrasing is intended here as the combined-paper synthesis, or swap to the softer form used in the standalone nitride report.

4. **Oxide §4.5, last sentence of paragraph 2.** "We avoid stronger versions of this claim because the regime is specific in four ways…" The four ways are listed immediately after. This is intentionally a self-limiting paragraph; confirm the four bounds (target, splits, protocol, `N`-range) are the canonical four you want stated, and not three or five.

5. **Oxide §4.7 and Nitride §5.7 future-work items.** Each future-work paragraph lists specific follow-up `N` values (`N ∈ {10, 100, 200, 1 000}` for oxide; same for nitride). These should be cross-checked against the canonical-numbers file to ensure they exactly match the sizes referenced elsewhere in the manuscript. If they are meant as illustrative examples rather than a commitment, consider adding "for example" to the lead-in.

6. **Nitride Conclusion, final sentence.** "Stated more sharply: chemically distant targets require substantially more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do." This is the sharpest claim in the nitride Conclusion. It is defensible — the tested `N` range up to 1 000 does not beat zero-shot on nitrides, and oxide zero-shot sits 0.0342 eV/atom vs 0.0695 eV/atom on nitrides — but phrased this way it could be read by a reviewer as a quantitative claim. Please confirm the authors are comfortable with the word "substantially" here, or swap for "more" (weaker) or "at least several-fold more" (specific but less defensible).

7. **Combined Conclusion, closing sentence.** Same consideration as #6: "the labelled-data cost of moving below a pretrained baseline is substantially higher than chemistry-aligned task experience would predict, and that should therefore be planned for rather than discovered after the fact." The closing clause ("planned for rather than discovered after the fact") is the paper's strongest rhetorical moment and an appropriate Conclusion beat. Confirm this is the intended closing register.

8. **All three reports, `mean_best_epoch` first mention.** In the edited Methods, `mean_best_epoch` is defined only in the nitride and combined Methods (not the oxide Methods), because the oxide prose does not need the concept to motivate §3.2. If the oxide Methods is read in isolation — i.e., separately from the combined paper — the oxide Results' use of `mean_best_epoch` would arrive undefined. Confirm whether the oxide Methods should add a one-sentence definition, or whether readers are expected to have the combined Methods in context.

9. **Figure-memo anchors.** Several anchors (`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER`, `FIG_S1_LC_OXIDE`, `FIG_S1_LC_NITRIDE`, `FIG_S1_COMP_OXIDE`, `FIG_S1_COMP_NITRIDE`, `FIG_TRANSFER_BENEFIT`, `FIG_ZS_COMPARISON`) appear across multiple files in subtly different formats. The edited files preserve each file's internal convention but do not unify across files. Before final assembly, please decide whether figures will use underscored or hyphenated identifiers and sweep all seven files together.

10. **Citation-placeholder format.** The original drafts mix three placeholder conventions: `[CITE: Lee & Asahi 2021; Kim et al. 2024]`, `[CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]`, and `[CITE: JARVIS 2020 dataset/repository paper]`. The edited files preserve each file's internal convention but do not unify across files. Final-assembly pass should choose one convention and sweep.

---

## Do the edited files need a second read?

Files 02 (oxide Results), 03 (nitride Results), and 04 (combined Results III/IV) had the heaviest structural revision (bullet-to-prose, caveat consolidation). They would benefit most from a targeted re-read focused on whether any intended hedge was dropped in the compression. Files 01 (Methods), 05 (oxide Disc/Con), 06 (nitride Disc/Con), and 07 (combined Disc/Con) are structurally close to the originals and needed re-reading only for voice consistency.
