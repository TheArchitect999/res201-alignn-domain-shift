# Nitride Revision Notes

Summary of the v1 → v2 revision applied to:
- `nitride_analysis_document_v2.md`
- `nitride_results_section_draft_v2.md`

The revision aimed to sharpen the scientific story, tighten wording where v1 was slightly over-strong, use oxide as an explicit control comparator at the right transition points, and make the four-step domain-shift arc the unmistakable spine of both files — without inventing numbers, without adding unsupported literature claims, and without collapsing the separation between literature context, implementation, and findings.

---

## 1. Biggest framing changes

### 1.1 Four-step domain-shift arc is now the explicit spine

- Both documents now open with a thesis block that names the four steps as numbered items:
  1. zero-shot family penalty
  2. low-`N` fine-tuning inertness
  3. genuine but incomplete high-`N` adaptation
  4. embedding-space geometry consistent with the penalty
- Subsection headings in the analysis doc (§§2, 3.1, 3.2, 4.1, 4.2) now begin with "**Step 1 —**", "**Step 2 —**" etc. The Results draft uses parallel language ("Step 1 — zero-shot…", "Step 2 — low-`N`…", etc.).
- The closing synthesis in both files (§6 of the analysis doc, §4.7 of the Results draft) is restructured as a step-by-step restatement of the arc, ending on Step 4.
- Transition sentences at the end of each step now forward-reference the next, or back-reference the previous, so the arc is visible in connective tissue and not only in headings.

### 1.2 Scratch repositioned as supporting evidence, not a parallel main claim

- In the analysis doc, the scratch section was moved to §5 (after the full Steps 1–4 arc is developed) and retitled "Supporting evidence — pretrained initialization vs training from scratch". The section now opens with an explicit positioning sentence: "This section is deliberately positioned as support for Steps 1–4, not as a parallel main claim."
- A new closing paragraph ("Role in the overall reading") contrasts "pretraining helps on nitrides" (a standard transfer-learning result) with "the domain-shift penalty persists despite adaptation" (the OOD-specific finding), naming the second as the headline.
- In the Results draft, the equivalent subsection (§4.6) is labeled "Supporting evidence" in its heading and contains an explicit "Relationship to the main arc" paragraph that makes the same distinction.
- All scratch numbers, caveats, and scope limits (N = 50 and N = 500 only) are preserved unchanged.

### 1.3 Oxide used as a control comparator at three key transition points

New or sharpened oxide-as-control anchors at:

- **After §4.1 / §2 (zero-shot).** "Nitride starts at roughly 2× the oxide zero-shot MAE." (was present in v1 but is now tagged as a transition anchor and forward-references §§4.2–4.5.)
- **After §4.2 / §3.1 (low-`N` inertness).** New sentence: "Unlike oxide, which begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5`, rising to 35.5–39.0 at N ≥ 200), nitride remains operationally inert through N = 200." This leverages the oxide canonical numbers already in `canonical_numbers_v2.md` and sharpens the Step 2 contrast without duplicating oxide material.
- **After §4.4 / §4.1 (family separation).** The nitride region is now described consistently as "distinguishable but less cohesive than the oxide control region" rather than the looser v1 phrasing "less internally cohesive."

Oxide is never elevated to a parallel narrative: it appears only as a control comparator where it strengthens the domain-shift reading.

### 1.4 Wording softened where v1 was slightly over-strong (FIX 1)

| v1 phrasing | v2 phrasing |
|---|---|
| "oxide-heavy chemistries" dominate | "consistent with an oxide-skewed reference regime" |
| "purest behavioral signature of a family-level representational mismatch" | "the cleanest behavioral indicator of a family-level shift under this protocol" |
| "This is why nitride belongs as the OOD arm of the study." | "This is why nitride functions as the OOD arm in this study." |
| "Zero-shot is the cleanest behavioral evidence that nitrides are harder for the pretrained model." | "Zero-shot … is the cleanest behavioral indicator of a family-level shift under this protocol." |
| "representational correlate of the behavioral nitride penalty" | "representational correlate of the behavioral domain-shift penalty" (also unifies terminology; see §1.6) |

The substantive domain-shift claim is retained; only the rhetorical register is tightened.

### 1.5 Caveats consolidated into a single early block (FIX 5)

- The analysis doc now has a dedicated "§1b. Caveats applied throughout this document" block with four numbered caveats (**C1**–**C4**):
  - **C1** — checkpoint not called "oxide-pretrained"
  - **C2** — low-`N` `mean_best_epoch = 1.0` is not meaningful adaptation
  - **C3** — N = 50 scratch gap is initialization advantage, not adaptation gain
  - **C4** — embedding distance is correlational, not causal
- In subsequent sections, each caveat is invoked economically by its label (e.g., "under **C3**"), rather than repeated as a paragraph-length "What we are not claiming" block. This removed about six redundant caveat paragraphs without dropping any substantive guardrail.
- The Results draft has a matching caveat block in its scope header (top of file) and uses the same **C1**–**C4** labels in-line throughout §§4.1, 4.2, 4.4, 4.5, and 4.6. The older, longer "What remains uncertain" sections are preserved in each subsection but are now tighter and less defensive.

### 1.6 Terminology unified to "domain-shift penalty" (FIX 5)

- The primary phrase across both files is now **"domain-shift penalty"**.
- "Family-level OOD penalty" is retained as a sparing secondary phrase where variation is needed for readability.
- The word "mismatch" at the representational level is retained once in the framing to name the concept, but phrases like "representational mismatch" are no longer used as a headline description of zero-shot results.
- "OOD-penalty picture" from v1's §6 was rewritten to "four-step domain-shift story" in v2's §6.

### 1.7 Structural changes that make the arc easier to read

- The analysis doc's old "§3 Fine-tuning trajectory" with subsections 3.1 / 3.2 / 3.3 was kept, but 3.3 (parity-plot cross-cut) was absorbed as a sub-element inside 3.2 (Step 3), because parity-plot MAEs are most meaningful when discussed alongside the genuinely-adapted N = 1000 row.
- The analysis doc's old §§4 (scratch) and §5 (embeddings) were **swapped** in v2 so embeddings close the four-step arc (Step 4) before scratch is introduced (§5, now supporting evidence). This is the single biggest structural change.
- The Results draft keeps the publication-conventional 4.1–4.7 numbering (JURI-style) but renumbers the embedding subsections to 4.4 (family separation = Step 4a) and 4.5 (distance–error = Step 4b), and moves scratch to 4.6 so the main-text reading order matches the arc.

---

## 2. What was deliberately preserved from v1

- All numeric values (zero-shot, fine-tuning mean/std, mean best epoch, from-scratch, parity metrics, embedding separation stats, distance–error stats and CIs/FDR q-values).
- All figure and table references (`TAB_*`, `FIG_*`).
- All citation placeholders. No new citations were invented.
- The literature / implementation / findings separation. Each section still tags claims by layer.
- The explicit distinction between summary-table MAE and parity-plot MAE.
- The appendix-only status of `pre_head` and `last_gcn_pool`.
- The from-scratch coverage scope (N = 50 and N = 500 only).
- The 5-move subsection template in the Results draft (*what is being compared → what the figure/table shows → consistent pattern → justified interpretation → what remains uncertain*).

---

## 3. Remaining ambiguity

These items were left as-is in v2 and are worth flagging for later editorial review, but none of them require number changes or introduce scientific risk.

### 3.1 Parity-plot aggregation framing

The parity-plot MAEs (0.0828 at N = 10, 0.0829 at N = 1000) are seed-averaged-prediction errors, while the summary-table MAEs (0.0874, 0.0907) are averages of per-seed errors. v2 keeps both, explicitly labels their difference as structural, and draws the conclusion that the dominant high-`N` improvement is in variance / best-epoch rather than headline parity error. If the Discussion ultimately wants a cleaner visual story, a later edit could drop the on-figure parity MAEs from the main text and keep only the summary-table values, with the parity metrics moved to the figure caption.

### 3.2 Oxide comparator in Step 3

v2 adds an oxide-as-control anchor after §4.2 (low-`N`) but does not add an explicit oxide contrast inside §4.3 (high-`N`). An optional additional anchor here would be: "The oxide high-`N` band is both below its zero-shot baseline and well below the nitride high-`N` band" — but this requires the oxide report to be drafted in a compatible way. We did not add it in v2 to avoid pre-committing to a specific oxide-report framing.

### 3.3 Oxide N = 10 caveat

The canonical numbers pack flags oxide N = 10 with the lighter `zero_shot_checkpoint_at_low_N` flag (mean_best_epoch = 1.0 only at N = 10, while oxide starts adapting at N = 50). This is relevant context that reinforces the nitride-specific nature of the low-`N` inertness band (N = 10–200), but v2 references it only implicitly in §4.2's oxide-as-control anchor ("oxide … begins genuine optimization by N = 50"). A later edit could add one sentence explicitly noting that even on oxide the very smallest budget (N = 10) selects epoch 1, which would make the nitride contrast sharper without weakening the domain-shift claim.

### 3.4 "Less native" phrasing

v1 had a sentence in the embedding section describing nitrides as "the less 'native' family for this checkpoint." This was dropped in v2 as mildly anthropomorphic and replaced with the more neutral "less cohesive" / "less internally organized" phrasing. If the Discussion wants an accessible shorthand, "less native" could be re-introduced there with explicit scare quotes, but it should not re-enter the Results or Analysis body.

---

## 4. Sentences that still need human confirmation

These are places where the v2 wording is defensible given the evidence packets but involves a framing choice that a human reader should sign off on before publication.

### 4.1 Analysis doc §1 — literature framing on pretraining-corpus composition

> "The element and bonding statistics of these corpora are consistent with an oxide-skewed reference regime rather than a uniform coverage of chemistries."

**Why flagged.** This is the softest defensible version of the v1 "oxide-heavy chemistries dominate." It should survive a literature check, but if the cited references (e.g., `Dunn2020_Matbench`, or the JARVIS-DFT family-distribution tables in `Choudhary2020_JARVIS`) do not explicitly use "oxide-skewed" / "oxide-dominated" language, this sentence should be revised to match the exact wording in the sources.

### 4.2 Analysis doc §1 and §6 — "consistent with" framing

Both files use "consistent with" repeatedly when describing how our findings relate to (i) a domain-shift account and (ii) the broader transfer-learning literature. This is the intended epistemic register (correlational, non-causal), but if a reviewer finds it repetitive, some instances could be varied to "compatible with" or "aligns with."

### 4.3 Analysis doc §4.1 — "without being trained to"

> "The pretrained network has, without being trained to, built a representation in which oxides and nitrides occupy distinguishable regions."

**Why flagged.** The phrase "without being trained to" is accurate (the model was trained on formation energy, not family labels) but could be misread as implying something stronger about what the network "knows." If this reads as over-interpretation in a later review, rewrite as: "The pretrained model, trained only on formation energy, has developed a representation that also places oxides and nitrides in distinguishable regions." The numeric claim is unchanged either way.

### 4.4 Results draft §4.6 — "headline OOD result"

> "The central OOD finding of this report is that the domain-shift penalty persists through Step 3's genuine adaptation…"

**Why flagged.** This is an editorial prioritization, not a numeric claim. It reflects the user's stated preference that scratch be supporting evidence rather than the main act. If the final Discussion later foregrounds a different main result, this sentence will need to be adjusted in lockstep.

### 4.5 Oxide adaptation-onset numbers inside §4.2

> "oxide … begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5`, rising to 35.5–39.0 at N ≥ 200)"

**Why flagged.** These are canonical oxide mean-best-epoch values from `canonical_numbers_v2.md`. They are the minimum needed to make the oxide contrast concrete. If the oxide standalone report uses different summary numbers for the same rows (e.g., in case of a later recompute), this sentence must be kept in sync.

---

## 5. Net verdict

All five fixes from the revision brief were applied. The v2 files:

- preserve all numbers and references;
- replace three over-strong phrases with the suggested softer forms;
- add oxide-as-control anchors at the three requested transition points;
- make the four-step domain-shift arc the unmistakable spine (thesis → step-labeled sections → step-by-step synthesis);
- keep scratch analysis present and sharp, but reposition it as supporting evidence explicitly;
- consolidate the four key caveats into one early block and reference them economically later;
- unify terminology around "domain-shift penalty" as the primary phrase.

The two files are ready for downstream review and prose-polish. The flagged sentences in §4 above are the cleanest human-checkpoints for a final pass.
