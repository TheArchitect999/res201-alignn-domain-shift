# RES201 ALIGNN Domain Shift Repo Payload

This payload is only for **Stage 2: build the datasets correctly**.

It adds:
- a minimal **data-only** conda environment bootstrap
- the dataset builder and validator
- split manifest templates
- a short playbook

## Expected repo layout after extraction

- `env/` → environment bootstrap and verification
- `scripts/dataset/` → Stage 2 dataset scripts
- `manifests/` → optional official split manifest
- `data_shared/` → outputs will be written here

Do not use this for training yet. Training comes in a separate environment later.
