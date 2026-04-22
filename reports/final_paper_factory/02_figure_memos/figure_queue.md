# Figure Queue

**Purpose:** Human-readable companion to `figure_queue.csv`. Lists all figures assigned to the three report streams, their source paths, placement (main text vs appendix), linked evidence tables, and copy status.

All currently listed core main-text figures exist in the repo.

---

## Core Main-Text Figures

These figures are copied to `core_figures/`.

---

### Shared / Multi-report Figures

#### FIG_SCHEMATIC
- **Status:** exists
- **Report membership:** all three reports
- **Placement:** main text
- **Purpose:** Study design schematic showing oxide as in-distribution control and nitride as out-of-distribution test with zero-shot / fine-tune / scratch protocol
- **Linked table:** none
- **Source path:** `reports/final_paper_factory/02_figure_memos/core_figures/FIG_SCHEMATIC.png`
- **Copied to:** `core_figures/FIG_SCHEMATIC.png`

#### FIG_ZS_COMPARISON
- **Status:** exists
- **Report membership:** nitride | combined | oxide (optional)
- **Placement:** main text
- **Purpose:** Side-by-side bar or paired comparison of oxide vs nitride zero-shot MAE; establishes the domain-shift baseline gap
- **Linked table:** `reports/zero_shot/zero_shot_summary.csv`
- **Source path:** `reports/final_paper_factory/02_figure_memos/core_figures/FIG_ZS_COMPARISON.png`
- **Vector source path:** `reports/final_paper_factory/02_figure_memos/core_figures/FIG_ZS_COMPARISON.svg`
- **Copied to:** `core_figures/FIG_ZS_COMPARISON.png`

#### FIG_TRANSFER_BENEFIT
- **Status:** exists
- **Report membership:** combined
- **Placement:** main text
- **Purpose:** Side-by-side grouped bar: oxide and nitride transfer benefit (from_scratch_minus_finetune_mae) at N=50 and N=500 ONLY; scope strictly limited to these two N values
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- **Additional linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.png`
- **Vector source path:** `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.svg`
- **PDF source path:** `reports/final_paper_factory/02_figure_memos/core_figures/FIG_TRANSFER_BENEFIT.pdf`
- **Copied to:** `core_figures/FIG_TRANSFER_BENEFIT.png`
- **Note:** Scope is strictly `N=50` and `N=500`; nitride `N=50` is flagged as pretrained initialization advantage, not strong fine-tuning adaptation.

---

### Learning Curves

#### FIG_S1_LC_OXIDE
- **Status:** exists
- **Report membership:** oxide | combined
- **Placement:** main text
- **Purpose:** Oxide fine-tuning learning curve across N under canonical Set 1 setting; shows smooth adaptation from N≥50
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/Hyperparameter Set 1/Learning Curves/Oxide Learning Curve - Hyperparameter Set 1.png`
- **Copied to:** `core_figures/FIG_S1_LC_OXIDE.png`

#### FIG_S1_LC_NITRIDE
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** main text
- **Purpose:** Nitride fine-tuning learning curve across N under canonical Set 1 setting; shows inertness at N≤200 and onset at N=500
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/Hyperparameter Set 1/Learning Curves/Nitride Learning Curve - Hyperparameter Set 1.png`
- **Copied to:** `core_figures/FIG_S1_LC_NITRIDE.png`

---

### Parity Plots — Main Text

#### FIG_S1_PARITY_OXIDE_N10
- **Status:** exists
- **Report membership:** oxide | combined
- **Placement:** main text
- **Purpose:** Oxide parity plot at N=10; paired with low-N checkpoint caveat; shows zero-shot-state error distribution
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=10.png`
- **Copied to:** `core_figures/FIG_S1_PARITY_OXIDE_N10.png`

#### FIG_S1_PARITY_OXIDE_N1000
- **Status:** exists
- **Report membership:** oxide | combined
- **Placement:** main text
- **Purpose:** Oxide parity plot at N=1000; shows best oxide fine-tuning error structure
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=1000.png`
- **Copied to:** `core_figures/FIG_S1_PARITY_OXIDE_N1000.png`

#### FIG_S1_PARITY_NITRIDE_N10
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** main text
- **Purpose:** Nitride parity plot at N=10; inert regime; checkpoint is zero-shot state; shows domain-shift error floor
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=10.png`
- **Copied to:** `core_figures/FIG_S1_PARITY_NITRIDE_N10.png`

#### FIG_S1_PARITY_NITRIDE_N1000
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** main text
- **Purpose:** Nitride parity plot at N=1000; shows best nitride fine-tuning result despite not surpassing zero-shot
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`
- **Source path:** `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=1000.png`
- **Copied to:** `core_figures/FIG_S1_PARITY_NITRIDE_N1000.png`

---

### Comparison Plots (Finetune vs From-Scratch)

#### FIG_S1_COMP_OXIDE
- **Status:** exists
- **Report membership:** oxide | combined
- **Placement:** main text
- **Purpose:** Oxide finetune vs from-scratch comparison at N=50 and N=500; quantifies pretraining value on control task
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- **Source path:** `reports/Hyperparameter Set 1/Comparison Plots/Oxide Comparison Plot - Hyperparameter Set 1.png`
- **Copied to:** `core_figures/FIG_S1_COMP_OXIDE.png`

#### FIG_S1_COMP_NITRIDE
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** main text
- **Purpose:** Nitride finetune vs from-scratch comparison at N=50 and N=500; N=50 is initialization advantage; N=500 is first real adaptation comparison
- **Linked table:** `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`
- **Source path:** `reports/Hyperparameter Set 1/Comparison Plots/Nitride Comparison Plot - Hyperparameter Set 1.png`
- **Copied to:** `core_figures/FIG_S1_COMP_NITRIDE.png`

---

### Embedding Analysis — Main Text

#### FIG_EA_6A_PCA
- **Status:** exists
- **Report membership:** nitride | combined | oxide (optional)
- **Placement:** main text
- **Purpose:** PCA of last_alignn_pool on fixed test set colored by family; shows family separation in raw pretrained space
- **Linked table:** `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- **Source path:** `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_fixed_test_family.png`
- **Copied to:** `core_figures/FIG_EA_6A_PCA.png`

#### FIG_EA_6B_TSNE
- **Status:** exists
- **Report membership:** nitride | combined | oxide (optional)
- **Placement:** main text
- **Purpose:** t-SNE (perplexity=30) of last_alignn_pool on fixed test set colored by family; canonical perplexity selection
- **Linked table:** `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- **Source path:** `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p30.png`
- **Copied to:** `core_figures/FIG_EA_6B_TSNE_P30.png`
- **Note:** t-SNE preserves local neighborhoods but not global inter-cluster distances; interpret cautiously.

#### FIG_EA_6C_UMAP
- **Status:** exists
- **Report membership:** nitride | combined | oxide (optional)
- **Placement:** main text
- **Purpose:** UMAP (n_neighbors=30) of last_alignn_pool on fixed test set colored by family; canonical n_neighbors selection
- **Linked table:** `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- **Source path:** `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n30.png`
- **Copied to:** `core_figures/FIG_EA_6C_UMAP_N30.png`

#### FIG_EA_6D_BOXPLOT
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** main text
- **Purpose:** Primary FIG_EA_6D: hard vs easy nitride boxplot by kNN5 distance quartile; illustrates hard-minus-easy mean gap
- **Linked table:** `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- **Source path:** `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_hard_easy_boxplot.png`
- **Copied to:** `core_figures/FIG_EA_6D_KNN5_BOXPLOT.png`

#### FIG_EA_6D_SCATTER
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** main text
- **Purpose:** Companion to FIG_EA_6D_BOXPLOT: scatter of kNN5 distance vs absolute error; illustrates Spearman correlation; use alongside or as alternative to boxplot
- **Linked table:** `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- **Source path:** `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_knn5_mean_distance_vs_abs_error.png`
- **Copied to:** `core_figures/FIG_EA_6D_KNN5_SCATTER.png`

---

## Appendix Figures

These figures are copied to `appendix_figures/`.

---

### Parity Plots — Appendix (Oxide)

| Label | N | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_PARITY_OXIDE_N50 | 50 | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=50.png` | `appendix_figures/FIG_S1_PARITY_OXIDE_N50.png` |
| FIG_APP_PARITY_OXIDE_N100 | 100 | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=100.png` | `appendix_figures/FIG_S1_PARITY_OXIDE_N100.png` |
| FIG_APP_PARITY_OXIDE_N200 | 200 | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=200.png` | `appendix_figures/FIG_S1_PARITY_OXIDE_N200.png` |
| FIG_APP_PARITY_OXIDE_N500 | 500 | `reports/Hyperparameter Set 1/Parity Plots/Oxide Parity Plot - Hyperparameter Set 1 N=500.png` | `appendix_figures/FIG_S1_PARITY_OXIDE_N500.png` |

**Purpose:** Oxide parity progression N=50 through N=500; appendix robustness for the two main-text parity plots (N=10 and N=1000). N=50 is the first genuine adaptation checkpoint.

---

### Parity Plots — Appendix (Nitride)

| Label | N | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_PARITY_NITRIDE_N50 | 50 | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=50.png` | `appendix_figures/FIG_S1_PARITY_NITRIDE_N50.png` |
| FIG_APP_PARITY_NITRIDE_N100 | 100 | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=100.png` | `appendix_figures/FIG_S1_PARITY_NITRIDE_N100.png` |
| FIG_APP_PARITY_NITRIDE_N200 | 200 | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=200.png` | `appendix_figures/FIG_S1_PARITY_NITRIDE_N200.png` |
| FIG_APP_PARITY_NITRIDE_N500 | 500 | `reports/Hyperparameter Set 1/Parity Plots/Nitride Parity Plot - Hyperparameter Set 1 N=500.png` | `appendix_figures/FIG_S1_PARITY_NITRIDE_N500.png` |

**Purpose:** Nitride parity progression. N=50, 100, 200 are all inert-regime evidence (mean_best_epoch=1.0); N=500 is the first genuine adaptation. Appendix evidence for the inertness claim.

---

### Embedding Robustness — t-SNE Parameter Variants

| Label | Perplexity | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_TSNE_P15 | 15 | `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p15.png` | `appendix_figures/FIG_EA_TSNE_P15.png` |
| FIG_APP_TSNE_P50 | 50 | `reports/week4_embedding_analysis/figures/tsne/last_alignn_pool_fixed_test_family_p50.png` | `appendix_figures/FIG_EA_TSNE_P50.png` |

**Purpose:** Robustness checks for canonical t-SNE (p=30). Show family separation is not perplexity-sensitive.

---

### Embedding Robustness — UMAP Parameter Variants

| Label | n_neighbors | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_UMAP_N15 | 15 | `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n15.png` | `appendix_figures/FIG_EA_UMAP_N15.png` |
| FIG_APP_UMAP_N50 | 50 | `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n50.png` | `appendix_figures/FIG_EA_UMAP_N50.png` |

**Purpose:** Robustness checks for canonical UMAP (n=30). Show family separation is not n_neighbors-sensitive.

---

### Embedding Robustness — Alternative Layers

| Label | Layer | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_PCA_PRE_HEAD | pre_head | `reports/week4_embedding_analysis/figures/pca/pre_head_fixed_test_family.png` | `appendix_figures/FIG_EA_PCA_PRE_HEAD.png` |
| FIG_APP_PCA_LAST_GCN_POOL | last_gcn_pool | `reports/week4_embedding_analysis/figures/pca/last_gcn_pool_fixed_test_family.png` | `appendix_figures/FIG_EA_PCA_LAST_GCN_POOL.png` |

**Purpose:** Appendix-support layers only. Near-duplicate of last_alignn_pool in family-separation metrics. Do not use as co-equal main-text evidence.

---

### Embedding — Hard/Easy Nitride Context

#### FIG_APP_PCA_HARD_EASY
- **Status:** exists
- **Report membership:** nitride | combined
- **Placement:** appendix
- **Purpose:** PCA of last_alignn_pool with nitrides colored by hard/easy label; balanced pool; appendix context for domain-shift mechanism
- **Linked table:** `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv`
- **Source path:** `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_hard_easy_nitrides_on_balanced_pool.png`
- **Copied to:** `appendix_figures/FIG_EA_PCA_HARD_EASY.png`

---

### Embedding Distance Metric Robustness

| Label | Distance Metric | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_CENTROID_BOXPLOT | centroid | `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_centroid_distance_hard_easy_boxplot.png` | `appendix_figures/FIG_EA_CENTROID_BOXPLOT.png` |
| FIG_APP_MAHAL_BOXPLOT | Mahalanobis (LW) | `reports/week4_embedding_analysis/figures/distance_vs_error/last_alignn_pool_oxide_mahalanobis_lw_distance_hard_easy_boxplot.png` | `appendix_figures/FIG_EA_MAHAL_BOXPLOT.png` |

**Purpose:** Robustness checks against canonical kNN5 metric. Show hard-easy separation holds under alternative distance definitions.

---

### Element-Level Embeddings (Appendix)

| Label | Plot Type | Source Path | Copied To |
|---|---|---|---|
| FIG_APP_ELEMENT_PCA | PCA | `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_pca.png` | `appendix_figures/FIG_EA_ELEMENT_PCA.png` |
| FIG_APP_ELEMENT_TSNE | t-SNE | `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_tsne.png` | `appendix_figures/FIG_EA_ELEMENT_TSNE.png` |
| FIG_APP_ELEMENT_UMAP | UMAP | `reports/week4_embedding_analysis/figures/element_appendix/element_embedding_umap.png` | `appendix_figures/FIG_EA_ELEMENT_UMAP.png` |

**Purpose:** Appendix context showing what the pretrained representation encodes at element level. Not part of the main domain-shift argument.

---

## Summary Counts

| Category | Count |
|---|---|
| Core main-text figures (exists) | 16 |
| Core main-text figures (to_be_created) | 0 |
| Appendix figures | 20 |
| **Total** | **36** |

### Figures to be created

No figures are currently marked `to_be_created`.

### Canonical embedding layer reminder

Main-text embedding figures use `last_alignn_pool` only. `pre_head` and `last_gcn_pool` figures are appendix_support and must not be presented as co-equal evidence.
