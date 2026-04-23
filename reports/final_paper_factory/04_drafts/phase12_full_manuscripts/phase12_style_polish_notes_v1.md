# Phase 12 Style Polish Notes (v1)

Editorial notes only. Summarizes the highest-value prose/style improvements made in the Phase 12B polish pass across the three manuscript drafts:

- `oxide_polished_v2.md`
- `nitride_polished_v2.md`
- `combined_paper_polished_v2.md`

No numerical content, figure/table references, or scientific claims were altered. All edits were at the prose/style level. Verified by machine diff: numeric sets and `FIG_*`/`TAB_*` reference sets are identical to the v1 drafts.

---

## 1. Cross-manuscript improvements

These were applied consistently across all three drafts to maintain a uniform materials-AI scientific register.

- **Abstract framing.** Each abstract now opens scope-first and closes with an explicit scope-bounded reading ("Scoped to the tested regime, the evidence supports…" / "…fix the in-distribution reference condition…"). The closing clause of the nitride abstract was aligned with the oxide and combined abstracts so that all three share the same rhetorical shape: problem → method → findings → scope-bounded implication.

- **De-stylization of the CGCNN/ALIGNN paragraphs.** The phrase "ALIGNN sharpens this family by…" (slightly florid) was replaced with "ALIGNN refines this approach by…" in the individual reports and "ALIGNN extends crystal-graph message passing by…" in the combined paper. Same paragraph: "relying solely on handcrafted descriptors" → "relying on handcrafted descriptors" ("solely" is redundant given the contrast that follows).

- **JARVIS infrastructure clause.** Across all three introductions, the triple "the dataset, the pretrained-model checkpoints, and the benchmark splits" was trimmed to "the benchmark splits" after a linking word ("which also supplies"). The dataset and checkpoints are already present in the preceding clause; the triple read as padding.

- **Directness on the "benefit survives" clause.** "Whether and how much of this benefit survives on a new target" → "How much of that benefit survives on a new target." Shorter, same meaning.

- **"What remains harder" → "What is harder."** The "remains" softener was removed in all three intros.

- **Participial vs. relative-clause phrasing.** Several "that is" constructions in closing clauses were collapsed to participial phrases (e.g. "a correlational probe that is consistent with it" → "a correlational probe consistent with it"). This matches the tighter register used elsewhere in the drafts.

- **Caveat density in conclusions.** The three Conclusion paragraphs that list three-part practical readings were all restructured with semicolons instead of repeated "that" clauses, so each point reads as an individually weighted claim rather than a rushed comma-chain.

---

## 2. Oxide-specific polish improvements

- **Abstract tightened from 235 to 225 words.** Three specific cuts: (i) the three-surface enumeration ("we compare zero-shot…, fine-tuning…, and matched from-scratch baselines") was folded into a single sentence introduced by "we combine three measurement surfaces"; (ii) "This report evaluates … providing a reference condition against which the companion chemistry-shifted evaluation can be read" → "establishing the reference condition against which…"; (iii) the duplicated scope qualifier "within the tested range and protocol" that appeared twice near the end was reduced to one occurrence.

- **Discussion §4.1 opening sentence.** "Read together, these establish…" now reads "Read together, these three findings establish…" — clearer antecedent for a reader entering the Discussion cold.

- **Conclusion paragraph 2.** Originally a triple-"that" comma chain ("that the choice of initialization is…, that fine-tuning is…, that pretrained zero-shot is…"). Now "the practical reading is threefold: X; Y; and Z" — same claims, cleaner cadence and easier to scan.

- **Conclusion paragraph 3.** The clause "is the case in which the pretrained representation is known to operate in the regime it was prepared for; it is the control without which…" was collapsed to a single em-dash construction ("the case in which the pretrained representation operates inside the regime it was prepared for — the control without which…"). Final sentence: "makes … an interpretable and quantifiable phenomenon" → "renders … an interpretable, quantifiable phenomenon" — crisper verb.

---

## 3. Nitride-specific polish improvements

- **Abstract.** Minor clarifying edit: "the selected checkpoint is still the pretrained zero-shot state at every seed" → "the selected checkpoint is the pretrained zero-shot state at every seed." The "still" read as a temporal softener where the claim is in fact categorical. Closing line reframed from "Results support a domain-shift reading…" to "Scoped to the tested regime, the evidence supports a domain-shift reading…" to match the oxide and combined abstracts.

- **Introduction.** "if it is read in isolation" → "if read in isolation." Also "The companion oxide report establishes the in-distribution control condition against which this report's evidence is read" → "…against which the present evidence is read" — slightly less self-referential, a small register improvement.

- **Introduction RQ4 framing.** "a correlational probe that is consistent with it rather than a causal proof" → "a correlational probe consistent with it" — drops redundant copula, and the "rather than a causal proof" caveat is already carried explicitly elsewhere in the same paragraph.

- **Introduction section-map sentence.** "Section 3 reports the behavioural evidence … and the representational evidence" → "…together with the representational evidence." The bare "and" read as coordinate items of the same kind; "together with" signals that the representational evidence is a distinct surface, which matches how the Results section is actually structured.

- **Results §3.1 verb variation.** "§§3.2–3.3 evaluate whether fine-tuning…" → "§§3.2–3.3 examine whether fine-tuning…" to avoid the "evaluate" repetition that already appeared in the parent paragraph.

- **Discussion §4.1.** "…reporting an optimizer that does not move off…" → "…showing an optimizer that does not move off…" — "showing" is the more natural verb for what the signature does.

- **Conclusion.** The final paragraph originally ended with a "Stated more sharply:" preamble before a single-sentence restatement. The preamble was doing the work the sentence already does; removing it lets the closing line land directly.

---

## 4. Combined-paper polish improvements

- **Abstract (250 words, unchanged).** Two structural edits without length change: (i) "a shared protocol comprising zero-shot evaluation…, fine-tuning…, and matched from-scratch baselines" → colon-introduced list ("a shared protocol: zero-shot evaluation…, fine-tuning…, and matched…"); (ii) "analyse family structure and a within-family distance–error correlate" → "analyse family structure together with a within-family distance–error correlate" to prevent a reader parsing the two as a single compound object.

- **§V.A closing sentence.** "§IV introduces a correlational geometric counterpart that is consistent with the gap but does not explain it" → "…a correlational geometric counterpart consistent with the gap but does not explain it." Dropped "that is" for tightness.

- **Discussion §VII.A opening.** The original one-paragraph answer packed the headline claim and its support into a long sentence with a trailing "with…" clause. Split into two sentences: the headline sentence ("behaves as transfer learning predicts on the oxide arm and only partially on the nitride arm") and a separate sentence for the every-surface claim. Stronger cadence for the paragraph that serves as the Discussion's TL;DR.

- **Conclusion paragraph 2.** The original "…2× family-level zero-shot penalty, the canonical fine-tuning loop is operationally inert at `N ≤ 200`…" strung three distinct findings together with commas. Now uses semicolons between the three findings (penalty / inertness / residual gap), so each is readable as a weighted claim.

- **Conclusion paragraph 3 (practical reading).** Parallel edit to the oxide conclusion: triple-"that" comma chain → semicolon-separated three-part reading.

- **Conclusion final paragraph.** Split the long closing sentence at the em-dash and replaced with period + new sentence beginning "Under the canonical protocol, that cost separates…" The v1 version piled the position claim, the penalty description, and the "should be planned for rather than discovered after the fact" flourish into one sentence; splitting lets the closing flourish actually land.

---

## 5. Remaining sentences or sections that may still need human review

None of the items below were touched in this pass. They are flagged for a human editor's attention during the final-submission phase.

**Workflow artefacts to strip before submission**

- The `**Assembly note.** Built from the approved component drafts on 2026-04-23. Figure and table insertion markers are preserved for manuscript assembly.` header appears verbatim at the top of all three drafts. It is a Phase 12 assembly marker and should be removed before any journal or reviewer-facing export.

- Combined paper, lines ~380–390: the "Evidence provenance for review" table and the numbered reviewer-facing notes ("All citation placeholders must be replaced…", "§III.D can be demoted to a single paragraph…", "§IV.B currently treats the PCA, t-SNE, and UMAP panels as a descriptive triptych…"). These are internal Phase 12 review aids and should either be moved to a separate assembly-notes file or deleted before submission.

- Nitride §3.7, closing block: the `**Citation placeholders used in Results:** [CITE: …]` paragraph is a handover note from the reference-filling phase and shouldn't appear in a submitted version.

**Citation placeholders**

- All three drafts still contain `[CITE: …]` tokens throughout Introduction, Methods, Results, and Discussion. These are intentional and flagged for the reference-insertion phase; not a prose issue, but the item most likely to cause trouble if it slips through.

**Harmonization candidates across the three drafts**

- Treatment of the `criterion: "mse"` vs. L1Loss discrepancy. Oxide §2.5 uses the framing "for transparency, the inherited config JSON retains…"; combined §2.5 uses "we record this discrepancy explicitly for reproducibility"; nitride §2.5 states the fact without an accompanying frame. These three read as three different editorial voices on the same technical point; a human may want to converge them on one phrasing.

- Keywords lists. The three keyword blocks overlap heavily but are not identical. A human should decide whether strict harmonization is wanted or whether arm-specific emphasis (e.g. "in-distribution evaluation" on oxide, "out-of-distribution generalization" on nitride) is intentional.

- Section-numbering convention. The oxide and nitride reports use Arabic numerals ("§1.", "§2.", "§4.3"). The combined paper uses mixed Roman-then-Arabic ("§I.", "§II.", "§III.A", "§VII.G"). Intentional per the JURI-style brief, but worth a final sanity check when cross-references between the three files are being resolved.

**Style items worth one more pass**

- The word "discrete" in "indicates a discrete transition" (nitride §3.3 and combined §4.3 / equivalent section). In materials-physics writing, "discrete" can be read as "quantized"; a human may prefer "sharp" or "step-wise" to avoid the ambiguity. The meaning in context is clearly the latter.

- "A technical note: on-figure MAEs are computed on seed-averaged predictions…" appears in oxide §3.3 and again in the parity sections of the combined paper. A copy-editor may prefer to demote these to footnotes rather than running them as inline caveats, depending on the journal's footnote policy.

- Oxide §3.6 ("Summary of oxide results") uses a numbered list with bolded lead sentences ("In descending order of scientific weight: 1. Pretrained initialization dominates…"). The register differs from the surrounding prose sections. This was left as-is because the project brief explicitly asks for a ranked summary, but a human should confirm that the numbered-list register is acceptable for the target venue.

- Oxide §4.4 and §4.5 are adjacent and closely related (embedding-view add + practical implications). Not a prose issue, but a human may want to check whether the boundary between them reads cleanly when the full Discussion is read linearly.

**Closing note.** The polish pass was conservative by design: transitions, flow, and abstract/conclusion tightening only. No section was rewritten, no argument restructured, no scope language weakened or strengthened. The items above are editorial observations for a human reader, not pending edits.
