# Nitride Standalone Report Blueprint (v3)

Purpose: Structure the nitride report as the out-of-distribution test paper. The emphasis is the domain-shift penalty, inert low-N fine-tuning, the limited onset of adaptation at high N, and the embedding-based interpretation anchored to `last_alignn_pool`.

## Revision notes

**v2:** Results section split into two explicit acts — Behavioral evidence and Representational evidence. Subsection ordering inside each act unchanged from v1.

**v3 (current):**
- FIX A: Introduction row now contains no result tables or MAE values. Objective-driven framing replaces result-driven claim.
- FIX B: "oxide-pretrained representation" removed from Discussion main claim. Replaced with "pretrained formation-energy representation".
- FIX F: `writing_layer` column added to all rows.
- FIX G: Internal JSON context table replaced with manuscript-facing table label.
- FIX H: Wildcard `CN_FT_S1_NITRIDE_N*_...` references replaced with explicit N-enumerated notation distinguishing the inert regime (N≤200) from the adaptation regime (N=500, 1000).

---

## Report-level guardrails

- Nitride `N <= 200` must be written as inert fine-tuning, not successful adaptation.
- `CN_TRANSFER_BENEFIT_NITRIDE_N50` must always be framed as pretrained-initialization advantage over scratch, not adaptation gain. Keep this guardrail at subsection-heading level to prevent drift during writing.
- Use `last_alignn_pool` as the only primary main-text embedding layer.
- Do not imply from-scratch nitride comparisons exist outside `N=50` and `N=500`.
- The Introduction must contain only background, motivation, and objective framing. Do not place result tables or MAE values in the Introduction.
- Do not describe the pretrained checkpoint as "oxide-pretrained". Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model".

## Prose-drafting guardrails

These five rules apply when converting blueprint rows into actual prose.

1. **Keep the Introduction result-free in actual prose.** No MAE values, no result tables, no inline performance claims. Frame only the question, the approach, and the paper map.

2. **Treat subsection blueprint rows as the primary drafting source.** Draft from the row's Purpose, Main Claim, and Canonical Numbers. If a number is needed that is not in the row, escalate to `canonical_numbers_v2.csv` — do not pull values from source CSVs directly.

3. **Repeat the nitride N=50 caveat every time `CN_TRANSFER_BENEFIT_NITRIDE_N50` appears in text.** Required phrasing: "pretrained-initialization advantage over scratch, not fine-tuning adaptation". Do not omit or abbreviate this caveat even in passing references.

4. **Keep `last_alignn_pool` as the only main-text embedding layer.** If a draft sentence references `pre_head` or `last_gcn_pool` in the main body, move it to the appendix or a robustness note.

5. **Distinguish the Behavioral evidence act from the Representational evidence act clearly.** Rows 3–6 are behavioral (what the model does). Rows 7–8 are representational (why it does it). Do not let mechanism language from rows 7–8 bleed into the behavioral act, and do not let the behavioral act preview the Spearman result before row 8.

---

## Subsection plan

| # | Section Heading | Subsection Heading | Purpose | Figure(s) | Table(s) | Canonical Numbers Used | Main Claim | Mode | writing_layer |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Introduction | Nitride as the out-of-distribution test | Frame the research question: how does a pretrained formation-energy model behave when the test chemistry lies outside the effective pretraining distribution, and can fine-tuning overcome the resulting domain-shift penalty? Provide context → literature gap → objective → paper map. No result tables. No MAE values. | `FIG_SCHEMATIC` (optional) | none | `CN_ZS_NITRIDE_N_TEST` (dataset characterization only) | This report examines how a pretrained formation-energy ALIGNN model behaves when evaluated on nitrides — a family that lies outside the chemistry of the pretraining distribution — and asks whether fine-tuning can overcome the resulting domain-shift penalty. | descriptive | literature_context |
| 2 | Methods | Canonical scope and caveat policy | Anchor the report to Set 1, the nitride test-set size, the canonical run counts, and the low-N interpretation rules. State from-scratch coverage limitation explicitly (N=50 and N=500 only). | `FIG_SCHEMATIC` (optional) | `TAB_METHODS_DATASET_SPLITS` (evidence: family_summary.json; shows nitride family composition and test-set size), `TAB_METHODS_EXPERIMENT_SCOPE` (evidence: finetune_runs.csv, fromscratch_runs.csv; shows Set 1 run counts) | `CN_ZS_NITRIDE_N_TEST`, `CN_S1_FT_RUN_COUNT`, `CN_S1_FS_RUN_COUNT` | All nitride quantitative claims come from the brief-aligned Set 1 namespace, with explicit safeguards against overreading the low-N checkpoints. | descriptive | implementation_detail |
| 3 | Results — Behavioral evidence | Zero-shot domain-shift penalty | Establish the nitride starting point relative to the oxide control. This is the first quantitative evidence of chemical-family mismatch. | `FIG_ZS_COMPARISON` (if created) | `TAB_ZS_SUMMARY` | `CN_ZS_NITRIDE_MAE`, `CN_ZS_OXIDE_MAE` | Nitride zero-shot error is substantially worse than oxide zero-shot error, consistent with a domain-shift penalty at the pretrained model's initial evaluation. | comparative | experimental_finding |
| 4 | Results — Behavioral evidence | Fine-tuning inertness at N ≤ 200 | Show that the low-N nitride fine-tuning regime is operationally inert rather than adaptively successful. Explicitly flag mean_best_epoch=1.0 at N=10, 50, 100, and 200. Scope note: inertness flags apply to all four N values. | `FIG_S1_LC_NITRIDE`, `FIG_S1_PARITY_NITRIDE_N10` | `TAB_S1_FT_SUMMARY_BY_N` | `CN_FT_S1_NITRIDE_N10_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N10_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N50_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N50_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N100_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N100_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N200_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N200_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N10_TRANSFER_GAIN_VS_ZERO_SHOT` (effective_zero_shot), `CN_FT_S1_NITRIDE_N50_TRANSFER_GAIN_VS_ZERO_SHOT` (effective_zero_shot), `CN_FT_S1_NITRIDE_N100_TRANSFER_GAIN_VS_ZERO_SHOT` (effective_zero_shot), `CN_FT_S1_NITRIDE_N200_TRANSFER_GAIN_VS_ZERO_SHOT` (effective_zero_shot) | Nitride fine-tuning is effectively inert for all N ≤ 200 because the selected checkpoints are still the pretrained zero-shot state (mean_best_epoch=1.0 at all four sizes). | interpretive | experimental_finding |
| 5 | Results — Behavioral evidence | Meaningful adaptation begins only at N = 500 and 1000 | Isolate the first nitride data scales where real adaptation appears. Contrast these rows against the inertness evidence. Note that even these runs do not surpass nitride zero-shot. | `FIG_S1_LC_NITRIDE`, `FIG_S1_PARITY_NITRIDE_N1000` | `TAB_S1_FT_SUMMARY_BY_N` | `CN_FT_S1_NITRIDE_N500_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N500_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N500_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_NITRIDE_N1000_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N1000_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N1000_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_ZS_NITRIDE_MAE` | Nitride begins adapting meaningfully only at N=500 (mean_best_epoch=40.5) and N=1000 (mean_best_epoch=45.0), yet even these runs remain worse than nitride zero-shot. | interpretive | experimental_finding |
| 6 | Results — Behavioral evidence | From-scratch baselines and the N=50 initialization-advantage caveat | Quantify pretraining value while preserving the N=50 semantic guardrail at the subsection-heading level. Scope note: from-scratch comparison limited to N=50 and N=500. | `FIG_S1_COMP_NITRIDE` | `TAB_S1_FS_SUMMARY` | `CN_FS_S1_NITRIDE_N50_MEAN_TEST_MAE`, `CN_FS_S1_NITRIDE_N500_MEAN_TEST_MAE`, `CN_TRANSFER_BENEFIT_NITRIDE_N50`, `CN_TRANSFER_BENEFIT_NITRIDE_N500` | The nitride N=50 transfer gap reflects initialization advantage over scratch (not fine-tuning adaptation), while the nitride N=500 gap is the first clean comparison that includes real weight-update adaptation. | interpretive | comparison |
| 7 | Results — Representational evidence | Family separation in frozen pretrained embeddings | Show that the pretrained representation already separates oxide and nitride families in raw space before any nitride fine-tuning story is told. Use last_alignn_pool as the primary reported layer. | `FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C` | `TAB_EA_FAMILY_SEPARATION` | `CN_EA_FIXED_TEST_LAST_ALIGNN_POOL_SILHOUETTE`, `CN_EA_FIXED_TEST_LAST_ALIGNN_POOL_DAVIES_BOULDIN`, `CN_EA_FIXED_TEST_LAST_ALIGNN_POOL_KNN_PURITY`, `CN_EA_FIXED_TEST_LAST_ALIGNN_POOL_LOGISTIC_AUC` | Frozen last_alignn_pool embeddings already separate oxide and nitride families in raw pretrained space, supporting a distribution-shift interpretation of the behavioral differences. | interpretive | experimental_finding |
| 8 | Results — Representational evidence | Nitride error versus oxide-reference distance | Use the main embedding mechanism test to connect nitride error with distance from the oxide-reference region in pretrained space. | `FIG_EA_6D` | `TAB_EA_DISTANCE_ERROR_STATS` | `CN_EA_KNN5_LAST_ALIGNN_POOL_SPEARMAN_RHO`, `CN_EA_KNN5_LAST_ALIGNN_POOL_SPEARMAN_Q`, `CN_EA_KNN5_LAST_ALIGNN_POOL_HARD_EASY_MEAN_GAP`, `CN_EA_KNN5_LAST_ALIGNN_POOL_HARD_EASY_MEAN_GAP_Q` | Nitride prediction error increases with distance from the oxide-reference region in pretrained embedding space, consistent with a geometric account of domain-shift difficulty. | interpretive | interpretation |
| 9 | Discussion | Domain-shift explanation of nitride behavior | Synthesize the Behavioral and Representational evidence acts into the nitride narrative. Address: what the domain-shift penalty means, why low-N inertness is not just a data-quantity problem, and what the embedding distance evidence adds. | none | `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_DISTANCE_ERROR_STATS` | `CN_ZS_NITRIDE_MAE`, `CN_FT_S1_NITRIDE_N10_MEAN_BEST_EPOCH`, `CN_FT_S1_NITRIDE_N500_MEAN_BEST_EPOCH`, `CN_TRANSFER_BENEFIT_NITRIDE_N50`, `CN_TRANSFER_BENEFIT_NITRIDE_N500`, `CN_EA_KNN5_LAST_ALIGNN_POOL_SPEARMAN_RHO` | The nitride difficulty is best explained as domain shift acting on a pretrained formation-energy representation, not as a simple low-data problem. | interpretive | interpretation |
| 10 | Conclusion | Out-of-distribution takeaways | End with the nitride-specific conclusion that feeds directly into the combined paper. | none | none | `CN_ZS_NITRIDE_MAE`, `CN_FT_S1_NITRIDE_N500_MEAN_TEST_MAE`, `CN_FT_S1_NITRIDE_N1000_MEAN_TEST_MAE`, `CN_EA_KNN5_LAST_ALIGNN_POOL_SPEARMAN_RHO` | The nitride report closes by showing that the main challenge is out-of-distribution generalization, with only partial recovery at the largest fine-tuning scales and a geometric interpretation grounded in pretrained embedding distance. | interpretive | interpretation |
