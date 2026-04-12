# RES201 ALIGNN Domain Shift Workspace

This repository now carries the full shared RES201 workspace rather than a narrow
"dataset-only payload." A fresh clone is intended to give a collaborator the same
project materials, datasets, checkpoints, experiment outputs, and supporting docs
that exist in the main working folder.

## What Is Included

- canonical oxide and nitride family datasets under `data_shared/`
- the pretrained ALIGNN checkpoint and paired config under `jv_formation_energy_peratom_alignn/`
- zero-shot and fine-tuning outputs under `results/`
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
- `results/`: zero-shot predictions, fine-tuning outputs, dataset roots, and saved checkpoints
- `jv_formation_energy_peratom_alignn/`: pretrained checkpoint assets used by the training scripts
- `env/`: reproducible environment setup scripts
- `scripts/`: dataset, training, plotting, and inventory utilities
- `reports/`: report sources and generated summary artifacts

## Portable Archive

`res201_family_datasets_payload.zip` is a portability convenience artifact. It is a
named archive of the shared family-dataset payload so collaborators can move the
canonical dataset bundle around without relying on local cache state.
