# Oxide Revision Notes

Companion to `oxide_analysis_document_v2.md` and `oxide_results_section_draft_v2.md`. Logs the framing changes made in the v2 revision, flags ambiguity, and lists sentences that still need a human reviewer's sign-off before the report is finalized.

---

## 1. Biggest framing changes made

### 1.1 Oxide identity is now explicitly stated as "disciplined control-arm evidence"

Both files now open with an explicit identity statement: the oxide report is the in-distribution control arm of the broader study, not a dramatic failure case or a breakthrough. This replaces the v1 opening which read as a neutral analysis memo. The analysis document's §1 and the Results draft's preamble both name this identity up front, so that later rhetorical weight on the scratch-comparison subsection lands as "the central control-arm finding" rather than as a surprise.

### 1.2 Pretrained-vs-scratch is now the central oxide result, not co-equal with fine-tuning

In v1, the fine-tuning trajectory and the scratch comparison had roughly equal rhetorical weight. In v2:

- The analysis document's §1.3 lists findings in scientific-weight order, with the scratch-gap result stated first.
- The analysis document's §4 is rewritten with a stronger opening sentence ("This comparison is the oxide arm's clearest on-family signature of transfer value, and it is the result the oxide report is built around") and closes with a "why this is the central oxide result" paragraph.
- The analysis document's §6 Synthesis is reordered to lead with the scratch-gap.
- The Results draft's §3.4 now opens with a dedicated transition paragraph that positions the scratch comparison as the subsection the earlier results were building toward.
- The Results draft's §3.6 Summary is reordered to lead with scratch.
- The §3.4 heading was lengthened to signal its centrality: "Pretrained initialization dominates random initialization at both scratch-tested data sizes — the central on-oxide transfer-value result."

### 1.3 Source-distribution wording has been neutralized

v1 used phrasing such as "oxides are well represented in this source distribution," "chemically familiar target within the source distribution," and "a large-dataset JARVIS-pretrained ALIGNN model [...] is already well-matched to oxide formation-energy prediction." These overclaimed the chemical composition of the pretraining corpus. In v2, every such instance has been replaced with design-neutral wording:

- "oxides are the chemically aligned control arm as defined by this project"
- "the oxide arm functioning as the in-distribution control condition in this study"
- "oxides are the chemistry-aligned control arm by project design"
- A new explicit disclaimer: "We do not make separate claims here about the exact chemical composition of the pretraining corpus."

The analysis document's §1.2 carries the full disclaimer; the Results draft's §3.1 "What the pattern is consistent with" paragraph carries a compressed version.

### 1.4 "Ceiling" language has been softened in early Results prose

v1 used "sets the in-distribution ceiling" as the §3.1 heading and "performance ceiling" repeatedly in the §3.1 body. In v2:

- §3.1 is renamed "Zero-shot oxide performance establishes the best Set 1 oxide benchmark."
- §3.1 body replaces ceiling language with "best observed oxide performance under Set 1" and "baseline not surpassed under the canonical fine-tuning or from-scratch protocols."
- §3.2 retains the word "ceiling" in the heading ("converges toward, but does not surpass, the zero-shot benchmark" — the v2 heading actually uses "benchmark" not "ceiling" anywhere in 3.2) because interpretive prose at that stage benefits from the economy of the word; however, in the §3.2 body, where the fine-tuning curve is being characterized, the "approaches from above" and "flattens toward the zero-shot benchmark" phrasings are used in place of "ceiling."
- The analysis document retains the word "ceiling" only in §2's section title and §3.3's interpretive "on saturation" paragraph, where it is clearly scoped as a Set 1 observation rather than a universal claim.

### 1.5 Parity-plot discussion shortened by roughly one-third

v1's parity discussion was embedded in §3.2 and ran three sentences with substantial re-explanation of the aggregation difference and an appendix cross-reference. In v2:

- Parity is pulled into its own Results subsection §3.3 (matching blueprint v3 row 5), making its scope cleanly bounded.
- The content is compressed to four sentences of body text plus a "what is uncertain" line. The appendix cross-reference is moved to the opening "what is compared" line. The aggregation-difference note is kept as a single technical sentence.
- The analysis document's parity paragraph in §3.3 is similarly compressed to a single paragraph.

### 1.6 Embedding subsection now has a positive oxide-specific payoff

v1's embedding subsection spent disproportionate space on what the subsection does **not** do and what belongs to the nitride/combined paper. In v2:

- The §5.3 analysis paragraph now opens with the positive oxide-specific statement ("oxides form a cohesive, locally pure region") and enumerates three concrete oxide-specific implications of the numbers: (i) negligible cross-family contamination in oxide neighbourhoods, (ii) oxide region is internally more coherent than nitride region, (iii) family label is recoverable at essentially ceiling level without supervision on that axis.
- A "What this adds to the oxide report" paragraph explicitly names this as "a real oxide-specific finding, not a handoff."
- The non-claims have been kept but trimmed to a single paragraph at the end, with a single-sentence forward-reference to the combined paper.
- The Results draft §3.5 mirrors this structure and uses the same three-implication framing.

### 1.7 Results structure now matches blueprint v3 rows 3–7

v1 had four Results subsections (zero-shot, fine-tuning+parity, scratch, embedding) plus a summary. v2 has five Results subsections (zero-shot, fine-tuning, parity, scratch, embedding) plus a summary. This matches the blueprint's subsection plan, makes FIX 4 easy to apply with a clearly bounded parity subsection, and produces a cleaner narrative sequence where scratch (§3.4) is visibly the anchor.

---

## 2. Decisions that trade off

### 2.1 Keeping the lighter N=10 flag language ("near-pretrained-checkpoint")

Canonical numbers v2 flags the oxide N=10 row as `zero_shot_checkpoint_at_low_N` — deliberately lighter than the nitride `effective_zero_shot_checkpoint` flag used at nitride N=10, 50, 100, 200. Both files now use phrasing consistent with the lighter flag: "near-pretrained-checkpoint view," "effectively the pretrained initialization." The alternative would be a stronger "this is not a fine-tuned result at all" framing, but that would over-read the flag relative to the canonical file. The phrasing in v2 is deliberate and, on the conservative side, preserves some ambiguity about the row's status.

### 2.2 Keeping the saturation framing soft

v2 consistently uses "flattening of the fine-tuning curve" and "convergence from above toward the zero-shot benchmark" rather than "saturation." With only six N values and no data above N = 1,000, a formal saturation claim is not supported. The softer phrasing does leave the report without a single compact term for the phenomenon; the trade-off is accuracy.

### 2.3 Retaining the "~25× the residual gap" rhetorical figure

The sentence "the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark" at N = 500 is kept in both documents because it is the cleanest single sentence that communicates FIX 3's core point. It is derived from the canonical numbers (0.2214 / 0.0088) and is not an invented ratio, but it does editorialize by choosing one data point for the comparison. A human reviewer should confirm they are comfortable with this rhetorical move.

---

## 3. Sentences still needing human confirmation

The following items are factually aligned with the evidence packets but involve interpretive judgment calls where a human reviewer's sign-off is appropriate before finalization.

1. **Analysis document §1, "Identity of the oxide paper" paragraph.** The sentence "It is neither a dramatic failure case nor a breakthrough result" is stylistically useful for framing the control-arm identity but editorializes the scientific weight of the paper. Reviewer should confirm the tone is appropriate for the final report.

2. **Analysis document §4.3 and Results draft §3.4 "What interpretation is justified" paragraphs.** The "roughly 25× the residual gap" figure is derived from canonical values (0.2214 eV/atom scratch-minus-fine-tune gap at N = 500, versus 0.0088 eV/atom fine-tune-minus-zero-shot gap at N = 500). The ratio is correct, but it is a rhetorical construction. Reviewer should confirm whether this framing should appear in the final manuscript or be reserved for internal analysis only.

3. **Analysis document §3.3 and Results draft §3.2 "on saturation" passages.** The word "saturation" is deliberately avoided in favour of "flattening." Reviewer should confirm this is the preferred final language. If a single-word term is desired for the Discussion section, candidates are "flattening," "diminishing-returns regime," or "convergence from above"; each has slightly different connotations.

4. **Results draft §3.4 heading.** The extended heading "Pretrained initialization dominates random initialization at both scratch-tested data sizes — the central on-oxide transfer-value result" uses the long form intentionally to signal centrality (FIX 3). If the final report uses a shorter heading style, this should be trimmed to "Pretrained initialization dominates random initialization at both scratch-tested data sizes," and the centrality signal can be moved to the transition paragraph only.

5. **Analysis document §5.3 and Results draft §3.5 three-implication framing.** The three oxide-specific implications ((i) negligible cross-family contamination; (ii) oxide region internally more coherent than nitride region; (iii) family label recoverable at essentially ceiling level without supervision) are consistent with the canonical embedding metrics but are interpretive packaging. Reviewer should confirm the packaging is appropriate for a standalone oxide report, especially item (ii) which compares against the nitride silhouette — if the oxide paper is strictly standalone, the comparison may need to be softened to "the oxide region is internally cohesive in absolute terms (silhouette 0.2546)" without the cross-family comparator.

6. **Analysis document §6 and Results draft §3.6 summary ordering.** Both summaries now begin with the scratch-gap result (item i) rather than the zero-shot benchmark (which was v1's item i). This is the intended FIX 3 change. Reviewer should confirm the re-ordered summary reads as intended, since this ordering defines how the reader leaves the Results section.

7. **Citation placeholders.** All `[CITE: …]` markers are placeholders with author-year hints. The citation set used is consistent with the project files but the specific references need final matching by a human reviewer during the manuscript's final pass. In particular, the ALIGNN citation in §3.1 (Choudhary & DeCost 2021) is used as the primary ALIGNN reference across both documents; if the project prefers a different primary ALIGNN citation (e.g., Choudhary 2025), a global find-and-replace is appropriate.

---

## 4. Items deliberately not changed

- **All measured values are preserved exactly as in v1.** No number has been added, changed, or removed. The embedding metric precision (e.g., 0.9872 for oxide 15-NN purity) is kept at the 4-decimal level used in v1, matching the source packets rather than the 3-decimal rounding used in canonical_numbers_v2.md prose.
- **The three-layer literature / implementation / findings discipline.** Both documents continue to separate these layers explicitly, in the analysis document via §x.1 / §x.2 / §x.3 subheadings and in the Results draft via the 5-step Results template (what is compared / what the evidence shows / what the pattern is consistent with / what interpretation is justified / what is uncertain).
- **The N = 10 lighter-flag language.** The lighter `zero_shot_checkpoint_at_low_N` framing is preserved consistent with the canonical numbers file's designation.
- **Scope guardrails on scratch.** Every mention of scratch comparison explicitly states that scratch baselines exist only at N = 50 and N = 500 and that other N are not in scope. This wording is unchanged from v1.
- **Embedding layer discipline.** `last_alignn_pool` is the only main-text embedding layer in both documents. `pre_head` and `last_gcn_pool` are not cited in either document's main body, consistent with canonical_numbers_v2.md's `appendix_support` visibility designation.
