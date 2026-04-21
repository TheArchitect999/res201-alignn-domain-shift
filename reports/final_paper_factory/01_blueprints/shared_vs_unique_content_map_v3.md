# Shared vs Unique Content Map (v3)

Purpose: Prevent the three report streams from collapsing into one another. This map records which evidence blocks are shared, which interpretations are unique, and which guardrails must travel with each reused block.

## Revision notes

**v2:** Initial shared-vs-unique map.

**v3 (current):**
- FIX D: From-scratch baselines and direct comparison blocks now carry an explicit scope constraint stating that FIG_TRANSFER_BENEFIT and all transfer-benefit claims are limited to N=50 and N=500.
- FIX E: Oxide embedding family-separation usage updated to include the brief bridge subsection (row 7 in the oxide blueprint). Oxide is no longer "usually omit".
- Other rows unchanged from v2 except for clarified guardrail language where helpful.

---

## Reuse rules

- Reuse the same canonical evidence objects across reports, but do not reuse the same narrative emphasis.
- Oxide standalone should sound like a control paper.
- Nitride standalone should sound like an out-of-distribution failure-and-interpretation paper.
- The combined paper should sound like a comparison-and-mechanism paper.
- Do not describe the pretrained checkpoint as "oxide-pretrained". Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model". Reserve "oxide-reference region" for embedding-distance contexts only.

---

## Content map

| Content Block | Shared Evidence Core | Oxide Standalone Use | Nitride Standalone Use | Combined Paper Use | Guardrail |
|---|---|---|---|---|---|
| Problem framing | Project brief framing plus the shared zero-shot baseline | Introduce oxide as the in-distribution control. No result numbers in Introduction. | Introduce nitride as the out-of-distribution test. No result numbers in Introduction. | Introduce the control-versus-shift design in one paragraph. No result numbers in Introduction. | Introductions must be result-free. Do not flatten the two families into interchangeable tasks. Do not use "oxide-pretrained" to describe the checkpoint. |
| Canonical setting and run counts | `CN_S1_FT_RUN_COUNT`, `CN_S1_FS_RUN_COUNT`, `CN_ZS_OXIDE_N_TEST`, `CN_ZS_NITRIDE_N_TEST` | Methods anchor only. | Methods anchor only. | Methods anchor for the whole paper. | Keep all reports tied to Set 1. |
| Zero-shot baseline | `TAB_ZS_SUMMARY`, `CN_ZS_OXIDE_MAE`, `CN_ZS_NITRIDE_MAE` | Results only (not Introduction). Use as the control benchmark. | Results only (not Introduction). Use as the domain-shift penalty benchmark. | Results only (not Introduction). Use as the opening direct comparison in Results I and Results III. | Zero-shot evidence must not appear in any Introduction. Keep anchored to `reports/zero_shot/` and `Results_Before_Correction/`. |
| Oxide fine-tuning | `TAB_S1_FT_SUMMARY_BY_N`, `FIG_S1_LC_OXIDE`, selected oxide parity plots | Main Results section (rows 3–5 of oxide blueprint). | Mention only as comparison context in Discussion, if needed. | Results I (rows 3–5) and Results III (rows 10–12 as comparison axis). | Keep the oxide N=10 checkpoint caveat lighter than the nitride story. Results III must use oxide FT evidence for comparison only, not re-explanation. |
| Nitride fine-tuning | `TAB_S1_FT_SUMMARY_BY_N`, `FIG_S1_LC_NITRIDE`, selected nitride parity plots | Mention only as contrast in Discussion. | Main Results section (rows 3–8 of nitride blueprint). | Results II (rows 6–9) and Results III (rows 10–12 as comparison axis). | Nitride N ≤ 200 must be written as inert fine-tuning, not successful adaptation. Results III must use nitride FT evidence for comparison only, not re-explanation. |
| From-scratch baselines | `TAB_S1_FS_SUMMARY`, comparison plots, transfer-benefit rows | Use to show pretraining value on the control task. Transfer-benefit limited to N=50 and N=500. | Use to show the difference between initialization advantage and real adaptation. Transfer-benefit limited to N=50 and N=500. | Results I, Results II, and Results III. Transfer-benefit claims and FIG_TRANSFER_BENEFIT limited to N=50 and N=500 because from-scratch baselines do not exist at other N. | Do not imply from-scratch comparisons exist outside N=50 and N=500 in any report stream. |
| Nitride N=50 transfer-benefit row | `CN_TRANSFER_BENEFIT_NITRIDE_N50` | Usually omit. If mentioned, carry the caveat. | Use with the caveat every time: initialization advantage over scratch, not adaptation gain. | Use in Results III only, always with the caveat. | This row is initialization advantage over scratch, not adaptation gain. Never describe it as a fine-tuning benefit without this explicit caveat. |
| Direct comparison block | `FIG_ZS_COMPARISON`, `FIG_TRANSFER_BENEFIT` (N=50 and N=500 only), oxide and nitride learning curves, `TAB_ZS_SUMMARY` | Keep brief and subordinated to the oxide control story. | Keep brief and subordinated to the nitride domain-shift story. | Full Results III section (rows 10–12). FIG_TRANSFER_BENEFIT scope is strictly N=50 and N=500. | Results III must compare, not replay. Do not let direct-comparison prose replace the standalone report identities. FIG_TRANSFER_BENEFIT must be scoped to N=50 and N=500 in all three streams. |
| Embedding family separation | `FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C`, `TAB_EA_FAMILY_SEPARATION` | Brief Results bridge (row 7 of oxide blueprint): 1–2 paragraphs acknowledging that analysis was conducted, confirming family separation, and forward-referencing combined paper Results IV. Do not build a standalone embedding argument. | Use as supporting mechanism context in Representational evidence act (row 7 of nitride blueprint). | Full Results IV section (row 13 of combined blueprint). | Use `last_alignn_pool` as the main-text embedding layer. Oxide bridge must stay short. Do not duplicate the full embedding block across reports. |
| Embedding distance-error link | `FIG_EA_6D`, `TAB_EA_DISTANCE_ERROR_STATS`, `CN_EA_KNN5_LAST_ALIGNN_POOL_*` | Omit from oxide standalone main text. Oxide embedding bridge (row 7) may reference that distance analysis was performed, but forward-reference the combined paper for the mechanism test. | Core interpretive evidence in Representational evidence act (row 8 of nitride blueprint). | Full Results IV section (row 14 of combined blueprint). | Do not claim causality from embedding distance alone. "Oxide-reference region" is acceptable terminology for distance-context only. |
| pre_head / last_gcn_pool embedding rows | `CN_EA_FIXED_TEST_PRE_HEAD_*`, `CN_EA_FIXED_TEST_LAST_GCN_POOL_*`, `CN_EA_KNN5_PRE_HEAD_*`, `CN_EA_KNN5_LAST_GCN_POOL_*` | Omit from main text in all three streams. | Mention only in appendix or robustness context. | Mention only as appendix-level support. | These rows are `appendix_support` visibility in canonical_numbers_v2.csv. They are not co-equal main-text evidence. |
| Discussion emphasis | Shared canonical numbers plus claim map v2 | Focus on what the control establishes. | Focus on domain shift and why low-N nitride fails to adapt. | Focus on the contrast and mechanism together. | Keep the three discussions distinct in title, emphasis, and closing message. |
