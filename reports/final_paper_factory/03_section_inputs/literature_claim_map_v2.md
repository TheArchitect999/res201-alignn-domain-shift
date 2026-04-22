# Literature Claim Map — v2

Scope: Stage 5 planning for the combined-paper introduction and the opening methods context. This file separates what can be claimed from scholarship, what comes from the project brief and repo design, and what counts as our own research questions.

**Version note (v2).** Patch applied per Stage 5 lit-intro review. Changes are: JARVIS 2020 added as primary provenance anchor; Kim et al. 2024 added explicitly as secondary transfer-learning support; citation hierarchy tightened for transfer learning and JARVIS rows; Matbench confirmed optional; literature / project / question boundary language strengthened. No claims were added or broadened.

---

## Source Tier Note

### Scholarly Anchors

Use these as manuscript-citable anchors, with citation placeholders only at this stage.

| Theme | Local source candidates | Planned manuscript role |
|---|---|---|
| Crystal graph baseline | `paper_sources/CGCNN_Paper.pdf`; `paper_sources/Chen et al. - 2019 - Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals.pdf` | Foundational background for structure-based graph learning in materials |
| ALIGNN architecture | `paper_sources/ALIGNN_Paper.pdf` | Main architecture citation for the pretrained model family used in this project |
| JARVIS ecosystem / benchmark context | **Primary (dataset/repository provenance):** `[JARVIS 2020 — to be obtained; see note below]` Choudhary et al. 2020, "The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design," *npj Computational Materials* 6, 173. **Secondary (broader ecosystem/pretrained infrastructure):** `paper_sources/Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf`. **Contextual (benchmarking/leaderboard framing only):** `paper_sources/Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | JARVIS 2020 is the primary anchor for where the DFT dataset and repository come from. JARVIS 2025 covers broader pretrained-model ecosystem context. JARVIS-Leaderboard 2024 is used only when the sentence explicitly concerns benchmark infrastructure or leaderboard standing — not as a generic JARVIS citation. |
| Materials-data ecosystem background | `paper_sources/Jain et al. - 2013 - Commentary The Materials Project A materials genome approach to accelerating materials innovation.pdf`; `paper_sources/Dunn et al. - 2020 - Benchmarking materials property prediction methods the Matbench test set and Automatminer reference algorithm.pdf` | Optional background only. Include only if the intro or methods section genuinely needs broader benchmarking or data-ecosystem context. Do not force Matbench into the paper to appear scholarly. |
| Transfer learning in materials | **Primary:** `paper_sources/Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`. **Secondary (low-data property transfer):** `paper_sources/Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf`. **Contextual (domain adaptation / shifted-target framing):** `paper_sources/Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | Lee & Asahi 2021 is the canonical primary citation for transfer learning in crystal-graph materials ML. Kim et al. 2024 is the best supporting anchor for "pretrain-then-fine-tune on scarce property data." Hu et al. 2024 is contextual support when the wording leans specifically toward domain adaptation or realistic shifted-target evaluation — not the default lead citation for generic transfer-learning sentences. |
| Domain shift / OOD in materials ML | `paper_sources/Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `paper_sources/Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf`; `paper_sources/Li et al. - 2025 - Out-of-Distribution Material Property Prediction Using Adversarial Learning.pdf` | Literature support for the domain-shift framing and the need for explicit OOD evaluation |

**JARVIS 2020 file status.** The 2020 paper (Choudhary et al., npj Computational Materials 6, 173) is not yet in `paper_sources/`. It must be obtained before manuscript submission. For planning purposes, treat it as the canonical provenance anchor. When obtained, add it as `paper_sources/Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design.pdf` or equivalent.

---

### Internal Course / Project Scaffolding

These shape wording, sequencing, and implementation discipline, but they are not default manuscript references.

| Source | Role in paper planning | Manuscript policy |
|---|---|---|
| `paper_sources/ALIGNN_Tutorial.pdf` | Practical implementation guidance, training outputs, parity-plot conventions | Do not use as the primary scholarly citation for ALIGNN |
| `paper_sources/RES201_Project.pdf` | Project brief; defines oxide control, nitride shift, and required deliverables | Internal framing source, not a normal manuscript citation |
| `paper_sources/Research_Assignment_1.pdf`; `paper_sources/Research_Assignment_2.pdf` | Course scaffolding and conceptual framing | Internal only unless advisor explicitly permits otherwise |
| `paper_sources/JURI_Template.docx` | Formatting / deliverable scaffold | Never a scholarly citation |
| `REPORT_PLAN.txt`; `reports/final_paper_factory/01_blueprints/*.md`; `reports/final_paper_factory/00_source_of_truth/*.md` | Repo-specific planning and guardrails | Internal only; do not cite in the manuscript |

---

## 1. Literature-Grounded Claims

These are the claims that should be backed by manuscript citations.

The three-column separation (literature / project / question) is **operational, not decorative**. A sentence that belongs in the project column cannot borrow its authority from the literature column by adding a citation placeholder. Drafters must assign each sentence to exactly one column before writing it.

| ID | Safe claim family | Citation placeholder(s) | Local source candidates | Writing note |
|---|---|---|---|---|
| L1 | Crystal-structure graph neural networks are established tools for materials property prediction because they learn from atomic structure directly rather than relying only on handcrafted descriptors. | `[CITE: crystal graph baseline for materials property prediction]` | `CGCNN_Paper.pdf`; `Chen et al. - 2019 - Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals.pdf` | Use for the opening field-setting paragraph. Do not attach any project results here. |
| L2 | CGCNN is a natural baseline anchor for crystal-graph learning in materials informatics. | `[CITE: CGCNN foundational paper]` | `CGCNN_Paper.pdf`; `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf` | Keep this as historical / conceptual context, not as a claim that the present project benchmarks CGCNN directly. |
| L3 | ALIGNN extends crystal-graph message passing with angle-aware line-graph information, making it a stronger geometry-aware model family for crystal-property prediction. | `[CITE: ALIGNN foundational paper]` | `ALIGNN_Paper.pdf` | This is the main model-architecture citation for the paper. |
| L4 | JARVIS provides the primary repository and DFT dataset infrastructure from which the pretrained formation-energy checkpoints used in this work are drawn. The broader JARVIS ecosystem also supports pretrained-model availability and reproducible evaluation pipelines. | `[CITE: JARVIS dataset/repository paper]`; `[CITE: JARVIS infrastructure or ecosystem paper]` | **Primary (dataset/repository provenance):** JARVIS 2020 (to be obtained). **Secondary:** `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf`. **Contextual (only if sentence concerns benchmarking/leaderboard):** `Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | Use JARVIS 2020 when the sentence anchors where the dataset or repository comes from. Use JARVIS 2025 when the sentence describes the broader pretrained-infrastructure ecosystem. Use the 2024 Leaderboard paper only when the sentence genuinely concerns benchmark standing or leaderboard infrastructure — do not use it as a generic JARVIS citation. Do not force all three into a single sentence. |
| L5 | Transfer learning can improve materials-property prediction in limited-data regimes, but the benefit depends on source-target relatedness and the quality of the pretrained representation. | `[CITE: transfer learning in materials informatics]` | **Primary:** `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`. **Secondary:** `Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf`. **Contextual:** `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | Lee & Asahi 2021 is the canonical anchor; it should lead. Kim et al. 2024 is a strong secondary if the sentence specifically references property-specific or low-data transfer. Hu et al. 2024 is contextual support when the wording leans toward domain adaptation or realistic shifted-target evaluation. Do not treat Hu et al. as the default lead citation for generic transfer-learning sentences; it is not the primary anchor. This claim motivates the fine-tuning question — it should not pre-answer it. |
| L6 | Out-of-distribution or domain-shift effects can degrade materials-ML performance when evaluation chemistry or structure differs from the data regime that supported training or pretraining. | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf`; `Li et al. - 2025 - Out-of-Distribution Material Property Prediction Using Adversarial Learning.pdf` | Use for the literature-gap paragraph and for discussion framing later. |
| L7 | Embedding-space analyses can be used as interpretive probes of distributional structure and error patterns, but they should not be treated as causal proof by themselves. | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf` | This claim protects the paper from overreading the embedding section. |

---

## 2. Project-Specific Motivation

These statements come from the brief, the blueprints, and the repo design. They are part of the paper's motivation, but they are **not themselves literature claims** and must not borrow a literature citation to appear more authoritative.

| ID | Project-specific statement | Primary basis | External citation needed? | Writing note |
|---|---|---|---|---|
| M1 | The study is intentionally organized as a control-versus-shift design: oxide is the in-distribution control arm and nitride is the out-of-distribution test arm. | `paper_sources/RES201_Project.pdf`; `docs/PROJECT_STATUS_SO_FAR.md`; `combined_paper_blueprint_v3.md` | No external citation for the study design itself | This is our project framing. Do not present it as a literature consensus statement, and do not attach a domain-shift citation to it. |
| M2 | The same pretrained formation-energy ALIGNN model is evaluated zero-shot, then under fine-tuning, and compared against matched from-scratch baselines. | `FIG_SCHEMATIC` memo; blueprints; repo README | Needs ALIGNN / JARVIS citation only if the sentence also explains model provenance | The experimental comparison is ours; the model family and ecosystem still need normal citations when named. |
| M3 | The paper uses embedding analysis as a mechanism-oriented follow-up to the behavioral results. | Combined and nitride v3 blueprints; figure memos for `FIG_EA_6A` through `FIG_EA_6D` | No mandatory external citation for the workflow choice | Keep the wording modest: mechanism-oriented, not mechanism-proven. |
| M4 | Set 1 is the canonical main-results namespace because it matches the project brief's required hyperparameter setting. | `claim_support_map_v2.csv`; `source_of_truth_memo_v2.md`; `README.md` | No manuscript citation required | This belongs in methods / internal planning, not the introduction. |
| M5 | The introduction must stay result-free: background, motivation, objective, and paper map only. | v3 blueprints; `REPORT_PLAN.txt` | No manuscript citation required | Drafting guardrail only. |

---

## 3. Our Specific Research Questions

These are our paper's questions. They are not citations in themselves, though the framing language around them should be supported by the literature claims above.

| RQ ID | Research question | Claim layer | Citation expectation |
|---|---|---|---|
| RQ1 | How does a pretrained formation-energy ALIGNN model behave on an in-distribution oxide control task versus an out-of-distribution nitride test task at the zero-shot starting point? | Our question | No citation required for the question itself; the surrounding setup should already cite ALIGNN and domain-shift background. |
| RQ2 | How does fine-tuning response change with labeled-data scale across the oxide control arm and the nitride shifted arm? | Our question | No citation required for the question itself. |
| RQ3 | What advantage does pretraining provide over matched from-scratch training at the sample sizes where both families have scratch baselines? | Our question | No citation required for the question itself. |
| RQ4 | Does pretrained embedding-space geometry help explain why nitride prediction remains harder than oxide prediction? | Our question | No citation required for the question itself; use domain-shift literature only to motivate why this is a meaningful question. |

---

## Working Boundary

- **Literature-grounded claims** should cite scholarship.
- **Project-specific motivation** should cite scholarship only when model architecture or data provenance is named.
- **Our research questions** should usually not be citation-bearing sentences.
- These three categories are **operational, not decorative**. A sentence cannot slide from the project column to the literature column by adding a citation placeholder.
- Do not turn `ALIGNN_Tutorial.pdf`, the project brief, the blueprints, or repo planning docs into manuscript references unless explicit advisor guidance overrides this policy.
- Benchmark and ecosystem papers (Matbench, JARVIS-Leaderboard) are optional background, not required core evidence for the paper's thesis.
