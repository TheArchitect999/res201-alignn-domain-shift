# Figure Memo: Fig. 10 Embedding PCA

## Metadata

- Figure label: `FIG_EA_6A_PCA`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_EA_6A_PCA.png`
- Canonical source path: `reports/week4_embedding_analysis/figures/pca/last_alignn_pool_fixed_test_family.png`
- Linked table: `reports/week4_embedding_analysis/tables/family_separation_metrics.csv`
- Embedding source: `last_alignn_pool`
- Dataset: `fixed_test_set`
- Report membership: `nitride | combined | oxide_optional`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\ChatGPT Figure Memo.txt`
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is a 2-D PCA projection of the pretrained ALIGNN `last_alignn_pool` embeddings for the fixed test set, with points colored by chemical family. The plotted test set contains `1726` structures total: `1484` oxides and `242` nitrides. The first two principal components shown in the panel explain `18.1%` and `9.5%` of the variance, respectively.

Visually, the two families are not randomly intermixed. Oxides form the larger and denser cloud, concentrated mostly on the positive-PC1 side of the projection, while nitrides are shifted toward lower PC2 values and extend farther into the negative-PC1 region. There is still visible overlap in the central region, so the 2-D PCA view shows partial rather than complete separation.

The linked metrics table provides the quantitative family-separation summary for this exact figure configuration in the raw `256`-dimensional embedding space:

- Overall silhouette score: `0.239` (95% CI `0.233-0.246`)
- Oxide silhouette score: `0.255` (95% CI `0.248-0.262`)
- Nitride silhouette score: `0.145` (95% CI `0.132-0.158`)
- Overall 15-NN family purity: `0.966` (95% CI `0.960-0.971`)
- Oxide 15-NN family purity: `0.987` (95% CI `0.983-0.991`)
- Nitride 15-NN family purity: `0.833` (95% CI `0.798-0.864`)
- Logistic-regression family AUC: `0.9994` (95% CI `0.9984-0.9999`)
- Davies-Bouldin index: `1.83` (95% CI `1.73-1.91`)

## Justified Interpretation

The safest interpretation is that the pretrained representation already contains strong family-level structure before any downstream fine-tuning. Oxides and nitrides occupy measurably different regions in the raw pretrained embedding space, and that conclusion is supported both visually and by the separation metrics computed from the same `last_alignn_pool` vectors.

The most important nuance is that the family shift is not all-or-nothing. The PCA panel shows overlap, and the nitride family is not absent from the oxide-dominated region. At the same time, the nitride cluster is visibly more diffuse in the 2-D projection, and the raw-space metrics are asymmetric: nitride silhouette (`0.145`) and nitride 15-NN family purity (`0.833`) are both lower than the corresponding oxide values (`0.255` and `0.987`). That supports a conservative representation-space reading in which nitrides are embedded in a less cohesive and less oxide-like region of the learned manifold.

The very high logistic-regression family AUC (`0.9994`) adds another useful constraint. The model has retained enough information in the raw pretrained embeddings to distinguish the two families almost perfectly at the family-label level, even though the PCA projection still shows overlap and the nitride region is internally weaker than the oxide region. Taken together, the defensible interpretation is not that nitrides are completely outside the learned representation, but that they occupy a shifted and less well-structured portion of it. That is consistent with the broader domain-shift story developed from the performance curves.

## Non-Claims / Cautions

- This figure does not prove that embedding-space shift causes nitride prediction difficulty; it provides correlational mechanistic context only.
- This figure does not show complete oxide-nitride separability in the 2-D PCA plane; visible overlap remains.
- This figure does not justify strong claims from the PCA geometry alone, because the panel is a 2-D projection of a `256`-dimensional space.
- The reported silhouette, kNN-purity, logistic-AUC, and Davies-Bouldin values are computed in the raw embedding space, not on the plotted 2-D PCA coordinates.
- This figure does not compare fine-tuning against scratch, low `N` against high `N`, or one hyperparameter set against another.
- This figure does not establish which nitrides are hard or easy; that requires the separate distance-error analysis figure.
- In main text, this figure should be treated as the `last_alignn_pool` embedding anchor only; `pre_head` and `last_gcn_pool` belong in appendix-level robustness context.

## Caption Draft

Figure X. PCA projection of pretrained ALIGNN `last_alignn_pool` embeddings for the fixed test set, colored by chemical family. The panel contains `1484` oxide structures and `242` nitride structures. PC1 and PC2 explain `18.1%` and `9.5%` of the variance, respectively. Oxides occupy a denser region of the projection, whereas nitrides are shifted toward lower PC2 values and extend farther into the negative-PC1 region, with partial overlap near the center. Quantitative family-separation metrics computed in the raw `256`-dimensional embedding space are consistent with this visual pattern, including silhouette `0.239` overall (`0.255` oxide, `0.145` nitride), 15-NN family purity `0.966` overall (`0.987` oxide, `0.833` nitride), logistic-regression family AUC `0.9994`, and Davies-Bouldin index `1.83`. The panel is interpreted as representation-space evidence consistent with chemical-family domain shift, not as a causal test.

## Results Paragraph Draft

To inspect whether the pretrained representation already distinguishes the two chemical families, we projected the fixed-test-set `last_alignn_pool` embeddings into two dimensions with PCA (Figure X). The panel contains `1484` oxides and `242` nitrides, and the first two principal components explain `18.1%` and `9.5%` of the variance, respectively. The two families are not randomly intermixed: oxides form the denser cloud, concentrated mostly on the positive-PC1 side, whereas nitrides are shifted toward lower PC2 values and extend farther into the negative-PC1 region, with partial overlap in the middle of the plane. Quantitative separation metrics computed in the raw `256`-dimensional embedding space support the same pattern. The overall silhouette score is `0.239` (95% CI `0.233-0.246`), with an oxide value of `0.255` and a lower nitride value of `0.145`. The overall 15-NN family purity is `0.966`, again with a strong asymmetry between oxides (`0.987`) and nitrides (`0.833`). At the same time, the family labels remain almost perfectly recoverable from the raw embeddings, with logistic-regression AUC `0.9994` (95% CI `0.9984-0.9999`) and Davies-Bouldin index `1.83` (95% CI `1.73-1.91`). Together, these results indicate that oxide and nitride structures are strongly separated at the family level in pretrained space, but that the nitride region is less cohesive than the oxide region.

## Discussion Paragraph Draft

This PCA figure adds the intended mechanistic layer to the project without carrying more argumentative weight than it should. The pretrained ALIGNN representation already encodes oxide and nitride structures differently before any task-specific adaptation, which is exactly the kind of geometric observation needed to support a domain-shift interpretation. But the important detail is the asymmetry, not just the existence of separation. Oxides form the tighter and more internally coherent region, whereas nitrides are more diffuse and show lower family purity. That pattern is consistent with the behavioral results: the nitride target family is not alien to the pretrained representation, but it appears less cleanly organized than the oxide control family. In the combined paper, this makes PCA the correct opening figure for Results IV, after which the distance-error analysis can test whether nitride difficulty is specifically linked to distance from the oxide-reference region.

## Role In Report

- Main-text opening figure for Results IV in the combined paper: family separation in raw pretrained space.
- Supporting mechanistic-context figure for the nitride standalone report, where it helps bridge from performance results to representational interpretation.
- Optional brief bridge figure for the oxide standalone report only; the oxide report should forward-reference the full embedding argument rather than reproduce it in detail.
- Main-text embedding anchor must remain `last_alignn_pool`; other embedding layers should stay in appendix support.
