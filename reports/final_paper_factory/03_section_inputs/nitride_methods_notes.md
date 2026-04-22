# Nitride Methods Notes

Use this with `shared_methods_skeleton.md`. The nitride report should preserve the shared experimental pipeline but give full methodological space to the frozen-embedding analysis, because that report relies more heavily on representational evidence.

## Nitride-specific scope

- Report identity: out-of-distribution or cross-family transfer test paper.
- Methods should define the common data/model protocol without smuggling in nitride outcome claims.
- Keep the detailed nitride interpretation for Results and Discussion; Methods should explain only what was evaluated and how.

## Recommended subsection order

1. Dataset source and nitride-family construction
2. Shared split protocol and nitride run-local sampling
3. Zero-shot nitride evaluation
4. Fine-tuning and from-scratch training protocols
5. Main narrative hyperparameter setting and evaluation metric
6. Full frozen-embedding analysis protocol

## Literature-Grounded Context Placeholders

### Dataset and model provenance

- "Crystal structures and formation-energy targets were drawn from the JARVIS repository/dataset. [CITE: JARVIS dataset/repository paper]"
- "Predictions and transfer experiments were built on a pretrained ALIGNN formation-energy model. [CITE: ALIGNN foundational paper]"

### Nitride-study framing

- "The nitride arm was used as the cross-family test setting for transfer evaluation." Keep this as study-design wording unless a stronger literature-supported domain-shift sentence is needed.
- `TODO:` if the standalone nitride report explicitly calls nitrides "out of distribution" inside Methods, confirm whether that sentence should cite transfer-learning/domain-shift literature or stay as a design label tied to this study only.

## Our Implementation Details

### Dataset source

- Nitride data were derived from `dft_3d_2021` with `formation_energy_peratom` as the target.
- The nitride family summary is stored in `data_shared/nitride/summaries/summary.json`.

### Family definitions and filtering

- Nitrides are defined by the presence of `N` and the absence of `O`.
- Oxygen-containing nitrides are excluded from the nitride arm by construction.
- The nitride family summary records `0` oxynitrides.
- If the nitride Methods section mentions oxide, keep it as the shared counterpart definition: oxides are structures containing `O`.

### Split protocol

- Nitride split identities inherit the shared benchmark split mapping before family filtering.
- Nitride counts are:
  - all: `2288`
  - train: `1837`
  - val: `209`
  - test: `242`
  - pool: `2046`
- Run-local nitride subsets sample `N` structures from the nitride train+validation pool and reuse the fixed nitride test set unchanged.

### Zero-shot evaluation

- Evaluate the pretrained model on the fixed nitride test set from `data_shared/nitride/manifests/test.csv`.
- Zero-shot outputs should be cited from `reports/zero_shot/zero_shot_summary.csv` and `Results_Before_Correction/nitride/zero_shot/predictions.csv`.

### Fine-tuning protocol

- Fine-tuning uses the shared partial-update protocol:
  - load pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`
  - freeze all parameters
  - unfreeze only `gcn_layers.3` and `fc`
  - train with `AdamW`, `OneCycleLR`, and `L1Loss`
  - select the best checkpoint by validation `L1`
- Nitride fine-tuning covers `N = 10, 50, 100, 200, 500, 1000` with five seeds each.

### From-scratch protocol

- Nitride from-scratch training reuses the same dataset roots and config template but initializes all model weights randomly.
- Nitride from-scratch runs exist only at `N = 50` and `N = 500`, with five seeds each.

### Hyperparameter setting used for the main narrative

- The nitride report should explicitly anchor to Hyperparameter Set 1:
  - `epochs = 50`
  - `batch_size = 16`
  - `learning_rate = 1e-4`
- If the report expands the model-spec paragraph, reuse the shared config note on `k-nearest` neighbors, `cutoff = 8.0`, `cutoff_extra = 3.0`, and `max_neighbors = 12`.

### Evaluation metric

- The primary reported metric is test MAE in `eV/atom`.
- `TODO:` confirm whether the nitride standalone report will summarize repeated runs with `mean +/- SD` or another dispersion convention.

### Embedding-analysis protocol

- This report should include more of the shared embedding workflow than the oxide report.
- Key implementation details worth keeping in the nitride Methods section:
  - embeddings are extracted from the frozen pretrained ALIGNN model, not from fine-tuned checkpoints
  - the main text should prioritize `last_alignn_pool`
  - the fixed comparison subsets are `fixed_test_set`, `balanced_pool_set`, and `oxide_reference_pool`
  - family separation is quantified in raw embedding space
  - nitride difficulty is analyzed against distance from the oxide reference pool in raw embedding space
  - PCA, t-SNE, and UMAP are descriptive views; raw-space statistics are the inferential layer
- Include the hard/easy nitride definition because it is part of the nitride-specific embedding workflow:
  - hard nitrides: top `20%` of fixed-test nitrides by absolute zero-shot error
  - easy nitrides: bottom `20%`

## Our Experimental Setup

### Nitride experiment scope

| protocol | nitride conditions | seeds | notes |
|---|---|---:|---|
| zero-shot | fixed nitride test set (`n = 242`) | not seed-varied | pretrained baseline |
| fine-tuning | `N = 10, 50, 100, 200, 500, 1000` | 5 | `30` total nitride runs |
| from scratch | `N = 50, 500` | 5 | `10` total nitride runs |

### Nitride run-local train/validation sizes

| sampled N | train | val |
|---|---:|---:|
| 10 | 5 | 5 |
| 50 | 45 | 5 |
| 100 | 90 | 10 |
| 200 | 180 | 20 |
| 500 | 450 | 50 |
| 1000 | 900 | 100 |

### Embedding subset definitions worth naming explicitly in nitride Methods

| subset | definition | main role |
|---|---|---|
| `fixed_test_set` | all oxide test structures plus all nitride test structures | family-separation evaluation and nitride error metadata |
| `balanced_pool_set` | all nitride pool rows plus an equal-size random oxide pool sample with seed `42` | balanced visualization and family-separation subset |
| `oxide_reference_pool` | all oxide pool rows | distance-to-oxide reference manifold |

### Nitride-specific phrasing guidance

- Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model", not "oxide-pretrained model".
- Do not write low-`N` nitride behavior into Methods as if it were already an interpretation; just state the protocol scope.
- Keep the distance-to-oxide analysis procedural here and causal discussion out of Methods.

## Nitride-Specific TODOs

- `TODO:` decide how much of the PCA, t-SNE, and UMAP parameter detail stays in the nitride main-text Methods versus figure notes or appendix.
- `TODO:` decide whether `oxide_reference_pool` needs an explicit rationale sentence in Methods or whether the rationale should wait for Results IV / Discussion.
- `TODO:` if the nitride standalone report uses a longer domain-shift framing sentence in Methods, attach a confirmed citation instead of a generic placeholder.
