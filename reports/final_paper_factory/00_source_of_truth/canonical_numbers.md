# Canonical Numbers

This file is the human-readable companion to `canonical_numbers.csv`. The CSV carries the authoritative full-precision rows and ambiguity flags.

## Source files used

- `reports/zero_shot/zero_shot_summary.csv`
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`

## Zero-shot

| family | n_test | mae_eV_per_atom | source_file_path |
|---|---|---|---|
| oxide | 1484 | 0.03418360680813096 | reports/zero_shot/zero_shot_summary.csv |
| nitride | 242 | 0.06954201496284854 | reports/zero_shot/zero_shot_summary.csv |

## Fine-tuning across N (Set 1)

| family | N | mean_test_mae | std_test_mae | transfer_gain_vs_zero_shot | mean_best_epoch |
|---|---|---|---|---|---|
| oxide | 10 | 0.04173159822912616 | 0.01111565197074509 | -0.007547991420995194 | 1.0 |
| oxide | 50 | 0.05229857842801289 | 0.014787255005441039 | -0.018114971619881924 | 18.5 |
| oxide | 100 | 0.04649868449619833 | 0.008637291877644603 | -0.012315077688067368 | 20.0 |
| oxide | 200 | 0.04570075810414355 | 0.00861267260326788 | -0.011517151296012586 | 39.0 |
| oxide | 500 | 0.042962743089354855 | 0.006232012753750299 | -0.008779136281223891 | 39.0 |
| oxide | 1000 | 0.04169220256934826 | 0.005333258733114451 | -0.007508595761217297 | 35.5 |
| nitride | 10 | 0.08741719760770394 | 0.01990570747172502 | -0.01787518264485541 | 1.0 |
| nitride | 50 | 0.1172923612154343 | 0.04506890822121626 | -0.04775034625258576 | 1.0 |
| nitride | 100 | 0.17224241466038237 | 0.09959653178355464 | -0.10270039969753383 | 1.0 |
| nitride | 200 | 0.13919243040563894 | 0.06768563446865479 | -0.06965041544279041 | 1.0 |
| nitride | 500 | 0.0976572126288675 | 0.01783679848489001 | -0.02811519766601897 | 40.5 |
| nitride | 1000 | 0.09065131140364843 | 0.013479532180190537 | -0.021109296440799896 | 45.0 |

## From-scratch at selected N (Set 1)

| family | N | mean_test_mae | std_test_mae | gain_vs_zero_shot |
|---|---|---|---|---|
| oxide | 50 | 0.5560532795358512 | 0.05234908833632355 | -0.5218696727277202 |
| oxide | 500 | 0.2643359895387973 | 0.022803815863399742 | -0.23015238273066632 |
| nitride | 50 | 0.6914345625279978 | 0.016308222994666725 | -0.6218925475651493 |
| nitride | 500 | 0.3682740165490257 | 0.023305927781258735 | -0.2987320015861772 |

## Direct transfer-benefit comparisons (Set 1)

| family | N | from_scratch_minus_finetune_mae | source_file_paths |
|---|---|---|---|
| oxide | 50 | 0.50375470110783831 | reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv; reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv |
| oxide | 500 | 0.221373246449442445 | reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv; reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv |
| nitride | 50 | 0.5741422013125635 | reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv; reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv |
| nitride | 500 | 0.2706168039201582 | reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv; reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv |

## Embedding family-separation summary metrics

| embedding_source | silhouette_score | davies_bouldin_index | knn_family_purity | logistic_regression_family_auc |
|---|---|---|---|---|
| pre_head | 0.1904993335658557 | 1.6936503655060886 | 0.9577056778679026 | 0.9976108796863514 |
| last_alignn_pool | 0.23924905439423452 | 1.8289881053584107 | 0.9655465430668212 | 0.9993623443451917 |
| last_gcn_pool | 0.1904993335658557 | 1.6936503655060886 | 0.9577056778679026 | 0.9973324274353434 |

## Embedding domain-shift summary metrics (oxide kNN5 distance)

| embedding_source | spearman_rho | spearman_q | hard_easy_mean_gap | hard_easy_mean_gap_q |
|---|---|---|---|---|
| pre_head | 0.4073794654707518 | 0.00012855857271415716 | 0.9471743398604149 | 0.00017998200179982003 |
| last_alignn_pool | 0.34276416031728496 | 0.00012855857271415716 | 0.8167619384662306 | 0.00017998200179982003 |
| last_gcn_pool | 0.4073794654707518 | 0.00012855857271415716 | 0.9471743398604149 | 0.00017998200179982003 |

## Ambiguity flags

- `CN_FT_S1_NITRIDE_N10_*`: `mean_best_epoch=1.0`; selected checkpoint is effectively the pretrained zero-shot state.
- `CN_TRANSFER_BENEFIT_*`: derived exactly from the Set 1 fine-tuning and from-scratch summary tables.
- `CN_EA_*PRE_HEAD*` and `CN_EA_*LAST_GCN_POOL*`: selected kNN5 domain-shift rows match exactly and 3 of 4 fixed-test family-separation metrics match, but fixed-test logistic AUC differs slightly (0.9976108796863514 vs 0.9973324274353434).

Robustness-only Set 2 and Set 3 numbers live in `robustness_numbers_appendix.csv`.
