# Results Before Correction

Preserved pre-correction namespace from the original `results/` tree.

This folder exists to keep the early outputs separate from the corrected hyperparameter-set experiments. These runs predate the professor-advice training-mode correction that uses `model.eval()` with `fc.train()` and `gcn_layers[3].train()`.

Contents:

- `oxide/zero_shot/predictions.csv` and `nitride/zero_shot/predictions.csv`: canonical zero-shot prediction outputs used throughout the project.
- `oxide/N*_seed*/dataset_root/` and `nitride/N*_seed*/dataset_root/`: shared materialized run splits inherited from the original workspace.
- `oxide/N*_seed*/finetune_last2/` and `nitride/N*_seed*/finetune_last2/`: before-correction partial fine-tuning artifacts.
- `../configs/configs_before_correction/`: matching preserved run configs.

Expected coverage:

- Zero-shot predictions: 2 family-level prediction CSVs.
- Before-correction fine-tuning: 36 run summaries.
- Shared dataset roots: 60 run split roots.

Zero-shot summary note:

The single canonical zero-shot summary table lives in the reports tree at
`reports/zero_shot/zero_shot_summary.csv`. Summary JSON copies are intentionally
not kept in this results namespace.

Important distinction:

- Corrected Set 1 artifacts live under `Results_Hyperparameter_Set_1/`.
- Corrected Set 2 artifacts live under `Results_Hyperparameter_Set_2/`.
- Corrected Set 3 artifacts live under `Results_Hyperparameter_Set_3/`.

Historical run logs and JSON files may still contain absolute paths from the machine or Colab session where they were created. Treat those as provenance strings; use the repo-relative paths in this README and the current scripts for navigation.
