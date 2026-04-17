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
  Stores the preserved baseline namespace from the original `main` branch. This is
  the only canonical home for baseline `zero_shot/` outputs and the original
  `results/*/finetune_last2/` tree.
- `results_prof_advice/`
  Imported 5-seed experiment namespace for professor-hyperparameter runs.
- `results_prof_advice_alignn_recommended/`
  Imported 5-seed experiment namespace for ALIGNN-recommended runs.
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
- `results_prof_advice/README.md`
- `results_prof_advice_alignn_recommended/README.md`

## Canonical Experiment Namespaces

| Namespace | Experiment type | Hyperparameters | Seeds covered | Canonical report folder |
| --- | --- | --- | --- | --- |
| `results/` | Baseline `main` experiments | Historical baseline values from the original `main` branch | Original baseline coverage only | `reports/week2/`, `reports/week3_fromscratch_baseline/` |
| `results_prof_advice/` | Fine-tune and from-scratch imported from Colab | `epochs=50`, `batch_size=16`, `learning_rate=0.0001` | Fine-tune: `0..4`; from-scratch (`N=50,500`): `0..4` | `reports/week2_prof_advice/`, `reports/week3_fromscratch_prof_advice/` |
| `results_prof_advice_alignn_recommended/` | Fine-tune and from-scratch imported from Colab | `epochs=300`, `batch_size=64`, `learning_rate=0.001` | Fine-tune: `0..4`; from-scratch (`N=50,500`): `0..4` | `reports/week2_prof_advice_alignn_recommended/`, `reports/week3_fromscratch_alignn_recommended/` |

## Config Layout

- `configs_prof_advice/week2_finetune/`
  Canonical imported configs for professor-hyperparameter week-2 fine-tuning.
- `configs_prof_advice/week3_fromscratch/`
  Canonical imported configs for professor-hyperparameter week-3 from-scratch runs.
- `configs_prof_advice_alignn_recommended/week2_finetune/`
  Canonical imported configs for ALIGNN-recommended week-2 fine-tuning.
- `configs_prof_advice_alignn_recommended/week3_fromscratch/`
  Canonical imported configs for ALIGNN-recommended week-3 from-scratch runs.

## Provenance Reports

- `reports/provenance/colab/`
  Frozen copies of the original Colab-named report bundles. These are kept for
  traceability and may contain historical absolute paths from Colab or local
  workstations.
- `reports/week2_seed34_last2_colab/` no longer exists as a top-level canonical
  report. Its preserved copy now lives under `reports/provenance/colab/`.

## Practical Rule Of Thumb

If a file lives under `data_shared/`, it is part of the canonical dataset story.
If it lives under `results/`, it belongs to the preserved original `main` baseline.
If it lives under `results_prof_advice*`, it belongs to one of the imported 5-seed
experiment namespaces.
If it lives under `jv_formation_energy_peratom_alignn/`, it is part of the pretrained
model payload needed for the current training workflow.
