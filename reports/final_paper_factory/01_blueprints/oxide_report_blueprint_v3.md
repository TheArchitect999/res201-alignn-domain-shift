# Oxide Standalone Report Blueprint (v3)

Purpose: Structure the oxide report as the in-distribution control paper. The emphasis is strong zero-shot performance, smoother fine-tuning adaptation than nitride, and persistent pretraining advantage over from-scratch training.

## Revision notes

**v2:** Parity snapshots moved up after the fine-tuning trajectory subsection. From-scratch contrast moved to the closing Results move (establish baseline → FT behavior → scratch contrast).

**v3 (current):**
- FIX A: Introduction row now contains no result tables or MAE values. All result evidence moved to Results sections.
- FIX E: New light embedding bridge subsection added to Results (row 7) to satisfy the project-brief oxide Week 4 deliverable without duplicating the combined paper's full embedding block.
- FIX F: `writing_layer` column added to all rows.
- FIX G: Internal JSON context tables replaced with manuscript-facing table labels.
- FIX H: Wildcard `CN_FT_S1_OXIDE_N*_...` references replaced with explicit N-enumerated notation.
- FIX I: Subsection headings sharpened to be thesis-bearing.

---

## Report-level guardrails

- Keep oxide framed as the in-distribution control, not the headline failure case.
- Mention the oxide `N=10` checkpoint caveat (`zero_shot_checkpoint_at_low_N`) when that row appears, but keep it lighter than the nitride inertness story.
- Do not imply from-scratch comparisons exist outside `N=50` and `N=500`.
- Use nitride only as control-versus-shift context, not as the main narrative engine.
- The Introduction must contain only background, motivation, and objective framing. Do not place result tables or MAE values in the Introduction.
- Embedding analysis in this report is a brief bridge only (1–2 paragraphs in row 7). Detailed embedding evidence lives in the combined paper's Results IV.
- Do not describe the pretrained checkpoint as "oxide-pretrained". Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model".

## Prose-drafting guardrails

These five rules apply when converting blueprint rows into actual prose.

1. **Keep the Introduction result-free in actual prose.** No MAE values, no result tables, no inline performance claims. Frame only the question, the approach, and the paper map.

2. **Treat subsection blueprint rows as the primary drafting source.** Draft from the row's Purpose, Main Claim, and Canonical Numbers. If a number is needed that is not in the row, escalate to `canonical_numbers_v2.csv` — do not pull values from source CSVs directly.

3. **Keep the nitride N=50 caveat if it appears.** If `CN_TRANSFER_BENEFIT_NITRIDE_N50` is mentioned in any oxide discussion context, include the required phrasing: "pretrained-initialization advantage over scratch, not fine-tuning adaptation".

4. **Keep `last_alignn_pool` as the only main-text embedding layer.** Row 7 (the oxide embedding bridge) references family-separation evidence from `last_alignn_pool` only. Do not cite `pre_head` or `last_gcn_pool` in the main body.

5. **Keep the embedding bridge section short.** Row 7 is 1–2 paragraphs only. If the embedding bridge prose grows longer, it has overrun its scope — trim it back and forward-reference the combined paper.

---

## Subsection plan

| # | Section Heading | Subsection Heading | Purpose | Figure(s) | Table(s) | Canonical Numbers Used | Main Claim | Mode | writing_layer |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Introduction | Oxide as the in-distribution control | Frame the research question: how does a pretrained formation-energy model behave on a chemically familiar test regime, and what does that control behavior establish about pretraining value and data efficiency? Provide context → literature motivation → project objective → paper map. No result tables. No MAE values. | `FIG_SCHEMATIC` (optional) | none | `CN_ZS_OXIDE_N_TEST` (dataset characterization only) | This report examines how a pretrained formation-energy ALIGNN model adapts to an in-distribution oxide regime, establishing a control baseline for understanding pretraining value and data efficiency in materials property prediction. | descriptive | literature_context |
| 2 | Methods | Canonical dataset and experiment scope | Lock the report to Set 1, the oxide test-set size, and the canonical run counts. State the from-scratch coverage limitation (N=50 and N=500 only). | `FIG_SCHEMATIC` (optional) | `TAB_METHODS_DATASET_SPLITS` (evidence: family_summary.json; shows oxide family composition and test-set size), `TAB_METHODS_EXPERIMENT_SCOPE` (evidence: finetune_runs.csv, fromscratch_runs.csv; shows Set 1 run counts) | `CN_ZS_OXIDE_N_TEST`, `CN_S1_FT_RUN_COUNT`, `CN_S1_FS_RUN_COUNT` | All oxide quantitative claims in this report come from the brief-aligned Set 1 namespace plus the shared zero-shot baseline. | descriptive | implementation_detail |
| 3 | Results | Zero-shot performance establishes a strong control benchmark | Establish the oxide zero-shot starting point as the demanding control benchmark that all subsequent sections must interpret against. | none | `TAB_ZS_SUMMARY` | `CN_ZS_OXIDE_MAE` | Oxide zero-shot performance is already strong and sets a demanding in-distribution benchmark that fine-tuning must overcome to show additional value. | descriptive | experimental_finding |
| 4 | Results | Fine-tuning adapts smoothly once data exceeds the low-N checkpoint threshold | Show how oxide fine-tuning behaves across data scale, where genuine adaptation begins (N≥50), and that the N=10 checkpoint effect is mild and isolated. | `FIG_S1_LC_OXIDE` | `TAB_S1_FT_SUMMARY_BY_N` | `CN_FT_S1_OXIDE_N10_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N10_MEAN_BEST_EPOCH`, `CN_FT_S1_OXIDE_N50_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N50_MEAN_BEST_EPOCH`, `CN_FT_S1_OXIDE_N100_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N200_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N500_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N10_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N50_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N100_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N200_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N500_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N1000_TRANSFER_GAIN_VS_ZERO_SHOT` | Oxide adapts smoothly once data grows beyond the very-low-N checkpoint effect, but even the best oxide fine-tuning run does not beat oxide zero-shot. | interpretive | experimental_finding |
| 5 | Results | Error structure shifts with data scale: low-N ceiling versus high-N improvement | Use selected parity plots to show qualitative error structure at the smallest and largest fine-tuning scales, directly after the FT trajectory. | `FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_OXIDE_N1000` | `TAB_S1_FT_SUMMARY_BY_N` | `CN_FT_S1_OXIDE_N10_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N10_MEAN_BEST_EPOCH`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_ZS_OXIDE_MAE` | The oxide parity view improves markedly with data scale; the low-N checkpoint caveat and the zero-shot ceiling still bound the low-N result. | descriptive | experimental_finding |
| 6 | Results | Pretraining dominates from-scratch training at both available data sizes | Close Results with the scratch-versus-pretrained comparison that quantifies pretraining value on the control task. Scope note: comparison limited to N=50 and N=500 because from-scratch baselines do not exist at other N. | `FIG_S1_COMP_OXIDE` | `TAB_S1_FS_SUMMARY` | `CN_FS_S1_OXIDE_N50_MEAN_TEST_MAE`, `CN_FS_S1_OXIDE_N500_MEAN_TEST_MAE`, `CN_FS_S1_OXIDE_N50_GAIN_VS_ZERO_SHOT`, `CN_FS_S1_OXIDE_N500_GAIN_VS_ZERO_SHOT`, `CN_TRANSFER_BENEFIT_OXIDE_N50`, `CN_TRANSFER_BENEFIT_OXIDE_N500` | Pretraining gives oxide a large and stable advantage over from-scratch training at both available scratch data sizes. | comparative | comparison |
| 7 | Results | Oxide embedding context: family separation confirmed | Brief bridge (1–2 paragraphs). Acknowledge that oxide embeddings were extracted and analyzed as part of the project brief (Week 4). State that the pretrained representation separates oxide and nitride families in raw space. Forward-reference the combined paper's Results IV for the full embedding analysis. Do NOT build a standalone embedding argument here. | appendix reference only (e.g., `FIG_EA_6A` thumbnail or omit) | none in main text | none in main text (appendix_support embedding rows available if needed for appendix reference) | Oxide embedding analysis confirms family separation in pretrained space; the detailed distance-error mechanism is examined in the combined paper. | descriptive | experimental_finding |
| 8 | Discussion | Oxide as the stable control: what the in-distribution result confirms | Convert the oxide evidence into the control-side interpretation for the broader project. Address: what pretraining helps with, why in-distribution adaptation is smoother, and what zero-shot dominance implies. | none | `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY` | `CN_ZS_OXIDE_MAE`, `CN_FT_S1_OXIDE_N50_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N100_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N200_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N500_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_TRANSFER_BENEFIT_OXIDE_N50`, `CN_TRANSFER_BENEFIT_OXIDE_N500`, `CN_ZS_NITRIDE_MAE` | Oxide shows the expected in-distribution pattern: smoother adaptation than nitride and large pretraining value, even though zero-shot remains the performance ceiling at all tested data sizes. | interpretive | interpretation |
| 9 | Conclusion | Control-side takeaways for the broader study | End with the control result that the combined paper will later contrast against nitride. | none | none | `CN_ZS_OXIDE_MAE`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_TRANSFER_BENEFIT_OXIDE_N50`, `CN_TRANSFER_BENEFIT_OXIDE_N500` | The oxide report closes by showing that the control task is stable, learnable, and still dominated by the pretrained baseline — setting the reference point for the domain-shift comparison. | interpretive | interpretation |
