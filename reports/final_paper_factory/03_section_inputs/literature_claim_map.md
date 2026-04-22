# Literature Claim Map

Scope: Stage 5 planning for the combined-paper introduction and the opening methods context. This file separates what can be claimed from scholarship, what comes from the project brief and repo design, and what counts as our own research questions.

## Source Tier Note

### Scholarly Anchors

Use these as manuscript-citable anchors, with citation placeholders only at this stage.

| Theme | Local source candidates | Planned manuscript role |
|---|---|---|
| Crystal graph baseline | `paper_sources/CGCNN_Paper.pdf`; `paper_sources/Chen et al. - 2019 - Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals.pdf` | Foundational background for structure-based graph learning in materials |
| ALIGNN architecture | `paper_sources/ALIGNN_Paper.pdf` | Main architecture citation for the pretrained model family used in this project |
| JARVIS ecosystem / benchmark context | `paper_sources/Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf`; `paper_sources/Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | Dataset / infrastructure / pretrained-model provenance context |
| Materials-data ecosystem background | `paper_sources/Jain et al. - 2013 - Commentary The Materials Project A materials genome approach to accelerating materials innovation.pdf`; `paper_sources/Dunn et al. - 2020 - Benchmarking materials property prediction methods the Matbench test set and Automatminer reference algorithm.pdf` | Optional background if the intro needs broader benchmarking or data-ecosystem context |
| Transfer learning in materials | `paper_sources/Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`; `paper_sources/Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | Literature support for transfer-learning motivation and limits |
| Domain shift / OOD in materials ML | `paper_sources/Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `paper_sources/Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf`; `paper_sources/Li et al. - 2025 - Out-of-Distribution Material Property Prediction Using Adversarial Learning.pdf` | Literature support for the domain-shift framing and the need for explicit OOD evaluation |

### Internal Course / Project Scaffolding

These shape wording, sequencing, and implementation discipline, but they are not default manuscript references.

| Source | Role in paper planning | Manuscript policy |
|---|---|---|
| `paper_sources/ALIGNN_Tutorial.pdf` | Practical implementation guidance, training outputs, parity-plot conventions | Do not use as the primary scholarly citation for ALIGNN |
| `paper_sources/RES201_Project.pdf` | Project brief; defines oxide control, nitride shift, and required deliverables | Internal framing source, not a normal manuscript citation |
| `paper_sources/Research_Assignment_1.pdf`; `paper_sources/Research_Assignment_2.pdf` | Course scaffolding and conceptual framing | Internal only unless advisor explicitly permits otherwise |
| `paper_sources/JURI_Template.docx` | Formatting / deliverable scaffold | Never a scholarly citation |
| `REPORT_PLAN.txt`; `reports/final_paper_factory/01_blueprints/*.md`; `reports/final_paper_factory/00_source_of_truth/*.md` | Repo-specific planning and guardrails | Internal only; do not cite in the manuscript |

## 1. Literature-Grounded Claims

These are the claims that should be backed by manuscript citations.

| ID | Safe claim family | Citation placeholder(s) | Local source candidates | Writing note |
|---|---|---|---|---|
| L1 | Crystal-structure graph neural networks are established tools for materials property prediction because they learn from atomic structure directly rather than relying only on handcrafted descriptors. | `[CITE: crystal graph baseline for materials property prediction]` | `CGCNN_Paper.pdf`; `Chen et al. - 2019 - Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals.pdf` | Use for the opening field-setting paragraph. Do not attach any project results here. |
| L2 | CGCNN is a natural baseline anchor for crystal-graph learning in materials informatics. | `[CITE: CGCNN foundational paper]` | `CGCNN_Paper.pdf`; `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf` | Keep this as historical / conceptual context, not as a claim that the present project benchmarks CGCNN directly. |
| L3 | ALIGNN extends crystal-graph message passing with angle-aware line-graph information, making it a stronger geometry-aware model family for crystal-property prediction. | `[CITE: ALIGNN foundational paper]` | `ALIGNN_Paper.pdf` | This is the main model-architecture citation for the paper. |
| L4 | JARVIS provides relevant dataset / infrastructure / benchmark context for pretrained formation-energy modeling and reproducible evaluation. | `[CITE: JARVIS infrastructure or dataset paper]` | `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf`; `Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | Use when describing where the pretrained ecosystem and data context come from. |
| L5 | Transfer learning can improve materials-property prediction in limited-data regimes, but the benefit depends on source-target relatedness and the quality of the pretrained representation. | `[CITE: transfer learning in materials informatics]` | `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`; `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | This should motivate the fine-tuning question, not pre-answer it. |
| L6 | Out-of-distribution or domain-shift effects can degrade materials-ML performance when evaluation chemistry or structure differs from the data regime that supported training or pretraining. | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf`; `Li et al. - 2025 - Out-of-Distribution Material Property Prediction Using Adversarial Learning.pdf` | Use for the literature-gap paragraph and for discussion framing later. |
| L7 | Embedding-space analyses can be used as interpretive probes of distributional structure and error patterns, but they should not be treated as causal proof by themselves. | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf` | This claim protects the paper from overreading the embedding section. |

## 2. Project-Specific Motivation

These statements come from the brief, the blueprints, and the repo design. They are part of the paper's motivation, but they are not themselves literature claims.

| ID | Project-specific statement | Primary basis | External citation needed? | Writing note |
|---|---|---|---|---|
| M1 | The study is intentionally organized as a control-versus-shift design: oxide is the in-distribution control arm and nitride is the out-of-distribution test arm. | `paper_sources/RES201_Project.pdf`; `docs/PROJECT_STATUS_SO_FAR.md`; `combined_paper_blueprint_v3.md` | No external citation for the study design itself | This is our project framing. Do not present it as a literature consensus statement. |
| M2 | The same pretrained formation-energy ALIGNN model is evaluated zero-shot, then under fine-tuning, and compared against matched from-scratch baselines. | `FIG_SCHEMATIC` memo; blueprints; repo README | Needs ALIGNN / JARVIS citation only if the sentence also explains model provenance | The experimental comparison is ours; the model family and ecosystem still need normal citations when named. |
| M3 | The paper uses embedding analysis as a mechanism-oriented follow-up to the behavioral results. | Combined and nitride v3 blueprints; figure memos for `FIG_EA_6A` through `FIG_EA_6D` | No mandatory external citation for the workflow choice | Keep the wording modest: mechanism-oriented, not mechanism-proven. |
| M4 | Set 1 is the canonical main-results namespace because it matches the project brief's required hyperparameter setting. | `claim_support_map_v2.csv`; `source_of_truth_memo_v2.md`; `README.md` | No manuscript citation required | This belongs in methods / internal planning, not the introduction. |
| M5 | The introduction must stay result-free: background, motivation, objective, and paper map only. | v3 blueprints; `REPORT_PLAN.txt` | No manuscript citation required | Drafting guardrail only. |

## 3. Our Specific Research Questions

These are our paper's questions. They are not citations in themselves, though the framing language around them should be supported by the literature claims above.

| RQ ID | Research question | Claim layer | Citation expectation |
|---|---|---|---|
| RQ1 | How does a pretrained formation-energy ALIGNN model behave on an in-distribution oxide control task versus an out-of-distribution nitride test task at the zero-shot starting point? | Our question | No citation required for the question itself; the surrounding setup should already cite ALIGNN and domain-shift background. |
| RQ2 | How does fine-tuning response change with labeled-data scale across the oxide control arm and the nitride shifted arm? | Our question | No citation required for the question itself. |
| RQ3 | What advantage does pretraining provide over matched from-scratch training at the sample sizes where both families have scratch baselines? | Our question | No citation required for the question itself. |
| RQ4 | Does pretrained embedding-space geometry help explain why nitride prediction remains harder than oxide prediction? | Our question | No citation required for the question itself; use domain-shift literature only to motivate why this is a meaningful question. |

## Working Boundary

- Literature-grounded claims should cite scholarship.
- Project-specific motivation should cite scholarship only when model architecture or data provenance is named.
- Our research questions should usually not be citation-bearing sentences.
- Do not turn `ALIGNN_Tutorial.pdf`, the project brief, the blueprints, or repo planning docs into manuscript references unless explicit advisor guidance overrides this policy.
