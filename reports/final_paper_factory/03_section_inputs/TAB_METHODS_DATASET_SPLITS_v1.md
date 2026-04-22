# TAB_METHODS_DATASET_SPLITS_v1

**Table label:** TAB_METHODS_DATASET_SPLITS  
**Version:** v1  
**Status:** Manuscript-facing artifact — Phase 6 closure pass 2026-04-22.  
**Source files:** `data_shared/oxide/summaries/summary.json`, `data_shared/nitride/summaries/summary.json`

---

## Manuscript-Facing Table

**Table 1. Dataset composition and split statistics.**

| Family | Total | Train | Val | Test | Pool (Train+Val) | Oxynitrides | Split source |
|---|---:|---:|---:|---:|---:|---:|---|
| Oxide | 14 991 | 11 960 | 1 547 | 1 484 | 13 507 | 499 (retained) | Original JARVIS split manifest |
| Nitride | 2 288 | 1 837 | 209 | 242 | 2 046 | 0 (excluded) | Original JARVIS split manifest |

**Table notes (for manuscript caption):**

- All structures and their train/val/test assignments derive from the `dft_3d_2021` JARVIS release. `[CITE: JARVIS 2020 dataset/repository paper]` Original JARVIS benchmark split identities were preserved before family filtering; the split manifest is `provided:manifests/dft_3d_formation_energy_peratom_splits.csv`.
- Oxide family: any structure containing O. Structures containing both O and N (oxynitrides) are retained in the oxide arm (499 structures).
- Nitride family: structures containing N and not containing O. All oxynitrides are excluded from the nitride arm (0 oxynitrides).
- Pool = Train + Val. The pool is the sampling reservoir for run-local training subsets. The test set is held fixed and never resampled.
- The formation-energy target in both families is `formation_energy_peratom` (eV/atom).

---

## Run-Local Subset Sizes (derived by protocol)

Fine-tuning and from-scratch runs sample N structures from the family pool. Validation allocation uses `n_val = max(5, round(0.1 × N))`.

| Sampled N | Train | Val |
|---:|---:|---:|
| 10 | 5 | 5 |
| 50 | 45 | 5 |
| 100 | 90 | 10 |
| 200 | 180 | 20 |
| 500 | 450 | 50 |
| 1 000 | 900 | 100 |

Fine-tuning was run at all six N values for both families. From-scratch runs exist only at N = 50 and N = 500.

---

## Provenance notes (internal — not for manuscript)

- Oxide summary verified from `data_shared/oxide/summaries/summary.json`: `{"all": 14991, "pool": 13507, "test": 1484, "train": 11960, "val": 1547, "oxynitride_count_in_family": 499, "split_source": "provided:manifests/dft_3d_formation_energy_peratom_splits.csv", "dataset_key": "dft_3d_2021", "target_key": "formation_energy_peratom"}`.
- Nitride summary verified from `data_shared/nitride/summaries/summary.json`: `{"all": 2288, "pool": 2046, "test": 242, "train": 1837, "val": 209, "oxynitride_count_in_family": 0, "split_source": "provided:manifests/dft_3d_formation_energy_peratom_splits.csv", "dataset_key": "dft_3d_2021", "target_key": "formation_energy_peratom"}`.
- Do not modify these counts without updating the canonical_numbers_v2 files.
