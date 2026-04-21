# Canonical Numbers v2

This file is the human-readable companion to `canonical_numbers_v2.csv`. The CSV carries the authoritative full-precision rows and ambiguity flags. **v2 incorporates all Phase 2 patch fixes (Fixes A–F). Do not draft from v1.**

## Source files used

- `reports/zero_shot/zero_shot_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv`
- `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`

---

## Zero-shot

| family | n_test | mae_eV_per_atom | source_file_path |
|---|---|---|---|
| oxide | 1484 | 0.03418360680813096 | reports/zero_shot/zero_shot_summary.csv |
| nitride | 242 | 0.06954201496284854 | reports/zero_shot/zero_shot_summary.csv |

---

## Set 1 run counts (canonical namespace)

| experiment_type | run_count | source_file |
|---|---|---|
| fine-tuning | 60 | reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv |
| from-scratch | 20 | reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv |

Row counts verified directly from source CSV files (header row excluded). Robustness Set 2 and Set 3 counts remain in `robustness_numbers_appendix.csv`.

---

## Fine-tuning across N (Set 1)

**IMPORTANT INTERPRETATION NOTE — NITRIDE FINE-TUNING INERTNESS:**
Nitride mean_best_epoch = 1.0 at N=10, 50, 100, and 200. This means the selected checkpoint at all four of these data sizes is effectively the pretrained zero-shot state. No meaningful weight adaptation occurred under the canonical 50-epoch / lr=1e-4 / batch=16 setting for N ≤ 200. Nitride fine-tuning only begins adapting meaningfully at N=500 (mean_best_epoch=40.5) and N=1000 (mean_best_epoch=45.0). All nitride fine-tuning rows for N ≤ 200 carry the `effective_zero_shot_checkpoint` flag in the CSV. Do NOT describe these as "fine-tuned performance" without this caveat.

**Light note — oxide N=10:**
Oxide mean_best_epoch = 1.0 at N=10 as well, but this is less severe because oxide begins adapting at N=50 (mean_best_epoch=18.5). Oxide N=10 rows carry a lighter `zero_shot_checkpoint_at_low_N` flag.

| family | N | mean_test_mae | std_test_mae | transfer_gain_vs_zero_shot | mean_best_epoch | flag |
|---|---|---|---|---|---|---|
| oxide | 10 | 0.04173159822912616 | 0.01111565197074509 | -0.007547991420995194 | 1.0 | zero_shot_checkpoint_at_low_N |
| oxide | 50 | 0.05229857842801289 | 0.014787255005441039 | -0.018114971619881924 | 18.5 | — |
| oxide | 100 | 0.04649868449619833 | 0.008637291877644603 | -0.012315077688067368 | 20.0 | — |
| oxide | 200 | 0.04570075810414355 | 0.00861267260326788 | -0.011517151296012586 | 39.0 | — |
| oxide | 500 | 0.042962743089354855 | 0.006232012753750299 | -0.008779136281223891 | 39.0 | — |
| oxide | 1000 | 0.04169220256934826 | 0.005333258733114451 | -0.007508595761217297 | 35.5 | — |
| nitride | 10 | 0.08741719760770394 | 0.01990570747172502 | -0.01787518264485541 | 1.0 | effective_zero_shot_checkpoint |
| nitride | 50 | 0.1172923612154343 | 0.04506890822121626 | -0.04775034625258576 | 1.0 | effective_zero_shot_checkpoint |
| nitride | 100 | 0.17224241466038237 | 0.09959653178355464 | -0.10270039969753383 | 1.0 | effective_zero_shot_checkpoint |
| nitride | 200 | 0.13919243040563894 | 0.06768563446865479 | -0.06965041544279041 | 1.0 | effective_zero_shot_checkpoint |
| nitride | 500 | 0.0976572126288675 | 0.01783679848489001 | -0.02811519766601897 | 40.5 | — |
| nitride | 1000 | 0.09065131140364843 | 0.013479532180190537 | -0.021109296440799896 | 45.0 | — |

---

## From-scratch at selected N (Set 1)

**Coverage limitation — IMPORTANT FOR DRAFTING:**
From-scratch experiments were run only at **N=50 and N=500** for both oxide and nitride under Set 1. No from-scratch comparison exists at N=10, N=100, N=200, or N=1000. Later drafting must not imply any transfer-benefit comparison at these missing data sizes.

| family | N | mean_test_mae | std_test_mae | gain_vs_zero_shot |
|---|---|---|---|---|
| oxide | 50 | 0.5560532795358512 | 0.05234908833632355 | -0.5218696727277202 |
| oxide | 500 | 0.2643359895387973 | 0.022803815863399742 | -0.23015238273066632 |
| nitride | 50 | 0.6914345625279978 | 0.016308222994666725 | -0.6218925475651493 |
| nitride | 500 | 0.3682740165490257 | 0.023305927781258735 | -0.2987320015861772 |

---

## Direct transfer-benefit comparisons (Set 1)

**IMPORTANT SEMANTIC CAVEAT — nitride N=50:**
The transfer benefit at nitride N=50 (0.574 eV/atom) is numerically correct, but it does NOT measure fine-tuning adaptation benefit over scratch. Because nitride mean_best_epoch = 1.0 at N=50, the fine-tuning checkpoint is effectively the pretrained zero-shot state. This value therefore reflects the advantage of pretrained initialization (zero-shot state) over training from scratch at N=50 — not genuine fine-tuning learning. Do not describe this as "fine-tuning outperforms scratch by 0.574 eV/atom" without the caveat.

The nitride N=500 transfer benefit (0.271 eV/atom) does reflect real fine-tuning adaptation, as mean_best_epoch = 40.5.

| family | N | from_scratch_minus_finetune_mae | flag | source_file_paths |
|---|---|---|---|---|
| oxide | 50 | 0.50375470110783831 | — | reports/Hyperparameter Set 1/Summaries/From Scratch/...; ...Finetuning/... |
| oxide | 500 | 0.221373246449442445 | — | reports/Hyperparameter Set 1/Summaries/From Scratch/...; ...Finetuning/... |
| nitride | 50 | 0.5741422013125635 | effective_zero_shot_at_N50 | reports/Hyperparameter Set 1/Summaries/From Scratch/...; ...Finetuning/... |
| nitride | 500 | 0.2706168039201582 | — | reports/Hyperparameter Set 1/Summaries/From Scratch/...; ...Finetuning/... |

---

## Embedding family-separation summary metrics

**Visibility note — primary reporting layer:**
`last_alignn_pool` is the **primary main-text embedding layer** for all embedding-related claims. `pre_head` and `last_gcn_pool` are near-duplicates of each other and are designated as `appendix_support` visibility in the CSV. They should not appear as equal-weight main-text rows. Use them for supporting context or robustness checks only.

| embedding_source | silhouette_score | davies_bouldin_index | knn_family_purity | logistic_regression_family_auc | paper_visibility |
|---|---|---|---|---|---|
| pre_head | 0.1904993335658557 | 1.6936503655060886 | 0.9577056778679026 | 0.9976108796863514 | **appendix_support** |
| last_alignn_pool | 0.23924905439423452 | 1.8289881053584107 | 0.9655465430668212 | 0.9993623443451917 | **main_text** |
| last_gcn_pool | 0.1904993335658557 | 1.6936503655060886 | 0.9577056778679026 | 0.9973324274353434 | **appendix_support** |

---

## Embedding domain-shift summary metrics (oxide kNN5 distance)

**Visibility note:** Same layering applies. `last_alignn_pool` rows are the primary main-text domain-shift numbers. `pre_head` and `last_gcn_pool` are appendix_support.

| embedding_source | spearman_rho | spearman_q | hard_easy_mean_gap | hard_easy_mean_gap_q | paper_visibility |
|---|---|---|---|---|---|
| pre_head | 0.4073794654707518 | 0.00012855857271415716 | 0.9471743398604149 | 0.00017998200179982003 | **appendix_support** |
| last_alignn_pool | 0.34276416031728496 | 0.00012855857271415716 | 0.8167619384662306 | 0.00017998200179982003 | **main_text** |
| last_gcn_pool | 0.4073794654707518 | 0.00012855857271415716 | 0.9471743398604149 | 0.00017998200179982003 | **appendix_support** |

---

## Ambiguity flags (v2 — updated)

- `CN_FT_S1_NITRIDE_N10_*` through `CN_FT_S1_NITRIDE_N200_*`: `effective_zero_shot_checkpoint` — mean_best_epoch=1.0 at all four data sizes; selected checkpoint is effectively the pretrained zero-shot state; does not represent meaningful fine-tuning adaptation. **(v2 extends this caveat from N=10 only to N=10, N=50, N=100, N=200.)**
- `CN_FT_S1_OXIDE_N10_*`: `zero_shot_checkpoint_at_low_N` — mean_best_epoch=1.0 at N=10 only; oxide begins adapting at N>=50; lighter flag.
- `CN_TRANSFER_BENEFIT_NITRIDE_N50`: `derived_from_two_summary_tables|effective_zero_shot_at_N50` — this value reflects pretrained initialization advantage over from-scratch, not genuine fine-tuning adaptation benefit, because mean_best_epoch=1.0 at N=50. **(v2 adds this semantic caveat.)**
- `CN_TRANSFER_BENEFIT_*` (other): derived exactly from the Set 1 fine-tuning and from-scratch summary tables.
- `CN_EA_*PRE_HEAD*` and `CN_EA_*LAST_GCN_POOL*`: `partial_embedding_duplicate_with_conflict`; visibility downgraded to `appendix_support` in v2. Selected kNN5 domain-shift rows match exactly and 3 of 4 fixed-test family-separation metrics match, but fixed-test logistic AUC differs slightly (0.9976 vs 0.9973).

Robustness-only Set 2 and Set 3 numbers live in `robustness_numbers_appendix.csv`.
