# Oxide Methods Notes v2

**Status: CLOSED FOR PROSE DRAFTING — Phase 6 closure pass applied 2026-04-22.**
Supersedes `oxide_methods_notes.md`. Use with `shared_methods_skeleton_v2.md`.

The oxide report treats oxide prediction as the in-distribution control arm of the study. Methods should be shared where possible, with nitride-specific embedding machinery compressed to a short bridge note or forward reference.

---

## Oxide-specific scope

- Report identity: control-arm paper, not the domain-shift paper.
- Shared protocol intact; nitride details minimal.
- Do not present nitride behavior as evidence inside oxide Methods; only define the shared family-construction pipeline once.
- Oxide Methods must match `oxide_report_blueprint_v3.md` row 2 (Set 1, oxide test-set size, canonical run counts, from-scratch coverage limitation).
- Do not call the pretrained checkpoint "oxide-pretrained". Use "pretrained formation-energy ALIGNN model".

## Frozen decisions (oxide-specific)

| Decision | Frozen value |
|---|---|
| Repeated-run convention | Mean ± SD (five random seeds) |
| Oxynitride treatment in prose | One brief parenthetical on first mention; no separate definition subsection |
| Train/val counts in Methods | Reference TAB_METHODS_DATASET_SPLITS_v1; do not repeat inline prose |
| Embedding machinery in main text | Short bridge sentence (1–2 sentences); appendix-facing note via `embedding_methods_appendix_notes_v1.md` |
| Domain-shift framing in Methods | Study-design wording only; no literature citation required unless explicitly confirmed |

---

## Recommended subsection order

1. Dataset source and oxide-family construction
2. Shared split protocol and oxide run-local sampling
3. Zero-shot oxide evaluation
4. Oxide fine-tuning and from-scratch training protocols
5. Main hyperparameter setting, model specification, and evaluation metric
6. Embedding-analysis bridge (short)

---

## Literature-Grounded Context

### Dataset and model provenance

- "Crystal structures and formation-energy targets were drawn from the JARVIS materials repository. `[CITE: JARVIS 2020 dataset/repository paper]`"
- "All transfer experiments used a pretrained formation-energy ALIGNN model as the starting point. `[CITE: ALIGNN foundational paper]`"

### Oxide-control framing

- "This report treats oxide prediction as the in-distribution control arm, allowing comparison against a more challenging cross-family evaluation." Study-design wording; no additional literature citation required in Methods.

---

## Implementation Details

### Dataset source

- Oxide data derived from `dft_3d_2021`; target: `formation_energy_peratom`.
- Summary: `data_shared/oxide/summaries/summary.json`.

### Family definitions and filtering

- Oxides: structures containing `O`. Oxynitrides (containing both `O` and `N`) are retained in the oxide arm (499 structures).
- If nitride is mentioned at all in oxide Methods, limit to one shared-definitions sentence: nitrides require `N` and no `O`.

### Split protocol

- Oxide split identities inherit the shared JARVIS benchmark split mapping before family filtering.
- Oxide counts: all = 14991, train = 11960, val = 1547, test = 1484, pool = 13507.
- See TAB_METHODS_DATASET_SPLITS_v1 for the manuscript-facing table.
- Run-local oxide subsets sample N structures from the oxide pool and reuse the fixed oxide test set unchanged.

### Zero-shot evaluation

- Evaluate the pretrained model on the fixed oxide test set (`data_shared/oxide/manifests/test.csv`; n = 1484).
- Results cited from `reports/zero_shot/zero_shot_summary.csv` and `Results_Before_Correction/oxide/zero_shot/predictions.csv`.

### Fine-tuning protocol

- Shared partial-update protocol (see `shared_methods_skeleton_v2.md` §5):
  - pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`
  - freeze all; unfreeze `gcn_layers.3` and `fc`
  - `AdamW`, `OneCycleLR`, `L1Loss`; best checkpoint by validation L1
- Oxide fine-tuning: N = 10, 50, 100, 200, 500, 1000; five random seeds each.

### From-scratch protocol

- Reuses same dataset roots and config template; initializes model weights randomly.
- Oxide from-scratch: N = 50 and N = 500 only; five random seeds each.

### Hyperparameter setting and model specification

- Hyperparameter Set 1: `epochs = 50`, `batch_size = 16`, `learning_rate = 1e-4`.
- Model: four ALIGNN layers, four gated GCN layers, hidden size 256, scalar output. `[CITE: ALIGNN foundational paper]`
- No standalone architecture subsection needed.

### Evaluation metric

- Primary metric: test MAE in eV/atom.
- Multi-seed conditions reported as **mean ± SD** across five random seeds.
- Zero-shot is a single evaluation (no SD).

### Embedding-analysis bridge (oxide main text)

Embeddings were extracted from the frozen pretrained ALIGNN model (`last_alignn_pool` layer) to characterize the structure representation space. Visualization and quantitative separation analysis are described in the combined paper; the oxide report references these as contextual support only. Full parameter details are in `embedding_methods_appendix_notes_v1.md`.

*Oxide-specific note:* Do not reproduce the nitride distance-to-oxide workflow here. The oxide blueprint permits a brief 1–2 paragraph embedding bridge in Results confirming family separation; Methods should name the extraction protocol and `last_alignn_pool` preference, then forward-reference the combined paper for the full analysis.

---

## Experimental Setup

### Oxide experiment scope (see TAB_METHODS_EXPERIMENT_SCOPE_v1)

| protocol | oxide conditions | seeds | notes |
|---|---|---:|---|
| zero-shot | fixed oxide test set (n = 1484) | not seed-varied | pretrained baseline |
| fine-tuning | N = 10, 50, 100, 200, 500, 1000 | 5 | 30 total oxide runs |
| from scratch | N = 50, 500 only | 5 | 10 total oxide runs |

### Oxide-specific phrasing guidance

- Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model"; never "oxide-pretrained model".
- Methods may mention nitride only to define the shared family-construction rule.
- Do not let oxide Methods become a comparison section; comparison belongs to Results or the combined paper.
- Do not interpret low-N behavior; state the protocol scope only.

---

## Cross-check against required Methods coverage

| required topic | oxide-facing coverage |
|---|---|
| dataset source | Dataset source subsection |
| family definitions | Family definitions and filtering subsection |
| split protocol | Split protocol subsection |
| oxide/nitride filtering | Family definitions and filtering subsection |
| zero-shot evaluation | Zero-shot evaluation subsection |
| fine-tuning protocol | Fine-tuning protocol subsection |
| from-scratch protocol | From-scratch protocol subsection |
| hyperparameter setting | Hyperparameter setting subsection |
| evaluation metric | Evaluation metric subsection |
| embedding-analysis protocol | Embedding-analysis bridge subsection |

---

## Stage 6 closure provenance (oxide bundle)

Supersedes `oxide_methods_notes.md`. Phase 6 closure pass applied 2026-04-22.

Inputs used (unchanged from v1):
- `shared_methods_skeleton_v2.md` (active shared backbone)
- `oxide_report_blueprint_v3.md`
- `canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `table_inventory_v2.csv`
- `source_of_truth_memo_v2.md`
- Figure memos: `fig01`, `fig02`, `fig05a`, `fig06`, `fig07`

Brief-fixed constraints applied: Set 1 (`epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`); oxide = structures containing `O` (oxynitrides retained); from-scratch only at N = 50 and N = 500.
