# Hyperparameter Set 3

- epochs: `100`
- batch size: `32`
- learning rate: `5e-05`

This folder groups the fine-tuning and from-scratch report artifacts for one hyperparameter family.

Subfolders:
- `Learning Curves`: aggregate test-MAE-vs-N plots for fine-tuning
- `Training Curves`: per-run epoch-history plots, split into `Finetuning` and `From Scratch`
- `Comparison Plots`: 5-seed fine-tune mean +/- std versus 5-seed from-scratch mean +/- std, plus zero-shot
- `Parity Plots`: true versus predicted formation-energy scatter plots by domain family and N
- `Summaries`: CSV, JSON, and LaTeX summary artifacts for both fine-tuning and from-scratch runs
