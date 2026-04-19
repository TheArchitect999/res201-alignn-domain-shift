# Week 4 Embedding Subset Design

This file defines the canonical metadata and row subsets to use before plotting or dimensionality reduction.

## Master Test Metadata

- Long embedding table: `artifacts/embedding_analysis/metadata/fixed_test_set_embedding_master.csv`
- Structure-level table: `artifacts/embedding_analysis/metadata/fixed_test_set_structure_master.csv`
- The long table has one row per structure per embedding source.
- The structure-level table has one row per fixed-test structure and records the shared NPZ row index plus available embedding sources.

## Named Subsets

- `fixed_test_set`: all oxide test structures plus all nitride test structures. Embeddings and prediction/error metadata are available.
- `balanced_pool_set`: all nitride train+val pool structures plus a random oxide train+val pool sample of equal size using seed `42`. This is the balanced visualization and separation-analysis subset.
- `oxide_reference_pool`: all oxide train+val pool structures. This is the oxide distance-to-manifold reference subset.

Pool subsets are metadata/subset manifests only at this stage. Their embeddings and pretrained predictions are intentionally blank until a later extraction step is run for pool data.

## Sampling Rule

The oxide side of `balanced_pool_set` is sampled with `random.Random(42).sample(...)` over the canonical oxide pool manifest row indices. The selected oxide rows are saved in canonical manifest order, and each row keeps its random draw rank in `sample_draw_rank`.

## Counts

| Subset | Family | Split | Count |
|---|---|---|---|
| `fixed_test_set` | `nitride` | `test` | 242 |
| `fixed_test_set` | `oxide` | `test` | 1484 |
| `fixed_test_set` | `nitride` | `all` | 242 |
| `fixed_test_set` | `oxide` | `all` | 1484 |
| `fixed_test_set` | `all` | `all` | 1726 |
| `balanced_pool_set` | `nitride` | `train` | 1837 |
| `balanced_pool_set` | `nitride` | `val` | 209 |
| `balanced_pool_set` | `oxide` | `train` | 1839 |
| `balanced_pool_set` | `oxide` | `val` | 207 |
| `balanced_pool_set` | `nitride` | `all` | 2046 |
| `balanced_pool_set` | `oxide` | `all` | 2046 |
| `balanced_pool_set` | `all` | `all` | 4092 |
| `oxide_reference_pool` | `oxide` | `train` | 11960 |
| `oxide_reference_pool` | `oxide` | `val` | 1547 |
| `oxide_reference_pool` | `oxide` | `all` | 13507 |
| `oxide_reference_pool` | `all` | `all` | 13507 |

## Output Files

| Subset | IDs | Metadata | Manifest |
|---|---|---|---|
| `fixed_test_set` | `artifacts/embedding_analysis/subsets/fixed_test_set/ids.csv` | `artifacts/embedding_analysis/subsets/fixed_test_set/metadata.csv` | `artifacts/embedding_analysis/subsets/fixed_test_set/manifest.json` |
| `balanced_pool_set` | `artifacts/embedding_analysis/subsets/balanced_pool_set/ids.csv` | `artifacts/embedding_analysis/subsets/balanced_pool_set/metadata.csv` | `artifacts/embedding_analysis/subsets/balanced_pool_set/manifest.json` |
| `oxide_reference_pool` | `artifacts/embedding_analysis/subsets/oxide_reference_pool/ids.csv` | `artifacts/embedding_analysis/subsets/oxide_reference_pool/metadata.csv` | `artifacts/embedding_analysis/subsets/oxide_reference_pool/manifest.json` |

Exact IDs are saved in each subset's `ids.csv` and `ids.json`.
