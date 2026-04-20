# Configs

This folder is the canonical home for run configuration JSON files. Config
paths are organized to mirror the result namespaces where practical.

## Result Namespace Mapping

- `Hyperparameter_Set_1/`: configs for `Results_Hyperparameter_Set_1`.
  These use the professor hyperparameters: `epochs=50`, `batch_size=16`,
  `learning_rate=0.0001`.
- `Hyperparameter_Set_2/`: configs for `Results_Hyperparameter_Set_2`.
  These use the ALIGNN-recommended hyperparameters: `epochs=300`,
  `batch_size=64`, `learning_rate=0.001`.
- `Hyperparameter_Set_3/`: configs for `Results_Hyperparameter_Set_3`.
  These use the corrected low-learning-rate hyperparameters: `epochs=100`,
  `batch_size=32`, `learning_rate=0.00005`.

The remaining flat JSON files in this directory are historical before-correction
or early debugging configs. Keep them for provenance, but prefer the namespaced
folders above for current experiment navigation.

## Cache Note

The config JSON files are durable research inputs. The `id_prop.csv*_data/`
LMDB directories created beside training data are generated runtime caches and
should not be committed.
