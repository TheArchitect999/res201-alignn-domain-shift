# Parity Plots

These parity plots compare ground-truth formation energy on the x-axis to predicted formation energy on the y-axis.

Each plot is built from `prediction_results_test_set.csv` outputs produced from the best validation checkpoint for each seed.

For each `{family, N, hyperparameter set}` combination, the plotted prediction is the mean test prediction across seeds `0..4`.

- Set 1: professor-advice fine-tuning (`epochs=50`, `batch_size=16`, `learning_rate=0.0001`)
- Set 2: ALIGNN-recommended fine-tuning (`epochs=300`, `batch_size=64`, `learning_rate=0.001`)
- Set 3: `epochs=100`, `batch_size=32`, `learning_rate=0.00005`

See `parity_plot_manifest.csv` for file paths and summary metrics.
