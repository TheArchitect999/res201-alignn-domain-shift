# Cache Cleanup Summary

## Decision

The generated cache files are not necessary for the research record in GitHub.
The retained canonical assets are the frozen `data_shared/` datasets, run configs,
split/id manifests, histories, prediction CSVs, summaries, figures, reports, and
scripts.

## Deleted Cache Groups

| Category | Count | Rationale |
| --- | ---: | --- |
| `id_prop.csv*_data/` LMDB files and `*_data_range` markers | 2,490 | Generated ALIGNN/DGL graph caches; reproducible from retained structures, ids, configs, and scripts. |
| `artifacts/embedding_analysis/cache/` LMDB files | 4 | Temporary embedding-extraction LMDB caches; downstream embedding matrices, metadata, figures, and manifests are retained. |
| `cache/jarvis/jdft_3d-8-18-2021.json.zip` | 1 | Local JARVIS download cache; the frozen project datasets already live under `data_shared/`. |

Total cache/provenance-cache files deleted in this follow-up cleanup: 2,495.
This count includes the six root-level `id_prop.csv*_data/*.mdb` files already
marked for deletion by the earlier cleanup pass.

The path-level deletion list is recorded in
`reports/repo_cleanup/cache_deleted_files.csv`.

## Policy Update

- `.gitignore` now excludes `cache/`, `artifacts/embedding_analysis/cache/`,
  `*.mdb`, `id_prop.csv*_data/`, `id_prop.csv*_data_range`, `*_lmdb/`, and
  `*_lmdb_data_range`.
- `.gitattributes` was removed because LMDB caches should not be versioned through
  Git LFS or normal Git.
- Documentation now describes cache files as generated local artifacts rather
  than canonical results.

## What Was Preserved

No unique scientific results were removed. Model checkpoints, configs, frozen
datasets, prediction tables, summaries, reports, figures, and embedding-analysis
outputs remain in the repository.
