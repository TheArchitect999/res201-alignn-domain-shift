# Phase 1 Micro-fix Changelog

Date: 2026-04-21  
File patched: `figure_inventory_v2.csv`  
Nature of fix: filename precision only — no classification, scope, or section values changed.

---

## Issue

The four promoted parity-plot rows in `figure_inventory_v2.csv` had paths missing the `, ` (comma-space) that appears in the actual filenames on disk before `N=`. Additionally, because the corrected paths now contain a comma, those fields must be wrapped in CSV double-quotes per RFC 4180.

No other rows were affected. All other parity plot entries (the collection row `FIG_S1_PARITY_COLLECTION`) point to manifest files and are unaffected.

---

## Changes

### FIG_S1_PARITY_OXIDE_N10

| Field | Old value | New value |
|---|---|---|
| preferred_path | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=10.png` | `"reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1, N=10.png"` |
| alternate_path_or_manifest | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=10.pdf` | `"reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1, N=10.pdf"` |
| Disk check | MISSING | **OK** |

### FIG_S1_PARITY_OXIDE_N1000

| Field | Old value | New value |
|---|---|---|
| preferred_path | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=1000.png` | `"reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1, N=1000.png"` |
| alternate_path_or_manifest | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=1000.pdf` | `"reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1, N=1000.pdf"` |
| Disk check | MISSING | **OK** |

### FIG_S1_PARITY_NITRIDE_N10

| Field | Old value | New value |
|---|---|---|
| preferred_path | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=10.png` | `"reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1, N=10.png"` |
| alternate_path_or_manifest | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=10.pdf` | `"reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1, N=10.pdf"` |
| Disk check | MISSING | **OK** |

### FIG_S1_PARITY_NITRIDE_N1000

| Field | Old value | New value |
|---|---|---|
| preferred_path | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=1000.png` | `"reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1, N=1000.png"` |
| alternate_path_or_manifest | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=1000.pdf` | `"reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1, N=1000.pdf"` |
| Disk check | MISSING | **OK** |

---

## Confirmation

- Only `preferred_path` and `alternate_path_or_manifest` fields were changed.
- `main_text_status`, `report_scope`, `paper_section`, `notes`, `category`, `namespace_role`, `namespace`, `family_or_scope`, and `source_evidence` are unchanged for all four rows.
- All four corrected paths verified to resolve to real files on disk.
- No other rows in `figure_inventory_v2.csv` were modified.
