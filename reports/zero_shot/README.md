# Zero-Shot Summary

This folder contains the single canonical zero-shot summary table for the repo:

- `zero_shot_summary.csv`

The full zero-shot prediction tables remain with the model-output artifacts:

- `Results_Before_Correction/oxide/zero_shot/predictions.csv`
- `Results_Before_Correction/nitride/zero_shot/predictions.csv`

Do not duplicate the summary table inside individual hyperparameter-set report
folders. Hyperparameter-set summaries should reference this canonical report
table when they need the baseline zero-shot MAE values.
