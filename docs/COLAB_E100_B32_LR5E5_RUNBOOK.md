# Colab Runbook: 100 Epoch / Batch 32 / LR 5e-5

This runbook describes the new non-destructive experiment entrypoints added for the updated hyperparameters:

- learning rate: `0.00005`
- epochs: `100`
- batch size: `32`

The new scripts do not overwrite existing experiment outputs on `main`. They write to fresh directories:

- fine-tune results: `results/<family>/N<N>_seed<seed>/finetune_last2_epochs100_bs32_lr5e5/`
- fine-tune configs: `configs/week2_last2_epochs100_bs32_lr5e5/`
- fine-tune reports: `reports/week2_last2_epochs100_bs32_lr5e5/`
- from-scratch results: `results/<family>/N<N>_seed<seed>/train_alignn_fromscratch_epochs100_bs32_lr5e5/`
- from-scratch configs: `configs/week3_fromscratch_epochs100_bs32_lr5e5/`
- from-scratch reports: `reports/week3_fromscratch_epochs100_bs32_lr5e5/`

The consolidated week-3 from-scratch report bundle on `main` was generated against zero-shot references only and is reproducible with:

```bash
python scripts/shared/summarize_week3_fromscratch_zero_shot_only.py \
  --repo-root . \
  --results-root results \
  --zero-shot-root results \
  --families oxide nitride \
  --Ns 50 500 \
  --seeds 0 1 2 3 4 \
  --run-subdir train_alignn_fromscratch_epochs100_bs32_lr5e5 \
  --out-dir reports/week3_fromscratch_epochs100_bs32_lr5e5
```

Fine-tuning uses the existing explicit partial-finetune trainer and keeps the intended mode control:

- `model.eval()`
- `model.fc.train()`
- `model.gcn_layers[3].train()`
- all other parameters frozen
- BatchNorm invariants checked so only `gcn_layers.3.*` BatchNorm state is allowed to update

## Colab commands

After bootstrapping the repo and checking out `main`, run:

```bash
bash scripts/shared/run_week2_finetune_pipeline_epochs100_bs32_lr5e5.sh .
```

and for from-scratch:

```bash
bash scripts/shared/run_week3_fromscratch_pipeline_epochs100_bs32_lr5e5.sh .
```

Both pipelines default to:

- `GIT_BRANCH=main`
- `PUSH_AFTER_RUN=1`
- `PUSH_FINAL_REPORTS=1`

To disable auto-push temporarily:

```bash
PUSH_AFTER_RUN=0 PUSH_FINAL_REPORTS=0 \
bash scripts/shared/run_week2_finetune_pipeline_epochs100_bs32_lr5e5.sh .
```

```bash
PUSH_AFTER_RUN=0 PUSH_FINAL_REPORTS=0 \
bash scripts/shared/run_week3_fromscratch_pipeline_epochs100_bs32_lr5e5.sh .
```
