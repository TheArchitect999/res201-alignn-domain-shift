# Week 2 Training Curves

These figures were generated from the saved `history_train.json` and `history_val.json` files for every completed Week 2 fine-tuning run in this namespace.

- results root: `results`
- run subdirectory: `finetune_last2_epochs100_bs32_lr5e5`

Each per-run figure contains:
- left panel: train and validation L1 loss curves
- right panel: train and validation relative error reduction from epoch 1

Files in this folder:
- one PNG and one PDF per fine-tuning run
- one grid figure per family for quick browsing
- `training_curve_manifest.csv` with file paths and run metadata

Family grid figures:
- oxide: `reports/week2_last2_epochs100_bs32_lr5e5/training_curves/oxide_training_curve_grid.png` and `reports/week2_last2_epochs100_bs32_lr5e5/training_curves/oxide_training_curve_grid.pdf`
- nitride: `reports/week2_last2_epochs100_bs32_lr5e5/training_curves/nitride_training_curve_grid.png` and `reports/week2_last2_epochs100_bs32_lr5e5/training_curves/nitride_training_curve_grid.pdf`
