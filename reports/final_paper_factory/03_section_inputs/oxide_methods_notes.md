# Oxide Methods Notes

Use this with `shared_methods_skeleton.md`. The oxide report should keep the shared protocol intact while foregrounding the oxide arm as the in-distribution control study.

## Oxide-specific scope

- Report identity: control-arm paper, not the domain-shift paper.
- Methods should be shared where possible, but the oxide version can compress nitride-specific embedding machinery.
- Do not present nitride behavior as evidence inside oxide Methods; only define the shared family-construction pipeline once.
- Oxide Methods must match the structural ordering implied by `oxide_report_blueprint_v3.md` row 2 (the "Canonical dataset and experiment scope" Methods row). That row pins the report to Set 1, the oxide test-set size, and the canonical run counts, and calls out the from-scratch coverage limitation.
- Do not call the pretrained checkpoint "oxide-pretrained" anywhere in oxide Methods. Use "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model".

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
  - embeddings were extracted from the frozen pretrained ALIGNN model, not from fine-tuned or from-scratch checkpoints
  - the main text, if it mentions an embedding layer, should prefer `last_alignn_pool`
  - quantitative raw-space analysis and nonlinear visualization details are part of the shared embedding workflow and can be forward-referenced to the combined paper or appendix
- Avoid reproducing the full nitride distance-to-oxide workflow here unless the final oxide blueprint expands that section.
- The oxide blueprint (row 7) permits a brief 1–2 paragraph embedding bridge in Results that confirms family separation. Methods should be consistent with that bridge: name the extraction protocol and the `last_alignn_pool` preference, then forward-reference the combined paper for the rest.

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
- `TODO:` decide whether oxide Methods should explicitly define the term "oxynitride" once (because oxide retains 499 of them) or leave the term as a parenthetical.

## Cross-check against required Methods coverage

Every one of the ten Stage 6 required topics is covered in this notes file plus the shared skeleton:

| required topic | oxide-facing coverage |
|---|---|
| dataset source | Dataset source subsection |
| family definitions | Family definitions and filtering subsection |
| split protocol | Split protocol subsection |
| oxide/nitride filtering | Family definitions and filtering subsection |
| zero-shot evaluation | Zero-shot evaluation subsection |
| fine-tuning protocol | Fine-tuning protocol subsection |
| from-scratch protocol | From-scratch protocol subsection |
| hyperparameter setting used for the main narrative | Hyperparameter setting subsection |
| evaluation metric | Evaluation metric subsection |
| embedding-analysis protocol | Embedding-analysis protocol subsection |

## Stage 6 handoff provenance (oxide bundle)

This notes file was assembled from the oxide standalone methods bundle in `STAGE6_METHODS_HANDOFF.md` §E:

Required inputs used:

- `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton.md`
- `reports/final_paper_factory/01_blueprints/oxide_report_blueprint_v3.md`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`, `canonical_numbers_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/table_inventory_v2.csv`
- `reports/final_paper_factory/00_source_of_truth/source_of_truth_memo_v2.md`
- `reports/final_paper_factory/02_figure_memos/figure_memo_index.md`
- `reports/final_paper_factory/02_figure_memos/fig01_study_design_schematic_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig02_oxide_learning_curve_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig05a_oxide_comparison_plot_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig06_oxide_lowN_parity_memo.md`
- `reports/final_paper_factory/02_figure_memos/fig07_oxide_highN_parity_memo.md`

Recommended support used:

- `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md`
- `reports/week1_report.tex`, `reports/week2_report.tex`

Brief-fixed constraints applied: Set 1 (`epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`); oxide = structures containing `O` (oxynitrides retained); from-scratch only at `N = 50` and `N = 500`.
