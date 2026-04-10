# RES201 Project Status So Far

Date of audit: 2026-04-10

This note summarizes the current state of the `res201-alignn-domain-shift` workspace against the official project brief in `Project_Task/RES201 Project.pdf`. It is based on the project brief, the Week 1 and Week 2 report sources, the saved result summaries, the dataset summaries, and the currently uncommitted artifacts in the repo.

## Core Project Goal

The project asks:

> How does chemical-family domain shift affect the data efficiency of a pretrained ALIGNN model for formation-energy prediction?

More concretely, the brief defines:

- oxide experiments as the relatively in-distribution control arm,
- nitride experiments as the more out-of-distribution arm,
- zero-shot, fine-tuning, and from-scratch comparisons as the main study conditions,
- test MAE in eV/atom as the primary metric,
- and embedding analysis as the mechanism-oriented analysis later in the project.

## What Is Complete

### 1. Stage 2 dataset construction is complete

The repo already contains the full Stage 2 family dataset pipeline, manifests, and validation logic:

- `scripts/dataset/build_res201_family_datasets.py`
- `scripts/dataset/res201_stage2_lib.py`
- `scripts/dataset/validate_res201_stage2.py`
- `manifests/dft_3d_formation_energy_peratom_splits.csv`

The resulting family datasets exist under `data_shared/` and follow the project rules:

- source dataset: `dft_3d_2021`
- split rule: original JARVIS train/val/test IDs applied first, then family filtering
- oxide definition: contains O
- nitride definition: contains N and no O
- oxynitrides excluded from nitride arm
- fixed family test sets preserved for reuse

Saved summary counts confirm the frozen dataset:

| Family | All | Train | Val | Test | Pool |
| --- | ---: | ---: | ---: | ---: | ---: |
| Oxide | 14991 | 11960 | 1547 | 1484 | 13507 |
| Nitride | 2288 | 1837 | 209 | 242 | 2046 |

Evidence:

- `data_shared/oxide/summaries/summary.json`
- `data_shared/nitride/summaries/summary.json`
- `data_shared/diagnostics/global_split_manifest.json`
- `data_shared/diagnostics/global_record_catalog.csv`
- `data_shared/diagnostics/schema_report.json`

### 2. Week 1 deliverables are complete

The Week 1 requirements in the brief were:

- build and confirm oxide subset
- build and confirm nitride subset
- exclude oxynitrides from nitride arm
- apply original split IDs first
- keep fixed oxide and nitride test sets
- load pretrained ALIGNN checkpoint
- report oxide zero-shot MAE
- report nitride zero-shot MAE
- complete one oxide fine-tuning run at `N=50`
- complete one nitride fine-tuning run at `N=50`

All of those deliverables are already satisfied in the workspace and documented in `reports/week1_report.tex`.

Key Week 1 metrics:

| Family | Condition | Test MAE (eV/atom) |
| --- | --- | ---: |
| Oxide | Zero-shot | 0.0341836068 |
| Oxide | Fine-tune `N=50`, seed 0 | 0.0700507342 |
| Nitride | Zero-shot | 0.0695420150 |
| Nitride | Fine-tune `N=50`, seed 0 | 0.1617631432 |

Interpretation:

- Week 1 is complete as a milestone.
- Under the current partial-fine-tuning setup, both `N=50` runs were worse than zero-shot.
- That is a valid result and became the motivation for the larger Week 2 sweep.

Evidence:

- `results/oxide/zero_shot/summary.json`
- `results/nitride/zero_shot/summary.json`
- `results/oxide/N50_seed0/finetune_last2/summary.json`
- `results/nitride/N50_seed0/finetune_last2/summary.json`
- `reports/week1_report.tex`

### 3. Week 2 deliverables are complete

The Week 2 brief required:

- all oxide fine-tuning runs completed
- oxide MAE table
- oxide learning-curve plot
- all nitride fine-tuning runs completed
- nitride MAE table
- nitride learning-curve plot

The repo now contains the complete three-seed Week 2 sweep:

- families: oxide, nitride
- training sizes: `N = 10, 50, 100, 200, 500, 1000`
- seeds: `0, 1, 2`
- total fine-tuning runs: `2 x 6 x 3 = 36`

Saved aggregate results show:

| Family | Best mean fine-tuned MAE | Best `N` | Zero-shot MAE |
| --- | ---: | ---: | ---: |
| Oxide | 0.04556 +- 0.00086 | 1000 | 0.03418 |
| Nitride | 0.09875 +- 0.01763 | 10 | 0.06954 |

Important Week 2 conclusion:

- Oxide adaptation is smoother and less variable than nitride adaptation.
- Nitride behavior is noisier across seeds and harder to improve.
- Under the current "freeze all but the last two groups" protocol, neither family beats zero-shot by `N=1000`.

Evidence:

- `reports/week2/finetune_runs.csv`
- `reports/week2/finetune_summary_by_N.csv`
- `reports/week2/finetune_summary_wide.csv`
- `reports/week2/zero_shot_summary.csv`
- `reports/week2/oxide_learning_curve.pdf`
- `reports/week2/nitride_learning_curve.pdf`
- `reports/week2/training_curves/`
- `reports/week2_report.tex`

## What The Repo Added Beyond The Last Committed Milestone

The currently uncommitted work reviewed in this audit mainly extends documentation and reproducibility:

- `Project_Task/` now contains the project brief, ALIGNN tutorial, timeline PDF, ALIGNN paper PDF, and a Week 1 PDF export.
- `docs/STAGE3_PLAYBOOK.md` captures the original Week 1 Stage 3 output expectations.
- `env/bootstrap_res201_stage3_train.sh` and `requirements/res201_train_frozen.txt` document the training environment.
- `jv_formation_energy_peratom_alignn/config.json` preserves the pretrained checkpoint configuration.
- `reports/week2/training_curves/` contains per-run training-curve figures plus family grid figures and manifests.
- `scripts/shared/plot_week2_training_curves.py` generates those Week 2 curve artifacts.
- `data_shared/diagnostics/` preserves dataset inspection artifacts that support the Stage 2 story.
- `results/oxide/N50_seed0/train_alignn_restart/` preserves an older partial restart attempt for the oxide `N=50` path.

## What Is Not Done Yet

Relative to the project brief, the main unfinished work starts after Week 2.

### Week 3 still appears unfinished

The brief expects, for both families:

- from-scratch baselines at `N=50` and `N=500`
- comparison plots
- parity plots

I did not find completed from-scratch result suites or finished Week 3 comparison outputs in the current workspace.

### Week 4 still appears unfinished

The brief expects:

- written oxide analysis on saturation, zero-shot usefulness, and pretraining effect
- written nitride analysis on saturation, domain-shift penalty, and pretraining effect
- extracted embeddings
- embedding visualizations

The current workspace contains strong Week 1 and Week 2 narrative/report material, but not a completed embedding-analysis artifact set.

### Weeks 5 and 6 are still ahead

The brief expects:

- a full combined paper draft in Week 5
- a final oral presentation in Week 6

The repo already contains material that can feed those deliverables, but the final integrated paper and presentation do not appear complete yet.

## Main Scientific Story So Far

If we had to summarize the project honestly today, the story is:

1. The dataset split-and-filter pipeline is built correctly and reproducibly for oxide and nitride families.
2. Zero-shot pretrained ALIGNN performs noticeably better on oxides than on nitrides.
3. Partial fine-tuning with only `gcn_layers.3` and `fc` unfrozen does not yet beat zero-shot for either family.
4. Oxide fine-tuning improves more smoothly with additional data, while nitride fine-tuning is noisier and harder to stabilize.
5. The current evidence is consistent with the domain-shift hypothesis, but the project still needs from-scratch baselines and embedding analysis to fully answer the brief.

## Recommended Immediate Next Step

The next highest-value project step is to start the Week 3 from-scratch baselines for both families at `N=50` and `N=500`, using the same fixed datasets, metrics, and reporting structure already established for Week 2. That is the shortest path to answering the brief's core "pretrained vs. scratch" question.
