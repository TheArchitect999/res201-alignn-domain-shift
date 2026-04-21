# Figure Memo: Fig. 12 Embedding UMAP

## Metadata

- Figure label: `FIG_EA_6C_UMAP`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6C_UMAP_N30.png`
- Canonical source path: `reports/week4_embedding_analysis/figures/umap/last_alignn_pool_fixed_test_family_n30.png`
- Linked table: `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- Embedding source: `last_alignn_pool`
- Dataset: `fixed_test_set`
- UMAP setting: `n_neighbors = 30`
- Report membership: `nitride | combined | oxide_optional`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is a 2-D UMAP projection of the pretrained ALIGNN `last_alignn_pool` embeddings for the fixed test set, using the canonical `n_neighbors = 30` setting. The plotted test set contains `1726` structures total: `1484` oxides and `242` nitrides. Each point is colored only by chemical family.

Visually, the two families are not uniformly intermixed. Nitrides are concentrated mainly in a left-side, lower-left region of the map, while oxides occupy a broader manifold spanning most of the remaining area, especially the right-hand and upper regions. There is still visible overlap along the family boundary, and a small number of nitride points appear inside oxide-dominated regions. The panel therefore shows partial family-level separation in neighborhood structure rather than complete separation.

Because this figure uses the same fixed-test-set `last_alignn_pool` embeddings as the PCA and t-SNE panels, the linked metrics table provides the same quantitative family-separation summary for the underlying raw `256`-dimensional space:

- Overall silhouette score: `0.239` (95% CI `0.233-0.246`)
- Oxide silhouette score: `0.255` (95% CI `0.248-0.262`)
- Nitride silhouette score: `0.145` (95% CI `0.132-0.158`)
- Overall 15-NN family purity: `0.966` (95% CI `0.960-0.971`)
- Oxide 15-NN family purity: `0.987` (95% CI `0.983-0.991`)
- Nitride 15-NN family purity: `0.833` (95% CI `0.798-0.864`)
- Logistic-regression family AUC: `0.9994` (95% CI `0.9984-0.9999`)
- Davies-Bouldin index: `1.83` (95% CI `1.73-1.91`)

## Justified Interpretation

The safest interpretation is that the pretrained representation places oxides and nitrides into different neighborhood structures often enough to produce clear family-wise organization in the UMAP view. That is consistent with the broader domain-shift argument: oxides act as the in-distribution control family, while nitrides occupy a shifted region of pretrained representation space.

The main UMAP-specific nuance is that the figure is useful for showing relative localization and neighborhood organization, but not for making metric claims about exact distances, densities, or cluster sizes in the original embedding space. The left-side nitride region is therefore useful evidence that nitrides are not randomly dispersed through the oxide manifold, but it should not be treated as a direct quantitative map of the raw embeddings.

This figure also needs the same raw-space constraint as the PCA and t-SNE memos. Although the UMAP projection makes the nitride region look visually compact, the quantitative raw-space metrics still show that nitrides are the less cohesive family overall: nitride silhouette is `0.145` versus `0.255` for oxides, and nitride 15-NN purity is `0.833` versus `0.987` for oxides. The defensible combined interpretation is therefore: the families occupy distinct local regions, but nitrides remain the less internally coherent family in the underlying representation.

## Non-Claims / Cautions

- This figure does not prove that embedding-space shift causes nitride prediction difficulty; it provides correlational mechanistic context only.
- This figure does not justify interpreting the UMAP axes physically or metrically.
- This figure does not justify treating visual distances, densities, or cluster sizes in the UMAP plane as exact properties of the original `256`-dimensional space.
- This figure does not show complete oxide-nitride separability; overlap and a few cross-family outliers remain visible.
- This figure does not justify claiming that nitrides are more cohesive than oxides based on apparent visual compactness; the raw-space silhouette and kNN-purity values indicate the opposite.
- The reported silhouette, kNN-purity, logistic-AUC, and Davies-Bouldin values are computed in the raw embedding space, not on the 2-D UMAP coordinates.
- This figure does not compare fine-tuning against scratch, low `N` against high `N`, or one hyperparameter set against another.
- This figure does not establish which nitrides are hard or easy; that requires the separate distance-error analysis figure.

## Caption Draft

Figure X. UMAP projection of pretrained ALIGNN `last_alignn_pool` embeddings for the fixed test set, using the canonical `n_neighbors = 30` setting and colored by chemical family. The panel contains `1484` oxide structures and `242` nitride structures. Nitrides concentrate in a distinct left-side region of the map, whereas oxides occupy a broader manifold with partial overlap near the family boundary. Because UMAP is a nonlinear projection rather than a metric map of the original embedding space, the panel is interpreted as neighborhood-structure evidence consistent with family-level representation shift, not as a direct geometric measurement. Quantitative separation metrics are reported from the raw `256`-dimensional embeddings, including silhouette `0.239` overall (`0.255` oxide, `0.145` nitride), 15-NN family purity `0.966` overall (`0.987` oxide, `0.833` nitride), logistic-regression family AUC `0.9994`, and Davies-Bouldin index `1.83`.

## Results Paragraph Draft

As a third view of the same pretrained representation, Figure X shows a UMAP projection of the fixed-test-set `last_alignn_pool` embeddings at `n_neighbors = 30`. The panel contains `1484` oxides and `242` nitrides. The two families are not uniformly intermixed: nitrides are concentrated mainly in a left-side, lower-left region of the map, whereas oxides span a broader manifold across most of the remaining area, with partial overlap near the boundary. This pattern is consistent with family-level localization in pretrained space rather than a single fully mixed distribution. The raw-space separation metrics reported for the same `256`-dimensional embeddings support the same conclusion while also constraining over-interpretation: overall silhouette is `0.239` (95% CI `0.233-0.246`), oxide silhouette is `0.255`, nitride silhouette is `0.145`, and overall 15-NN family purity is `0.966` (`0.987` oxide, `0.833` nitride). Thus, the UMAP panel supports the claim that oxide and nitride structures occupy different embedding neighborhoods, but it does not overturn the quantitative result that nitrides are the less cohesive family in raw space.

## Discussion Paragraph Draft

The UMAP panel complements the PCA and t-SNE figures by showing the same family-separation result under a third projection method. That agreement across projections is useful because it makes the embedding argument less dependent on any single visualization. At the same time, the interpretation still has to stay disciplined: the panel supports the existence of different family regions, not exact claims about absolute distance, density, or nitride compactness. In the combined paper, this makes UMAP the right third panel or robustness-oriented companion in Results IV. Together, the three projections show that the oxide-nitride contrast is visible under multiple views of the same pretrained embedding, while the quantitative family-separation claims remain anchored to the raw `last_alignn_pool` space rather than to the projection method.

## Role In Report

- Main-text companion figure to PCA and t-SNE in Results IV of the combined paper, adding a third projection view of family separation in raw pretrained space.
- Supporting mechanistic-context figure for the nitride standalone report, where it reinforces the representation-shift interpretation without serving as a standalone quantitative result.
- Optional brief bridge figure for the oxide standalone report only; the oxide report should forward-reference the full embedding argument rather than reproduce it in detail.
- Canonical main-text UMAP figure at `n_neighbors = 30`; other UMAP settings belong in appendix robustness support.
