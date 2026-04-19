# balanced_pool_set Structure Embeddings

This folder contains structure embeddings extracted with the same local pretrained ALIGNN hook definitions used for the fixed test set.

Counts by family:
- `oxide`: 2046
- `nitride`: 2046

Embedding matrices:
- `pre_head`: shape `[4092, 256]`
- `last_alignn_pool`: shape `[4092, 256]`
- `last_gcn_pool`: shape `[4092, 256]`

NPZ: `artifacts/embedding_analysis/embeddings/balanced_pool/structure_embeddings.npz`
Metadata CSV: `artifacts/embedding_analysis/embeddings/balanced_pool/structure_embedding_metadata.csv`
Manifest JSON: `artifacts/embedding_analysis/manifests/balanced_pool_embedding_manifest.json`
