# Parity Plots

These parity plots compare ground-truth formation energy on the x-axis to predicted formation energy on the y-axis.

Each plot is built from `prediction_results_test_set.csv` outputs produced from the best validation checkpoint for each seed.

For Hyperparameter Set 2, the plotted prediction is the mean test prediction across seeds `0..4` for each `{family, N}` combination.

- epochs: `300`
- batch size: `64`
- learning rate: `0.001`

See `parity_plot_manifest.csv` for file paths and summary metrics.
