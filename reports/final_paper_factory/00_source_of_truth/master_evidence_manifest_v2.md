# Master Evidence Manifest v2

This is the authoritative evidence-policy document for the RES201 paper phase. Canonical namespace decisions and writing rules live in `source_of_truth_memo_v2.md`. This document records what artifact belongs where and at what tier.

---

## Document hierarchy

| Document | Role |
|---|---|
| `source_of_truth_memo_v2.md` | Decision rationale, empirical caveats, writing guardrails |
| `master_evidence_manifest_v2.md` (this file) | Authoritative artifact inventory and tier classification |
| `figure_inventory_v2.csv` | Figure-level detail with paths, scope, and section mapping |
| `table_inventory_v2.csv` | Table-level detail with paths, scope, and section mapping |
| `claim_support_map_v2.csv` | Claim-to-evidence linkage and decision record |

---

## Canonical decisions

- Main-results namespace: `Results_Hyperparameter_Set_1/`
- Canonical report bundle for the main setting: `reports/Hyperparameter Set 1/`
- Canonical zero-shot namespace: `Results_Before_Correction/` with `reports/zero_shot/zero_shot_summary.csv`
- Canonical embedding-analysis package: `reports/week4_embedding_analysis/`
- Robustness namespaces: `Results_Hyperparameter_Set_2/` and `Results_Hyperparameter_Set_3/`
- Provenance-only report bundles: `reports/week2/` and `reports/provenance/colab/`

**Zero-shot namespace policy:** Zero-shot is treated as a shared pretrained baseline outside the fine-tuning namespace hierarchy. Its authoritative files remain in `reports/zero_shot/` and `Results_Before_Correction/` while Set 1 governs fine-tuning and from-scratch reporting. This split is intentional and must not be collapsed.

---

## Coverage snapshot

| Category | Canonical source | Comparison or appendix coverage | Verified coverage |
|---|---|---|---|
| Zero-shot evaluation | `reports/zero_shot/zero_shot_summary.csv` plus the two `Results_Before_Correction/.../zero_shot/predictions.csv` files | None | 2 families; 1726 fixed-test predictions total |
| Fine-tuning main setting | Set 1 summary tables and Set 1 learning curves | Set 1 parity and training-curve manifests as appendix support | Set 1 complete: 60 runs |
| From-scratch main setting | Set 1 from-scratch summary tables and Set 1 comparison plots | Set 1 training-curve manifest as appendix support | Set 1 complete: 20 runs |
| Hyperparameter robustness | Set 2 and Set 3 summary bundles and aggregate plots | Set 2 and Set 3 parity and training-curve manifests | Set 2 complete: 60 FT + 20 FS; Set 3 complete: 60 FT + 20 FS |
| Embedding analysis | `reports/week4_embedding_analysis/final_figures/figure6a-d` plus `family_separation_metrics.csv` and `nitride_distance_error_stats.csv` | Sensitivity figures and detailed embedding tables | 4 curated main-text figures; 4 sensitivity appendix figures; 5 structured tables |
| Historical provenance | None | `reports/week2/` and `reports/provenance/colab/` | Retained for auditability only |

---

## What belongs in main text

**Tier 1 — non-negotiable main-text items**

- Zero-shot summary table: `reports/zero_shot/zero_shot_summary.csv`
- Set 1 fine-tuning summary: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- Set 1 oxide and nitride learning curves (2 figures)
- Set 1 from-scratch summary: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- Set 1 oxide and nitride comparison plots (2 figures)
- Embedding Figure 6 panels 6a–6d (4 figures)
- Embedding quantitative tables: `family_separation_metrics.csv` and `nitride_distance_error_stats.csv`

**Tier 2 — main-text candidates pending figure memo decisions**

- Selected parity plots: oxide N=10, oxide N=1000, nitride N=10, nitride N=1000
- Zero-shot oxide vs nitride comparison figure (to be created from `zero_shot_summary.csv`)
- Study design schematic (to be created)
- Direct transfer-benefit across families figure (to be created or adapted from comparison plots)

**Tier 2 does not automatically enter main text. Each item requires a figure memo before promotion is confirmed.**

---

## What stays out of main text by default

- Set 1 parity plots other than the 4 promoted candidates
- Set 1 per-run training curves (60 FT + 20 FS)
- All Set 2 and Set 3 artifacts unless the paper explicitly enters a robustness or hyperparameter-sensitivity section
- Embedding sensitivity figures for alternate t-SNE perplexities and UMAP neighbor counts
- Detailed embedding tables: per-structure distance listings, PCA explained-variance table, element-correlation table
- Subset counts table (`subset_counts.csv`) — methods support only; not a paper table
- Historical `reports/week2/` and `reports/provenance/colab/` bundles

---

## Guardrails

- Treat `Results_Hyperparameter_Set_1/` as the main-results namespace because it matches the project-brief setting `epochs=50`, `batch_size=16`, and `learning_rate=1e-4`.
- Treat Set 2 and Set 3 as robustness namespaces even though they are complete and numerically competitive.
- Keep zero-shot evidence anchored to `Results_Before_Correction/` and `reports/zero_shot/`.
- Anchor embedding claims to structured Week 4 tables. Use projection plots as descriptive support rather than primary statistics.
- Do not overwrite or regenerate result artifacts during the paper phase.
