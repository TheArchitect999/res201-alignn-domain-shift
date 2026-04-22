# Oxide Methods Notes

Use this with `shared_methods_skeleton.md`. The oxide report should keep the shared protocol intact while foregrounding the oxide arm as the in-distribution control study.

## Oxide-specific scope

- Report identity: control-arm paper, not the domain-shift paper.
- Methods should be shared where possible, but the oxide version can compress nitride-specific embedding machinery.
- Do not present nitride behavior as evidence inside oxide Methods; only define the shared family-construction pipeline once.

## Recommended subsection order

1. Dataset source and oxide-family construction
2. Shared split protocol and oxide run-local sampling
3. Zero-shot oxide evaluation
4. Oxide fine-tuning and from-scratch training protocols
5. Main hyperparameter setting and metric
6. Brief embedding-analysis bridge or appendix-facing note

## Literature-Grounded Context Placeholders

### Dataset and model provenance

- "Crystal structures and formation-energy targets were drawn from the JARVIS repository/dataset. [CITE: JARVIS dataset/repository paper]"
- "All transfer experiments used a pretrained ALIGNN formation-energy model as the starting point. [CITE: ALIGNN foundational paper]"

### Oxide-control framing

- "This report treats oxide prediction as the in-distribution control arm of the study, allowing later comparison against a more challenging cross-family setting. [CITE: transfer/domain-shift context if used outside Introduction]"
- `TODO:` if the oxide standalone report keeps a short domain-shift framing sentence in Methods, confirm whether that sentence needs a literature citation or should remain purely study-design wording.

## Our Implementation Details

### Dataset source

- Oxide data were derived from `dft_3d_2021` with `formation_energy_peratom` as the target.
- The oxide family summary is stored in `data_shared/oxide/summaries/summary.json`.

### Family definitions and filtering

- Oxides are defined by the presence of `O`.
- Oxynitrides are retained in the oxide arm when oxygen is present.
- The oxide family summary records `499` oxynitrides inside the oxide subset.
- If nitride is mentioned at all in oxide Methods, keep it to one shared-definitions sentence: nitrides require `N` and no `O`.

### Split protocol

- Oxide split identities inherit the shared benchmark split mapping before family filtering.
- Oxide counts are:
  - all: `14991`
  - train: `11960`
  - val: `1547`
  - test: `1484`
  - pool: `13507`
- Run-local oxide subsets sample `N` structures from the oxide train+validation pool and reuse the fixed oxide test set unchanged.

### Zero-shot evaluation

- Evaluate the pretrained model on the fixed oxide test set from `data_shared/oxide/manifests/test.csv`.
- Zero-shot outputs should be cited from `reports/zero_shot/zero_shot_summary.csv` and `Results_Before_Correction/oxide/zero_shot/predictions.csv`.

### Fine-tuning protocol

- Fine-tuning uses the shared partial-update protocol:
  - load pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`
  - freeze all parameters
  - unfreeze only `gcn_layers.3` and `fc`
  - train with `AdamW`, `OneCycleLR`, and `L1Loss`
  - select the best checkpoint by validation `L1`
- Oxide fine-tuning covers `N = 10, 50, 100, 200, 500, 1000` with five seeds each.

### From-scratch protocol

- Oxide from-scratch training reuses the same dataset roots and config template but initializes all model weights randomly.
- Oxide from-scratch runs exist only at `N = 50` and `N = 500`, with five seeds each.

### Hyperparameter setting used for the main narrative

- The oxide report should explicitly anchor to Hyperparameter Set 1:
  - `epochs = 50`
  - `batch_size = 16`
  - `learning_rate = 1e-4`
- If more detail is needed, note that the shared config also uses `k-nearest` neighbors, `cutoff = 8.0`, `cutoff_extra = 3.0`, and `max_neighbors = 12`.

### Evaluation metric

- The primary reported metric is test MAE in `eV/atom`.
- `TODO:` confirm whether the oxide standalone report will present repeated-run values as `mean +/- SD` or use another dispersion convention.

### Embedding-analysis protocol

- Keep this short in the oxide standalone report.
- Safe methods-level wording:
  - embeddings were extracted from the frozen pretrained ALIGNN model
  - the main text, if it mentions an embedding layer, should prefer `last_alignn_pool`
  - quantitative raw-space analysis and nonlinear visualization details are part of the shared embedding workflow and can be forward-referenced to the combined paper or appendix
- Avoid reproducing the full nitride distance-to-oxide workflow here unless the final oxide blueprint expands that section.

## Our Experimental Setup

### Oxide experiment scope

| protocol | oxide conditions | seeds | notes |
|---|---|---:|---|
| zero-shot | fixed oxide test set (`n = 1484`) | not seed-varied | pretrained baseline |
| fine-tuning | `N = 10, 50, 100, 200, 500, 1000` | 5 | `30` total oxide runs |
| from scratch | `N = 50, 500` | 5 | `10` total oxide runs |

### Oxide run-local train/validation sizes

| sampled N | train | val |
|---|---:|---:|
| 10 | 5 | 5 |
| 50 | 45 | 5 |
| 100 | 90 | 10 |
| 200 | 180 | 20 |
| 500 | 450 | 50 |
| 1000 | 900 | 100 |

### Oxide-specific phrasing guidance

- Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model", not "oxide-pretrained model".
- Methods can mention nitride only to define the shared family-construction rule.
- Do not let the oxide Methods section become a comparison section; comparison belongs to Results or the combined paper.

## Oxide-Specific TODOs

- `TODO:` decide whether the oxide standalone Methods needs a one-sentence embedding bridge in the main text or only an appendix note.
- `TODO:` confirm whether the oxide Methods will include the oxide counts inline or push them entirely into `TAB_METHODS_DATASET_SPLITS`.
- `TODO:` if the final prose mentions the official split provenance explicitly, attach the confirmed citation placeholder rather than a bare "official split" claim.
