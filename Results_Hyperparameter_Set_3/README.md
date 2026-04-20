# Results Hyperparameter Set 3

Canonical namespace for the corrected low-learning-rate hyperparameter setting split out from the old `results/` tree.

Hyperparameters:

- `epochs = 100`
- `batch_size = 32`
- `learning_rate = 0.00005`

Contents:

- `oxide/` and `nitride/`: family-specific run trees.
- `N*_seed*/finetune_last2_epochs100_bs32_lr5e5/`: corrected partial fine-tuning runs using `model.eval()` with `fc.train()` and `gcn_layers[3].train()`.
- `N*_seed*/train_alignn_fromscratch_epochs100_bs32_lr5e5/`: from-scratch comparison runs for `N=50` and `N=500`.

Expected coverage:

- Fine-tuning: 60 runs (`2` families x `6` N values x `5` seeds).
- From-scratch: 20 runs (`2` families x `2` N values x `5` seeds).

Primary report bundle: `reports/Hyperparameter Set 3/`.

Zero-shot baseline note:

Zero-shot summaries are not duplicated in this namespace. Use
`reports/zero_shot/zero_shot_summary.csv` for the canonical zero-shot MAE table
and `Results_Before_Correction/{oxide,nitride}/zero_shot/predictions.csv` for
the full prediction outputs.

Dataset-root note:

The existing Set 3 run artifacts were moved without duplicating the shared `dataset_root/` folders from the original `results/` tree. The historical materialized splits remain under `Results_Before_Correction/{oxide,nitride}/N*_seed*/dataset_root/`. The Set 3 runner scripts now target this namespace for future outputs and can recreate Set 3-local `dataset_root/` directories if reruns are requested.

Historical run logs and JSON files may still contain absolute paths from the machine or Colab session where they were created. Treat those as provenance strings; use this folder and the updated scripts as the canonical repo-relative namespace.
