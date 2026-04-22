# Embedding Interpretation Packet

Status: combined-paper source packet for Results IV embedding analysis and its handoff from Results III.

Canonical namespace: Week 4 embedding analysis, primary layer `last_alignn_pool`, raw 256D metrics for statistical claims, PCA/t-SNE/UMAP as descriptive projections.

## Source Priority

| Evidence type | Primary source |
|---|---|
| Blueprint structure | `reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md` |
| Canonical numbers | `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md` and `.csv` |
| Family-separation metrics | `reports/week4_embedding_analysis/tables/family_separation_metrics.csv` |
| Distance-error metrics | `reports/week4_embedding_analysis/tables/nitride_distance_error_stats.csv` |
| PCA variance | `reports/week4_embedding_analysis/tables/pca_explained_variance.csv` |
| Subset counts | `reports/week4_embedding_analysis/subset_counts.csv` |
| Figure memos | `reports/final_paper_factory/02_figure_memos/fig10_embedding_pca_memo.md` through `fig13b_nitride_distance_error_scatter_memo.md` |

## Results IV Job

Results IV should make the domain-shift interpretation geometrically legible without claiming causality. It has two jobs:

1. Show that the frozen pretrained representation separates oxide and nitride families in raw `last_alignn_pool` space.
2. Show that, within nitrides, zero-shot error co-varies with distance from the oxide-reference region.

## Behavioral Handoff From Results III

The embedding section should start from the direct-comparison results, not replace them:

- Zero-shot: nitride MAE `0.0695 eV/atom` vs oxide MAE `0.0342 eV/atom` (`2.03x` higher).
- Fine-tuning: oxide begins genuine optimization by `N=50`; nitride remains operationally inert through `N=200`.
- High-N nitride: genuine adaptation begins at `N=500` and `N=1000`, but the best genuinely adapted nitride row still remains above nitride zero-shot.
- Transfer benefit: pretraining helps both families relative to scratch at `N=50` and `N=500`; nitride `N=50` is initialization advantage over scratch, not adaptation.

One-sentence bridge: The performance curves establish the behavioral domain-shift penalty; the embedding analysis asks whether the frozen pretrained representation contains geometric structure consistent with that penalty.

## Embedding Figure Memo Set

| Figure | Source figure | Memo | Main use |
|---|---|---|---|
| `FIG_EA_6A_PCA` | `core_figures/FIG_EA_6A_PCA.png` | `fig10_embedding_pca_memo.md` | Opening family-separation panel; conservative linear projection. |
| `FIG_EA_6B_TSNE` | `core_figures/FIG_EA_6B_TSNE_P30.png` | `fig11_embedding_tsne_memo.md` | Local-neighborhood view at perplexity `30`. |
| `FIG_EA_6C_UMAP` | `core_figures/FIG_EA_6C_UMAP_N30.png` | `fig12_embedding_umap_memo.md` | Neighborhood/manifold view at `n_neighbors = 30`. |
| `FIG_EA_6D_BOXPLOT` | `core_figures/FIG_EA_6D_KNN5_BOXPLOT.png` | `fig13_nitride_distance_error_memo.md` | Hard-vs-easy nitride distance contrast. |
| `FIG_EA_6D_SCATTER` | `core_figures/FIG_EA_6D_KNN5_SCATTER.png` | `fig13b_nitride_distance_error_scatter_memo.md` | Full-sample nitride error-distance association. |

Appendix-only embedding figures:

| Group | Files |
|---|---|
| t-SNE sensitivity | `FIG_EA_TSNE_P15.png`, `FIG_EA_TSNE_P50.png` |
| UMAP sensitivity | `FIG_EA_UMAP_N15.png`, `FIG_EA_UMAP_N50.png` |
| Alternative layers | `FIG_EA_PCA_PRE_HEAD.png`, `FIG_EA_PCA_LAST_GCN_POOL.png` |
| Hard/easy PCA context | `FIG_EA_PCA_HARD_EASY.png` |
| Distance robustness | `FIG_EA_CENTROID_BOXPLOT.png`, `FIG_EA_MAHAL_BOXPLOT.png` |
| Element embeddings | `FIG_EA_ELEMENT_PCA.png`, `FIG_EA_ELEMENT_TSNE.png`, `FIG_EA_ELEMENT_UMAP.png` |

## Raw Embedding Summary Metrics

Primary reported layer: `last_alignn_pool`.

Primary subset for family separation: fixed test set (`1726` structures total: `1484` oxides and `242` nitrides).

| Metric | Scope | Value | 95% CI | Interpretation |
|---|---|---:|---|---|
| Silhouette score | overall | `0.2392490544` | `0.2331648813` to `0.2456353033` | Families are separated in raw space. |
| Silhouette score | oxide | `0.2545637433` | `0.2476217597` to `0.2616933351` | Oxide region is more cohesive. |
| Silhouette score | nitride | `0.1453358383` | `0.1316160217` to `0.1581706088` | Nitride region is distinguishable but less cohesive. |
| Davies-Bouldin index | overall | `1.8289881054` | `1.7339536904` to `1.9071249603` | Raw-space cluster separation summary. |
| 15-NN family purity | overall | `0.9655465431` | `0.9602925840` to `0.9707609115` | Local neighborhoods are strongly family structured. |
| 15-NN family purity | oxide | `0.9871518419` | `0.9832423630` to `0.9905671608` | Oxide neighborhoods are very pure. |
| 15-NN family purity | nitride | `0.8330578512` | `0.7977823691` to `0.8644628099` | Nitride neighborhoods are less pure than oxide. |
| Logistic-regression family AUC | overall | `0.9993623443` | `0.9983647892` to `0.9999443792` | Family labels are almost perfectly recoverable from frozen embeddings. |

PCA support for `last_alignn_pool`:

| PCA fit subset | PC1 variance | PC2 variance | Cumulative 2D variance |
|---|---:|---:|---:|
| Balanced pool set (`4092` structures) | `18.1265%` | `9.4719%` | `27.5984%` |

## Raw Distance-Error Summary Metrics

Primary metric: mean Euclidean distance from each nitride test embedding to its `5` nearest oxide-reference embeddings in raw 256D `last_alignn_pool` space.

Reference sets:

- Nitride test set: `242` structures.
- Oxide reference pool: `13507` oxide train+val structures.
- Hard nitrides: top `20%` by absolute zero-shot error (`49` structures).
- Easy nitrides: bottom `20%` by absolute zero-shot error (`49` structures).

| Statistic | Value | 95% CI / detail | FDR q | Interpretation |
|---|---:|---|---:|---|
| Hard mean 5NN oxide distance | `4.5988141847` | hard group | -- | Hard nitrides lie farther from oxide neighbors. |
| Easy mean 5NN oxide distance | `3.7820522463` | easy group | -- | Easy nitrides lie closer on average. |
| Hard-minus-easy mean gap | `0.8167619385` | `0.4745924078` to `1.1596977522` | `0.0001799820` | Strong tail-group distance contrast. |
| Hard-minus-easy median gap | `0.8729275210` | `0.4161000885` to `1.2864051002` | `0.0002999700` | Same direction by medians. |
| Spearman rho | `0.3427641603` | `0.2213574115` to `0.4597133751` | `0.0001285586` | Positive full-sample monotonic association. |
| Pearson r | `0.2769539690` | `0.1740654951` to `0.3889666434` | `0.0001285586` | Positive full-sample linear association. |

## Figure-Level Interpretation

### Family-Separation Panels

`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, and `FIG_EA_6C_UMAP` should be interpreted as projection views of the same underlying result: oxide and nitride structures are not randomly mixed in the frozen pretrained `last_alignn_pool` space.

Best phrasing: The projections are visually consistent with family-level representation shift, while the raw 256D metrics provide the quantitative evidence.

Avoid: Claims that visual distances in PCA, t-SNE, or UMAP directly measure physical or chemical distance.

### Distance-Error Panels

`FIG_EA_6D_BOXPLOT` and `FIG_EA_6D_SCATTER` are stronger than the family-separation projections because they connect representation geometry to prediction difficulty inside the nitride family.

Best phrasing: Nitrides farther from the oxide-reference region tend to have larger zero-shot errors, making oxide-reference distance a correlational geometric indicator of domain-shift difficulty.

Avoid: Claims that oxide-reference distance alone explains error, causes error, or perfectly separates hard and easy nitrides.

## Strongest Evidence For The Domain-Shift Interpretation

1. Raw-space family separation: `last_alignn_pool` gives 15-NN family purity `0.9655` and family AUC `0.9994`, so the frozen representation contains strong family information.
2. Asymmetric cohesion: oxide silhouette and 15-NN purity (`0.2546`, `0.9872`) exceed nitride values (`0.1453`, `0.8331`), so nitrides are distinguishable but less internally organized in the main representation.
3. Error-linked distance: hard nitrides sit farther from the oxide-reference region than easy nitrides by mean gap `0.8168` with FDR q `0.0001800`.
4. Continuous association: across all `242` nitrides, mean 5NN oxide distance correlates positively with absolute zero-shot error (Spearman rho `0.3428`, FDR q `0.0001286`).
5. Behavioral match: the embedding pattern aligns with the direct comparison packet: nitrides have worse zero-shot MAE, delayed adaptation, and persistent high-N fine-tuning shortfall relative to zero-shot.

Draftable Results IV synthesis: In the frozen `last_alignn_pool` representation, oxides and nitrides occupy strongly distinguishable family regions, but the nitride region is less cohesive than the oxide region; within nitrides, larger distance from the oxide-reference region co-varies with larger zero-shot error. Together these embedding results provide a correlational geometric counterpart to the behavioral domain-shift penalty.

## Strongest Caveats Against Overclaiming

- The embedding analysis is correlational. It does not prove that embedding distance causes prediction error.
- `last_alignn_pool` is the only main-text embedding layer. `pre_head` and `last_gcn_pool` are appendix-support layers and should not be presented as co-equal.
- PCA, t-SNE, and UMAP are projection figures. Raw 256D metrics are the statistical evidence.
- t-SNE and UMAP axes, global distances, apparent cluster sizes, and visual density should not be read metrically.
- Logistic AUC shows family-label recoverability, not a mechanism of formation-energy error.
- The oxide-reference pool is an operational reference region, not proof that the pretrained checkpoint is oxide-exclusive or oxide-pretrained.
- Hard/easy groups overlap in the distance-error plots; the association is moderate, not deterministic.
- The distance-error relationship is shown for absolute zero-shot error, not for fine-tuned error.
- Alternative layers give useful appendix robustness but include near-duplicate `pre_head` and `last_gcn_pool` behavior; avoid claiming layer-specific mechanistic differences unless the hook behavior is revisited.

## Recommended Figures For Results III

Results III is not the main home for embedding figures. It should use behavioral comparison figures:

| Subsection | Figure(s) | Why |
|---|---|---|
| Zero-shot family gap | `FIG_ZS_COMPARISON` | Establishes the direct zero-shot domain-shift penalty. |
| Differential fine-tuning response | `FIG_S1_LC_OXIDE` + `FIG_S1_LC_NITRIDE` | Shows oxide adaptation begins earlier and nitride low-N inertness persists through `N=200`. |
| Transfer-benefit contrast | `FIG_TRANSFER_BENEFIT` | Shows pretraining benefit over scratch at `N=50` and `N=500` only. |

Bridge sentence at end of Results III: Because the behavioral comparison shows a persistent nitride-side domain-shift penalty despite the practical value of pretraining, Results IV asks whether the frozen representation contains geometric structure consistent with that penalty.

## Recommended Figures For Results IV

Minimum Results IV set:

| Subsection | Figure(s) | Why |
|---|---|---|
| Family separation | `FIG_EA_6A_PCA` | Clean opening visual; paired with raw metrics table. |
| Distance-error association | `FIG_EA_6D_BOXPLOT` | Strongest hard/easy effect-size panel. |
| Distance-error continuity | `FIG_EA_6D_SCATTER` | Shows the full-sample association across all `242` nitrides. |

Expanded Results IV set:

| Figure(s) | Use |
|---|---|
| `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP` | Projection triptych for family separation, with raw metrics in text/table. |
| `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER` | Two-panel distance-error argument: tail contrast plus continuous relationship. |

Recommended compact caption logic:

- Family-separation panels: "Projection views are descriptive; quantitative values are raw-space `last_alignn_pool` metrics."
- Distance-error panels: "Distance to the oxide-reference region is associated with nitride zero-shot error; the relationship is correlational and non-deterministic."

Recommended table anchors:

| Table | Source | Placement |
|---|---|---|
| `TAB_EA_FAMILY_SEPARATION` | `family_separation_metrics.csv` | Results IV main text or compact table. |
| `TAB_EA_DISTANCE_ERROR_STATS` | `nitride_distance_error_stats.csv` | Results IV main text or compact table. |

Best compact Results IV package: `FIG_EA_6A_PCA`, `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER`, plus compact raw metrics in text.
