# Canonical Numbers Audit — Phase 2

Auditor: Claude Code  
Date: 2026-04-21  
Files audited: `canonical_numbers.csv` (92 data rows), `canonical_numbers.md`, `claim_to_number_source_map.csv`, `robustness_numbers_appendix.csv` (124 data rows)

---

## Overall verdict

The pack is structurally sound. All primary numbers are present, all derivations are arithmetically exact, and the robustness appendix is cleanly separated from the main-text CSV. Three issues require fixes before Phase 3 may proceed: an incomplete `mean_best_epoch = 1.0` flag that covers only one of four affected nitride N values, a missing annotation on the nitride N=50 transfer-benefit number, and twelve rows of pre_head/last_gcn_pool embedding metrics that are marked main_text despite being near-duplicates of each other. Two smaller items are flagged for awareness.

---

## 1. Number accuracy spot-check

All numbers verified against source CSVs.

| Number | Canonical value | Source CSV value | Match |
|---|---|---|---|
| Oxide zero-shot MAE | 0.03418360680813096 | `reports/zero_shot/zero_shot_summary.csv` | ✓ |
| Nitride zero-shot MAE | 0.06954201496284854 | `reports/zero_shot/zero_shot_summary.csv` | ✓ |
| Oxide FT N=1000 mean MAE | 0.04169220256934826 | `finetune_summary_by_N.csv` | ✓ |
| Nitride FT N=10 mean MAE | 0.08741719760770394 | `finetune_summary_by_N.csv` | ✓ |
| Oxide FS N=50 mean MAE | 0.5560532795358512 | `fromscratch_summary.csv` | ✓ |
| Nitride FS N=50 mean MAE | 0.6914345625279978 | `fromscratch_summary.csv` | ✓ |
| Oxide transfer benefit N=50 (derived) | 0.50375470110783831 | computed: 0.5560532795358512 − 0.05229857842801289 | ✓ exact |
| Nitride transfer benefit N=50 (derived) | 0.5741422013125635 | computed: 0.6914345625279978 − 0.1172923612154343 | ✓ exact |

---

## 2. Missing numbers

### Issue 2A — Set 1 fine-tuning run count and seed count not in canonical pack (Important)

`canonical_numbers.csv` has no rows recording the number of seeds (5) or total fine-tuning runs (60) for Set 1. The robustness appendix records `RN_S2_FT_RUN_COUNT = 60` and `RN_S3_FT_RUN_COUNT = 60` for the comparison namespaces, but there is no `CN_S1_FT_RUN_COUNT` or `CN_S1_FS_RUN_COUNT`. Writers citing "5 seeds × 12 conditions = 60 fine-tuning runs" for Set 1 will have no number_id to anchor to.

**Action:** Add rows `CN_S1_FT_RUN_COUNT` (value=60) and `CN_S1_FS_RUN_COUNT` (value=20) to `canonical_numbers.csv`, sourced from `finetune_runs.csv` and `fromscratch_runs.csv` row counts.

### Issue 2B — From-scratch N-value coverage not documented (Polish)

`canonical_numbers.csv` includes from-scratch numbers only at N=50 and N=500. This is correct given that the from-scratch experiments were only run at those two N values. However, there is no annotation anywhere in the pack stating this limitation. Writers approaching from-scratch comparisons may expect N=10 or N=1000 from-scratch data that does not exist.

**Action:** Add a note to `canonical_numbers.md` stating explicitly that from-scratch experiments were run only at N=50 and N=500 for both families (20 total runs for Set 1), so no from-scratch N=10 or N=1000 comparison is possible.

---

## 3. Duplications under different names

### Issue 3A — pre_head / last_gcn_pool near-identity correctly flagged but visibility tier not adjusted (Important)

The `partial_embedding_duplicate_with_conflict` flag is correctly applied to all 12 pre_head and last_gcn_pool rows in both the family-separation and domain-shift sections. The flag wording is accurate. However, all 12 of these rows carry `paper_visibility = main_text`, the same tier as the non-duplicated `last_alignn_pool` rows.

The practical consequence: a writer reading the canonical numbers CSV sees three embedding layers as equally main-text, when the Phase 1 source-of-truth policy (CLM_11 in the claim map) has already said not to distinguish pre_head from last_gcn_pool. Including all three layers at main_text visibility risks producing redundant tables or figures.

**Action:** Change `paper_visibility` for all 12 pre_head and last_gcn_pool rows from `main_text` to `appendix_support`. This matches the intent of CLM_11 and does not discard the data — it signals to writers that these rows are supporting context rather than primary reported metrics. The 4 `last_alignn_pool` rows remain `main_text`.

Affected rows: `CN_EA_FIXED_TEST_PRE_HEAD_*` (4 rows), `CN_EA_FIXED_TEST_LAST_GCN_POOL_*` (4 rows), `CN_EA_KNN5_PRE_HEAD_*` (4 rows), `CN_EA_KNN5_LAST_GCN_POOL_*` (4 rows) — 16 rows total.

**No silent duplications found.** No number appears under two different IDs claiming to be independent measurements.

---

## 4. Unresolved ambiguities

### Issue 4A — CRITICAL: mean_best_epoch = 1.0 flag applied only to nitride N=10; nitride N=50, N=100, N=200 are unflagged

This is the most important finding in this audit.

From the source `finetune_summary_by_N.csv`:

| family | N | mean_best_epoch | Flag in canonical pack |
|---|---|---|---|
| nitride | 10 | 1.0 | `effective_zero_shot_checkpoint` ✓ |
| nitride | 50 | **1.0** | `none` ✗ |
| nitride | 100 | **1.0** | `none` ✗ |
| nitride | 200 | **1.0** | `none` ✗ |
| nitride | 500 | 40.5 | `none` ✓ |
| nitride | 1000 | 45.0 | `none` ✓ |

At N=50, N=100, and N=200 for nitride, early stopping selected epoch 1 on average across all five seeds, just as at N=10. The selected checkpoint is the pretrained zero-shot state with no meaningful weight updates in all four cases. Yet only N=10 carries the `effective_zero_shot_checkpoint` flag.

This means 12 unflagged rows carry values that share the same interpretation caveat as N=10:
- `CN_FT_S1_NITRIDE_N50_MEAN_TEST_MAE`, `_STD_TEST_MAE`, `_TRANSFER_GAIN_VS_ZERO_SHOT`, `_MEAN_BEST_EPOCH`
- `CN_FT_S1_NITRIDE_N100_MEAN_TEST_MAE`, `_STD_TEST_MAE`, `_TRANSFER_GAIN_VS_ZERO_SHOT`, `_MEAN_BEST_EPOCH`
- `CN_FT_S1_NITRIDE_N200_MEAN_TEST_MAE`, `_STD_TEST_MAE`, `_TRANSFER_GAIN_VS_ZERO_SHOT`, `_MEAN_BEST_EPOCH`

**Correct interpretation of the nitride fine-tuning curve:** Fine-tuning with 50-epoch training fails to improve on the pretrained zero-shot state for all N ≤ 200 for nitride. The model only begins to learn from fine-tuning data at N=500 (mean_best_epoch=40.5) and N=1000 (mean_best_epoch=45.0). This is a stronger and more interesting finding than "N=10 is problematic" — the domain-shift penalty is severe enough that nitride fine-tuning is effectively inert until N=500.

**Action required before Phase 3:** Apply `effective_zero_shot_checkpoint` ambiguity flag and the annotation text to all 12 affected rows.

### Issue 4B — Important: nitride transfer-benefit at N=50 conflates two effects

`CN_TRANSFER_BENEFIT_NITRIDE_N50 = 0.574 eV/atom` is derived as from_scratch_N50 − finetune_N50. The derivation is arithmetically exact. However, because `CN_FT_S1_NITRIDE_N50_MEAN_TEST_MAE` reflects a checkpoint at epoch 1 (effectively the pretrained zero-shot state, see Issue 4A), this "transfer benefit" figure is not measuring the benefit of fine-tuning over training from scratch. It is measuring the benefit of **pretraining** (zero-shot initialization) over training from scratch.

The canonical number itself is correct. The problem is that a writer could cite it as "fine-tuning over scratch provides a 0.574 eV/atom advantage at N=50 for nitride" when it actually measures "pretrained zero-shot initialization over scratch at N=50 for nitride." The same issue applies to `CN_TRANSFER_BENEFIT_NITRIDE_N100` and `CN_TRANSFER_BENEFIT_NITRIDE_N200` if those are added later.

**Action:** Add an `ambiguity_note` to `CN_TRANSFER_BENEFIT_NITRIDE_N50` stating that because `mean_best_epoch=1.0` for nitride N=50 fine-tuning, this gap measures the pretraining initialization advantage over from-scratch rather than the fine-tuning adaptation benefit.

### Issue 4C — Oxide N=10 mean_best_epoch = 1.0 not flagged (Polish)

Oxide N=10 also has `mean_best_epoch = 1.0`. Unlike the nitride case, oxide does recover and improve genuinely with more data at N≥50 (mean_best_epoch rises to 18.5 at N=50, 20.0 at N=100, and so on). The implication is less severe but the same basic caveat applies: the oxide N=10 "fine-tuned" result is the pretrained zero-shot checkpoint.

**Action:** Apply a lighter version of the flag to the four `CN_FT_S1_OXIDE_N10_*` rows. Use a distinct flag value such as `zero_shot_checkpoint_at_low_N` to distinguish it from the more severe nitride case where the flag extends to N=200.

---

## 5. Main-text vs appendix separation

### Separation between files — correct

`canonical_numbers.csv` contains 92 rows, all intended for main-text use.  
`robustness_numbers_appendix.csv` contains 124 rows across Set 2 (48 FT + 12 FS + 2 run-counts) and Set 3 (48 FT + 12 FS + 2 run-counts), all marked `paper_visibility = appendix`.  
The file-level split is clean. No main-text number leaked into the appendix file and vice versa.

### Within canonical_numbers.csv — pre_head and last_gcn_pool over-classified (see Issue 3A)

Within the single CSV, the 16 pre_head and last_gcn_pool rows are marked `main_text` despite being near-duplicates. This is the only within-file classification problem found. All other rows are correctly classified at the main_text tier.

### From-scratch coverage

From-scratch numbers in `canonical_numbers.csv` are limited to N=50 and N=500 for both families. This matches the experimental design (only 20 from-scratch runs in Set 1: 2 N × 2 families × 5 seeds). The robustness appendix correctly includes from-scratch for Set 2 and Set 3 at the same N values.

---

## 6. Claim-to-number mapping completeness

All numbered claims in `claim_support_map_v2.csv` that require numerical backing have mappings in `claim_to_number_source_map.csv`:

| Claim | Mapped | Notes |
|---|---|---|
| CLM_01 (dataset counts) | ✓ | CN_ZS_OXIDE_N_TEST; CN_ZS_NITRIDE_N_TEST |
| CLM_02 (zero-shot comparison) | ✓ | CN_ZS_OXIDE_MAE; CN_ZS_NITRIDE_MAE |
| CLM_03 (oxide FT never beats ZS) | ✓ | All oxide FT transfer-gain rows |
| CLM_04 (nitride FT never beats ZS) | ✓ | All nitride FT transfer-gain rows + N10 best-epoch caveat |
| CLM_05 (from-scratch worse than ZS) | ✓ | From-scratch gain rows + transfer-benefit rows |
| CLM_06 (Set 2/3 run counts) | ✓ | Robustness appendix run-count rows |
| CLM_07 (namespace sensitivity) | ✓ | Cross-namespace transfer-gain rows |
| CLM_08 (embedding separation) | ✓ | All family-separation metric rows |
| CLM_09 (distance-error correlation) | ✓ | All kNN5 domain-shift rows |
| CLM_11 (pre_head=last_gcn_pool) | ✓ | Mapped with guardrail flag |

**Gap:** CLM_04 maps to the N=10 best-epoch row but not to the N=50/100/200 best-epoch rows that carry the same caveat. After Issue 4A is resolved, the claim_to_number_source_map should be updated to reference the newly-flagged rows as well.

---

## Summary of findings

| # | Issue | Severity | Action required |
|---|---|---|---|
| 4A | nitride N=50/100/200 mean_best_epoch=1.0 not flagged | **Critical** | Apply `effective_zero_shot_checkpoint` flag to 12 rows |
| 4B | nitride N=50 transfer-benefit conflates FT with ZS initialization | **Important** | Add ambiguity_note to CN_TRANSFER_BENEFIT_NITRIDE_N50 |
| 3A | pre_head/last_gcn_pool rows marked main_text despite near-duplication | **Important** | Downgrade 16 rows to appendix_support |
| 2A | Set 1 run count / seed count missing | **Important** | Add CN_S1_FT_RUN_COUNT and CN_S1_FS_RUN_COUNT |
| 4C | Oxide N=10 mean_best_epoch=1.0 not flagged | Polish | Apply lighter flag to 4 oxide N=10 rows |
| 2B | From-scratch N-value limitation not documented | Polish | Add one-line note to canonical_numbers.md |

---

## Stop/Go assessment

**Do not proceed to Phase 3 until Issue 4A is resolved.** Issues 4A and 4B together mean that a writer building the nitride results section from the current canonical numbers could cite N=50, N=100, and N=200 fine-tuning results as genuine fine-tuning without being prompted by any flag in the pack. The resulting prose would misrepresent the experimental findings.

Issues 3A and 2A should be fixed in the same pass. Issues 4C and 2B may be deferred to a separate micro-patch.

**Proceed to Phase 3 only when:**
- `effective_zero_shot_checkpoint` flag is applied to all four affected nitride N values (N=10, 50, 100, 200)
- `CN_TRANSFER_BENEFIT_NITRIDE_N50` carries an ambiguity note about the FT vs ZS initialization distinction
- pre_head and last_gcn_pool rows are downgraded to `appendix_support`
- CN_S1_FT_RUN_COUNT and CN_S1_FS_RUN_COUNT are added
