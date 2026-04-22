# Citation Needed List — v2 (Stage 5 consistency patch)

Supersedes `citation_needed_list.md` for all sections. Introduction planning has moved to `introduction_paragraph_plan_v4.md` §5–§6 and is not maintained here.

**Authority note.** This file is the practical citation helper for Methods, Discussion, and Abstract. It must not contradict `literature_claim_map_v3.md` (source-tier and claim-boundary authority) or `introduction_paragraph_plan_v4.md` (authoritative intro blueprint). If a conflict is found, the claim map and intro blueprint take precedence.

Inherits all source-tier rules from `literature_claim_map_v3.md`: scholarly anchors are citable, internal course scaffolding (brief, tutorial, blueprints, repo planning docs) is not.

---

## What changed from the prior version

| Change | Rationale |
|---|---|
| JARVIS citation hierarchy updated | M1 and M5 now reflect the three-tier hierarchy: JARVIS 2020 is the primary dataset/repository provenance anchor; JARVIS 2025 is broader ecosystem/pretrained-infrastructure context; JARVIS-Leaderboard 2024 is benchmark/leaderboard framing only. The prior version listed only 2025 and 2024. |
| §5 JARVIS summary row expanded | The single "JARVIS / dataset" summary row now distinguishes primary, secondary, and contextual uses to prevent regression to the undifferentiated hierarchy. |
| Introduction section updated | The superseded-by pointer now names `introduction_paragraph_plan_v4.md`, the current authoritative intro blueprint. |
| Authority note added | Makes the three-file hierarchy explicit so this file cannot accidentally override the claim map or intro blueprint. |
| Transfer-learning hierarchy preserved | D1 and D4 already reflected the correct Lee & Asahi (primary) / Kim et al. (secondary) / Hu et al. (contextual) ordering from the Stage 5 patch; no changes required here. |

---

## Citation policy note (unchanged)

- Use citation placeholders only at this stage.
- Prefer scholarly anchors from `paper_sources/`.
- Do not insert manuscript citations to internal scaffolding by default: `ALIGNN_Tutorial.pdf`, `RES201_Project.pdf`, `Research_Assignment_1.pdf`, `Research_Assignment_2.pdf`, the blueprints, `REPORT_PLAN.txt`, and repo planning docs are internal guidance rather than default references.
- `NONE` means "do not invent a citation here." It does not mean "add one if it feels empty."

---

## Section 1 — Introduction

> **Superseded.** See `introduction_paragraph_plan_v4.md` §5 (consolidated citation table) and §6 (local source candidates mapped to placeholders). Do not maintain introduction citation planning in this file.

---

## Section 2 — Methods

The methods section has a mix of literature-dependent and self-contained paragraphs. Most methods paragraphs are `NONE`: the protocol is ours, the constituent concepts are already cited earlier in the paper, and adding fresh citations would decorate rather than inform.

| Paragraph ID | Planned function | Citation essentiality | Placeholder set | Local source candidates | Notes |
|---|---|---|---|---|---|
| M1 | Dataset and benchmark provenance (JARVIS-DFT-3D, how it was obtained, what it contains). | ESSENTIAL | `[CITE: JARVIS dataset/repository paper]` | **Primary (dataset/repository provenance):** `Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf`. **Secondary (broader ecosystem context):** `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf`. **Contextual (benchmark infrastructure only):** `Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | **Use JARVIS 2020 as the primary anchor when the sentence concerns where the dataset and repository come from.** Use JARVIS 2025 when the sentence describes the broader pretrained-model ecosystem. Use JARVIS-Leaderboard 2024 only when the sentence explicitly concerns benchmark infrastructure or leaderboard standing. `Jain et al. - 2013 - Commentary The Materials Project...` is OPTIONAL as a broader data-ecosystem anchor only if the paragraph explicitly contextualizes JARVIS against the wider materials-database landscape. |
| M2 | Pretrained formation-energy ALIGNN checkpoint: what the model is, what it was trained on, why we use it as-is. | ESSENTIAL | `[CITE: ALIGNN foundational paper]` | `ALIGNN_Paper.pdf` | Single file. `ALIGNN_Tutorial.pdf` can guide implementation-level phrasing but must not replace the paper citation. |
| M3 | Optional historical context: ALIGNN's relationship to earlier distance-only crystal-graph models. | OPTIONAL | `[CITE: CGCNN foundational paper]` | `CGCNN_Paper.pdf` | Include only if the paragraph explicitly names CGCNN as the historical baseline. If the introduction already carried that contrast, do not repeat it in methods. |
| M4 | Subset filtering: oxide definition (O present), nitride definition (N present, O absent), oxynitride exclusion. | NONE | none | none | This is our data-preparation choice driven by the project brief. No external citation required; do not cite the brief itself. |
| M5 | Split protocol: preservation of original JARVIS train/validation/test IDs, family filtering applied within each split, fixed test set reused across runs. | CONDITIONAL | `[CITE: JARVIS dataset/repository paper]` only if the paragraph invokes the original JARVIS split provenance as a justification | **Primary:** `Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf`. **Secondary:** `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf` | **Cite JARVIS 2020 when invoking the original JARVIS split provenance.** If M1 already cited JARVIS in the immediately preceding paragraph, the citation can be omitted here and referenced by continuity. Do not cite twice in close succession. |
| M6 | Fine-tuning protocol: unfreeze last two layers, fine-tuning at N ∈ {10, 50, 100, 200, 500, 1000}, three to five seeds per N. | NONE | none | none | The protocol is ours. The broader concept of "pretrain, fine-tune, report MAE" is already cited in introduction P3 via the transfer-learning anchor and does not need repeating. |
| M7 | From-scratch baseline protocol: ALIGNN trained from random initialization at N ∈ {50, 500} for both families. | NONE | none | none | Same reasoning as M6. The baseline design is ours. |
| M8 | Fixed hyperparameters: epochs = 50, learning rate = 1e-4, batch size = 16. | NONE | none | none | These are project-brief-fixed values. Do not cite the brief. The ALIGNN paper's default hyperparameters (300 epochs, lr 1e-3, batch 64) are different and should not be invoked as a justification. |
| M9 | Evaluation metric: test MAE in eV/atom, mean ± std across seeds, canonical main-results namespace (Set 1) preserved. | NONE | none | none | MAE is a standard metric; no citation needed. The canonical-set choice (M4 in `literature_claim_map_v3.md`) is internal policy. |
| M10 | Embedding extraction and visualization: intermediate ALIGNN representations pulled for oxide and nitride structures, projected with PCA / t-SNE / UMAP for visualization, compared for family separation. | CONDITIONAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` only if the paragraph frames the embedding-space probe as a methodological choice that follows prior OOD-in-materials work | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf` | Omee et al. 2024 uses t-SNE on GNN latent spaces to interpret OOD behavior and is the most direct prior-art anchor for the methodological choice. If the paragraph simply describes our procedure without claiming methodological lineage, leave this `NONE`. The interpretive caveat (probe, not proof) belongs in discussion, not methods. |

**Methods section citation load.** Two ESSENTIAL placeholders (M1, M2), three CONDITIONAL / OPTIONAL (M3, M5, M10), five `NONE`. A well-written methods section for this paper should not carry more than five distinct citations total.

---

## Section 3 — Discussion

The discussion is where the literature does the most work after the introduction. Each paragraph below has a distinct argumentative function, and the citation load is intentionally different for each.

| Paragraph ID | Planned function | Citation essentiality | Placeholder set | Local source candidates | Notes |
|---|---|---|---|---|---|
| D1 | What pretraining provides in each family, and how the oxide vs nitride contrast fits the broader transfer-learning picture. | ESSENTIAL | `[CITE: transfer learning in materials informatics]` | **Primary:** `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`. **Secondary:** `Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf` | Lee & Asahi is the canonical anchor. Kim et al. 2024 is the strongest local "pretrain-then-fine-tune for a scarce property" precedent and fits well when discussing data-efficiency gains. Do not over-cite: one or two citations total for this paragraph. |
| D2 | Why nitride prediction remains harder after fine-tuning — the chemical-family mismatch interpretation, framed against existing OOD findings. | ESSENTIAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf`; `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | Omee et al. 2024 for the general "GNNs degrade on OOD" claim. Li et al. 2025 (Probing) when the paragraph discusses how scaling behavior itself can shift on OOD tasks. Hu et al. 2024 when the paragraph leans toward domain adaptation as a mitigation direction (which is more natural in D6 than D2). |
| D3 | What embedding analysis adds beyond the MAE plots: representation-space geometry as an interpretive probe. | CONDITIONAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf` | The citation is needed to support claim L7 from `literature_claim_map_v3.md` — that embedding-space analyses are interpretive rather than causal. Omee et al. 2024 explicitly uses t-SNE latent-space analysis to interpret OOD behavior and is the cleanest anchor for the "probe, not proof" framing. If the paragraph is purely descriptive of our own embedding result, mark `NONE` and save the citation for the interpretive caveat sentence. |
| D4 | Practical implications for small-data materials discovery: what a practitioner should take from the oxide/nitride contrast when applying pretrained checkpoints to a new chemical family. | OPTIONAL | `[CITE: transfer learning in materials informatics]` | **Primary:** `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`. **Secondary:** `Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf` | Most of this paragraph will be our recommendations and will not need external anchors. Include a citation only if the paragraph explicitly connects a recommendation to prior transfer-learning findings. Do not stack citations here. |
| D5 | Limitations: single property (formation energy), single architecture (ALIGNN), limited seeds, embedding analysis is qualitative. | CONDITIONAL | `[CITE: domain shift or OOD benchmark in materials property prediction]` only if the paragraph acknowledges that our OOD design (binary oxide vs nitride split) is less systematic than existing OOD benchmark frameworks | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf` | A limitations paragraph that acknowledges broader OOD benchmarking machinery gains credibility from pointing at it. A limitations paragraph that only lists internal caveats does not need an external citation. |
| D6 | Future work: extensions to more properties, more chemical families, domain-adaptation methods, quantitative representation metrics. | CONDITIONAL | `[CITE: transfer learning in materials informatics]` and/or `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf`; `Li et al. - 2025 - Out-of-Distribution Material Property Prediction Using Adversarial Learning.pdf`; `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf` | Hu et al. 2024 is the natural anchor when suggesting domain-adaptation methods as future work. Li et al. 2025 (Adversarial) is the right anchor when suggesting adversarial/OOD-robustness methods. Omee et al. 2024 if suggesting more systematic OOD splits. One citation per suggested future direction is enough; do not build a mini-review here. |

**Discussion section citation load.** Two ESSENTIAL placeholders (D1, D2), three to four CONDITIONAL, one OPTIONAL. A well-written discussion should carry roughly four to seven distinct citations in total. More than that usually means the paper is summarizing other work instead of interpreting its own.

---

## Section 4 — Abstract

| Paragraph ID | Planned function | Citation essentiality | Notes |
|---|---|---|---|
| A1 | Single paragraph covering problem, method, key results, interpretation, and implication. Under 250 words. Written last. | NONE | Abstracts in this paper do not carry citations by convention. If a reviewer requests one, it would be a JARVIS / ALIGNN anchor at most, but the default is zero. Do not add placeholders to abstract drafts. |

---

## Section 5 — Citation family summary (full paper, revised)

| Citation family | Primary local source | Paragraphs where it is ESSENTIAL | Paragraphs where it is CONDITIONAL or OPTIONAL |
|---|---|---|---|
| CGCNN | `CGCNN_Paper.pdf` | Intro P1 (see `introduction_paragraph_plan_v4.md` §5) | Methods M3; rarely in discussion only if the paragraph explicitly re-contrasts ALIGNN with earlier distance-only baselines |
| ALIGNN | `ALIGNN_Paper.pdf` | Intro P2; Methods M2 | Intro P4 (required because model name appears); never in discussion unless a new architectural claim is made |
| JARVIS 2020 — dataset/repository (primary) | `Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf` | Intro P2 (when anchoring dataset/repository provenance); Methods M1 | Intro P4 (required because checkpoint provenance appears); Methods M5 (only if not already cited in adjacent M1) |
| JARVIS 2025 — ecosystem/infrastructure (secondary) | `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf` | — | Intro P2 (when describing pretrained-model ecosystem); Methods M1 (supporting) |
| JARVIS-Leaderboard 2024 — benchmark/leaderboard (contextual) | `Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | — | Intro P2 optional (only if sentence explicitly concerns leaderboard/benchmark infrastructure); Methods M1 supporting anchor only |
| Transfer learning in materials — primary | `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf` | Intro P3; Discussion D1 | Discussion D4 (optional); Discussion D6 (conditional) |
| Transfer learning in materials — secondary | `Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf` | — | Discussion D1 (supporting); Discussion D4 (optional) |
| Transfer learning in materials — contextual | `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | — | Discussion D2 (domain-adaptation framing only); Discussion D6 (future-work suggestion only) |
| Domain shift / OOD in materials ML | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf` (primary); Li et al. 2025 (supporting) | Intro P3; Discussion D2 | Methods M10 (conditional); Discussion D3 (conditional); Discussion D5 (conditional); Discussion D6 (conditional) |
| Benchmark infrastructure (Matbench, Materials Project) | `Dunn et al. - 2020 - ...Matbench....pdf` | none by default | Intro P2 optional third sentence; Methods M1 supporting anchor only |

---

## Section 6 — Guardrails (expanded)

Carried forward and extended:

- Do not place zero-shot or fine-tuning result numbers into any introduction or discussion paragraph just because those paragraphs carry citations.
- Do not cite internal course scaffolding as if it were field literature.
- Do not describe the checkpoint as "oxide-pretrained." When architecture provenance is needed, use "pretrained formation-energy ALIGNN model" and pair it with the normal ALIGNN / JARVIS placeholders.
- Do not stack citations. One to two citations per claim is normal; three or more suggests the sentence is doing a mini-review and should be rewritten.
- Do not cite the same source twice within adjacent paragraphs unless the second occurrence supports a materially different claim. Continuity carries attribution across short distances.
- `NONE` means no citation. Do not treat `NONE` as "add one if the paragraph feels thin." A paragraph that feels thin without a citation usually needs a stronger claim, not a decorative anchor.
- Methods paragraphs that describe our own protocol (M4, M6, M7, M8, M9) must stay uncited. The protocol is ours.
- Discussion paragraphs that generalize beyond our results should carry anchors; discussion paragraphs that only interpret our own results need not.
- The embedding-analysis "interpretive probe, not causal proof" caveat (claim L7 in `literature_claim_map_v3.md`) must appear somewhere in D3 or its immediate vicinity, with a citation attached to the caveat sentence itself.
- **JARVIS hierarchy guardrail.** When citing JARVIS, match the citation to the sentence's content: JARVIS 2020 for dataset/repository provenance, JARVIS 2025 for ecosystem/infrastructure, JARVIS-Leaderboard 2024 for benchmark/leaderboard framing only. Do not use JARVIS 2025 or JARVIS-Leaderboard 2024 as generic substitutes for JARVIS 2020 when the sentence is about where the data comes from.
- **Transfer-learning hierarchy guardrail.** Lee & Asahi 2021 leads all transfer-learning citations. Kim et al. 2024 is secondary for property-specific or scarce-data framing. Hu et al. 2024 is contextual for domain-adaptation framing; do not use it as the default first citation in a generic transfer-learning sentence.

---

## Section 7 — Working order recommendation

Use this file in the following order during drafting:

1. Before drafting methods: read §2 and the corresponding M-row for every methods paragraph being written.
2. Before drafting discussion: read §3 and the corresponding D-row, then cross-check against the L1–L7 claim catalog in `literature_claim_map_v3.md`.
3. Before drafting the abstract: confirm §4 and do not attach placeholders.
4. Before handing the paper for review: scan §5 to confirm that no citation family is over- or under-represented, and scan §6 for guardrail violations.
