# RES201 Table Completion Map
**Generated:** 2026-04-24  
**Scope:** Every `[TABLE: TAB_*]` placeholder in the three final Word documents, cross-referenced against all canonical source files.  
**Source manuscripts:** oxide_polished_v3.md · nitride_polished_v3.md · combined_paper_polished_v4.md  
**Built documents:** oxide_final.docx · nitride_final.docx · combined_final.docx  

---

## Summary

| Table ID | Oxide | Nitride | Combined | Source confirmed | Action |
|----------|:-----:|:-------:|:--------:|:----------------:|--------|
| TAB_METHODS_DATASET_SPLITS | 1 | 1 | 1 | ✓ | Create 2-row Word table |
| TAB_METHODS_EXPERIMENT_SCOPE | 1 | 1 | 1 | ✓ | Create parameter/scope Word table |
| TAB_ZS_SUMMARY | 1 | 1 | 3 | ✓ | Create 2-row Word table (scope varies per instance) |
| TAB_S1_FT_SUMMARY_BY_N | 1 | 1 | 3 | ✓ | Delete placeholder where inline table exists; create fresh for nitride |
| TAB_S1_FS_SUMMARY | 1 | 1 | 3 | ✓ | Delete placeholder where inline table exists; create fresh for nitride |
| TAB_EA_FAMILY_SEPARATION | 1 | 1 | 3 | ✓ | Create 8-row metrics Word table |
| TAB_EA_DISTANCE_ERROR_STATS | 0 | 1 | 2 | ✓ | Create 5-row stats Word table |

**No table IDs have missing or unconfirmed sources.** All canonical data files are present on disk.

---

## Critical Note — Inline Table Duplication

The oxide manuscript and the oxide-results section of the combined manuscript embed the fine-tuning and from-scratch summary tables directly as markdown pipe tables in the prose (§3.2 and §3.4). The build script converted these to Word tables. The `[TABLE: TAB_S1_FT_SUMMARY_BY_N]` and `[TABLE: TAB_S1_FS_SUMMARY]` placeholders appear **immediately above** those existing Word tables in the document.

**For those instances: delete the `[TABLE: ...]` placeholder caption line — the inline Word table below it is the real table.**

For the nitride manuscript and the nitride sections of the combined paper, no inline tables exist; the placeholders must be replaced with freshly formatted Word tables.

---

## Table 1 — TAB_METHODS_DATASET_SPLITS

**Appears in:** oxide §2.3 (1×), nitride §2.3 (1×), combined §2.3 (1×)  
**Section:** Split protocol and subset construction / Split inheritance  
**Main text / Appendix:** Main text  
**Format action:** Create new Word table (no inline version exists)  

### Source
- `data_shared/oxide/summaries/summary.json`
- `data_shared/nitride/summaries/summary.json`

### Required columns
`Family` · `Total structures` · `Train` · `Validation` · `Test` · `Pool (Train+Val)` · `Oxynitrides retained`

### Data (verbatim from source files)

| Family | Total | Train | Validation | Test | Pool | Oxynitrides |
|--------|------:|------:|----------:|-----:|-----:|------------:|
| Oxide | 14,991 | 11,960 | 1,547 | 1,484 | 13,507 | 499 |
| Nitride | 2,288 | 1,837 | 209 | 242 | 2,046 | 0 |

### Notes
- The pool column is train + val: oxide 11960 + 1547 = 13507; nitride 1837 + 209 = 2046.
- "Oxynitrides retained" means structures containing both O and N: retained in oxide arm, excluded from nitride arm.
- In the oxide-only manuscript, the table may show only the oxide row; the header stays the same.
- In the nitride-only manuscript, show only the nitride row.
- In the combined paper, show both rows with a "Family" label column.

---

## Table 2 — TAB_METHODS_EXPERIMENT_SCOPE

**Appears in:** oxide §2.6 (1×), nitride §2.6 (1×), combined §2.7 (1×)  
**Section:** Hyperparameter setting, model specification, and evaluation metric  
**Main text / Appendix:** Main text  
**Format action:** Create new Word table (no inline version; manuscript prose has partial content)  

### Source
- Hyperparameter values: manuscript prose (canonical; do not alter)  
- Run counts: `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv`  
  — CN_S1_FT_RUN_COUNT = 60 total (30 per family), CN_S1_FS_RUN_COUNT = 20 total (10 per family)

### Required structure — two-section table

**Section A — Hyperparameter Set 1**

| Parameter | Value |
|-----------|-------|
| Epochs | 50 |
| Batch size | 16 |
| Learning rate | 1 × 10⁻⁴ |
| Neighbour strategy | k-nearest |
| Cutoff | 8.0 Å |
| Cutoff extra | 3.0 Å |
| Max neighbours | 12 |
| use_canonize | enabled |
| compute_line_graph | enabled |
| use_lmdb | enabled |

**Section B — Model architecture (ALIGNN formation-energy model)**

| Component | Setting |
|-----------|---------|
| ALIGNN convolutional layers | 4 |
| Gated GCN layers | 4 |
| Hidden size | 256 |
| Output head | scalar (formation energy per atom) |

**Section C — Experimental scope (per family / combined)**

| Experiment type | N values | Seeds per N | Oxide runs | Nitride runs | Combined total |
|-----------------|----------|-------------|-----------|--------------|---------------|
| Zero-shot | — | 1 (not seeded) | 1 | 1 | 2 |
| Fine-tuning | 10, 50, 100, 200, 500, 1000 | 5 | 30 | 30 | 60 |
| From-scratch | 50, 500 | 5 | 10 | 10 | 20 |

### Notes
- In the per-family manuscripts (oxide, nitride), show only that family's run counts.
- In the combined paper, show the combined totals column.
- The `criterion: mse` override note (training uses L1 despite config JSON saying MSE) is prose, not a table entry.

---

## Table 3 — TAB_ZS_SUMMARY

**Appears in:** oxide §3.1 (1×), nitride §3.1 (1×), combined §3.1 + §4.1 + §III.A (3×)  
**Section:** Zero-shot MAE results / Step 1 zero-shot penalty / Zero-shot family gap  
**Main text / Appendix:** Main text  
**Format action:** Create new Word table (no inline version in any manuscript)  

### Source
`reports/zero_shot/zero_shot_summary.csv`

### Data (verbatim from source file)

| Family | Model | Test structures (n) | Zero-shot MAE (eV/atom) |
|--------|-------|--------------------:|------------------------:|
| Oxide | jv_formation_energy_peratom_alignn | 1,484 | 0.0342 |
| Nitride | jv_formation_energy_peratom_alignn | 242 | 0.0695 |

Rounded values used in manuscript prose: oxide = 0.0342 eV/atom, nitride = 0.0695 eV/atom.  
Full precision from source: oxide = 0.03418360680813096, nitride = 0.06954201496284854.

### Per-instance scope

| Instance | Document | Section | Rows to show |
|----------|----------|---------|-------------|
| 1 | oxide_final.docx | §3.1 | Oxide row only (or both for comparison context) |
| 2 | nitride_final.docx | §3.1 | Both rows (nitride result + oxide comparator) |
| 3 | combined_final.docx | §III.3.1 | Oxide row (oxide results section) |
| 4 | combined_final.docx | §IV.4.1 | Both rows (nitride vs oxide comparison) |
| 5 | combined_final.docx | §V.III.A | Both rows (direct comparison — this is the primary comparison table) |

### Notes
- The model name column may be omitted in final formatting (single checkpoint throughout).
- The §V.III.A instance should include both rows and may add a "Ratio (nitride/oxide)" column = 2.03.

---

## Table 4 — TAB_S1_FT_SUMMARY_BY_N

**Appears in:** oxide §3.2 (1×), nitride §3.2 (1×), combined §3.2 + §4.2 + §III.B (3×)  
**Section:** Fine-tuning convergence / Low-N inertness / Differential fine-tuning response  
**Main text / Appendix:** Main text  
**Format action:** Mixed — see per-instance instructions below  

### Source
`reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`  
Confirmed against: `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv` (fine_tuning rows)

### Required columns
`N` · `Runs` · `Mean test MAE (eV/atom)` · `Std test MAE` · `Mean best epoch` · `Gap vs zero-shot (eV/atom)`

### Data — Oxide (verbatim from canonical_numbers_v2.csv)

| N | Runs | Mean test MAE | Std test MAE | Mean best epoch | Gap vs zero-shot |
|--:|-----:|--------------:|-------------:|----------------:|-----------------:|
| 10 | 5 | 0.0417 | 0.0111 | 1.0 | +0.0075 |
| 50 | 5 | 0.0523 | 0.0148 | 18.5 | +0.0181 |
| 100 | 5 | 0.0465 | 0.0086 | 20.0 | +0.0123 |
| 200 | 5 | 0.0457 | 0.0086 | 39.0 | +0.0115 |
| 500 | 5 | 0.0430 | 0.0062 | 39.0 | +0.0088 |
| 1,000 | 5 | 0.0417 | 0.0053 | 35.5 | +0.0075 |

Zero-shot MAE reference: 0.0342 eV/atom. Gap = mean test MAE − zero-shot MAE (positive = above zero-shot).

### Data — Nitride (verbatim from canonical_numbers_v2.csv)

| N | Runs | Mean test MAE | Std test MAE | Mean best epoch | Gap vs zero-shot |
|--:|-----:|--------------:|-------------:|----------------:|-----------------:|
| 10 | 5 | 0.0874 | 0.0199 | 1.0 | +0.0179 |
| 50 | 5 | 0.1173 | 0.0451 | 1.0 | +0.0477 |
| 100 | 5 | 0.1722 | 0.0996 | 1.0 | +0.1027 |
| 200 | 5 | 0.1392 | 0.0677 | 1.0 | +0.0696 |
| 500 | 5 | 0.0977 | 0.0178 | 40.5 | +0.0281 |
| 1,000 | 5 | 0.0907 | 0.0135 | 45.0 | +0.0211 |

Zero-shot MAE reference: 0.0695 eV/atom.

### Per-instance instructions

| Instance | Document | Section | Inline table already in docx? | Action |
|----------|----------|---------|-------------------------------|--------|
| 1 | oxide_final.docx | §3.2 | **YES** — inline markdown table converted | Delete placeholder; keep existing Word table |
| 2 | nitride_final.docx | §3.2 | No | Replace placeholder with nitride Word table |
| 3 | combined_final.docx | §III.3.2 | **YES** — inline markdown table converted | Delete placeholder; keep existing Word table |
| 4 | combined_final.docx | §IV.4.2 | No | Replace placeholder with nitride Word table |
| 5 | combined_final.docx | §V.III.B | No | Create combined table: oxide rows first, then nitride rows, with a Family column added |

### Notes
- For instance 5 (§V.III.B), the combined table format should add a "Family" column as the first column and show oxide N=10–1000, then nitride N=10–1000, for a 12-row table.
- The manuscript prose for oxide §3.2 and combined §III.3.2 shows the table inline with exactly the oxide data values above. Verify the inline Word table matches before deleting the placeholder.

---

## Table 5 — TAB_S1_FS_SUMMARY

**Appears in:** oxide §3.4 (1×), nitride §3.6 (1×), combined §3.4 + §4.6 + §III.C (3×)  
**Section:** Pretrained vs from-scratch / Supporting evidence / Transfer-benefit contrast  
**Main text / Appendix:** Main text  
**Format action:** Mixed — see per-instance instructions below  

### Source (primary)
`reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv`  
— experiment_type='direct_transfer_benefit' (transfer gaps) + experiment_type='from_scratch' (scratch MAEs)

### Source (secondary)
`reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`

### Required columns
`N` · `Fine-tune mean MAE ± SD (eV/atom)` · `From-scratch mean MAE ± SD (eV/atom)` · `Scratch − fine-tune (eV/atom)` · `Scratch − zero-shot (eV/atom)`

### Data — Oxide rows (verbatim from canonical_numbers_v2.csv + finetune_summary_by_N.csv)

| N | FT mean ± SD | Scratch mean ± SD | Scratch − FT | Scratch − zero-shot |
|--:|-------------:|------------------:|-------------:|--------------------:|
| 50 | 0.0523 ± 0.0148 | 0.5561 ± 0.0523 | +0.5038 | +0.5219 |
| 500 | 0.0430 ± 0.0062 | 0.2643 ± 0.0228 | +0.2214 | +0.2301 |

### Data — Nitride rows (verbatim from canonical_numbers_v2.csv + fromscratch_summary.csv)

| N | FT mean ± SD | Scratch mean ± SD | Scratch − FT | Scratch − zero-shot |
|--:|-------------:|------------------:|-------------:|--------------------:|
| 50 | 0.1173 ± 0.0451 | 0.6914 ± 0.0163 | +0.5741 | +0.6219 |
| 500 | 0.0977 ± 0.0178 | 0.3683 ± 0.0233 | +0.2706 | +0.2988 |

Source check for scratch − fine-tune: canonical CN_TRANSFER_BENEFIT_OXIDE_N50 = 0.5037547011; CN_TRANSFER_BENEFIT_OXIDE_N500 = 0.2213732464; CN_TRANSFER_BENEFIT_NITRIDE_N50 = 0.5741422013; CN_TRANSFER_BENEFIT_NITRIDE_N500 = 0.2706168039. These match the manuscript prose values (rounded to 4 d.p.).

### Per-instance instructions

| Instance | Document | Section | Inline table already in docx? | Action |
|----------|----------|---------|-------------------------------|--------|
| 1 | oxide_final.docx | §3.4 | **YES** — inline markdown table converted | Delete placeholder; keep existing Word table |
| 2 | nitride_final.docx | §3.6 | No | Replace placeholder with nitride Word table |
| 3 | combined_final.docx | §III.3.4 | **YES** — inline markdown table converted | Delete placeholder; keep existing Word table |
| 4 | combined_final.docx | §IV.4.6 | No | Replace placeholder with nitride Word table |
| 5 | combined_final.docx | §V.III.C | No | Create combined table: oxide rows first, then nitride rows, with a Family column added |

### Notes
- Scratch − FT in the manuscript prose uses rounded values (0.5038, 0.2214, 0.5741, 0.2706). Use the same rounding in the Word table.
- The `fromscratch_summary.csv` column `gain_vs_finetune_seed0` uses seed 0 only, not the mean fine-tuning MAE. Use the `canonical_numbers_v2.csv` transfer-benefit values (CN_TRANSFER_BENEFIT_*) which use the proper mean fine-tune minus mean scratch.
- At N = 50 on nitride: fine-tune mean MAE = 0.1173 (but this reflects mean_best_epoch = 1.0 — the pretrained checkpoint, not fine-tuned adaptation). The table should carry a footnote to that effect, as the manuscript prose does (§3.6 caveat C3).

---

## Table 6 — TAB_EA_FAMILY_SEPARATION

**Appears in:** oxide §3.5 (1×), nitride §3.4 (1×), combined §3.5 + §4.4 + §VI.B (3×)  
**Section:** Oxide/nitride embeddings form cohesive region / Step 4a family structure / Family separation in frozen representation  
**Main text / Appendix:** Main text  
**Format action:** Create new Word table (no inline version in any manuscript)  

### Source
`reports/week4_embedding_analysis/tables/family_separation_metrics.csv`  
**Filter:** `embedding_source = 'last_alignn_pool'` AND `dataset = 'fixed_test_set'`

### Data (verbatim from source file after filtering)

| Metric | Scope | Value | 95% CI lower | 95% CI upper |
|--------|-------|------:|-------------:|-------------:|
| Silhouette score | Overall | 0.2392 | 0.2332 | 0.2456 |
| Silhouette score | Oxide | 0.2546 | 0.2476 | 0.2617 |
| Silhouette score | Nitride | 0.1453 | 0.1316 | 0.1582 |
| Davies–Bouldin index | Overall | 1.8290 | 1.7340 | 1.9071 |
| 15-NN family purity | Overall | 0.9655 | 0.9603 | 0.9708 |
| 15-NN family purity | Oxide | 0.9872 | 0.9832 | 0.9906 |
| 15-NN family purity | Nitride | 0.8331 | 0.7978 | 0.8645 |
| Logistic-regression AUC | Overall | 0.9994 | 0.9984 | 0.9999 |

Confidence intervals: 95%, bootstrap resampling. Confirmed against `canonical_numbers_v2.csv` (embedding_family_separation rows for last_alignn_pool, main_text visibility).

### Per-instance scope

| Instance | Document | Section | Family scope of table |
|----------|----------|---------|----------------------|
| 1 | oxide_final.docx | §3.5 | All rows (both families, shared metrics) |
| 2 | nitride_final.docx | §3.4 | All rows |
| 3 | combined_final.docx | §III.3.5 | All rows |
| 4 | combined_final.docx | §IV.4.4 | All rows |
| 5 | combined_final.docx | §VI.B | All rows (primary combined embedding section) |

### Notes
- All five instances use the same 8-row table. The table is the same regardless of which manuscript section it appears in.
- The CI method is "stratified bootstrap over per-structure silhouette values" for overall silhouette, and "bootstrap over family per-structure silhouette values" for per-family metrics.
- Davies–Bouldin: lower is better. Silhouette and AUC: higher is better. 15-NN purity: higher is better. Add higher/lower indicator in column header or footnote.

---

## Table 7 — TAB_EA_DISTANCE_ERROR_STATS

**Appears in:** nitride §3.5 (1×), combined §4.5 + §VI.C (2×)  
**Section:** Step 4b within-family distance–error association / Error-linked distance  
**Main text / Appendix:** Main text  
**Format action:** Create new Word table (no inline version in any manuscript)  

### Source
`reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`  
**Filter:** `embedding_source = 'last_alignn_pool'` AND `distance_metric = 'oxide_knn5_mean_distance'`

### Data (verbatim from source file after filtering)

**Continuous association (full 242 nitride test structures):**

| Statistic | Value | 95% CI lower | 95% CI upper | FDR q-value |
|-----------|------:|-------------:|-------------:|------------:|
| Spearman ρ | 0.3428 | 0.2214 | 0.4597 | 1.3 × 10⁻⁴ |
| Pearson r | 0.2770 | 0.1741 | 0.3890 | 1.3 × 10⁻⁴ |

**Tail contrast (hard top 20% vs easy bottom 20%, n = 49 each):**

| Statistic | Hard group | Easy group | Hard − Easy | 95% CI lower | 95% CI upper | FDR q-value |
|-----------|----------:|----------:|------------:|-------------:|-------------:|------------:|
| Mean 5NN distance | 4.5988 | 3.7821 | +0.8168 | +0.4746 | +1.1597 | 1.8 × 10⁻⁴ |
| Median 5NN distance | 4.6473 | 3.7744 | +0.8729 | +0.4161 | +1.2864 | 3.0 × 10⁻⁴ |

All values are in the raw 256-D `last_alignn_pool` embedding space, Euclidean distance metric.  
Statistical method: 5,000 bootstrap resamples, 10,000 permutations, Benjamini–Hochberg FDR correction within statistic.

### Per-instance scope

| Instance | Document | Section |
|----------|----------|---------|
| 1 | nitride_final.docx | §3.5 |
| 2 | combined_final.docx | §IV.4.5 |
| 3 | combined_final.docx | §VI.C |

All three instances use the same table content.

### Notes
- The manuscript prose rounds q-values to `1.3 × 10⁻⁴` and `1.8 × 10⁻⁴`. Use these rounded forms in the table.
- The Pearson r and median values are reported in supplementary/appendix context in the manuscript; verify whether they belong in the main-text table or in a note/footnote.
- Distance values (4.5988, 3.7821) are in the embedding-space Euclidean distance units (dimensionless L2 distance in 256-D space). Do not append units in the column header; include a table note.

---

## Source File Reference Index

| Source file | Tables served |
|------------|--------------|
| `data_shared/oxide/summaries/summary.json` | TAB_METHODS_DATASET_SPLITS (oxide row) |
| `data_shared/nitride/summaries/summary.json` | TAB_METHODS_DATASET_SPLITS (nitride row) |
| `reports/zero_shot/zero_shot_summary.csv` | TAB_ZS_SUMMARY |
| `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.csv` | TAB_METHODS_EXPERIMENT_SCOPE (run counts), TAB_S1_FT_SUMMARY_BY_N, TAB_S1_FS_SUMMARY (transfer gaps), TAB_EA_FAMILY_SEPARATION (confirmation) |
| `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv` | TAB_S1_FT_SUMMARY_BY_N (primary) |
| `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv` | TAB_S1_FS_SUMMARY (scratch MAEs) |
| `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` | TAB_EA_FAMILY_SEPARATION |
| `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv` | TAB_EA_DISTANCE_ERROR_STATS |

All source files confirmed present on disk as of 2026-04-24.
