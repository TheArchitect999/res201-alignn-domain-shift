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

- `Results_Before_Correction/`
  Stores the preserved pre-correction namespace. This is the canonical home for
  baseline zero-shot prediction CSVs, original `finetune_last2/` runs, and shared
  run-level `dataset_root/` directories. The single canonical zero-shot summary
  table lives at `reports/zero_shot/zero_shot_summary.csv`.
- `Results_Hyperparameter_Set_1/`
  5-seed experiment namespace for professor-hyperparameter runs.
- `Results_Hyperparameter_Set_2/`
  5-seed experiment namespace for ALIGNN-recommended runs.
- `Results_Hyperparameter_Set_3/`
  5-seed experiment namespace for the 100-epoch/batch-32/lr-5e-5 corrected runs
  split out from the old `results/` tree.
- `Results_*/*/*/finetune_last2/id_prop.csv*_data/`
  Per-run LMDB caches produced while preparing graph datasets for training. These
  are generated runtime artifacts and are intentionally not versioned.

Root-level `id_prop.csv*_data/` LMDB caches, `artifacts/embedding_analysis/cache/`,
and local download caches under `cache/` are intentionally not kept as canonical
repo assets. They are generated preprocessing/runtime caches and can be recreated
when needed.

## Cache Policy

LMDB cache files are not required to interpret the completed research results.
The durable research assets are the frozen datasets, run configs, split/id
manifests, predictions, histories, summaries, figures, reports, and scripts. Do
not commit `*.mdb`, `id_prop.csv*_data/`, `*_lmdb/`, `*_data_range`, or local
`cache/` contents.

## Files A New Collaborator Should Understand First

- `README.md`
- `docs/PROJECT_STATUS_SO_FAR.md`
- `docs/WORKSPACE_ARTIFACT_GUIDE.md`
- `Results_Before_Correction/README.md`
- `Results_Hyperparameter_Set_1/README.md`
- `Results_Hyperparameter_Set_2/README.md`
- `Results_Hyperparameter_Set_3/README.md`

## Canonical Experiment Namespaces

| Namespace | Experiment type | Hyperparameters | Seeds covered | Canonical report folder |
| --- | --- | --- | --- | --- |
| `Results_Before_Correction/` | Pre-correction baseline experiments | Historical values from the original before-correction workflow | Original baseline coverage plus canonical zero-shot prediction CSVs | `reports/week2/`, `reports/week3_fromscratch_baseline/` |
| `Results_Hyperparameter_Set_1/` | Fine-tune and from-scratch imported from Colab | `epochs=50`, `batch_size=16`, `learning_rate=0.0001` | Fine-tune: `0..4`; from-scratch (`N=50,500`): `0..4` | `reports/week2_prof_advice/`, `reports/week3_fromscratch_prof_advice/` |
| `Results_Hyperparameter_Set_2/` | Fine-tune and from-scratch imported from Colab | `epochs=300`, `batch_size=64`, `learning_rate=0.001` | Fine-tune: `0..4`; from-scratch (`N=50,500`): `0..4` | `reports/week2_prof_advice_alignn_recommended/`, `reports/week3_fromscratch_alignn_recommended/` |
| `Results_Hyperparameter_Set_3/` | Corrected low-learning-rate fine-tune and from-scratch runs | `epochs=100`, `batch_size=32`, `learning_rate=0.00005` | Fine-tune: `0..4`; from-scratch (`N=50,500`): `0..4` | `reports/Hyperparameter Set 3/` |

## Config Layout

- `configs/Hyperparameter_Set_1/week2_finetune/`
  Canonical imported configs for professor-hyperparameter week-2 fine-tuning.
- `configs/Hyperparameter_Set_1/week3_fromscratch/`
  Canonical imported configs for professor-hyperparameter week-3 from-scratch runs.
- `configs/Hyperparameter_Set_2/week2_finetune/`
  Canonical imported configs for ALIGNN-recommended week-2 fine-tuning.
- `configs/Hyperparameter_Set_2/week3_fromscratch/`
  Canonical imported configs for ALIGNN-recommended week-3 from-scratch runs.
- `configs/week2_last2_epochs100_bs32_lr5e5/`
  Canonical configs for `Results_Hyperparameter_Set_3` fine-tuning.
- `configs/week3_fromscratch_epochs100_bs32_lr5e5/`
  Canonical configs for `Results_Hyperparameter_Set_3` from-scratch runs.

## Provenance Reports

- `reports/provenance/colab/`
  Frozen copies of the original Colab-named report bundles. These are kept for
  traceability and may contain historical absolute paths from Colab or local
  workstations.
- `reports/week2_seed34_last2_colab/` no longer exists as a top-level canonical
  report. Its preserved copy now lives under `reports/provenance/colab/`.

## Practical Rule Of Thumb

If a file lives under `data_shared/`, it is part of the canonical dataset story.
If it lives under `Results_Before_Correction/`, it belongs to the pre-correction
baseline namespace. If it lives under `Results_Hyperparameter_Set_*/`, it belongs
to the matching hyperparameter set.
If it lives under `jv_formation_energy_peratom_alignn/`, it is part of the pretrained
model payload needed for the current training workflow.
