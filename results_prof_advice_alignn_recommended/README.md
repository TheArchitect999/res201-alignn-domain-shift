# `results_prof_advice_alignn_recommended`

This namespace contains the imported 5-seed experiment artifacts that use the
ALIGNN-recommended hyperparameters:

- `epochs = 300`
- `batch_size = 64`
- `learning_rate = 0.001`

What lives here:

- `dataset_root/` for each `oxide` and `nitride` run split
- `finetune_last2/` for the week-2 ALIGNN-recommended fine-tuning runs
- `train_alignn_fromscratch/` for the week-3 ALIGNN-recommended from-scratch runs

This tree is separate from both the preserved original `main` baseline in `results/`
and the professor-hyperparameter imports in `results_prof_advice/`.
