# oxide_reference_pool Structure Embeddings

This folder contains structure embeddings extracted with the same local pretrained ALIGNN hook definitions used for the fixed test set.

Counts by family:
- `oxide`: 13507

Embedding matrices:
- `pre_head`: shape `[13507, 256]`
- `last_alignn_pool`: shape `[13507, 256]`
- `last_gcn_pool`: shape `[13507, 256]`

NPZ: `artifacts/embedding_analysis/embeddings/oxide_reference_pool/structure_embeddings.npz`
Metadata CSV: `artifacts/embedding_analysis/embeddings/oxide_reference_pool/structure_embedding_metadata.csv`
Manifest JSON: `artifacts/embedding_analysis/manifests/oxide_reference_pool_embedding_manifest.json`
