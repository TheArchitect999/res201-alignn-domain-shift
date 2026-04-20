# `configs/configs_before_correction`

Preserved configs for `Results_Before_Correction` and early Week 1 debugging
runs.

Contents:

- `*_week1_*.json`: early single-run debug and baseline configs.
- `*_week2_*.finetune_last2.json`: three-seed before-correction fine-tuning
  configs for oxide and nitride across the original training sizes.

These files predate the corrected hyperparameter-set namespaces. Keep them for
provenance and for reproducing the preserved before-correction outputs. Current
experiments should use `configs/Hyperparameter_Set_1/`,
`configs/Hyperparameter_Set_2/`, or `configs/Hyperparameter_Set_3/`.
