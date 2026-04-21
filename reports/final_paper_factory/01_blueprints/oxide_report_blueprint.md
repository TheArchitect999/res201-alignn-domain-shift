# Oxide Standalone Report Blueprint (v2)

Purpose: Structure the oxide report as the in-distribution control paper. The emphasis is strong zero-shot performance, smoother fine-tuning adaptation than nitride, and persistent pretraining advantage over from-scratch training.

## Revision notes (v2)

- Parity snapshots moved up to sit directly after the fine-tuning trajectory subsection, so all FT-derived evidence is grouped together (quantitative curve → qualitative parity) before the scratch contrast.
- From-scratch contrast moved to the closing Results move, so Results now follow: establish baseline → show FT behavior → contrast with scratch. This is the canonical control-arm shape.

## Report-level guardrails

- Keep oxide framed as the in-distribution control, not the headline failure case.
- Mention the oxide `N=10` checkpoint caveat when that row appears, but keep it lighter than the nitride inertness story.
- Do not imply from-scratch comparisons exist outside `N=50` and `N=500`.
- Use nitride only as control-versus-shift context, not as the main narrative engine.

## Subsection plan

| # | Section Heading | Subsection Heading | Purpose | Figure(s) | Table(s) | Canonical Numbers Used | Main Claim | Mode |
|---|---|---|---|---|---|---|---|---|
| 1 | Introduction | Oxide as the in-distribution control | Frame why oxide is the control task and why its behavior anchors the rest of the project. | `FIG_SCHEMATIC` (optional if ready) | `TAB_ZS_SUMMARY` | `CN_ZS_OXIDE_N_TEST`, `CN_ZS_OXIDE_MAE`, `CN_ZS_NITRIDE_MAE` | Oxide is the control setting because pretrained ALIGNN starts much closer to the target regime on oxides than on nitrides. | descriptive |
| 2 | Methods | Canonical dataset and experiment scope | Lock the report to Set 1, the oxide test-set size, and the canonical run counts. | `FIG_SCHEMATIC` (optional if ready) | `TAB_CTX_OXIDE_SUMMARY_JSON`, `TAB_S1_FT_RUNS`, `TAB_S1_FS_RUNS` | `CN_ZS_OXIDE_N_TEST`, `CN_S1_FT_RUN_COUNT`, `CN_S1_FS_RUN_COUNT` | All oxide claims in this report come from the brief-aligned Set 1 namespace plus the shared zero-shot baseline. | descriptive |
| 3 | Results | Zero-shot control baseline | Establish the starting control benchmark before any fine-tuning or scratch comparison. | none | `TAB_ZS_SUMMARY` | `CN_ZS_OXIDE_MAE` | Oxide zero-shot performance is already strong and sets a demanding control benchmark for later sections. | descriptive |
| 4 | Results | Fine-tuning trajectory across N | Show how oxide fine-tuning behaves across data scale and where genuine adaptation begins. | `FIG_S1_LC_OXIDE` | `TAB_S1_FT_SUMMARY_BY_N` | `CN_FT_S1_OXIDE_N10_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N10_MEAN_BEST_EPOCH`, `CN_FT_S1_OXIDE_N50_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N100_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N200_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N500_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N*_TRANSFER_GAIN_VS_ZERO_SHOT` | Oxide adapts smoothly once data grows beyond the very-low-N checkpoint effect, but even the best oxide fine-tuning run does not beat oxide zero-shot. | interpretive |
| 5 | Results | Parity snapshots at low and high N | Use selected parity plots to show qualitative error structure at the smallest and largest fine-tuning scales, directly after the FT trajectory. | `FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_OXIDE_N1000` | `TAB_S1_FT_SUMMARY_BY_N` | `CN_FT_S1_OXIDE_N10_MEAN_TEST_MAE`, `CN_FT_S1_OXIDE_N10_MEAN_BEST_EPOCH`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_ZS_OXIDE_MAE` | The oxide parity view improves with data scale, but the low-N checkpoint caveat and the zero-shot ceiling still matter. | descriptive |
| 6 | Results | From-scratch contrast and pretraining value | Close Results with the scratch-versus-pretrained comparison that quantifies pretraining value on the control task. | `FIG_S1_COMP_OXIDE` | `TAB_S1_FS_SUMMARY` | `CN_FS_S1_OXIDE_N50_MEAN_TEST_MAE`, `CN_FS_S1_OXIDE_N500_MEAN_TEST_MAE`, `CN_FS_S1_OXIDE_N50_GAIN_VS_ZERO_SHOT`, `CN_FS_S1_OXIDE_N500_GAIN_VS_ZERO_SHOT`, `CN_TRANSFER_BENEFIT_OXIDE_N50`, `CN_TRANSFER_BENEFIT_OXIDE_N500` | Pretraining gives oxide a large and stable advantage over from-scratch training at both available scratch data sizes. | comparative |
| 7 | Discussion | What the oxide control establishes | Convert the oxide evidence into the control-side interpretation for the broader project. | none | `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY` | `CN_ZS_OXIDE_MAE`, `CN_FT_S1_OXIDE_N*_MEAN_TEST_MAE`, `CN_TRANSFER_BENEFIT_OXIDE_N50`, `CN_TRANSFER_BENEFIT_OXIDE_N500`, `CN_ZS_NITRIDE_MAE` | Oxide shows the expected in-distribution pattern: smoother adaptation than nitride and large pretraining value, even though zero-shot remains best. | interpretive |
| 8 | Conclusion | Control-side takeaways | End with the control result that the combined paper will later contrast against nitride. | none | none | `CN_ZS_OXIDE_MAE`, `CN_FT_S1_OXIDE_N1000_MEAN_TEST_MAE`, `CN_TRANSFER_BENEFIT_OXIDE_N50`, `CN_TRANSFER_BENEFIT_OXIDE_N500` | The oxide report should close by showing that the control task is stable, learnable, and still dominated by the pretrained baseline. | interpretive |
