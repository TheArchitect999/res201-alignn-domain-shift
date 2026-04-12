# Workspace Artifact Guide

This note explains the major artifact groups in the RES201 workspace so a teammate
can tell which files are canonical inputs, which files are generated outputs, and
which names come from the course timeline.

## Stage Terms

The project documents use the course schedule language:

- Stage 2: build, validate, and freeze the oxide/nitride family datasets.
- Stage 3: run zero-shot and fine-tuning experiments using the pretrained ALIGNN checkpoint.

Those names are still valid inside the reports and historical scripts, but the
repository itself is no longer only a "Stage 2 payload." It is the shared working
workspace.

## Canonical Shared Assets

- `data_shared/`
  Contains the canonical oxide and nitride family datasets. This includes manifests,
  summaries, diagnostics, raw structure files, and ALIGNN-ready exports.
- `jv_formation_energy_peratom_alignn/`
  Contains the pretrained ALIGNN checkpoint (`checkpoint_300.pt`) and the config used
  to reconstruct the model architecture.
- `res201_family_datasets_payload.zip`
  Portable archive copy of the family-dataset payload for handoff or backup.

## Generated Experiment Assets

- `results/`
  Stores zero-shot outputs, fine-tuning runs, saved predictions, dataset roots, and
  model checkpoints.
- `id_prop.csvtrain_data/`, `id_prop.csvval_data/`, `id_prop.csvtest_data/`
  Root-level LMDB caches created by ALIGNN preprocessing.
- `results/*/*/finetune_last2/id_prop.csv*_data/`
  Per-run LMDB caches produced while preparing graph datasets for training.

## Why Some Large Files Use Git LFS

Several LMDB `data.mdb` files are larger than GitHub's standard per-file push limit.
To keep the full shared workspace publishable while preserving the files themselves,
`*.mdb` artifacts are stored through Git LFS.

## Files A New Collaborator Should Understand First

- `README.md`
- `docs/PROJECT_STATUS_SO_FAR.md`
- `docs/WORKSPACE_ARTIFACT_GUIDE.md`
- `scripts/shared/finetune_last2_alignn.py`
- `scripts/shared/run_week2_finetune_suite.py`

## Practical Rule Of Thumb

If a file lives under `data_shared/`, it is part of the canonical dataset story.
If it lives under `results/`, it is an experiment output or run-specific derivative.
If it lives under `jv_formation_energy_peratom_alignn/`, it is part of the pretrained
model payload needed for the current training workflow.
