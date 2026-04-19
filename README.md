# RES201 ALIGNN Domain Shift Workspace

This repository now carries the full shared RES201 workspace rather than a narrow
"dataset-only payload." A fresh clone is intended to give a collaborator the same
project materials, datasets, checkpoints, experiment outputs, and supporting docs
that exist in the main working folder.

## What Is Included

- canonical oxide and nitride family datasets under `data_shared/`
- the pretrained ALIGNN checkpoint and paired config under `jv_formation_energy_peratom_alignn/`
- preserved zero-shot predictions and before-correction fine-tuning outputs under `Results_Before_Correction/`
- the canonical zero-shot summary table under `reports/zero_shot/`
- 5-seed professor-hyperparameter experiments under `Results_Hyperparameter_Set_1/`
- 5-seed ALIGNN-recommended experiments under `Results_Hyperparameter_Set_2/`
- 5-seed 100-epoch/batch-32/lr-5e-5 experiments under `Results_Hyperparameter_Set_3/`
- environment bootstrap scripts in `env/`
- experiment automation in `scripts/`
- reports, plots, inventories, and project reference PDFs
- a portable dataset archive named `res201_family_datasets_payload.zip`

## Collaboration Notes

- Generated cache files are intentionally not versioned. This includes ALIGNN/DGL
  LMDB folders (`id_prop.csv*_data/`, `*_lmdb/`, `*.mdb`) and local download or
  plotting caches under `cache/` and `artifacts/embedding_analysis/cache/`.
  They can be recreated from the canonical datasets, manifests, configs, and scripts
  when a workflow is rerun.
- Historical project documents still use the course timeline names "Stage 2" and
  "Stage 3". In this repo, those names mean:
  Stage 2 = dataset construction and validation.
  Stage 3 = training, fine-tuning, and checkpoint-based experiments.
- The most useful orientation doc for a new collaborator is
  `docs/WORKSPACE_ARTIFACT_GUIDE.md`.

## Key Directories

- `data_shared/`: frozen oxide/nitride dataset manifests, summaries, structures, diagnostics, and ALIGNN-ready exports
- `Results_Before_Correction/`: immutable pre-correction namespace, including zero-shot prediction CSVs, original fine-tuning runs, and the shared run-level `dataset_root/` directories inherited from the old `results/` tree
- `Results_Hyperparameter_Set_1/`: 5-seed professor-hyperparameter fine-tune and from-scratch runs
- `Results_Hyperparameter_Set_2/`: 5-seed ALIGNN-recommended fine-tune and from-scratch runs
- `Results_Hyperparameter_Set_3/`: 5-seed 100-epoch/batch-32/lr-5e-5 fine-tune and from-scratch runs split out from the old `results/` tree
- `configs_prof_advice/` and `configs_prof_advice_alignn_recommended/`: matching canonical configs for the imported namespaces
- `jv_formation_energy_peratom_alignn/`: pretrained checkpoint assets used by the training scripts
- `env/`: reproducible environment setup scripts
- `scripts/`: dataset, training, plotting, and inventory utilities
- `reports/`: baseline reports, imported canonical reports, the canonical zero-shot summary, and preserved provenance bundles

## Experiment Namespaces

The repository now keeps experiment families separated by both provenance and
hyperparameter set:

- `Results_Before_Correction/`
  Baseline namespace preserved from the pre-correction workflow. This includes the
  original `finetune_last2/` runs, zero-shot prediction CSVs, and shared run-level
  dataset roots. The canonical zero-shot MAE summary table lives at
  `reports/zero_shot/zero_shot_summary.csv`.
- `Results_Hyperparameter_Set_1/`
  Experiments using the professor hyperparameters:
  `epochs=50`, `batch_size=16`, `learning_rate=0.0001`.
- `Results_Hyperparameter_Set_2/`
  Experiments using ALIGNN-recommended hyperparameters:
  `epochs=300`, `batch_size=64`, `learning_rate=0.001`.
- `Results_Hyperparameter_Set_3/`
  Experiments using the low-learning-rate corrected setting:
  `epochs=100`, `batch_size=32`, `learning_rate=0.00005`.

Canonical imported report folders mirror the same split:

- `reports/week2_prof_advice/`
- `reports/week2_prof_advice_alignn_recommended/`
- `reports/week3_fromscratch_prof_advice/`
- `reports/week3_fromscratch_alignn_recommended/`

Original Colab-named report bundles are preserved under `reports/provenance/colab/`
for auditability and historical reference.

## Portable Archive

`res201_family_datasets_payload.zip` is a portability convenience artifact. It is a
named archive of the shared family-dataset payload so collaborators can move the
canonical dataset bundle around without relying on local cache state.
