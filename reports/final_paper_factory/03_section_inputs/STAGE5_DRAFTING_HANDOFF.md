# Stage 5 Drafting Handoff

This file is the workflow-control layer for all RES201 combined-paper drafting phases. It does not change scientific content. It exists so every drafting agent — human or AI — loads the same authority files and follows the same hard rules.

---

## Section A — Active Authority Files

The following three files are the exclusive Stage 5 drafting authority. Read them before writing anything.

| Role | File |
|---|---|
| Source-tier and claim-boundary authority | `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md` |
| Authoritative introduction blueprint | `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v4.md` |
| Practical citation helper — Methods / Discussion / Abstract | `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md` |

**Precedence.** If anything in `citation_needed_list_v2.md` appears to conflict with the claim map or the intro blueprint, the claim map and intro blueprint win. The citation helper must not override the first two.

**Superseded files.** Older variants (`literature_claim_map.md`, `literature_claim_map_v2.md`, `introduction_paragraph_plan.md`, `introduction_paragraph_plan_v2.md`, `introduction_paragraph_plan_v3.md`, `citation_needed_list.md`) may still exist in the repository. Do not use them to guide active drafting.

---

## Section B — Non-Negotiable Drafting Rules

These apply in every drafting phase. None may be relaxed without explicit advisor sign-off.

1. **Introduction stays result-free.** No MAE values, no learning-curve shapes, no "we find that," no quantitative trends. The introduction ends with the question, not the answer.

2. **The literature gap must remain narrow.** The gap is a gap in *evaluation design* — a missing clean reference experiment built around a single pretrained checkpoint, a chemistry-family split, and a data-efficiency comparison. It is not a claim that OOD or transfer learning in materials is unstudied.

3. **Do not write that materials-ML has not studied domain shift.** That is false, contradicts the papers the introduction cites, and will invite rejection. The preferred framing: "What remains less standardized is a clean evaluation design built around a single pretrained checkpoint, a chemistry-family shift, and a data-efficiency comparison."

4. **Do not describe the checkpoint as oxide-pretrained.** The pretrained formation-energy ALIGNN checkpoint is trained on JARVIS-DFT-3D, which is chemistry-diverse. Nothing in the paper should imply otherwise. Required phrasing: "pretrained formation-energy ALIGNN model."

5. **Embedding analysis is an interpretive probe, not causal proof.** Permitted verbs: "is consistent with," "supports the interpretation that," "lets us ask whether." Forbidden verbs when describing embeddings in the paper: "explains," "proves," "causes."

6. **Use only the active Stage 5 files during drafting.** The files listed in Section A are the source of truth. Do not infer citation or framing rules from prior-version files, the project brief, the tutorial, or blueprint planning documents.

7. **Do not let superseded Stage 5 files guide current writing.** If a superseded file is encountered during drafting, close it and open the active version.

---

## Section C — Citation Hierarchy Rules

Follow these hierarchies exactly. Do not substitute a nearby related paper for the designated anchor.

### JARVIS hierarchy

| Role | Paper |
|---|---|
| **Primary — provenance / dataset / repository anchor** | JARVIS 2020: Choudhary et al. "The joint automated repository for various integrated simulations (JARVIS) for data-driven materials design," *npj Computational Materials* 6, 173. Local file: `Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf` |
| **Secondary — broader ecosystem / pretrained-infrastructure context** | JARVIS 2025: `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf` |
| **Contextual — benchmark / leaderboard framing only** | JARVIS-Leaderboard 2024: `Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` |

Use JARVIS 2020 when a sentence anchors *where the dataset and repository come from*. Use JARVIS 2025 when a sentence describes the *broader pretrained-model ecosystem*. Use JARVIS-Leaderboard 2024 only when the sentence explicitly concerns *benchmark standing or leaderboard infrastructure*.

### Transfer-learning hierarchy

| Role | Paper |
|---|---|
| **Primary — canonical transfer-learning anchor** | Lee & Asahi 2021: `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf` |
| **Secondary — scarce-data / property-specific transfer** | Kim et al. 2024: `Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf` |
| **Contextual — domain-adaptation / shifted-target framing only** | Hu et al. 2024: `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` |

Lee & Asahi 2021 leads all generic transfer-learning sentences. Kim et al. 2024 is added when the sentence is specifically about property-specific or low-data transfer. Hu et al. 2024 is contextual support for domain-adaptation framing — it is not the default first citation.

**Cross-hierarchy warning.** A sentence must use the citation that matches its content. Do not swap in a nearby related paper just because it is familiar or was most recently read.

---

## Section D — Sentence-Type Discipline

Before writing any sentence, classify it as exactly one of:

- **Literature claim** — a claim backed by scholarship, which requires a citation placeholder.
- **Project design** — a statement about what this study did and why. Cites scholarship only when naming a model, dataset, or ecosystem.
- **Our question** — one of RQ1–RQ4. Carries no citation.
- **Experimental finding** — belongs in Results only; never in Introduction.
- **Interpretation** — belongs in Discussion; must be hedged appropriately.

**Rule.** A project-design sentence must not borrow authority by attaching an irrelevant literature citation. Adding a placeholder does not move a sentence from the project-design column into the literature column. The category is determined by the content of the claim, not the presence of a citation.

---

## Section E — Future-Phase Checklist

Run this checklist before submitting any drafted section for review.

- [ ] Am I using only the three active Stage 5 files (`literature_claim_map_v3.md`, `introduction_paragraph_plan_v4.md`, `citation_needed_list_v2.md`)?
- [ ] Does each citation match the specific content of the sentence it anchors?
- [ ] Is the introduction still result-free — no MAE values, no trends, no "we find that"?
- [ ] Does the gap statement remain narrow — framed as an evaluation-design gap, not as "nobody has studied OOD in materials ML"?
- [ ] Is Lee & Asahi 2021 still the lead citation wherever a generic transfer-learning sentence appears?
- [ ] Is JARVIS 2020 used for provenance statements — sentences that anchor where the dataset and repository come from?
- [ ] Are all embedding-analysis sentences framed as interpretive probes with no causal claims?

---

## Section F — Reusable Agent Preamble

**Paste this at the top of future drafting prompts.**

---

```
STAGE 5 DRAFTING AUTHORITY — READ BEFORE WRITING

Active authority files (read these first; do not use superseded versions):
  - literature_claim_map_v3.md      → source-tier and claim-boundary authority
  - introduction_paragraph_plan_v4.md → authoritative introduction blueprint
  - citation_needed_list_v2.md      → Methods / Discussion / Abstract citation helper

Hard rules:
1. Introduction is result-free. No MAE, no trends, no "we find that."
2. The gap is an evaluation-design gap, not a claim that domain shift in materials is unstudied.
3. Do not write that materials-ML literature has not examined domain shift.
4. Never call the checkpoint "oxide-pretrained." Use "pretrained formation-energy ALIGNN model."
5. Embedding analysis is a probe, not proof. Forbidden: "explains," "proves," "causes."

Citation hierarchy — JARVIS:
  - JARVIS 2020  → dataset / repository provenance sentences (PRIMARY)
  - JARVIS 2025  → broader ecosystem / pretrained-infrastructure sentences (SECONDARY)
  - JARVIS-Leaderboard 2024 → benchmark / leaderboard sentences only (CONTEXTUAL)

Citation hierarchy — transfer learning:
  - Lee & Asahi 2021 → lead citation for generic transfer-learning sentences (PRIMARY)
  - Kim et al. 2024  → secondary for scarce-data / property-specific transfer (SECONDARY)
  - Hu et al. 2024   → contextual for domain-adaptation framing only (CONTEXTUAL)

Match the citation to the sentence content. Do not swap in a related paper just because it is nearby.
```

---
