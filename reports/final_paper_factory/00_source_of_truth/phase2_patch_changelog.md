# Phase 2 Patch Changelog

**Date applied:** 2026-04-21
**Applied by:** Claude Code (audit/patch pass)
**Purpose:** Correct evidence semantics and visibility in the canonical number pack before Phase 3 blueprinting. No experimental result values were changed.

---

## Files created

| file | replaces |
|---|---|
| `canonical_numbers_v2.csv` | `canonical_numbers.csv` (v1 preserved, not overwritten) |
| `canonical_numbers_v2.md` | `canonical_numbers.md` (v1 preserved, not overwritten) |
| `claim_to_number_source_map_v2.csv` | `claim_to_number_source_map.csv` (v1 preserved, not overwritten) |
| `phase2_patch_changelog.md` | new file |

`robustness_numbers_appendix.csv` — **no changes required.** The fix-scope was limited to canonical Set 1 rows. The robustness appendix already correctly flags nitride N=10 rows across Sets 2 and 3 with `effective_zero_shot_checkpoint`; however, it does not flag N=50/100/200 there either. That is out of scope for this patch since those rows are appendix-only and will not drive main-text claims.

---

## FIX A — CRITICAL BLOCKER RESOLVED

**What changed:** Extended `effective_zero_shot_checkpoint` ambiguity flag from nitride N=10 only to nitride N=10, N=50, N=100, and N=200.

**Rows affected (canonical_numbers_v2.csv):**
- CN_FT_S1_NITRIDE_N50_MEAN_TEST_MAE
- CN_FT_S1_NITRIDE_N50_STD_TEST_MAE
- CN_FT_S1_NITRIDE_N50_TRANSFER_GAIN_VS_ZERO_SHOT
- CN_FT_S1_NITRIDE_N50_MEAN_BEST_EPOCH
- CN_FT_S1_NITRIDE_N100_MEAN_TEST_MAE
- CN_FT_S1_NITRIDE_N100_STD_TEST_MAE
- CN_FT_S1_NITRIDE_N100_TRANSFER_GAIN_VS_ZERO_SHOT
- CN_FT_S1_NITRIDE_N100_MEAN_BEST_EPOCH
- CN_FT_S1_NITRIDE_N200_MEAN_TEST_MAE
- CN_FT_S1_NITRIDE_N200_STD_TEST_MAE
- CN_FT_S1_NITRIDE_N200_TRANSFER_GAIN_VS_ZERO_SHOT
- CN_FT_S1_NITRIDE_N200_MEAN_BEST_EPOCH

**What was changed:** `ambiguity_flag` from `none` to `effective_zero_shot_checkpoint`; `ambiguity_note` from empty to: `mean_best_epoch=1.0; selected checkpoint is effectively the pretrained zero-shot state; does not represent meaningful fine-tuning adaptation`

**Why needed:** The v1 pack correctly flagged N=10, but N=50/100/200 also have mean_best_epoch=1.0 from the finetune_summary_by_N.csv source data. Any drafter reading v1 could treat the N=50/100/200 nitride fine-tuning rows as genuine adaptation results. This is scientifically incorrect and would cause overclaiming.

**Markdown update:** `canonical_numbers_v2.md` now contains an explicit block-level warning at the top of the Fine-tuning section stating that nitride fine-tuning is effectively inert for all N ≤ 200 under the canonical setting, and only begins adapting meaningfully at N=500 and N=1000.

**Claim map update:** CLM_04 updated to reference N=10 through N=200 explicitly.

**Severity resolved:** CRITICAL

---

## FIX B — IMPORTANT SEMANTIC CAVEAT APPLIED

**What changed:** Updated ambiguity flag and note for `CN_TRANSFER_BENEFIT_NITRIDE_N50`.

**Row affected:** CN_TRANSFER_BENEFIT_NITRIDE_N50

**What was changed:**
- `ambiguity_flag`: from `derived_from_two_summary_tables` to `derived_from_two_summary_tables|effective_zero_shot_at_N50`
- `ambiguity_note`: extended to include: `CAVEAT: nitride mean_best_epoch=1.0 at N=50; this value reflects the advantage of pretrained initialization / zero-shot state over from-scratch at N=50; not genuine fine-tuning adaptation benefit because no weight update occurred beyond epoch 1.`

**Why needed:** The transfer benefit value (0.574 eV/atom) is numerically correct as computed. However, without the caveat, a drafter would read this as "fine-tuning beats scratch by 0.574 eV/atom at N=50", which misrepresents the mechanism. The fine-tuning checkpoint at N=50 is the epoch-1 state, which is essentially the pretrained initialization. The benefit is therefore initialization quality vs random-weight training, not gradient-descent adaptation.

**Markdown update:** `canonical_numbers_v2.md` direct transfer-benefit section now contains an explicit paragraph-level caveat for the nitride N=50 row.

**Severity resolved:** IMPORTANT

---

## FIX C — IMPORTANT VISIBILITY CLEANUP APPLIED

**What changed:** Downgraded `pre_head` and `last_gcn_pool` embedding rows from `main_text` to `appendix_support` visibility.

**Rows affected:**
- CN_EA_FIXED_TEST_PRE_HEAD_SILHOUETTE
- CN_EA_FIXED_TEST_PRE_HEAD_DAVIES_BOULDIN
- CN_EA_FIXED_TEST_PRE_HEAD_KNN_PURITY
- CN_EA_FIXED_TEST_PRE_HEAD_LOGISTIC_AUC
- CN_EA_FIXED_TEST_LAST_GCN_POOL_SILHOUETTE
- CN_EA_FIXED_TEST_LAST_GCN_POOL_DAVIES_BOULDIN
- CN_EA_FIXED_TEST_LAST_GCN_POOL_KNN_PURITY
- CN_EA_FIXED_TEST_LAST_GCN_POOL_LOGISTIC_AUC
- CN_EA_KNN5_PRE_HEAD_SPEARMAN_RHO
- CN_EA_KNN5_PRE_HEAD_SPEARMAN_Q
- CN_EA_KNN5_PRE_HEAD_HARD_EASY_MEAN_GAP
- CN_EA_KNN5_PRE_HEAD_HARD_EASY_MEAN_GAP_Q
- CN_EA_KNN5_LAST_GCN_POOL_SPEARMAN_RHO
- CN_EA_KNN5_LAST_GCN_POOL_SPEARMAN_Q
- CN_EA_KNN5_LAST_GCN_POOL_HARD_EASY_MEAN_GAP
- CN_EA_KNN5_LAST_GCN_POOL_HARD_EASY_MEAN_GAP_Q

**What was changed:** `paper_visibility` from `main_text` to `appendix_support` for all 16 rows above. No numeric values changed. No rows deleted.

**`last_alignn_pool` rows remain `main_text` unchanged.**

**Why needed:** `pre_head` and `last_gcn_pool` are near-duplicates of each other. Presenting three equal-weight embedding layers in the main text would create false richness and obscure the primary result. `last_alignn_pool` is the most architecturally meaningful layer (output of the combined bond+angle graph processing) and should be the single primary main-text embedding anchor.

**Markdown update:** `canonical_numbers_v2.md` embedding sections now include a visibility note block making clear that `last_alignn_pool` is the primary main-text layer and the other two are appendix-level context.

**Claim map update:** CLM_08 and CLM_09 updated; CLM_11 updated.

**Severity resolved:** IMPORTANT

---

## FIX D — IMPORTANT COMPLETENESS FIX APPLIED

**What changed:** Added Set 1 canonical run-count rows.

**New rows added to canonical_numbers_v2.csv:**
- `CN_S1_FT_RUN_COUNT` = 60 (source: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv`, row count verified: 61 lines including header = 60 data rows)
- `CN_S1_FS_RUN_COUNT` = 20 (source: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv`, row count verified: 21 lines including header = 20 data rows)

**Why needed:** The v1 pack had run counts for robustness Sets 2 and 3 (in `robustness_numbers_appendix.csv`) but not for the canonical Set 1 namespace. The methods section of any report needs to state how many runs were conducted under the canonical setting. These numbers were missing from the canonical file.

**Markdown update:** `canonical_numbers_v2.md` now has a dedicated "Set 1 run counts" table before the fine-tuning section.

**Claim map update:** New CLM_13 added.

**Severity resolved:** IMPORTANT

---

## FIX E — SMALL DOCUMENTATION FIX APPLIED

**What changed:** Added explicit from-scratch coverage limitation note to the canonical markdown.

**Markdown update:** `canonical_numbers_v2.md` from-scratch section now contains a warning block stating: from-scratch experiments were run only at N=50 and N=500 for both families; no from-scratch comparison exists at N=10, N=100, N=200, or N=1000.

**Why needed:** Without this note, later drafters may attempt to describe transfer benefit at N=100 or N=200, or may compare fine-tuning to from-scratch at these sizes. No such comparison is possible from the available data.

**Claim map update:** CLM_05 note updated to include the from-scratch coverage limitation.

**Severity resolved:** POLISH / documentation

---

## FIX F — OPTIONAL LIGHT POLISH APPLIED

**What changed:** Added lighter `zero_shot_checkpoint_at_low_N` flag to oxide N=10 fine-tuning rows.

**Rows affected:**
- CN_FT_S1_OXIDE_N10_MEAN_TEST_MAE
- CN_FT_S1_OXIDE_N10_STD_TEST_MAE
- CN_FT_S1_OXIDE_N10_TRANSFER_GAIN_VS_ZERO_SHOT
- CN_FT_S1_OXIDE_N10_MEAN_BEST_EPOCH

**What was changed:** `ambiguity_flag` from `none` to `zero_shot_checkpoint_at_low_N`; note added: `mean_best_epoch=1.0 at N=10; oxide begins adapting at N>=50; this row reflects pretrained initialization advantage at very low data scale`

**Why needed / why lighter:** Oxide mean_best_epoch=1.0 at N=10, just like nitride. However, oxide resumes genuine adaptation at N=50 (mean_best_epoch=18.5), so the inertness is isolated to a single data-size point rather than a systematic pattern. The flag is intentionally lighter than the nitride flag to preserve the correct narrative distinction.

**Severity resolved:** POLISH

---

## Summary of strongest updated interpretations

1. **Nitride fine-tuning is effectively inert for all N ≤ 200 under the canonical 50-epoch setting.** The selected checkpoint at N=10, 50, 100, and 200 is the epoch-1 state, which is essentially the pretrained zero-shot initialization. No meaningful gradient-descent adaptation occurred at these data sizes under Set 1.

2. **Nitride only begins adapting meaningfully at N=500 and N=1000.** Mean best epochs of 40.5 and 45.0 at these sizes indicate genuine fine-tuning learning. These are the only nitride fine-tuning data points that can be described as adaptation results.

3. **The nitride N=50 transfer benefit (0.574 eV/atom) must be interpreted as pretrained-initialization advantage over scratch, not adaptation gain.** The fine-tuning state at N=50 is the pretrained zero-shot state. The comparison is initialization vs. random-weight training, not fine-tuned vs. random-weight training.

4. **For embedding analysis, `last_alignn_pool` is the single primary main-text reporting layer.** `pre_head` and `last_gcn_pool` are near-duplicates and carry `appendix_support` visibility only.

5. **From-scratch comparisons exist only at N=50 and N=500.** No transfer benefit calculation is possible at any other data size under the canonical namespace.

---

## Unresolved ambiguities before Phase 3

None of the issues above block Phase 3 blueprinting. The following items remain noted but are not critical for blueprint construction:

- The robustness appendix (Sets 2 and 3) does not flag nitride N=50/100/200 with `effective_zero_shot_checkpoint`. This is acceptable because those rows are appendix-only and no main-text claims will derive from them.
- The slight logistic AUC difference between `pre_head` (0.9976) and `last_gcn_pool` (0.9973) remains unresolved at source; the rows retain their `partial_embedding_duplicate_with_conflict` flag. This does not affect report drafting since both layers are now appendix_support.

---

## Phase 3 readiness verdict

**The canonical number pack v2 is safe for Phase 3 blueprinting.**

The critical blocker (nitride inertness extent) is fully resolved. All important semantic caveats are documented in both the CSV flags and the markdown. The primary embedding layer is clearly designated. Run counts are present. From-scratch coverage gaps are documented. No open ambiguity remains that would create a risk of overclaiming during blueprint construction or section drafting.
