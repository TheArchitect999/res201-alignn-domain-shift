# `results_prof_advice`

This namespace contains the imported 5-seed experiment artifacts that use the
professor hyperparameters:

- `epochs = 50`
- `batch_size = 16`
- `learning_rate = 0.0001`

What lives here:

- `dataset_root/` for each `oxide` and `nitride` run split
- `finetune_last2/` for the week-2 professor-hyperparameter fine-tuning runs
- `train_alignn_fromscratch/` for the week-3 professor-hyperparameter from-scratch runs

This tree is intentionally separate from the preserved original `main` baseline in
`results/`. Nothing under `results/` should be interpreted as belonging to this
imported namespace.
