# Claim-to-citation insertion plan — RES201 ALIGNN paper package

**Purpose.** This is a drafter's checklist. For each claim family in each draft, it specifies: (i) the claim or sentence trigger, (ii) the correct citation from the frozen hierarchy, (iii) the source role, and (iv) whether the citation is ESSENTIAL (must insert) or OPTIONAL (strengthens). Where the same claim repeats across the combined paper and a standalone, the later entry points back to the first with "same as COMBINED §X" and no re-justification.

**Global conventions used below.**
- *Role codes*: PRIMARY = primary source for the specific claim; BENCH = benchmark/review/framework paper; METHODS = canonical methodology reference.
- *Placeholder format for drafters*: `[CITE: FirstAuthorYear_keyword]` (e.g., `[CITE: Choudhary2021_ALIGNN]`).
- *Frozen hierarchy reminder for GNN architecture trio*: ALIGNN claims → Choudhary & DeCost 2021 PRIMARY; CGCNN claims → Xie & Grossman 2018 PRIMARY; MEGNet claims → Chen 2019 PRIMARY. Never substitute.
- *Frozen hierarchy reminder for JARVIS*: dataset composition/DFT protocol → Choudhary 2020 PRIMARY; infrastructure/tooling → Choudhary 2025; multi-task benchmark comparisons → Choudhary 2024 Leaderboard.
- *OOD citation disambiguation*: **Kangming Li 2025** (Commun. Mater. 6:9, probing OOD generalization) is distinct from **Qinyang Li 2025** (J. Phys. Chem. C, adversarial OOD). Use Kangming Li for "models fail on held-out chemistries / OOD generalization gap"; use Qinyang Li for "adversarially constructed OOD splits / worst-case OOD". Omee 2024 is the structure-based OOD benchmark. Hu 2024 is domain adaptation.
- *Embedding caveat ladder*: Wattenberg 2016 (t-SNE perplexity/shape artifacts), Kobak & Berens 2019 (global structure preservation), Kobak & Linderman 2021 (initialization dependence, t-SNE↔UMAP equivalence), Chari & Pachter 2023 (distances in 2D embeddings are unreliable, cluster shape is not biology/chemistry). Use the narrowest-matching caveat; cite Chari & Pachter whenever a cluster-shape or distance-in-2D interpretation is being hedged.

---

## 1. COMBINED PAPER

### 1a. Introduction citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| I-C1 | Opening framing: DFT-accurate formation energy prediction at ML speed has become a core materials informatics task. | Choudhary 2020 JARVIS dataset; Dunn 2020 Matbench | BENCH | ESSENTIAL |
| I-C2 | Graph neural networks now dominate crystal property prediction. | Xie & Grossman 2018 CGCNN | PRIMARY | ESSENTIAL |
| I-C3 | Early crystal-graph baseline established the atom-as-node / bond-as-edge paradigm. | Xie & Grossman 2018 CGCNN | PRIMARY | ESSENTIAL |
| I-C4 | MEGNet extended graph construction with global state and universal readouts. | Chen 2019 MEGNet | PRIMARY | ESSENTIAL |
| I-C5 | ALIGNN added the bond-angle line graph and improved formation-energy accuracy on JARVIS/MP. | Choudhary & DeCost 2021 ALIGNN | PRIMARY | ESSENTIAL |
| I-C6 | ALIGNN is the model used in this work / the pretrained checkpoint source. | Choudhary & DeCost 2021 ALIGNN | PRIMARY | ESSENTIAL |
| I-C7 | The JARVIS-DFT dataset is the pretraining corpus underlying the public ALIGNN checkpoint. | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| I-C8 | The JARVIS ecosystem / tooling / infrastructure enables reproducible downstream use. | Choudhary 2025 JARVIS Infrastructure | BENCH | ESSENTIAL |
| I-C9 | Cross-model benchmarking for materials GNNs is standardized via the JARVIS-Leaderboard. | Choudhary 2024 JARVIS-Leaderboard | BENCH | ESSENTIAL |
| I-C10 | Matbench is an alternative standard benchmark suite. | Dunn 2020 Matbench | BENCH | OPTIONAL |
| I-C11 | Despite strong in-distribution accuracy, GNNs degrade under distribution shift / held-out chemistries. | Kangming Li 2025 probing OOD | PRIMARY | ESSENTIAL |
| I-C12 | Structure-based OOD splits reveal that IID test error understates real generalization gap. | Omee 2024 structure-based OOD | PRIMARY | ESSENTIAL |
| I-C13 | Adversarial / worst-case OOD constructions further expose model brittleness. | Qinyang Li 2025 adversarial OOD | PRIMARY | OPTIONAL |
| I-C14 | Domain adaptation is an emerging mitigation for OOD in materials ML. | Hu 2024 domain adaptation | PRIMARY | OPTIONAL |
| I-C15 | Transfer learning from large pretrained crystal GNNs improves small-data targets. | Lee & Asahi 2021 transfer CGCNN | PRIMARY | ESSENTIAL |
| I-C16 | Transfer learning has been applied to thermophysical properties such as melting temperature. | Kim 2024 melting + transfer | PRIMARY (secondary TL example) | OPTIONAL |
| I-C17 | Motivation: oxides are well represented in JARVIS (in-distribution control); nitrides are under-represented (domain-shift arm). | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| I-C18 | We use low-dimensional projection (PCA/t-SNE/UMAP) of ALIGNN embeddings to characterize representation geometry. | van der Maaten & Hinton 2008 t-SNE; McInnes 2018 UMAP | METHODS | ESSENTIAL (introduce method names) |
| I-C19 | Interpretations from 2D projections must be hedged. | Wattenberg 2016 How to Use t-SNE; Chari & Pachter 2023 specious art | METHODS (caveat) | OPTIONAL in Intro (ESSENTIAL in Discussion) |
| I-C20 | Our contribution statement — pretrained ALIGNN evaluated with oxide IID control and nitride OOD arm, embedding geometry diagnostics, transfer implications. | *No citation (own contribution)* | — | — |

### 1b. Methods citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| M-C1 | "We use the pretrained ALIGNN model / ALIGNN architecture with line-graph bond-angle message passing." | Choudhary & DeCost 2021 ALIGNN | PRIMARY | ESSENTIAL |
| M-C2 | "Pretraining corpus: JARVIS-DFT formation energies per atom." | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| M-C3 | "JARVIS tooling / jarvis-tools used for structure ingestion and featurization." | Choudhary 2025 JARVIS Infrastructure | METHODS | ESSENTIAL if tooling named |
| M-C4 | "Reference leaderboard numbers for ALIGNN formation-energy MAE." | Choudhary 2024 JARVIS-Leaderboard | BENCH | ESSENTIAL if leaderboard value quoted |
| M-C5 | "CGCNN baseline" (only if a CGCNN comparison is reported). | Xie & Grossman 2018 CGCNN | PRIMARY | ESSENTIAL *conditional on baseline being reported* |
| M-C6 | "MEGNet comparison" (only if reported). | Chen 2019 MEGNet | PRIMARY | ESSENTIAL *conditional* |
| M-C7 | "PCA applied to penultimate-layer embeddings." | *No citation needed (standard)*; optionally cite a textbook — not in frozen list, so leave uncited. | — | OPTIONAL |
| M-C8 | "t-SNE with perplexity = X, initialization = PCA, …" (first naming of t-SNE). | van der Maaten & Hinton 2008 t-SNE original | METHODS | ESSENTIAL |
| M-C9 | "PCA initialization for t-SNE follows recommended practice." | Kobak & Linderman 2021 t-SNE/UMAP initialization | METHODS | ESSENTIAL if PCA-init is stated as a deliberate choice |
| M-C10 | "UMAP with n_neighbors = X, min_dist = Y" (first naming of UMAP). | McInnes 2018 UMAP original | METHODS | ESSENTIAL |
| M-C11 | "Silhouette coefficient used to quantify cluster separation." | Rousseeuw 1987 silhouette | METHODS | ESSENTIAL |
| M-C12 | "Davies–Bouldin index reported alongside silhouette." | Davies & Bouldin 1979 DB index | METHODS | ESSENTIAL |
| M-C13 | "Oxide / nitride subset definitions drawn from JARVIS composition filters." | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| M-C14 | Transfer learning / fine-tuning protocol description (if included in Methods). | Lee & Asahi 2021 transfer CGCNN | PRIMARY | ESSENTIAL if a TL protocol is described |
| M-C15 | Hyperparameter defaults inherited from ALIGNN release. | Choudhary & DeCost 2021 ALIGNN | PRIMARY | ESSENTIAL |
| M-C16 | Own-measured MAEs / learning-curve values / embedding statistics. | *NO CITATION — rule 1* | — | — |

### 1c. Results III / IV minimal citation map

Rule governing this section: **citations only where the method is first named inside a Results sentence, or where a projection caveat accompanies a figure.** No citations on measured numbers, curve shapes, cluster counts, or any finding we computed.

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| R-C1 | First in-Results use of the phrase "t-SNE projection" in a figure caption or sentence (if not already cited in Methods). | van der Maaten & Hinton 2008 t-SNE original | METHODS | OPTIONAL (ESSENTIAL only if Methods did not already cite) |
| R-C2 | First in-Results use of "UMAP projection" (same condition). | McInnes 2018 UMAP original | METHODS | OPTIONAL (ESSENTIAL only if Methods did not already cite) |
| R-C3 | Caveat sentence attached to a t-SNE/UMAP figure, e.g., "distances and cluster shapes in the 2D projection should not be interpreted quantitatively." | Chari & Pachter 2023 specious art; Wattenberg 2016 How to Use t-SNE | METHODS (caveat) | ESSENTIAL (at least one; prefer Chari & Pachter for distance claims, Wattenberg for shape/perplexity claims) |
| R-C4 | Caveat sentence that notes initialization / seed sensitivity of the embedding. | Kobak & Linderman 2021 initialization | METHODS (caveat) | ESSENTIAL if seed/init sensitivity is mentioned |
| R-C5 | Silhouette / DB numbers reported in a Results sentence (method reminder). | Rousseeuw 1987; Davies & Bouldin 1979 | METHODS | OPTIONAL (only if Methods didn't name them) |
| R-C6 | Any sentence stating our measured MAE, RMSE, learning-curve slope, cluster index, or embedding geometry. | *NO CITATION — rule 1* | — | — |
| R-C7 | "These oxide results align with the in-distribution regime of pretrained crystal GNNs." (comparison-to-prior-work sentence, if present) | Choudhary & DeCost 2021 ALIGNN; Choudhary 2024 Leaderboard | PRIMARY / BENCH | OPTIONAL |
| R-C8 | "The nitride degradation pattern is consistent with structure-based OOD reports." (if such a sentence appears in Results) | Omee 2024 structure-based OOD; Kangming Li 2025 | PRIMARY | OPTIONAL (preferred location is Discussion) |

### 1d. Discussion citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| D-C1 | "Oxide performance matches published pretrained-ALIGNN formation-energy accuracy." | Choudhary & DeCost 2021 ALIGNN; Choudhary 2024 Leaderboard | PRIMARY / BENCH | ESSENTIAL |
| D-C2 | "Nitride degradation is a textbook domain-shift signature — IID test loss understates held-out-chemistry error." | Kangming Li 2025 probing OOD; Omee 2024 structure-based OOD | PRIMARY | ESSENTIAL |
| D-C3 | "Worst-case / adversarially constructed splits expose even larger gaps." | Qinyang Li 2025 adversarial OOD | PRIMARY | OPTIONAL |
| D-C4 | "Domain adaptation is a candidate mitigation." | Hu 2024 domain adaptation | PRIMARY | ESSENTIAL if mitigation is named |
| D-C5 | "Transfer learning / fine-tuning on small nitride sets is a practical next step, following prior CGCNN transfer work." | Lee & Asahi 2021 transfer CGCNN | PRIMARY | ESSENTIAL |
| D-C6 | "Similar transfer strategy has succeeded for melting-temperature prediction." | Kim 2024 melting + transfer | PRIMARY (secondary) | OPTIONAL |
| D-C7 | "Cluster shapes and inter-cluster distances in t-SNE/UMAP projections should not be taken as chemical distances." | Chari & Pachter 2023 specious art | METHODS (caveat) | ESSENTIAL |
| D-C8 | "Perplexity / neighborhood-size choices materially alter apparent structure." | Wattenberg 2016 How to Use t-SNE | METHODS (caveat) | ESSENTIAL |
| D-C9 | "Global structure preservation is limited; PCA is complementary for the coarse geometry." | Kobak & Berens 2019 global structure | METHODS (caveat) | ESSENTIAL |
| D-C10 | "Initialization choices explain much of the t-SNE/UMAP divergence." | Kobak & Linderman 2021 initialization | METHODS (caveat) | OPTIONAL |
| D-C11 | "Silhouette / DB indices quantify what the eye cannot." | Rousseeuw 1987; Davies & Bouldin 1979 | METHODS | OPTIONAL (reminder) |
| D-C12 | "JARVIS remains the reference pretraining corpus; the oxide/nitride split is a function of its composition distribution." | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| D-C13 | "Benchmarks such as the JARVIS-Leaderboard and Matbench contextualize these numbers." | Choudhary 2024 JARVIS-Leaderboard; Dunn 2020 Matbench | BENCH | OPTIONAL |
| D-C14 | "The line-graph inductive bias that powers ALIGNN does not by itself guarantee OOD robustness." | Choudhary & DeCost 2021 ALIGNN; Omee 2024 | PRIMARY | ESSENTIAL |
| D-C15 | Own-measured numbers, MAE gaps, cluster counts in Discussion. | *NO CITATION — rule 1* | — | — |

---

## 2. NITRIDE STANDALONE

### 2a. Introduction citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| N-I1 | Nitrides are chemically/structurally distinct from oxides; they are under-represented in mainstream DFT training corpora. | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| N-I2 | Pretrained crystal GNNs (ALIGNN, CGCNN, MEGNet) achieve strong IID formation-energy accuracy. | Choudhary & DeCost 2021 ALIGNN; Xie & Grossman 2018 CGCNN; Chen 2019 MEGNet | PRIMARY | ESSENTIAL |
| N-I3 | Generalization to under-represented chemistries is an open problem (OOD framing). | Kangming Li 2025 probing OOD; Omee 2024 structure-based OOD | PRIMARY | ESSENTIAL |
| N-I4 | Adversarial OOD constructions further stress-test models. | Qinyang Li 2025 adversarial OOD | PRIMARY | OPTIONAL |
| N-I5 | Domain adaptation and transfer learning are two candidate mitigations. | Hu 2024 domain adaptation; Lee & Asahi 2021 transfer CGCNN | PRIMARY | ESSENTIAL (pick at least one; ideally both) |
| N-I6 | Benchmarks contextualize raw error numbers. | Choudhary 2024 JARVIS-Leaderboard | BENCH | OPTIONAL |
| N-I7 | We use embedding projection as a diagnostic (methods first-naming). | van der Maaten & Hinton 2008 t-SNE; McInnes 2018 UMAP | METHODS | ESSENTIAL |

### 2b. Methods citation map

Same-as-combined references: every entry below is identical in intent to the matching COMBINED §1b row.

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality | Notes |
|---|---|---|---|---|---|
| N-M1 | Pretrained ALIGNN architecture and checkpoint. | Choudhary & DeCost 2021 ALIGNN | PRIMARY | ESSENTIAL | Same as COMBINED M-C1 |
| N-M2 | JARVIS-DFT pretraining corpus. | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL | Same as COMBINED M-C2 |
| N-M3 | JARVIS tooling. | Choudhary 2025 JARVIS Infrastructure | METHODS | ESSENTIAL if tooling named | Same as COMBINED M-C3 |
| N-M4 | Leaderboard reference numbers. | Choudhary 2024 JARVIS-Leaderboard | BENCH | ESSENTIAL *conditional* | Same as COMBINED M-C4 |
| N-M5 | t-SNE first naming. | van der Maaten & Hinton 2008 | METHODS | ESSENTIAL | Same as COMBINED M-C8 |
| N-M6 | UMAP first naming. | McInnes 2018 | METHODS | ESSENTIAL | Same as COMBINED M-C10 |
| N-M7 | PCA-init t-SNE justification. | Kobak & Linderman 2021 | METHODS | ESSENTIAL if stated | Same as COMBINED M-C9 |
| N-M8 | Silhouette. | Rousseeuw 1987 | METHODS | ESSENTIAL | Same as COMBINED M-C11 |
| N-M9 | Davies–Bouldin. | Davies & Bouldin 1979 | METHODS | ESSENTIAL | Same as COMBINED M-C12 |
| N-M10 | Nitride subset definition (composition filter on JARVIS). | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL | Nitride-specific — do NOT drop |
| N-M11 | Any transfer-learning / fine-tuning protocol reported in nitride arm. | Lee & Asahi 2021 transfer CGCNN | PRIMARY | ESSENTIAL if protocol described | Same as COMBINED M-C14 |
| N-M12 | Own MAEs, per-split errors, embedding geometry numbers. | *NO CITATION* | — | — | Rule 1 |

### 2c. Discussion citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| N-D1 | "Nitride errors substantially exceed JARVIS-reported ALIGNN IID MAE — a domain-shift signature." | Choudhary & DeCost 2021 ALIGNN; Choudhary 2024 Leaderboard | PRIMARY / BENCH | ESSENTIAL |
| N-D2 | "This matches the held-out-chemistry degradation reported for pretrained crystal GNNs." | Kangming Li 2025 probing OOD | PRIMARY | ESSENTIAL |
| N-D3 | "Structure-based OOD evaluation would likely amplify the gap further." | Omee 2024 structure-based OOD | PRIMARY | ESSENTIAL |
| N-D4 | "Worst-case adversarial OOD splits provide an upper bound on fragility." | Qinyang Li 2025 adversarial OOD | PRIMARY | OPTIONAL |
| N-D5 | "Domain adaptation is a plausible mitigation path for the nitride regime." | Hu 2024 domain adaptation | PRIMARY | ESSENTIAL |
| N-D6 | "Transfer learning / fine-tuning from the pretrained checkpoint to small nitride sets is the first-line practical recommendation." | Lee & Asahi 2021 transfer CGCNN | PRIMARY | ESSENTIAL |
| N-D7 | "Analogous transfer gains have been reported on other thermophysical targets." | Kim 2024 melting + transfer | PRIMARY (secondary) | OPTIONAL |
| N-D8 | "Apparent nitride sub-clustering in t-SNE/UMAP should not be read as chemical similarity." | Chari & Pachter 2023 specious art | METHODS (caveat) | ESSENTIAL |
| N-D9 | "Perplexity sensitivity means a single projection is not evidence." | Wattenberg 2016 How to Use t-SNE | METHODS (caveat) | ESSENTIAL |
| N-D10 | "Global-geometry claims require PCA corroboration." | Kobak & Berens 2019 global structure | METHODS (caveat) | ESSENTIAL |
| N-D11 | "Initialization explains much of the t-SNE vs UMAP discrepancy." | Kobak & Linderman 2021 initialization | METHODS (caveat) | OPTIONAL |
| N-D12 | "Silhouette and DB confirm the nitride cluster separation that is visually suggested." | Rousseeuw 1987; Davies & Bouldin 1979 | METHODS | OPTIONAL (reminder) |
| N-D13 | "JARVIS composition imbalance is the structural cause of the nitride gap." | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| N-D14 | Own nitride numbers / MAE gaps / cluster statistics. | *NO CITATION* | — | — |

---

## 3. OXIDE STANDALONE

### 3a. Introduction citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| O-I1 | Oxides are the most populous chemistry in JARVIS and in most crystal-property corpora. | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| O-I2 | Pretrained crystal GNNs achieve near-DFT formation-energy accuracy on oxide-rich corpora. | Choudhary & DeCost 2021 ALIGNN; Xie & Grossman 2018 CGCNN; Chen 2019 MEGNet | PRIMARY | ESSENTIAL |
| O-I3 | Reference leaderboard numbers for pretrained ALIGNN formation-energy MAE. | Choudhary 2024 JARVIS-Leaderboard | BENCH | ESSENTIAL |
| O-I4 | Matbench is an alternative standard. | Dunn 2020 Matbench | BENCH | OPTIONAL |
| O-I5 | Oxide arm serves as an in-distribution control for a companion OOD (nitride) study. | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| O-I6 | Embedding projections (t-SNE/UMAP) are used as representation diagnostics. | van der Maaten & Hinton 2008; McInnes 2018 | METHODS | ESSENTIAL |
| O-I7 | Projections require interpretive caution (optionally flagged in Intro). | Wattenberg 2016; Chari & Pachter 2023 | METHODS (caveat) | OPTIONAL in Intro, ESSENTIAL in Discussion |

### 3b. Methods citation map

Mirror of COMBINED §1b; oxide-specific rows marked.

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality | Notes |
|---|---|---|---|---|---|
| O-M1 | Pretrained ALIGNN architecture and checkpoint. | Choudhary & DeCost 2021 ALIGNN | PRIMARY | ESSENTIAL | Same as COMBINED M-C1 |
| O-M2 | JARVIS-DFT pretraining corpus. | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL | Same as COMBINED M-C2 |
| O-M3 | JARVIS tooling. | Choudhary 2025 JARVIS Infrastructure | METHODS | ESSENTIAL if tooling named | Same as COMBINED M-C3 |
| O-M4 | Leaderboard reference numbers. | Choudhary 2024 JARVIS-Leaderboard | BENCH | ESSENTIAL *conditional* | Same as COMBINED M-C4 |
| O-M5 | t-SNE first naming. | van der Maaten & Hinton 2008 | METHODS | ESSENTIAL | Same as COMBINED M-C8 |
| O-M6 | UMAP first naming. | McInnes 2018 | METHODS | ESSENTIAL | Same as COMBINED M-C10 |
| O-M7 | PCA-init t-SNE justification. | Kobak & Linderman 2021 | METHODS | ESSENTIAL if stated | Same as COMBINED M-C9 |
| O-M8 | Silhouette. | Rousseeuw 1987 | METHODS | ESSENTIAL | Same as COMBINED M-C11 |
| O-M9 | Davies–Bouldin. | Davies & Bouldin 1979 | METHODS | ESSENTIAL | Same as COMBINED M-C12 |
| O-M10 | Oxide subset definition (composition filter on JARVIS). | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL | Oxide-specific — do NOT drop |
| O-M11 | Own-measured numbers. | *NO CITATION* | — | — | Rule 1 |

### 3c. Discussion citation map

| # | Claim / sentence trigger | Citation(s) | Role | Essentiality |
|---|---|---|---|---|
| O-D1 | "Oxide MAE is consistent with published pretrained-ALIGNN performance." | Choudhary & DeCost 2021 ALIGNN; Choudhary 2024 Leaderboard | PRIMARY / BENCH | ESSENTIAL |
| O-D2 | "Oxides sit firmly in-distribution for the JARVIS-trained ALIGNN checkpoint." | Choudhary 2020 JARVIS dataset | PRIMARY | ESSENTIAL |
| O-D3 | "The oxide result serves as a positive control against which the nitride domain-shift arm is measured." (framing statement only — no OOD citation here unless explicitly comparing) | *No citation needed if framing only*; if the sentence cites the OOD literature to justify the control design → Kangming Li 2025; Omee 2024 | PRIMARY | OPTIONAL |
| O-D4 | "Visual oxide clusters in t-SNE/UMAP should not be over-interpreted as chemically meaningful geometry." | Chari & Pachter 2023 specious art | METHODS (caveat) | ESSENTIAL |
| O-D5 | "Perplexity and neighborhood hyperparameters shape the apparent clustering." | Wattenberg 2016 How to Use t-SNE | METHODS (caveat) | ESSENTIAL |
| O-D6 | "Global structure in these 2D views is unreliable; PCA is used as a complementary coarse view." | Kobak & Berens 2019 global structure | METHODS (caveat) | ESSENTIAL |
| O-D7 | "Differences between t-SNE and UMAP projections are largely initialization-driven." | Kobak & Linderman 2021 initialization | METHODS (caveat) | OPTIONAL |
| O-D8 | "Silhouette / DB numbers corroborate the qualitative oxide cluster structure." | Rousseeuw 1987; Davies & Bouldin 1979 | METHODS | OPTIONAL (reminder) |
| O-D9 | "Transfer learning is not needed in the oxide regime but remains the recommended strategy for under-represented chemistries such as nitrides." | Lee & Asahi 2021 transfer CGCNN | PRIMARY | OPTIONAL (include only if Discussion bridges to nitride arm) |
| O-D10 | Own oxide MAEs, learning-curve shapes, silhouette/DB values. | *NO CITATION* | — | — |

---

## Cross-cutting verification notes for drafters

1. **Placeholder audit.** Any existing `[CITE: ...]` placeholder that currently reads `Choudhary 2021 JARVIS` is wrong — that is the ALIGNN paper, not a JARVIS-dataset reference. Correct to `[CITE: Choudhary2020_JARVIS]` for dataset claims or `[CITE: Choudhary2021_ALIGNN]` for architecture claims.
2. **Li disambiguation audit.** Any placeholder reading `[CITE: Li2025_OOD]` is ambiguous. Replace with `[CITE: KangmingLi2025_probingOOD]` for "held-out-chemistry / generalization-gap" sentences and `[CITE: QinyangLi2025_adversarialOOD]` for "adversarial / worst-case" sentences. If the sentence makes a structure-based OOD claim, use `[CITE: Omee2024_structureOOD]` instead (or in addition).
3. **Transfer-learning primary vs secondary.** Lee & Asahi 2021 is the primary transfer-learning CGCNN reference. Kim 2024 is a secondary example; it should never appear alone where Lee & Asahi would fit.
4. **Embedding caveat ladder selection.** Match the caveat citation to the specific worry: distance-in-2D / cluster-shape-as-meaning → Chari & Pachter 2023; perplexity/shape artifacts → Wattenberg 2016; global-structure loss → Kobak & Berens 2019; seed/initialization → Kobak & Linderman 2021.
5. **Results-section minimalism.** Do not back-fill Results sentences with PRIMARY/BENCH citations for claims we measured. The only admissible Results citations are (a) method first-namings not already covered by Methods and (b) the caveat line tied directly to a projection figure.
6. **Rule 1 reminder, repeated.** Measured MAEs, RMSEs, learning-curve slopes, cluster counts, silhouette/DB values, embedding geometry descriptors, and per-split errors are our findings. They carry zero citations.
7. **Duplication policy confirmed.** Methods rows in the nitride and oxide standalones inherit from COMBINED §1b by design — same citation, no new rationale needed. Drafters should simply copy the `[CITE: ...]` placeholder across files.
8. **Essentiality summary for the drafter's triage.** Every ESSENTIAL row must be resolved to an inserted placeholder before submission. OPTIONAL rows are strengthening — insert if space and prose flow permit, omit otherwise. No ESSENTIAL row is permitted to remain uncited in the final manuscript.