# RES201 ALIGNN Domain Shift Workspace

This repository now carries the full shared RES201 workspace rather than a narrow
"dataset-only payload." A fresh clone is intended to give a collaborator the same
project materials, datasets, checkpoints, experiment outputs, and supporting docs
that exist in the main working folder.

## What Is Included

- canonical oxide and nitride family datasets under `data_shared/`
- the pretrained ALIGNN checkpoint and paired config under `jv_formation_energy_peratom_alignn/`
- preserved baseline zero-shot and original fine-tuning outputs under `results/`
- imported 5-seed professor-hyperparameter experiments under `results_prof_advice/`
- imported 5-seed ALIGNN-recommended experiments under `results_prof_advice_alignn_recommended/`
- environment bootstrap scripts in `env/`
- experiment automation in `scripts/`
- reports, plots, inventories, and project reference PDFs
- a portable dataset archive named `res201_family_datasets_payload.zip`

## Collaboration Notes

- Large LMDB cache files (`*.mdb`) are versioned through Git LFS because several of
  them exceed GitHub's regular 100 MB per-file limit.
- Historical project documents still use the course timeline names "Stage 2" and
  "Stage 3". In this repo, those names mean:
  Stage 2 = dataset construction and validation.
  Stage 3 = training, fine-tuning, and checkpoint-based experiments.
- The most useful orientation doc for a new collaborator is
  `docs/WORKSPACE_ARTIFACT_GUIDE.md`.

## Key Directories

- `data_shared/`: frozen oxide/nitride dataset manifests, summaries, structures, diagnostics, and ALIGNN-ready exports
- `results/`: immutable baseline namespace from the original `main` branch, including zero-shot and the original fine-tuning/from-scratch artifacts
- `results_prof_advice/`: imported 5-seed professor-hyperparameter fine-tune and from-scratch runs
- `results_prof_advice_alignn_recommended/`: imported 5-seed ALIGNN-recommended fine-tune and from-scratch runs
- `configs_prof_advice/` and `configs_prof_advice_alignn_recommended/`: matching canonical configs for the imported namespaces
- `jv_formation_energy_peratom_alignn/`: pretrained checkpoint assets used by the training scripts
- `env/`: reproducible environment setup scripts
- `scripts/`: dataset, training, plotting, and inventory utilities
- `reports/`: baseline reports, imported canonical reports, and preserved provenance bundles

## Experiment Namespaces

The repository now keeps experiment families separated by both provenance and
hyperparameter set:

- `results/`
  Baseline namespace preserved from `main`. This includes the original
  `results/*/finetune_last2/` tree and the canonical `zero_shot/` results.
- `results_prof_advice/`
  Imported experiments using the professor hyperparameters:
  `epochs=50`, `batch_size=16`, `learning_rate=0.0001`.
- `results_prof_advice_alignn_recommended/`
  Imported experiments using ALIGNN-recommended hyperparameters:
  `epochs=300`, `batch_size=64`, `learning_rate=0.001`.

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
