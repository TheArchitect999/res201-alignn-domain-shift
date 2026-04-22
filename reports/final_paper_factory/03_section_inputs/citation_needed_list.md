# Citation Needed List v2

Supersedes `citation_needed_list.md` v1 for Methods, Discussion, and Abstract planning. Introduction planning has moved to `introduction_blueprint_v2.md` §5 and is no longer maintained here.

Inherits all source-tier rules from `literature_claim_map.md`: scholarly anchors are citable, internal course scaffolding (brief, tutorial, blueprints, repo planning docs) is not.

## What changed from v1

| Change | Rationale |
|---|---|
| Introduction rows removed | Single source of truth: `introduction_blueprint_v2.md` §5 is now authoritative for P1–P5 citation essentiality. Two tables in two files was causing drift risk. |
| Methods expanded from 3 rows to 10 rows | v1 covered only dataset, model, and an optional historical baseline. The actual methods section has many more paragraphs, most of which are citation-free. Stating that explicitly prevents drafters from inventing decoration to "look scholarly." |
| Discussion expanded from 1 row to 6 rows | v1 lumped the entire discussion under "generalization." The discussion section has distinct paragraphs for pretraining value, domain-shift interpretation, embedding interpretation, practical implications, limitations, and future work — each with different citation needs. |
| Abstract row added | v1 was silent on abstracts, which left ambiguity. The row exists to explicitly state the no-citations convention. |
| Essentiality tagging adopted | Each row now carries `ESSENTIAL` / `CONDITIONAL` / `OPTIONAL` / `NONE`, matching the convention in `introduction_blueprint_v2.md` §5. |

## Citation policy note (unchanged)

- Use citation placeholders only at this stage.
- Prefer scholarly anchors from `paper_sources/`.
- Do not insert manuscript citations to internal scaffolding by default: `ALIGNN_Tutorial.pdf`, `RES201_Project.pdf`, `Research_Assignment_1.pdf`, `Research_Assignment_2.pdf`, the blueprints, `REPORT_PLAN.txt`, and repo planning docs are internal guidance rather than default references.
- `NONE` means "do not invent a citation here." It does not mean "add one if it feels empty."

## Section 1 — Introduction

> **Superseded.** See `introduction_blueprint_v2.md` §5 (consolidated citation table) and §6 (local source candidates mapped to placeholders). Do not maintain introduction citation planning in this file.

## Section 2 — Methods

The methods section has a mix of literature-dependent and self-contained paragraphs. Most methods paragraphs are `NONE`: the protocol is ours, the constituent concepts are already cited earlier in the paper, and adding fresh citations would decorate rather than inform.

| Paragraph ID | Planned function | Citation essentiality | Placeholder set | Local source candidates | Notes |
|---|---|---|---|---|---|
| M1 | Dataset and benchmark provenance (JARVIS-DFT-3D, how it was obtained, what it contains). | ESSENTIAL | `[CITE: JARVIS infrastructure or dataset paper]` | `Choudhary__2025__The_JARVIS_Infrastructure_is_All_You_Need_for_Materials_Design.pdf`; `Choudhary_et_al___2024__JARVISLeaderboard_a_large_scale_benchmark_of_materials_design_methods.pdf` | Use the 2024 Leaderboard paper when the sentence is about benchmark infrastructure; use the 2025 Infrastructure paper when it is about the broader JARVIS ecosystem. Either is acceptable; both if the sentence spans both ideas. `Jain_et_al___2013__Commentary_The_Materials_Project_..._.pdf` is OPTIONAL as a broader data-ecosystem anchor only if the paragraph explicitly contextualizes JARVIS against the wider materials-database landscape. |
| M2 | Pretrained formation-energy ALIGNN checkpoint: what the model is, what it was trained on, why we use it as-is. | ESSENTIAL | `[CITE: ALIGNN foundational paper]` | `ALIGNN_Paper.pdf` | Single file. `ALIGNN_Tutorial.pdf` can guide implementation-level phrasing but must not replace the paper citation. |
| M3 | Optional historical context: ALIGNN's relationship to earlier distance-only crystal-graph models. | OPTIONAL | `[CITE: CGCNN foundational paper]` | `CGCNN_Paper.pdf` | Include only if the paragraph explicitly names CGCNN as the historical baseline. If the introduction already carried that contrast, do not repeat it in methods. |
| M4 | Subset filtering: oxide definition (O present), nitride definition (N present, O absent), oxynitride exclusion. | NONE | none | none | This is our data-preparation choice driven by the project brief. No external citation required; do not cite the brief itself. |
| M5 | Split protocol: preservation of original JARVIS train/validation/test IDs, family filtering applied within each split, fixed test set reused across runs. | CONDITIONAL | `[CITE: JARVIS infrastructure or dataset paper]` only if the paragraph invokes the original JARVIS split provenance as a justification | `Choudhary_et_al___2024__JARVISLeaderboard_a_large_scale_benchmark_of_materials_design_methods.pdf`; `Choudhary__2025__The_JARVIS_Infrastructure_is_All_You_Need_for_Materials_Design.pdf` | If M1 already cited JARVIS in the immediately preceding paragraph, the citation can be omitted here and referenced by continuity. Do not cite twice in close succession. |
| M6 | Fine-tuning protocol: unfreeze last two layers, fine-tuning at N ∈ {10, 50, 100, 200, 500, 1000}, three to five seeds per N. | NONE | none | none | The protocol is ours. The broader concept of "pretrain, fine-tune, report MAE" is already cited in introduction P3 via the transfer-learning anchor and does not need repeating. |
| M7 | From-scratch baseline protocol: ALIGNN trained from random initialization at N ∈ {50, 500} for both families. | NONE | none | none | Same reasoning as M6. The baseline design is ours. |
| M8 | Fixed hyperparameters: epochs = 50, learning rate = 1e-4, batch size = 16. | NONE | none | none | These are project-brief-fixed values. Do not cite the brief. The ALIGNN paper's default hyperparameters (300 epochs, lr 1e-3, batch 64) are different and should not be invoked as a justification. |
| M9 | Evaluation metric: test MAE in eV/atom, mean ± std across seeds, canonical main-results namespace (Set 1) preserved. | NONE | none | none | MAE is a standard metric; no citation needed. The canonical-set choice (M4 in `literature_claim_map.md`) is internal policy. |
| M10 | Embedding extraction and visualization: intermediate ALIGNN representations pulled for oxide and nitride structures, projected with PCA / t-SNE / UMAP for visualization, compared for family separation. | CONDITIONAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` only if the paragraph frames the embedding-space probe as a methodological choice that follows prior OOD-in-materials work | `Omee_et_al___2024__Structurebased_outofdistribution_OOD_materials_property_prediction_a_benchmark_study.pdf`; `Li_et_al___2025__Probing_outofdistribution_generalization_in_machine_learning_for_materials.pdf` | Omee et al. 2024 uses t-SNE on GNN latent spaces to interpret OOD behavior and is the most direct prior-art anchor for the methodological choice. If the paragraph simply describes our procedure without claiming methodological lineage, leave this `NONE`. The interpretive caveat (probe, not proof) belongs in discussion, not methods. |

**Methods section citation load.** Two ESSENTIAL placeholders (M1, M2), three CONDITIONAL / OPTIONAL (M3, M5, M10), five `NONE`. A well-written methods section for this paper should not carry more than five distinct citations total.

## Section 3 — Discussion

The discussion is where the literature does the most work after the introduction. Each paragraph below has a distinct argumentative function, and the citation load is intentionally different for each.

| Paragraph ID | Planned function | Citation essentiality | Placeholder set | Local source candidates | Notes |
|---|---|---|---|---|---|
| D1 | What pretraining provides in each family, and how the oxide vs nitride contrast fits the broader transfer-learning picture. | ESSENTIAL | `[CITE: transfer learning in materials informatics]` | `Lee_and_Asahi__2021__Transfer_learning_for_materials_informatics_using_crystal_graph_convolutional_neural_network.pdf`; `Kim_et_al___2024__Predicting_melting_temperature_of_inorganic_crystals_via_crystal_graph_neural_network_enhanced_by_tr.pdf` | Lee & Asahi is the canonical anchor. Kim et al. 2024 is the strongest local "pretrain-then-fine-tune for a scarce property" precedent and fits well when discussing data-efficiency gains. Do not over-cite: one or two citations total for this paragraph. |
| D2 | Why nitride prediction remains harder after fine-tuning — the chemical-family mismatch interpretation, framed against existing OOD findings. | ESSENTIAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee_et_al___2024__Structurebased_outofdistribution_OOD_materials_property_prediction_a_benchmark_study.pdf`; `Li_et_al___2025__Probing_outofdistribution_generalization_in_machine_learning_for_materials.pdf`; `Hu_et_al___2024__Realistic_material_property_prediction_using_domain_adaptation_based_machine_learning.pdf` | Omee et al. 2024 for the general "GNNs degrade on OOD" claim. Li et al. 2025 (Probing) when the paragraph discusses how scaling behavior itself can shift on OOD tasks. Hu et al. 2024 when the paragraph leans toward domain adaptation as a mitigation direction (which is more natural in D6 than D2). |
| D3 | What embedding analysis adds beyond the MAE plots: representation-space geometry as an interpretive probe. | CONDITIONAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee_et_al___2024__Structurebased_outofdistribution_OOD_materials_property_prediction_a_benchmark_study.pdf`; `Li_et_al___2025__Probing_outofdistribution_generalization_in_machine_learning_for_materials.pdf` | The citation is needed to support claim L7 from `literature_claim_map.md` — that embedding-space analyses are interpretive rather than causal. Omee et al. 2024 explicitly uses t-SNE latent-space analysis to interpret OOD behavior and is the cleanest anchor for the "probe, not proof" framing. If the paragraph is purely descriptive of our own embedding result, mark `NONE` and save the citation for the interpretive caveat sentence. |
| D4 | Practical implications for small-data materials discovery: what a practitioner should take from the oxide/nitride contrast when applying pretrained checkpoints to a new chemical family. | OPTIONAL | `[CITE: transfer learning in materials informatics]` | `Lee_and_Asahi__2021__Transfer_learning_for_materials_informatics_using_crystal_graph_convolutional_neural_network.pdf`; `Kim_et_al___2024__Predicting_melting_temperature_of_inorganic_crystals_via_crystal_graph_neural_network_enhanced_by_tr.pdf` | Most of this paragraph will be our recommendations and will not need external anchors. Include a citation only if the paragraph explicitly connects a recommendation to prior transfer-learning findings. Do not stack citations here. |
| D5 | Limitations: single property (formation energy), single architecture (ALIGNN), limited seeds, embedding analysis is qualitative. | CONDITIONAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` only if the paragraph acknowledges that our OOD design (binary oxide vs nitride split) is less systematic than existing OOD benchmark frameworks | `Omee_et_al___2024__Structurebased_outofdistribution_OOD_materials_property_prediction_a_benchmark_study.pdf`; `Li_et_al___2025__Probing_outofdistribution_generalization_in_machine_learning_for_materials.pdf` | A limitations paragraph that acknowledges broader OOD benchmarking machinery gains credibility from pointing at it. A limitations paragraph that only lists internal caveats does not need an external citation. |
| D6 | Future work: extensions to more properties, more chemical families, domain-adaptation methods, quantitative representation metrics. | CONDITIONAL | `[CITE: transfer learning in materials informatics]` and/or `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Hu_et_al___2024__Realistic_material_property_prediction_using_domain_adaptation_based_machine_learning.pdf`; `Li_et_al___2025__OutofDistribution_Material_Property_Prediction_Using_Adversarial_Learning.pdf`; `Omee_et_al___2024__Structurebased_outofdistribution_OOD_materials_property_prediction_a_benchmark_study.pdf` | Hu et al. 2024 is the natural anchor when suggesting domain-adaptation methods as future work. Li et al. 2025 (Adversarial) is the right anchor when suggesting adversarial/OOD-robustness methods. Omee et al. 2024 if suggesting more systematic OOD splits. One citation per suggested future direction is enough; do not build a mini-review here. |

**Discussion section citation load.** Two ESSENTIAL placeholders (D1, D2), three to four CONDITIONAL, one OPTIONAL. A well-written discussion should carry roughly four to seven distinct citations in total. More than that usually means the paper is summarizing other work instead of interpreting its own.

## Section 4 — Abstract

| Paragraph ID | Planned function | Citation essentiality | Notes |
|---|---|---|---|
| A1 | Single paragraph covering problem, method, key results, interpretation, and implication. Under 250 words. Written last. | NONE | Abstracts in this paper do not carry citations by convention. If a reviewer requests one, it would be a JARVIS / ALIGNN anchor at most, but the default is zero. Do not add placeholders to abstract drafts. |

## Section 5 — Citation family summary (full paper, revised)

| Citation family | Paragraphs where it is ESSENTIAL | Paragraphs where it is CONDITIONAL or OPTIONAL |
|---|---|---|
| CGCNN | Intro P1 (see `introduction_blueprint_v2.md` §5) | Methods M3; rarely in discussion only if the paragraph explicitly re-contrasts ALIGNN with earlier distance-only baselines |
| ALIGNN | Intro P2; Methods M2 | Intro P4 (required because model name appears); never in discussion unless a new architectural claim is made |
| JARVIS / dataset | Intro P2; Methods M1 | Intro P4 (required because checkpoint provenance appears); Methods M5 (only if not already cited in adjacent M1) |
| Transfer learning in materials | Intro P3; Discussion D1 | Discussion D4 (optional); Discussion D6 (conditional, when suggesting transfer-learning extensions) |
| Domain shift / OOD in materials ML | Intro P3; Discussion D2 | Methods M10 (conditional); Discussion D3 (conditional, paired with L7 caveat); Discussion D5 (conditional); Discussion D6 (conditional) |
| Benchmark infrastructure (Matbench, Materials Project) | none by default | Intro P2 optional third sentence; Methods M1 supporting anchor only |

## Section 6 — Guardrails (expanded)

Carried forward from v1 and extended:

- Do not place zero-shot or fine-tuning result numbers into any introduction or discussion paragraph just because those paragraphs carry citations.
- Do not cite internal course scaffolding as if it were field literature.
- Do not describe the checkpoint as "oxide-pretrained." When architecture provenance is needed, use "pretrained formation-energy ALIGNN model" and pair it with the normal ALIGNN / JARVIS placeholders.
- Do not stack citations. One to two citations per claim is normal; three or more suggests the sentence is doing a mini-review and should be rewritten.
- Do not cite the same source twice within adjacent paragraphs unless the second occurrence supports a materially different claim. Continuity carries attribution across short distances.
- `NONE` means no citation. Do not treat `NONE` as "add one if the paragraph feels thin." A paragraph that feels thin without a citation usually needs a stronger claim, not a decorative anchor.
- Methods paragraphs that describe our own protocol (M4, M6, M7, M8, M9) must stay uncited. The protocol is ours.
- Discussion paragraphs that generalize beyond our results should carry anchors; discussion paragraphs that only interpret our own results need not.
- The embedding-analysis "interpretive probe, not causal proof" caveat (claim L7 in `literature_claim_map.md`) must appear somewhere in D3 or its immediate vicinity, with a citation attached to the caveat sentence itself.

## Section 7 — Working order recommendation

Use this file in the following order during drafting:

1. Before drafting methods: read §2 and the corresponding M-row for every methods paragraph being written.
2. Before drafting discussion: read §3 and the corresponding D-row, then cross-check against the L1–L7 claim catalog in `literature_claim_map.md`.
3. Before drafting the abstract: confirm §4 and do not attach placeholders.
4. Before handing the paper for review: scan §5 to confirm that no citation family is over- or under-represented, and scan §6 for guardrail violations.
