# Week 4 Embedding Extraction Methods Notes

This phase extracts embeddings only. It does not retrain, fine-tune, download a model, or modify existing result folders.

## Model Source

- Checkpoint: `jv_formation_energy_peratom_alignn/checkpoint_300.pt`
- Config: `jv_formation_energy_peratom_alignn/config.json`
- Target: `formation_energy_peratom`

## Hook Points

### `pre_head`

- Layer name: `readout`
- Module path: `model.readout`
- Choice: Avg-pooled crystal-graph node representation produced by model.readout immediately before model.fc.

### `last_alignn_pool`

- Layer name: `alignn_layers.3`
- Module path: `model.alignn_layers[3]`
- Choice: Avg-pooled node tensor x returned by the last ALIGNNConv block, before the gated GCN stack.

### `last_gcn_pool`

- Layer name: `gcn_layers.3`
- Module path: `model.gcn_layers[3]`
- Choice: Avg-pooled node tensor x returned by the last EdgeGatedGraphConv GCN block. In this config it should match pre_head.

## Notes

- `pre_head` is the output of `model.readout`; for this config with `extra_features=0`, it is immediately before `model.fc`.
- `last_alignn_pool` pools the node tensor returned by the last ALIGNN block before the GCN stack.
- `last_gcn_pool` pools the node tensor returned by the last GCN block. In this model it is the nearest equivalent to, and should numerically match, `pre_head`.
- All pooling uses DGL `AvgPooling`, matching the model's own graph readout.
