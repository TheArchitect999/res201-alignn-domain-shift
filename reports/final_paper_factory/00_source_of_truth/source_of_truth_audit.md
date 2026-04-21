# Source-of-Truth Audit — Phase 1

Auditor: Claude Code  
Date: 2026-04-21  
Files audited: `master_evidence_manifest.csv`, `master_evidence_manifest.md`, `figure_inventory.csv`, `table_inventory.csv`, `claim_support_map.csv`, `source_of_truth_memo.md`

---

## Overall verdict

The pack is substantially sound. Namespace selection is justified, all primary paths were verified to exist on disk, and the quantitative anchors in `claim_support_map.csv` are accurate against the actual CSV outputs. Two missing figures, one classification mismatch with the REPORT_PLAN, and one number that needs contextual annotation are the items to resolve before Phase 4.

---

## 1. Canonical namespace selection

**Verdict: Justified.**

`Results_Hyperparameter_Set_1` matches the project-brief setting (`epochs=50`, `batch_size=16`, `learning_rate=1e-4`). Three independent repo documents confirm the mapping: `README.md`, `configs/README.md`, and `Results_Hyperparameter_Set_1/README.md`. The Week 4 embedding analysis already uses Set 1 as the error-linked namespace, so the embedding analysis is internally consistent with the main namespace choice.

The memo correctly flags that Set 2 and Set 3 are numerically closer to zero-shot than Set 1. This is real and will need explicit framing in the paper — the canonical setting is brief-specified, not cherry-picked for performance. That framing is the correct one. Do not change the namespace selection; change the prose framing.

---

## 2. Missing figures

Two gaps relative to the REPORT_PLAN Phase 4 core figure list.

### Gap 1 — Study design schematic (REPORT_PLAN core figure 1)

No entry exists in `figure_inventory.csv` for a study design schematic. This figure does not exist as a repo artifact — it must be created during the writing phase (drawn or assembled, not generated from experiments). Phase 4 cannot queue it for a figure memo until a source file is designated.

**Action before Phase 4:** decide whether to create this as a diagram (tikz, draw.io, PowerPoint) and note its intended location. Add a placeholder row to `figure_inventory.csv` with `main_text_status = to_be_created`.

### Gap 2 — Zero-shot oxide vs nitride comparison figure (REPORT_PLAN core figure 4)

The figure inventory has no dedicated figure for zero-shot performance comparison. Only `TAB_ZS_SUMMARY` (the CSV table) exists. The REPORT_PLAN core figure list specifically lists "Zero-shot oxide vs nitride comparison" as a main-text figure, not only a table.

**Possible resolutions:**
- A bar chart or two-column comparison derived from `reports/zero_shot/zero_shot_summary.csv` would satisfy this.
- Alternatively, the comparison plots (`FIG_S1_COMP_OXIDE`, `FIG_S1_COMP_NITRIDE`) show zero-shot as a reference line and partially serve this purpose, but they are family-separated, not a direct head-to-head panel.

**Action before Phase 4:** decide whether to generate a zero-shot comparison figure or rely on the table plus comparison-plot reference lines. Record the decision in the figure inventory.

---

## 3. Main-text vs appendix classification

### Parity plots — classification mismatch with REPORT_PLAN

The figure inventory classifies the full parity collection (`FIG_S1_PARITY_COLLECTION`) as `appendix_support`. However, the REPORT_PLAN Phase 4 core figure list (items 6–9) explicitly names four specific parity plots as core figures:

- Oxide low-N parity plot
- Oxide high-N parity plot
- Nitride low-N parity plot
- Nitride high-N parity plot

These four panels exist on disk (confirmed: 12 PNG/PDF pairs in `reports/Hyperparameter Set 1/Parity Plots/`). They are being treated as undifferentiated appendix material when the plan intends four of them to carry main-text weight.

**Action:** Before Phase 4, designate the four specific parity plots (suggested: N=10 and N=1000 for each family) as `main_text_candidate` entries in the figure inventory. Keep the remaining 8 as `appendix_support`. The figure memo phase needs this distinction to prioritize correctly.

### All other classifications are sensible

- Learning curves (main text), comparison plots (main text), embedding Figure 6 panels (main text): correct.
- Per-run training curve collections (appendix), sensitivity embedding figures (appendix): correct.
- Set 2 and Set 3 bundles (robustness/appendix only): correct.
- Historical provenance bundles (audit trail only): correct.

---

## 4. Path integrity

All paths verified on disk. No broken references found.

| Path category | Status |
|---|---|
| `reports/zero_shot/zero_shot_summary.csv` | ✓ exists |
| `Results_Before_Correction/oxide/zero_shot/predictions.csv` | ✓ exists |
| `Results_Before_Correction/nitride/zero_shot/predictions.csv` | ✓ exists |
| `reports/Hyperparameter Set 1/` (all subfolders) | ✓ exists |
| `reports/Hyperparameter Set 2/` (all subfolders) | ✓ exists |
| `reports/Hyperparameter Set 3/` (all subfolders) | ✓ exists |
| `reports/week4_embedding_analysis/final_figures/` (all 8 figures) | ✓ exists |
| `reports/week4_embedding_analysis/tables/` (all 5 tables) | ✓ exists |
| `reports/week4_embedding_analysis/figures/` (all 4 subfolders) | ✓ exists |
| `reports/week4_embedding_analysis/subset_counts.csv` | ✓ exists |
| `data_shared/oxide/summaries/summary.json` | ✓ exists |
| `data_shared/nitride/summaries/summary.json` | ✓ exists |
| `manifests/dft_3d_formation_energy_peratom_splits.csv` | ✓ exists |
| `reports/week2/` | ✓ exists (provenance only) |
| `reports/provenance/colab/` | ✓ exists (provenance only) |
| Secondary memo files in `reports/week4_embedding_analysis/` | ✓ all exist |

One minor precision note: `FIG_S1_FT_02` and `FIG_S1_FS_02` in the figure inventory use directory-level paths (`reports/Hyperparameter Set 1/Learning Curves/`) rather than specific filenames. The actual files (`Oxide Learning Curve - Hyperparameter Set 1.png`, etc.) exist and are confirmed. For Phase 4 figure memos, use the full filenames, not the directory paths.

---

## 5. Number accuracy and annotation

### Zero-shot anchors — verified

Verified directly from `reports/zero_shot/zero_shot_summary.csv`:
- Oxide zero-shot MAE: **0.03418 eV/atom** (n_test = 1484) ✓
- Nitride zero-shot MAE: **0.06955 eV/atom** (n_test = 242) ✓

These match CLM_02 exactly. Use these as the fixed comparison baseline throughout all drafts.

### CLM_03 (oxide fine-tuning never beats zero-shot) — verified

Confirmed from `finetune_summary_by_N.csv`. Best oxide fine-tune MAE is 0.04169 at N=1000, worse than zero-shot 0.03418. The negative `transfer_gain_vs_zero_shot` at every N confirms the claim. ✓

### CLM_04 (nitride fine-tuning never beats zero-shot) — verified but needs annotation

The claim is numerically correct. However, the statement "Best nitride fine-tune mean is 0.08742 at N=10" requires contextual annotation for safe writing use.

From the CSV, nitride `mean_best_epoch` at N=10 is **1.0** — meaning across 5 runs, early stopping selected epoch 1 as the best checkpoint. This means the "best" fine-tuned model at N=10 is essentially the pretrained zero-shot state with minimal (or no effective) weight updates. The model with 5 training samples immediately overshoots.

**Writing implication:** Do not present this as evidence that small-N fine-tuning is effective. The correct framing is that with only N=10 nitride samples, the pretrained model provides no additional signal above zero-shot when fine-tuned under the canonical 50-epoch setting. At larger N (500–1000), more epochs become useful (best_epoch ~40–45) but still fail to match zero-shot performance.

**Action:** Add this annotation to CLM_04 in `claim_support_map.csv` before the nitride drafting phase.

### CLM_07 (hyperparameter sensitivity) — correctly identified

Set 2 and Set 3 fine-tuning results are numerically closer to zero-shot than Set 1. This tension is real. Writers should frame Set 1 as "the brief-specified setting" and treat the better-performing sets as robustness evidence only — not as an argument that a different setting should have been chosen as the main result.

---

## 6. Items not requiring action

- The `pre_head` / `last_gcn_pool` identity warning (CLM_11) is correctly documented. No writing should distinguish these layers.
- The ALIGNN tutorial (`paper_sources/`) is correctly classified as internal scaffolding, not a scholarly anchor.
- Historical bundles in `reports/week2/` and `reports/provenance/colab/` are correctly excluded from canonical use.
- The Set 3 provenance limitation (dataset_root folders not duplicated) is correctly noted.

---

## Stop/Go assessment

**Proceed to Phase 2 with the following pre-conditions:**

1. Add a placeholder entry for the study design schematic to `figure_inventory.csv` with `main_text_status = to_be_created`.
2. Decide and document whether a zero-shot comparison figure will be generated, or whether the table plus comparison-plot reference line is sufficient.
3. Promote 4 specific parity plots (oxide N=10, oxide N=1000, nitride N=10, nitride N=1000) to `main_text_candidate` in `figure_inventory.csv`.
4. Add a context annotation to CLM_04 noting that `mean_best_epoch = 1.0` at N=10 implies the "fine-tuned" model is effectively in the zero-shot state.

None of these block Phase 2 (canonical numbers), but all four must be resolved before Phase 4 (figure memos).
