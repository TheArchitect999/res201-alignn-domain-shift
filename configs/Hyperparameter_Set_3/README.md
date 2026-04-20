# `configs/Hyperparameter_Set_3`

Canonical configs for `Results_Hyperparameter_Set_3`, the corrected low-
learning-rate experiment namespace.

- `week2_finetune/`: configs matching `Results_Hyperparameter_Set_3/*/*/finetune_last2_epochs100_bs32_lr5e5/`
- `week3_fromscratch/`: configs matching `Results_Hyperparameter_Set_3/*/*/train_alignn_fromscratch_epochs100_bs32_lr5e5/`

These configs correspond to:

- `epochs = 100`
- `batch_size = 32`
- `learning_rate = 0.00005`

The result subdirectories keep the `epochs100_bs32_lr5e5` suffix for provenance,
but the config folders use the same clean workflow names as Sets 1 and 2.
