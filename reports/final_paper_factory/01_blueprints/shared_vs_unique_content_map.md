# Shared vs Unique Content Map

Purpose: Prevent the three report streams from collapsing into one another. This map records which evidence blocks are shared, which interpretations are unique, and which guardrails must travel with each reused block.

## Reuse rules

- Reuse the same canonical evidence objects across reports, but do not reuse the same narrative emphasis.
- Oxide standalone should sound like a control paper.
- Nitride standalone should sound like an out-of-distribution failure-and-interpretation paper.
- The combined paper should sound like a comparison-and-mechanism paper.

## Content map

| Content Block | Shared Evidence Core | Oxide Standalone Use | Nitride Standalone Use | Combined Paper Use | Guardrail |
|---|---|---|---|---|---|
| Problem framing | Project brief framing plus the shared zero-shot baseline | Introduce oxide as the in-distribution control. | Introduce nitride as the out-of-distribution test. | Introduce the control-versus-shift design in one paragraph. | Do not flatten the two families into interchangeable tasks. |
| Canonical setting and run counts | `CN_S1_FT_RUN_COUNT`, `CN_S1_FS_RUN_COUNT`, `CN_ZS_OXIDE_N_TEST`, `CN_ZS_NITRIDE_N_TEST` | Methods anchor only. | Methods anchor only. | Methods anchor for the whole paper. | Keep all reports tied to Set 1. |
| Zero-shot baseline | `TAB_ZS_SUMMARY`, `CN_ZS_OXIDE_MAE`, `CN_ZS_NITRIDE_MAE` | Use as the control benchmark. | Use as the domain-shift penalty benchmark. | Use as the opening direct comparison. | Keep zero-shot evidence anchored to `reports/zero_shot/` and `Results_Before_Correction/`. |
| Oxide fine-tuning | `TAB_S1_FT_SUMMARY_BY_N`, `FIG_S1_LC_OXIDE`, selected oxide parity plots | Main results section. | Mention only as comparison context in discussion, if needed. | Results I and Results III. | Keep the oxide `N=10` checkpoint caveat lighter than the nitride story. |
| Nitride fine-tuning | `TAB_S1_FT_SUMMARY_BY_N`, `FIG_S1_LC_NITRIDE`, selected nitride parity plots | Mention only as contrast in discussion. | Main results section. | Results II and Results III. | Nitride `N <= 200` must be written as inert fine-tuning, not successful adaptation. |
| From-scratch baselines | `TAB_S1_FS_SUMMARY`, comparison plots, transfer-benefit rows | Use to show pretraining value on the control task. | Use to show the difference between initialization advantage and real adaptation. | Results I, Results II, and Results III. | Do not imply from-scratch comparisons exist outside `N=50` and `N=500`. |
| Nitride `N=50` transfer-benefit row | `CN_TRANSFER_BENEFIT_NITRIDE_N50` | Usually omit. If mentioned, keep the caveat. | Use with the caveat every time. | Use in Results III only with the caveat. | This row is initialization advantage over scratch, not adaptation gain. |
| Direct comparison block | `FIG_ZS_COMPARISON`, `FIG_TRANSFER_BENEFIT`, oxide and nitride learning curves, `TAB_ZS_SUMMARY` | Keep brief and subordinated to the oxide control story. | Keep brief and subordinated to the nitride domain-shift story. | Full Results III section. | Do not let direct-comparison prose replace the standalone report identities. |
| Embedding family separation | `FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C`, `TAB_EA_FAMILY_SEPARATION` | Usually omit or mention only as forward link. | Use as supporting mechanism context. | Full Results IV section. | Use `last_alignn_pool` as the main-text embedding layer. |
| Embedding distance-error link | `FIG_EA_6D`, `TAB_EA_DISTANCE_ERROR_STATS`, `CN_EA_KNN5_LAST_ALIGNN_POOL_*` | Omit. | Core interpretive evidence. | Full Results IV section. | Do not claim causality from distance alone. |
| pre_head / last_gcn_pool embedding rows | `CN_EA_FIXED_TEST_PRE_HEAD_*`, `CN_EA_FIXED_TEST_LAST_GCN_POOL_*`, `CN_EA_KNN5_PRE_HEAD_*`, `CN_EA_KNN5_LAST_GCN_POOL_*` | Omit from main text. | Mention only in appendix or robustness context. | Mention only as appendix-level support. | These rows are `appendix_support`, not co-equal main-text evidence. |
| Discussion emphasis | Shared canonical numbers plus claim map v2 | Focus on what the control establishes. | Focus on domain shift and why low-N nitride fails to adapt. | Focus on the contrast and mechanism together. | Keep the three discussions distinct in title, emphasis, and closing message. |
