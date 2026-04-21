# Phase 2 Patch Verification

Date: 2026-04-21
Scope: Verify the patched Phase 2 canonical number pack for semantic and operational safety before Phase 3 blueprinting.

## Passed checks

- `canonical_numbers_v2.csv` contains the full nitride low-N caveat extension. All 16 affected Set 1 nitride rows across `N=10`, `50`, `100`, and `200` now share the same `effective_zero_shot_checkpoint` flag and the same note: `mean_best_epoch=1.0; selected checkpoint is effectively the pretrained zero-shot state; does not represent meaningful fine-tuning adaptation`.
- The row types requested in check 1 are all covered at `N=50`, `100`, and `200`: `mean_test_mae`, `std_test_mae`, `transfer_gain_vs_zero_shot`, and `mean_best_epoch`.
- [canonical_numbers_v2.md](/abs/c:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md) now states the stronger interpretation explicitly: nitride fine-tuning is effectively inert for all `N <= 200` under the canonical setting, and meaningful adaptation begins only at `N=500` and `N=1000`.
- `CN_TRANSFER_BENEFIT_NITRIDE_N50` now carries the required semantic caveat in the CSV. Its `ambiguity_flag` is `derived_from_two_summary_tables|effective_zero_shot_at_N50`, and its note explicitly says the value reflects pretrained initialization / zero-shot-state advantage over from-scratch, not genuine adaptation benefit.
- All affected embedding rows were downgraded correctly. In `canonical_numbers_v2.csv`, all 8 `pre_head` embedding rows and all 8 `last_gcn_pool` embedding rows are `appendix_support`.
- `last_alignn_pool` remains the primary main-text embedding layer. All 8 `last_alignn_pool` embedding rows remain `main_text`, and the markdown plus claim map both identify it as the primary reporting layer.
- Canonical run-count rows now exist and are correct:
  - `CN_S1_FT_RUN_COUNT = 60`
  - `CN_S1_FS_RUN_COUNT = 20`
  These values were verified directly against `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv` and `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv`.
- `canonical_numbers_v2.md` explicitly documents the from-scratch coverage limit: only `N=50` and `N=500` exist for both families, and no from-scratch comparison exists at `N=10`, `100`, `200`, or `1000`.
- The optional oxide `N=10` caveat was added and is correctly lighter than the nitride case. The CSV uses `zero_shot_checkpoint_at_low_N`, and the note explicitly says oxide begins adapting at `N>=50`, which preserves the intended semantic distinction.
- No measured values were changed incorrectly. A full comparison of shared `number_id -> value` pairs between `canonical_numbers.csv` and `canonical_numbers_v2.csv` found zero value changes on common rows. The only new numeric rows are the two Set 1 run-count rows, and both match the source CSV row counts.
- Source-table spot checks match exactly for the nitride Set 1 fine-tuning rows (`N=10`, `50`, `100`, `200`, `500`, `1000`) and the nitride from-scratch rows (`N=50`, `500`).
- `claim_to_number_source_map_v2.csv` was updated coherently:
  - `CLM_04` now enumerates the nitride `mean_best_epoch` rows through `N=200` and states the inertness caveat explicitly.
  - `CLM_05` now documents the from-scratch coverage limit and the nitride `N=50` transfer-benefit caveat.
  - `CLM_08`, `CLM_09`, and `CLM_11` now encode the `last_alignn_pool` primary-layer policy and the appendix-only status of `pre_head` and `last_gcn_pool`.
  - `CLM_13` was added for the new Set 1 run counts.
- No result artifacts were edited or overwritten within the audited result-bearing paths. `git status --short` over `reports/zero_shot`, `reports/Hyperparameter Set 1`, `reports/week4_embedding_analysis`, `Results_Before_Correction`, and `Results_Hyperparameter_Set_1` shows no modified files there. Only the new source-of-truth patch files under `reports/final_paper_factory/00_source_of_truth/` appear as local changes.

## Failed checks

- None.

## Ambiguous checks

- `robustness_numbers_appendix_v2.csv` does not exist. This is not a failure because the file was explicitly optional, the Phase 2 patch scope was canonical Set 1 only, and `claim_to_number_source_map_v2.csv` continues to reference the unchanged `robustness_numbers_appendix.csv` where appropriate.

## Remaining issues before Phase 3

- None that block Phase 3 blueprinting.
- If a later appendix pass plans to discuss low-N nitride behavior in robustness Sets 2 or 3, mirror the same `effective_zero_shot_checkpoint` semantics there. The current omission is acceptable for Phase 3 because those rows remain appendix-only and are not part of the canonical main-text number pack.

## Final verdict

- ready for Phase 3
