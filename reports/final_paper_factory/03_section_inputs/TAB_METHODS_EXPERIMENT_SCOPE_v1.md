# TAB_METHODS_EXPERIMENT_SCOPE_v1

**Table label:** TAB_METHODS_EXPERIMENT_SCOPE  
**Version:** v1  
**Status:** Manuscript-facing artifact — Phase 6 closure pass 2026-04-22.  
**Source files:**
- `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv`
- `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv`
- `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md`

---

## Manuscript-Facing Table

**Table 2. Experiment scope under Hyperparameter Set 1.**

| Protocol | Families | N values | Seeds per condition | Runs per family | Total runs | Notes |
|---|---|---|---:|---:|---:|---|
| Zero-shot | Oxide, Nitride | Fixed test sets | 1 (not seed-varied) | 1 evaluation | 2 | Pretrained baseline; no training |
| Fine-tuning | Oxide, Nitride | 10, 50, 100, 200, 500, 1 000 | 5 | 30 | 60 | Partial weight update (last 2 layers) |
| From scratch | Oxide, Nitride | 50, 500 only | 5 | 10 | 20 | Full random initialization; N = 50 and N = 500 only |

**Table notes (for manuscript caption):**

- All training experiments use Hyperparameter Set 1: `epochs = 50`, `batch_size = 16`, `learning_rate = 1e-4`.
- Fine-tuning unfreezes only `gcn_layers.3` and `fc` of the pretrained formation-energy ALIGNN checkpoint. `[CITE: ALIGNN foundational paper]`
- From-scratch experiments exist **only at N = 50 and N = 500** for both families. No from-scratch comparison is available at N = 10, 100, 200, or 1000.
- Seeds: five random seeds per condition (seeds 0–4). Repeated-run results are reported as mean ± SD across seeds.
- Run counts verified from `finetune_runs.csv` (60 rows) and `fromscratch_runs.csv` (20 rows).
- Zero-shot evaluation is performed once per family on the fixed test set; it is not seed-varied.

---

## Per-Family Fine-Tuning Breakdown

| Family | N | Seeds | Runs |
|---|---:|---:|---:|
| Oxide | 10 | 5 | 5 |
| Oxide | 50 | 5 | 5 |
| Oxide | 100 | 5 | 5 |
| Oxide | 200 | 5 | 5 |
| Oxide | 500 | 5 | 5 |
| Oxide | 1000 | 5 | 5 |
| Nitride | 10 | 5 | 5 |
| Nitride | 50 | 5 | 5 |
| Nitride | 100 | 5 | 5 |
| Nitride | 200 | 5 | 5 |
| Nitride | 500 | 5 | 5 |
| Nitride | 1000 | 5 | 5 |
| **Total** | | | **60** |

## Per-Family From-Scratch Breakdown

| Family | N | Seeds | Runs |
|---|---:|---:|---:|
| Oxide | 50 | 5 | 5 |
| Oxide | 500 | 5 | 5 |
| Nitride | 50 | 5 | 5 |
| Nitride | 500 | 5 | 5 |
| **Total** | | | **20** |

---

## Provenance notes (internal — not for manuscript)

- Fine-tuning run count: 60 rows verified from `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_runs.csv` (header excluded).
- From-scratch run count: 20 rows verified from `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_runs.csv` (header excluded).
- Canonical run counts also confirmed in `canonical_numbers_v2.md` (Set 1 run counts section).
- Do not add N values or protocols not present in the actual run CSVs.
