# Week 3 From-Scratch Baselines Execution Plan

Goal: complete and save four from-scratch baseline runs in the same artifact style as Week 2:

- oxide: `N=50`, `N=500`
- nitride: `N=50`, `N=500`
- seed: `0`

## Artifact conventions (matching existing methodology)

- Per-run root: `results/<family>/N<N>_seed0/`
- Reused deterministic data split: `dataset_root/` (do not change split manifests)
- From-scratch output subdir: `train_alignn_fromscratch/`
- Per-run outputs: `summary.json`, `history_train.json`, `history_val.json`, `prediction_results_test_set.csv`, model checkpoints
- Aggregate outputs: `reports/week3_fromscratch_baseline/`

## Hyperparameters

- epochs: `300`
- batch size: `64`
- learning rate: `0.001`
- device: `cuda`

## Execution sequence

1. GPU preflight and package check:

```bash
python scripts/shared/preflight_week3_fromscratch.py
```

2. Optional short smoke validation:

```bash
scripts/shared/run_week3_fromscratch_smoke.sh .
```

3. Full 4-run suite:

```bash
scripts/shared/run_week3_fromscratch_pipeline.sh .
```

4. Integrity verification only:

```bash
scripts/shared/check_week3_fromscratch_status.sh . train_alignn_fromscratch reports/week3_fromscratch_baseline
```

## Notes

- The suite uses `prepare_week1_finetune_dataset.py` only if `dataset_root/split_manifest.json` is missing.
- Historical Week 1 / Week 2 outputs are not overwritten.
- If CUDA is not available, preflight aborts immediately instead of silently switching to CPU.
