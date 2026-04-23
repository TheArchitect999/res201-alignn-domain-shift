# Strict citation audit of the ALIGNN oxide/nitride transfer package

## Scope caveat read first

The task description lists ten draft files and says their full text was "provided verbatim in the conversation." In the actual input I received only the **task brief, frozen constraints, frozen citation hierarchies, and headline quantitative findings** — none of the underlying draft prose from `oxide_discussion_conclusion_draft_v2.md`, the nitride draft, the combined discussion/results, the methods pack, the intro plan, the literature claim map, or the citation-needed list. I therefore cannot audit sentence-level language (e.g., specific `[CITE: …]` placeholders, exact causal verbs used, specific hedges). **Every section below is written against the claim-types the frozen findings imply, not against specific quoted sentences.** Treat Section 3 in particular as a checklist the drafters must apply to their own prose, not as a catalogue of sentences I pulled from your files. Where a section depends on draft text I do not have, I say so explicitly. Every recommended paper has been independently web-verified and carries a live DOI or arXiv ID.

---

## 1. Claims that are already well supported

I can confirm support for the following **claim types** that the frozen findings and hierarchies clearly imply. These are safe to keep with their current placeholders provided the placeholder points to the paper listed.

**Architecture and baseline claims.** Any sentence of the form "ALIGNN augments atomistic graphs with a line graph over bond–bond angles" is directly supported by **Choudhary & DeCost 2021** (npj Comput. Mater. 7:185; doi:10.1038/s41524-021-00650-1). Any sentence positioning CGCNN as the baseline crystal graph convolutional architecture is supported by **Xie & Grossman 2018** (Phys. Rev. Lett. 120:145301). Any statement that MEGNet is an alternative crystal graph framework with transferable elemental embeddings is supported by **Chen et al. 2019** (Chem. Mater. 31:3564–3572).

**Dataset and infrastructure provenance.** Claims that `dft_3d` / JARVIS-DFT is the dataset source are fully supported by **Choudhary et al. 2020** (npj Comput. Mater. 6:173; doi:10.1038/s41524-020-00440-1). Broader ecosystem framing (multimodal, FAIR, cross-scale) is supported by **Choudhary 2025 ("The JARVIS Infrastructure is All You Need for Materials Design")** — **note: this paper is published in *Computational Materials Science* (doi:10.1016/j.commatsci.2025.114063), not npj Computational Materials, and is also on arXiv as 2503.04133. The citation in the frozen hierarchy should be corrected to the Comp. Mat. Sci. venue.** Benchmark/leaderboard framing is supported by **Choudhary et al. 2024, JARVIS-Leaderboard** (npj Comput. Mater. 10:93; doi:10.1038/s41524-024-01259-w).

**Transfer-learning precedent in crystal GNNs.** The general statement "pretraining on large property datasets (e.g., formation energy) and fine-tuning on target properties improves small-data accuracy in crystal graph networks" is supported by **Lee & Asahi 2021** (Comput. Mater. Sci. 190:110314) and **Chen et al. 2019** (MEGNet elemental-embedding transfer). The claim that low-data, property-specific crystal transfer can yield large accuracy gains is supported by **Kim et al. 2024** (Comput. Mater. Sci. 234:112783, ~46% improvement on melting temperature).

**Structural OOD and materials-ML generalization framing.** Any discussion positioning "OOD testing reveals substantial degradation relative to random splits on MatBench-style benchmarks" is directly supported by **Omee et al. 2024** (npj Comput. Mater. 10:144) — ALIGNN is explicitly benchmarked there. The claim that heuristically-defined OOD tasks often still test interpolation, and that scaling benefits can collapse on genuine extrapolation, is supported by **Kangming Li et al. 2025** (Commun. Mater. 6:9; arXiv:2406.06489).

**Benchmarking methodology background.** Any Matbench framing, or reference to crystal-graph models overtaking traditional ML above ~10⁴ training points, is well supported by **Dunn et al. 2020** (npj Comput. Mater. 6:138).

**Materials-data ecosystem context.** Passing references to Materials Project and the broader open-data movement are supported by **Jain et al. 2013** (APL Materials 1:011002).

**Embedding methodology (descriptive support only).** If the drafts cite the original t-SNE/UMAP algorithms, those are correctly anchored to **van der Maaten & Hinton 2008** (JMLR 9:2579–2605) and **McInnes, Healy & Melville 2018** (arXiv:1802.03426). Silhouette and Davies–Bouldin references anchor to **Rousseeuw 1987** (J. Comput. Appl. Math. 20:53–65; doi:10.1016/0377-0427(87)90125-7) and **Davies & Bouldin 1979** (IEEE TPAMI PAMI-1:224–227).

I cannot check whether the placeholders in the actual draft text point to these exact papers; please verify each `[CITE: …]` against the list above.

---

## 2. Claims that need stronger citation support

These are claim-types the findings clearly support and that typically need anchoring in papers beyond the frozen "background" tier. I recommend specific anchors for each.

**Claim that pretrained crystal-GNN representations retain chemistry information at the family level.** If the draft says something like "the last-layer pooled representation separates chemical families even without fine-tuning" (motivated by AUC 0.9994 / 15-NN purity 0.9872 / silhouette 0.2546), the strongest single anchor is **Chen et al. 2019 (MEGNet)** — where learned elemental embeddings were explicitly shown to recover periodic-table structure and transfer to new properties — plus **Magar, Wang & Barati Farimani 2022, "Crystal Twins"** (npj Comput. Mater. 8:231; doi:10.1038/s41524-022-00921-5) which explicitly evaluates crystal-GNN representation quality under self-supervised pretraining. These two together support the *existence* of chemically meaningful structure in pretrained crystal embeddings far more directly than JARVIS or ALIGNN citations alone.

**Claim that transfer efficiency (pretrained vs from-scratch gap) shrinks as N grows.** Your N=50 gap of 0.5038 eV/atom collapsing to 0.2214 eV/atom at N=500 is the textbook transfer-learning curve. Anchor to **Lee & Asahi 2021** for the same pattern on CGCNN (primary), **Chen & Ong 2021, "AtomSets"** (npj Comput. Mater. 7:173; doi:10.1038/s41524-021-00639-w) which explicitly quantifies the N-dependence of transfer gains from ~100 to 10⁴ samples, and **Frey et al. 2023, "Neural scaling of deep chemical models"** (Nat. Mach. Intell. 5:1297–1305; doi:10.1038/s42256-023-00740-3) for the data-scaling-law framing.

**Claim that nitrides exhibit slower convergence / poorer zero-shot performance than oxides because of chemical-family shift.** The frozen hierarchy lists Hu et al. 2024, Omee et al. 2024, and the two Li et al. 2025 papers, but a sentence specifically asserting *compositional / chemical-family* extrapolation should anchor on **Kangming Li et al. 2025** (Commun. Mater. 6:9) first — that paper is the most systematic leave-element/period/prototype-out benchmark and explicitly tests ALIGNN — and on **Omee et al. 2024** second for the structural-OOD counterpart. **Riebesell et al. 2025, Matbench Discovery** (Nat. Mach. Intell. 7:836–847; doi:10.1038/s42256-025-01055-1; preprint arXiv:2308.14920) is the correct anchor for "prospective / compositionally held-out evaluation of crystal stability models." **Note the frozen hierarchy lists Riebesell as 2024; the peer-reviewed publication year is 2025 — update accordingly.**

**Claim that under-represented chemical families systematically require more labeled data.** Anchor to **Kangming Li et al. 2025** (scaling collapses on truly extrapolative tasks) plus **Qinyang Li, Miklaucic & Hu 2025, "Out-of-Distribution Material Property Prediction Using Adversarial Learning"** (J. Phys. Chem. C 129:6372–6385; doi:10.1021/acs.jpcc.4c07481). Do *not* conflate the two Li et al. 2025 papers — they are different first authors, different groups, different methodologies.

**Claim that variance at low N (5 seeds each at N=10, 50) reflects fine-tuning instability rather than model uncertainty.** This is currently probably under-cited. Anchor to **Mosbach, Andriushchenko & Klakow 2021, "On the Stability of Fine-tuning BERT"** (ICLR 2021; arXiv:2006.04884) as the canonical methodological reference on small-N fine-tuning variance, and optionally **Zhang et al. 2021, "Revisiting Few-sample BERT Fine-tuning"** (ICLR 2021). These are NLP papers, but they are the standard cross-domain anchors; no materials-specific seed-variance study of comparable rigor currently exists.

**Claim that PCA/t-SNE/UMAP visual cluster separation is consistent with (but does not prove) representation-space family structure.** If the draft currently only cites the original t-SNE/UMAP papers, the caveat layer is underpowered. Add **Wattenberg, Viégas & Johnson 2016, "How to Use t-SNE Effectively"** (Distill 1:e2; doi:10.23915/distill.00002), **Kobak & Berens 2019** (Nat. Commun. 10:5416; doi:10.1038/s41467-019-13056-x), and **Kobak & Linderman 2021** (Nat. Biotechnol. 39:156–157; doi:10.1038/s41587-020-00809-z). These three are essential: they establish that cluster sizes, gaps, and relative distances in 2D embeddings are not metrically meaningful and that the apparent global-structure advantage of UMAP is an initialization artifact. Without them, any visual embedding interpretation is citation-thin.

**Claim that 2D embedding plots should not carry inferential weight.** If the drafts make inferential claims from t-SNE/UMAP panels, add **Chari & Pachter 2023, "The specious art of single-cell genomics"** (PLOS Comput. Biol. 19:e1011288; doi:10.1371/journal.pcbi.1011288). This is the strongest peer-reviewed critique of using 2D embeddings for downstream conclusions and is directly transferable from single-cell to materials-embedding contexts.

**Claim that k-NN purity / silhouette / Davies–Bouldin in high-D representations are informative.** These are fine as descriptive metrics but inherit distance-concentration caveats in high-dimensional embeddings. Optional but strengthening: **Aggarwal, Hinneburg & Keim 2001, "On the Surprising Behavior of Distance Metrics in High Dimensional Space"** (ICDT 2001, LNCS 1973:420–434; doi:10.1007/3-540-44503-X_27) as a methodological footnote when interpreting the AUC 0.9994 / silhouette 0.2546 split — the silhouette is only ~0.25 despite near-perfect AUC, and that divergence is exactly what distance-concentration literature predicts.

---

## 3. Claims that should be softened

I do not have the draft sentences, so I cannot point to specific lines. The frozen findings do, however, make certain claim-types high-risk. Apply the following rewording rules as a checklist across the oxide discussion, nitride discussion, combined discussion/conclusion, and combined Results IV (embeddings).

**Rule A — Embedding / representation-geometry verbs (STRICT).** The frozen whitelist allows only "is consistent with," "supports the interpretation that," "lets us ask whether." Across the draft, search and replace any of the following:

- "the embedding **shows that** oxides and nitrides occupy distinct regions" → "the embedding **is consistent with** oxides and nitrides occupying distinct regions"
- "PCA/t-SNE/UMAP **demonstrates** chemical-family separation" → "the projections **support the interpretation that** chemical-family structure is preserved in the last-layer pooled representation"
- "the high family-AUC **proves** the representation encodes chemistry" → "the high family-AUC **is consistent with** the pooled representation carrying family-level chemical information"
- "the clustering **explains** the zero-shot MAE gap" → "the clustering pattern **lets us ask whether** representation-space family structure is related to the zero-shot MAE gap"
- Any instance of "shows," "demonstrates," "proves," "causes," or "explains" applied to t-SNE / UMAP / PCA panels → replace with "is consistent with" or remove.

**Rule B — Domain-shift language.** Your setup is a chemical-family distribution shift, not a proven causal mechanism for the MAE gap. Soften:

- "nitrides **constitute a domain shift that causes** worse zero-shot performance" → "the nitride evaluation **is consistent with a chemical-family distribution shift** relative to the pretraining corpus, and the worse zero-shot MAE **is consistent with** that shift"
- "our results **demonstrate domain shift**" → "our results **are consistent with a representation-space shift** between oxide and nitride families"
- "nitrides are out-of-distribution for ALIGNN" → specify the operational meaning: "nitrides are under-represented in the `dft_3d` pretraining distribution used by the released ALIGNN checkpoint, as quantified by [describe procedure]"; avoid the bare "OOD" adjective unless you have measured coverage.

**Rule C — Transfer-efficiency verbs.** Your gaps (0.5038 → 0.2214 eV/atom from N=50 to N=500) are empirical observations, not a proof of universally efficient transfer. Soften:

- "pretraining **proves** data efficiency" → "the observed pretrained-vs-scratch gap at N=50 and N=500 is **consistent with** a data-efficiency benefit of pretraining in this regime"
- "ALIGNN **achieves data-efficient transfer**" → "ALIGNN fine-tuning from the pretrained formation-energy checkpoint **improves MAE over from-scratch training at N=50 and N=500 in our setup**"
- Any claim that extrapolates beyond N=1000 should be hedged — from-scratch baselines were not run above N=500 in your design.

**Rule D — Zero-shot claim.** The pretrained zero-shot oxide MAE of 0.0342 eV/atom is a specific number from a specific checkpoint on a specific oxide subset. Avoid phrasing like "pretrained ALIGNN **achieves** 0.034 eV/atom on oxides" (ambient) — prefer "on the oxide subset of `dft_3d` under our family definition, the released ALIGNN formation-energy checkpoint attains a zero-shot MAE of 0.0342 eV/atom (best observed configuration in our sweep)." This prevents the number from being read as the canonical ALIGNN oxide score.

**Rule E — Causation from embedding metrics to performance.** AUC 0.9994 and MAE gaps are two orthogonal measurements. Avoid "the high family-AUC **drives / causes / explains** the lower nitride MAE improvement curve." Replace with "the family-separation metrics and the per-family learning curves can be examined jointly; we find they **co-vary in a direction consistent with** the representation-shift hypothesis, without establishing causation."

**Rule F — "ALIGNN embeddings learn chemistry."** Avoid teleological phrasing. Prefer "the last-layer pooled activations separate oxide and nitride families as measured by AUC, 15-NN purity, and silhouette, consistent with family-level chemical information being retained in the pooled representation." Drop any "ALIGNN has learned the periodic table" style language.

**Rule G — Scope of the embedding layer claim.** You probed only `last_alignn_pool`. Never generalize to "ALIGNN's internal representations" or "ALIGNN's embeddings" as a whole — your evidence is layer-specific. Always qualify with "in the `last_alignn_pool` layer."

**Cannot audit without draft text:** specific `[CITE: …]` placements, hedging verbs actually used, and whether the conclusion overstates generalization to other chemical families (carbides, sulfides, halides). Please apply Rules A–G manually to each draft.

---

## 4. Best 14 papers to cite across the package

Every entry below is web-verified with a live DOI or arXiv ID.

1. **Xie, T. & Grossman, J. C. (2018).** Crystal Graph Convolutional Neural Networks for an Accurate and Interpretable Prediction of Material Properties. *Phys. Rev. Lett.* 120, 145301. doi:10.1103/PhysRevLett.120.145301. — *Role: foundational crystal graph NN baseline.*

2. **Choudhary, K. & DeCost, B. (2021).** Atomistic Line Graph Neural Network for improved materials property predictions. *npj Comput. Mater.* 7, 185. doi:10.1038/s41524-021-00650-1. — *Role: primary architecture citation for ALIGNN.*

3. **Choudhary, K. et al. (2020).** The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design. *npj Comput. Mater.* 6, 173. doi:10.1038/s41524-020-00440-1. — *Role: primary dataset/repository provenance for `dft_3d`.*

4. **Choudhary, K. (2025).** The JARVIS Infrastructure is All You Need for Materials Design. *Comput. Mater. Sci.* (2025), doi:10.1016/j.commatsci.2025.114063; arXiv:2503.04133. — *Role: broader JARVIS ecosystem framing. Correct the venue from npj to Comput. Mater. Sci.*

5. **Choudhary, K. et al. (2024).** JARVIS-Leaderboard: a large scale benchmark of materials design methods. *npj Comput. Mater.* 10, 93. doi:10.1038/s41524-024-01259-w. — *Role: benchmark/leaderboard framing only.*

6. **Lee, J. & Asahi, R. (2021).** Transfer learning for materials informatics using crystal graph convolutional neural network. *Comput. Mater. Sci.* 190, 110314. doi:10.1016/j.commatsci.2021.110314. — *Role: primary crystal-GNN transfer-learning precedent.*

7. **Chen, C., Ye, W., Zuo, Y., Zheng, C. & Ong, S. P. (2019).** Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals. *Chem. Mater.* 31, 3564–3572. doi:10.1021/acs.chemmater.9b01294. — *Role: alternative crystal GNN architecture + earliest explicit crystal-embedding transfer demonstration.*

8. **Kim, J., Jung, J., Kim, S. & Han, S. (2024).** Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning. *Comput. Mater. Sci.* 234, 112783. doi:10.1016/j.commatsci.2024.112783. — *Role: secondary evidence for low-data, property-specific crystal transfer.*

9. **Hu, J., Liu, D., Fu, N. & Dong, R. (2024).** Realistic material property prediction using domain adaptation based machine learning. *Digit. Discov.* 3, 300–312. doi:10.1039/D3DD00162H. — *Role: contextual domain-adaptation framing for materials ML.*

10. **Omee, S. S., Fu, N., Dong, R., Hu, M. & Hu, J. (2024).** Structure-based out-of-distribution materials property prediction: a benchmark study. *npj Comput. Mater.* 10, 144. doi:10.1038/s41524-024-01316-4. — *Role: structural-OOD benchmark including ALIGNN.*

11. **Li, K., Rubungo, A. N., Lei, X., Persaud, D., Choudhary, K., DeCost, B., Dieng, A. B. & Hattrick-Simpers, J. (2025).** Probing out-of-distribution generalization in machine learning for materials. *Commun. Mater.* 6, 9. doi:10.1038/s43246-024-00731-w; arXiv:2406.06489. — *Role: systematic leave-element/period/prototype-out generalization benchmark, tests ALIGNN.*

12. **Li, Q., Miklaucic, N. & Hu, J. (2025).** Out-of-Distribution Material Property Prediction Using Adversarial Learning. *J. Phys. Chem. C* 129, 6372–6385. doi:10.1021/acs.jpcc.4c07481. — *Role: OOD adversarial framing. **Different authors from #11 — do not conflate.***

13. **Dunn, A., Wang, Q., Ganose, A., Dopp, D. & Jain, A. (2020).** Benchmarking materials property prediction methods: the Matbench test set and Automatminer reference algorithm. *npj Comput. Mater.* 6, 138. doi:10.1038/s41524-020-00406-3. — *Role: benchmarking background.*

14. **van der Maaten, L. & Hinton, G. (2008).** Visualizing Data using t-SNE. *J. Mach. Learn. Res.* 9, 2579–2605. — *Role: canonical t-SNE reference.*

15. **McInnes, L., Healy, J. & Melville, J. (2018).** UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction. arXiv:1802.03426. — *Role: canonical UMAP reference.*

16. **Wattenberg, M., Viégas, F. & Johnson, I. (2016).** How to Use t-SNE Effectively. *Distill* 1, e2. doi:10.23915/distill.00002. — *Role: canonical caveat for t-SNE visual interpretation.*

17. **Kobak, D. & Linderman, G. C. (2021).** Initialization is critical for preserving global data structure in both t-SNE and UMAP. *Nat. Biotechnol.* 39, 156–157. doi:10.1038/s41587-020-00809-z. — *Role: anchors the UMAP/t-SNE equivalence argument on global structure.*

18. **Kobak, D. & Berens, P. (2019).** The art of using t-SNE for single-cell transcriptomics. *Nat. Commun.* 10, 5416. doi:10.1038/s41467-019-13056-x. — *Role: global-structure preservation critique for default settings.*

(Item count slightly over the 12–18 range; trim #9 or #13 if needed.)

---

## 5. Exact source recommendations mapped to claim types

**a) ALIGNN / CGCNN / JARVIS background.** Architecture → Choudhary & DeCost 2021 (#2). CGCNN baseline → Xie & Grossman 2018 (#1). Dataset provenance → Choudhary et al. 2020 (#3). Ecosystem framing → Choudhary 2025 (#4, *Comput. Mater. Sci.*, not npj). Benchmark framing → Choudhary et al. 2024 (#5). Alternative crystal GNN → Chen et al. 2019 (#7). Matbench background → Dunn et al. 2020 (#13). Materials Project ecosystem → Jain et al. 2013 (APL Mater. 1:011002; doi:10.1063/1.4812323).

**b) Transfer learning in materials ML.** Primary crystal-GNN transfer → Lee & Asahi 2021 (#6). Property-specific low-data transfer → Kim et al. 2024 (#8). MEGNet embedding transfer → Chen et al. 2019 (#7). Hierarchical small-to-large transfer → Chen & Ong 2021, **AtomSets** (npj Comput. Mater. 7:173; doi:10.1038/s41524-021-00639-w). Foundation-model transfer → Shoghi et al. 2024, **JMP** (ICLR 2024; arXiv:2310.16802). Self-supervised crystal pretraining → Magar, Wang & Barati Farimani 2022, **Crystal Twins** (npj Comput. Mater. 8:231; doi:10.1038/s41524-022-00921-5).

**c) OOD / domain shift in materials ML.** Structural OOD benchmark → Omee et al. 2024 (#10). Systematic leave-family-out generalization with ALIGNN → Kangming Li et al. 2025 (#11). Adversarial OOD method → Qinyang Li et al. 2025 (#12). Domain-adaptation baseline → Hu et al. 2024 (#9). Prospective crystal-stability OOD → **Riebesell et al. 2025, Matbench Discovery** (Nat. Mach. Intell. 7:836–847; doi:10.1038/s42256-025-01055-1; arXiv:2308.14920). **Update the frozen 2024 date to 2025.**

**d) Embedding / representation-space caution.** Over-interpretation critique → Chari & Pachter 2023 (PLOS Comput. Biol. 19:e1011288; doi:10.1371/journal.pcbi.1011288). Distance concentration in high-D → Aggarwal, Hinneburg & Keim 2001 (ICDT; doi:10.1007/3-540-44503-X_27). Internal cluster-validity definitions → Rousseeuw 1987 (silhouette; doi:10.1016/0377-0427(87)90125-7) and Davies & Bouldin 1979 (doi:10.1109/TPAMI.1979.4766909). That crystal-GNN embeddings encode chemistry at all → Chen et al. 2019 and Magar et al. 2022 (both above) as positive precedents.

**e) PCA / t-SNE / UMAP caveats.** t-SNE original → van der Maaten & Hinton 2008 (#14). UMAP original → McInnes, Healy & Melville 2018 (#15). Visual misreading of t-SNE → Wattenberg, Viégas & Johnson 2016 (#16). Global-structure preservation critique → Kobak & Berens 2019 (#18). t-SNE/UMAP equivalence on global structure under informative init → Kobak & Linderman 2021 (#17). Strong critique of 2D embedding inference → Chari & Pachter 2023.

---

## 6. Missing but important related-work angles

**Equivariant GNNs for atomistic systems.** The paper should explicitly situate ALIGNN relative to the modern equivariant architecture line. Cite **Batzner, S. et al. (2022), "E(3)-equivariant graph neural networks for data-efficient and accurate interatomic potentials" (NequIP)**, *Nat. Commun.* 13:2453, doi:10.1038/s41467-022-29939-5 — directly frames data-efficiency, which is your central empirical claim. Cite **Batatia, I., Kovács, D. P., Simm, G. N. C., Ortner, C. & Csányi, G. (2022), "MACE: Higher Order Equivariant Message Passing Neural Networks" (MACE)**, NeurIPS 2022, arXiv:2206.07697 — current state-of-the-art reference for higher-body-order equivariance.

**Universal / foundation interatomic potentials.** The "pretrained checkpoint" framing of your paper connects directly to the universal-potentials literature. Cite **Chen, C. & Ong, S. P. (2022), "A universal graph deep learning interatomic potential for the periodic table" (M3GNet)**, *Nat. Comput. Sci.* 2:718–728, doi:10.1038/s43588-022-00349-3. Cite **Deng, B. et al. (2023), "CHGNet as a pretrained universal neural network potential"**, *Nat. Mach. Intell.* 5:1031–1041, doi:10.1038/s42256-023-00716-3. Optional: **Batatia, I. et al. (2023/2025), "A foundation model for atomistic materials chemistry" (MACE-MP-0)**, arXiv:2401.00096 / *J. Chem. Phys.* 163:184110 (2025).

**Foundation / self-supervised models for materials.** Cite **Shoghi, N. et al. (2024), "From Molecules to Materials: Pre-training Large Generalizable Models for Atomic Property Prediction" (JMP)**, ICLR 2024, arXiv:2310.16802 — explicitly frames supervised multi-task pretraining + downstream fine-tuning, which is conceptually the paradigm your paper is a single-property instance of. Cite **Magar, Wang & Barati Farimani 2022, "Crystal Twins"** (already listed above) for the self-supervised crystal representation line.

**Data-efficiency / neural scaling laws.** Cite **Frey, N. C. et al. (2023), "Neural scaling of deep chemical models"**, *Nat. Mach. Intell.* 5:1297–1305, doi:10.1038/s42256-023-00740-3 — provides the formal power-law framework for your MAE-vs-N curves. Pair with Kangming Li et al. 2025 (#11) for the counter-finding that neural-scaling benefits collapse on truly extrapolative tasks — that pairing is exactly the oxide (in-distribution, scaling works) vs. nitride (shifted, scaling may not) contrast your paper implicitly makes.

**Few-shot / low-data crystal learning.** Cite **Chen, C. & Ong, S. P. (2021), "AtomSets as a hierarchical transfer learning framework for small and large materials datasets"**, *npj Comput. Mater.* 7:173, doi:10.1038/s41524-021-00639-w — explicitly designed for the ~100–10⁴ sample regime that matches your N=10…1000 sweep. Formal meta-learning on inorganic crystals is a thin literature; AtomSets is the strongest direct analogue.

**Chemical-family / compositional generalization benchmarks.** Cite **Riebesell, J. et al. (2025), "A framework to evaluate machine learning crystal stability predictions" (Matbench Discovery)**, *Nat. Mach. Intell.* 7:836–847, doi:10.1038/s42256-025-01055-1; arXiv:2308.14920. **The frozen hierarchy lists this as 2024 — the peer-reviewed publication is 2025; correct the year.** Pair with Kangming Li et al. 2025 (#11) which explicitly runs leave-element-out tests on ALIGNN.

**Fine-tuning stability at low N / seed variance.** Cite **Mosbach, M., Andriushchenko, M. & Klakow, D. (2021), "On the Stability of Fine-tuning BERT: Misconceptions, Explanations, and Strong Baselines"**, ICLR 2021, arXiv:2006.04884. Optional companion: **Zhang, T. et al. (2021), "Revisiting Few-sample BERT Fine-tuning"**, ICLR 2021. These are NLP-origin but are the standard cross-domain anchors; no materials-ML paper currently occupies the equivalent niche with comparable rigor. Flag this clearly when citing (e.g., "methodological anchor from NLP fine-tuning stability literature").

**Domain adaptation / covariate shift beyond Hu et al. 2024.** Cite **Klarner, L. et al. (2023), "Drug Discovery under Covariate Shift with Domain-Informed Prior Distributions over Functions"**, ICML 2023, arXiv:2307.15073 — rigorous molecular covariate-shift evaluation that transfers methodologically to inorganic chemical-family shift.

**Discriminative vs generative transfer framing.** The package appears purely discriminative (property regression). A single sentence acknowledging generative-transfer approaches (crystal generation conditioned on pretrained representations) would balance the framing; if you add one, **Zeni, C. et al. (2023/2025), "MatterGen: A Generative Model for Inorganic Materials Design"**, arXiv:2312.03687 / published in *Nature* (2025), is the canonical reference (verify the final venue before citing, as this was in press during the review window).

---

## Corrections flagged for the frozen citation hierarchy

Three items in the frozen hierarchy contain minor errors that should be fixed before the drafts are finalized:

- **JARVIS 2025 (Choudhary).** Listed without venue; actually *Computational Materials Science* (2025), doi:10.1016/j.commatsci.2025.114063; arXiv:2503.04133. Not npj.
- **Matbench Discovery (Riebesell et al.).** Listed as 2024; the peer-reviewed publication is 2025 in *Nature Machine Intelligence* 7:836–847, doi:10.1038/s42256-025-01055-1. The 2023 arXiv preprint predates the journal publication by two years.
- **"Li et al. 2025" (two entries).** Make sure the drafts cite the correct first author in each sentence: **Kangming Li et al.** (Commun. Mater. 6:9; probing OOD generalization) vs. **Qinyang Li et al.** (J. Phys. Chem. C 129:6372–6385; adversarial OOD). Different institutions, different methodologies; conflation would be a citation error.

## Sections I could not audit

I cannot audit (a) which specific `[CITE: …]` tokens are currently in which sentence, (b) specific hedging verbs actually used in each draft paragraph, (c) the intro blueprint's argumentative flow, (d) whether the methods prose correctly attributes the pretrained checkpoint to Choudhary & DeCost 2021 vs. the JARVIS-Leaderboard release, (e) the citation-needed list's coverage. To complete the audit at sentence resolution, please paste the draft prose of `oxide_discussion_conclusion_draft_v2.md`, `nitride_discussion_conclusion_draft_v2.md`, `combined_paper_discussion_conclusion_draft_v2.md`, `combined_paper_results_III_and_IV_draft_v3.md`, `introduction_paragraph_plan_v4.md`, `literature_claim_map_v3.md`, and `citation_needed_list_v2.md` into a follow-up so I can apply Rules A–G line by line and verify each `[CITE: …]` placement.