# Tagged Week 2 Training Curves

These figures were generated from the saved `history_train.json` and `history_val.json` files for every completed tagged Week 2 fine-tuning run.

Important note:
This project is a regression task, not a classification task. That means there is no true training `accuracy` metric in the saved histories.
Instead, each per-run figure contains:
- left panel: train and validation L1 loss curves
- right panel: train and validation relative error reduction from epoch 1

Files in this folder:
- one PNG and one PDF per fine-tuning run
- one grid figure per family for quick browsing
- `training_curve_manifest.csv` with file paths and run metadata

Family grid figures:
- oxide: `/content/res201-alignn-domain-shift/reports/week2_alignn_defaults_colab_5seed/training_curves/oxide_training_curve_grid.png` and `/content/res201-alignn-domain-shift/reports/week2_alignn_defaults_colab_5seed/training_curves/oxide_training_curve_grid.pdf`
- nitride: `/content/res201-alignn-domain-shift/reports/week2_alignn_defaults_colab_5seed/training_curves/nitride_training_curve_grid.png` and `/content/res201-alignn-domain-shift/reports/week2_alignn_defaults_colab_5seed/training_curves/nitride_training_curve_grid.pdf`
