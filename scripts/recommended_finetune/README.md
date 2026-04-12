# Recommended Fine-Tuning (Separate Workflow)

This folder provides **separate** training/fine-tuning scripts so the original repository scripts remain unchanged for future use.

## Files
- `finetune_last2_alignn_recommended.py`
  - Copy of the fine-tuning script used only for this recommended-parameter workflow.
- `run_recommended_finetune_tests.py`
  - Generates recommended config files per run and executes fine-tuning into a separate results tree.

## Default behavior
- Families: `oxide nitride`
- N values: `500 1000`
- Seeds: `0`
- Recommended params applied:
  - `batch_size=64`
  - `epochs=300`
  - `learning_rate=1e-3`
  - `cutoff=8.0`
  - `alignn_layers=4`, `gcn_layers=4`, `atom_input_features=92`

## Example quick test
```bash
PYTHONPATH=alignn_references/alignn-main \
python scripts/recommended_finetune/run_recommended_finetune_tests.py \
  --epochs-override 1 \
  --output-root results_recommended_v2
```

## Example full run
```bash
PYTHONPATH=alignn_references/alignn-main \
python scripts/recommended_finetune/run_recommended_finetune_tests.py \
  --output-root results_recommended_v2
```
