# Introductions, Titles, Abstracts, and Keywords — Three Streams

**Stage.** Drafting pass for the Oxide standalone report, the Nitride standalone report, and the Combined paper.

**Source authority.** Built from `01_blueprints/oxide_report_blueprint_v3.md`, `01_blueprints/nitride_report_blueprint_v3.md`, `01_blueprints/combined_paper_blueprint_v3.md`, `01_blueprints/shared_vs_unique_content_map_v3.md`, `03_section_inputs/literature_claim_map_v3.md`, `03_section_inputs/introduction_paragraph_plan_v4.md`, and the reviewed Methods / Results / Discussion drafts `04_drafts/01_methods_prose_edited.md` through `04_drafts/07_combined_discussion_conclusion_edited.md`.

**Drafting rules observed throughout.**

- Introductions are result-free prose: no MAE values, no learning-curve shapes, no project numbers, no previewed conclusions. Only background, motivation, project design, objective, and paper map.
- Citation placeholders (`[CITE: ...]`) appear only in Introductions. Abstracts carry no citations.
- Paragraph alignment follows `introduction_paragraph_plan_v4.md`: P1–P3 stay aligned across streams; divergence is earned at P4/P5.
- The pretrained checkpoint is never described as "oxide-pretrained"; the manuscript-facing phrasing is "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model". "Oxide-reference region" is reserved for embedding-distance contexts.
- Oxide P4/P5 emphasis: saturation question; RQ1–RQ3 primary, RQ4 secondary.
- Nitride P4/P5 emphasis: recovery question; RQ1–RQ4 with RQ4 co-primary.
- Combined P4/P5 emphasis: parallel phrasing, four RQs with roughly equal weight.
- No references are invented. Every citation placeholder corresponds to a local source already catalogued in `paper_sources/`.

---

## 1. Oxide Standalone Report

### 1.1 Title candidates

1. **Pretrained ALIGNN on Oxide Formation Energies: An In-Distribution Control for Data-Efficient Transfer Learning**
2. **Zero-Shot as the Ceiling: Pretrained ALIGNN, Fine-Tuning, and From-Scratch Baselines on JARVIS Oxide Formation-Energy Prediction**
3. **When Pretraining Is Already Enough: A Data-Efficiency Control on Oxide Formation Energies with Pretrained ALIGNN**
4. **The In-Distribution Control Arm: Pretraining Value and Fine-Tuning Behaviour in Chemistry-Aligned Formation-Energy Prediction**
5. **Data-Efficiency Saturation of Pretrained ALIGNN on an In-Distribution Oxide Formation-Energy Target**

Preferred lead: **Title 1** — it cleanly signals the scope (oxide), the model family (ALIGNN), the property (formation energy), the methodological role (in-distribution control), and the measurement surface (data-efficient transfer learning) without previewing any result. Titles 2 and 3 are stronger alternatives if a more pointed, thesis-bearing title is preferred; Title 2 leans on the zero-shot-is-the-ceiling finding, Title 3 leans on the pretraining-is-the-lever finding. Titles 4 and 5 are conservative reserve options.

### 1.2 Abstract candidates

**Abstract A (preferred, ~235 words).**

Pretrained crystal-graph neural networks have become a routine starting point for materials-property prediction in low-data regimes, but the data-efficiency value of such checkpoints depends on how related the target chemistry is to the distribution that supported pretraining. This report evaluates a single pretrained formation-energy ALIGNN model on an in-distribution oxide control task, providing a reference condition against which the companion chemistry-shifted evaluation can be read. Using the JARVIS `dft_3d` benchmark splits, we compare zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes from ten to one thousand structures at five random seeds per size, and matched from-scratch baselines at the two sizes where both protocols are available. We further extract frozen `last_alignn_pool` embeddings to characterize how oxides are organized in the pretrained representation. Under the canonical Hyperparameter Set 1 protocol, the pretrained zero-shot checkpoint is already the strongest observed oxide configuration, canonical fine-tuning converges monotonically toward but does not cross that benchmark across the tested range, and pretrained initialization outperforms random initialization by a wide margin at both scratch-tested sizes. In the frozen representation, oxides occupy a cohesive, locally pure region. Scoped to the tested regime, these findings identify the choice of initialization — not the amount of labelled oxide data — as the dominant data-efficiency lever, position pretrained zero-shot as a defensible first-pass estimator on chemistry-aligned formation-energy targets, and fix the in-distribution reference condition needed to interpret the chemistry-shifted nitride arm as domain shift.

**Abstract B (sharper, ~220 words).**

A pretrained crystal-graph neural network used for materials-property prediction is only as data-efficient as the match between its pretraining distribution and the downstream target. We evaluate a single pretrained formation-energy ALIGNN model on a chemistry-aligned oxide target drawn from the JARVIS `dft_3d` benchmark, measured across three regimes: zero-shot evaluation of the pretrained checkpoint, fine-tuning at six labelled-data sizes from ten to one thousand structures with five random seeds per size, and matched from-scratch baselines at two of those sizes. Frozen `last_alignn_pool` embeddings are extracted to describe how oxides sit in the pretrained representation. Under the canonical Hyperparameter Set 1 protocol, the pretrained zero-shot checkpoint is the strongest observed oxide configuration in this study; canonical fine-tuning approaches that benchmark from above but does not cross it across the tested range; and pretrained initialization beats random initialization by a wide margin at both scratch-tested sizes, while the fine-tuning loop itself contributes only modestly on top of the pretrained representation. Oxides form a cohesive, locally pure region in the frozen representation. Scoped to formation energy per atom on JARVIS `dft_3d` oxide splits, the choice of pretrained initialization is the dominant data-efficiency lever, fine-tuning's operational role is reproducibility rather than headline accuracy, and pretrained zero-shot is a defensible first-pass estimator on chemistry-aligned targets — fixing the in-distribution reference condition for subsequent domain-shift analysis.

### 1.3 Keywords

`crystal graph neural networks`, `ALIGNN`, `pretrained models`, `transfer learning`, `fine-tuning`, `data efficiency`, `formation energy`, `oxides`, `JARVIS DFT-3D`, `in-distribution evaluation`, `from-scratch baseline`, `frozen embeddings`

### 1.4 Introduction draft

**Target budget.** ~430–520 words (compressed P1–P3, oxide-emphasized P4/P5).

#### P1 — Field opener

Crystal-property prediction from atomic structure is a central workload in materials informatics. Structure-based crystal graph neural networks perform this task by learning directly from atomic coordinates, bonding topology, and element identities rather than relying solely on handcrafted descriptors, and they have become a routine starting point for high-throughput and low-data property modelling alike [CITE: crystal graph baseline for materials property prediction]. The early canonical exemplar of this family, CGCNN, established that a graph representation of the crystal structure can be mapped to scalar properties with competitive accuracy without hand-engineered features [CITE: CGCNN foundational paper].

#### P2 — Architecture and ecosystem bridge

ALIGNN sharpens this family by alternating message passing on the bond graph and its line graph, making bond-angle information explicit in the learned representation and improving accuracy on structure-dependent targets [CITE: ALIGNN foundational paper]. The specific ALIGNN checkpoint and training corpus used in this work — a formation-energy regressor trained on the JARVIS DFT-3D database — are distributed through the JARVIS infrastructure, which provides the dataset, the pretrained-model checkpoints, and the benchmark splits used throughout this report [CITE: JARVIS dataset/repository paper].

#### P3 — Literature gap (compressed)

Transfer learning from pretrained crystal-graph models has been shown to reduce labelled-data requirements for downstream property tasks [CITE: transfer learning in materials informatics]. Whether and how much of this benefit survives on a new target, however, depends on how related the target is to the distribution that supported pretraining; when the target chemistry or structure lies outside that distribution, both accuracy and apparent scaling behaviour can degrade, and recent out-of-distribution evaluations make this failure mode concrete [CITE: domain shift or OOD benchmark in materials property prediction]. What remains harder to read off the existing literature is how a single, widely used pretrained checkpoint behaves across a clean chemical-family split when evaluated as a data-efficiency curve — zero-shot, fine-tuning across labelled-data sizes, and matched from-scratch baselines — rather than as a single test-MAE number.

#### P4 — Project design (oxide-leaning)

This report addresses the in-distribution half of that evaluation. Using the same pretrained formation-energy ALIGNN model [CITE: ALIGNN foundational paper] on the JARVIS `dft_3d` benchmark splits [CITE: JARVIS dataset/repository paper], we study a chemistry-aligned oxide target — the regime in which a broadly JARVIS-trained representation is most likely to operate as transfer learning predicts. We evaluate the checkpoint zero-shot, fine-tune it across a range of labelled-data sizes at multiple random seeds, and compare fine-tuned runs against matched from-scratch baselines at the sample sizes where both protocols are available. To describe how oxides are organized in the pretrained representation before any fine-tuning, we also extract frozen intermediate embeddings from the same checkpoint. The companion nitride report treats the chemistry-shifted case on the same infrastructure; the two together form the control-versus-shift design for the combined manuscript.

#### P5 — Objective, research questions, paper map

The oxide report asks three linked questions scoped to the in-distribution control task: how strong the pretrained zero-shot checkpoint already is on a chemistry-aligned oxide target; how the fine-tuning response scales with labelled-data size across the tested range; and what pretraining contributes at the sample sizes where matched from-scratch baselines are available. A fourth, subsidiary question — whether the pretrained representation organizes oxides into a coherent region in embedding space — is addressed briefly as a bridge to the companion work. Section 2 describes the dataset, splits, protocols, and hyperparameter settings. Section 3 reports the zero-shot, fine-tuning, and from-scratch results, together with a short embedding bridge. Sections 4 and 5 discuss the control-arm interpretation and conclude with the reference condition carried forward to the domain-shift arm.

---

## 2. Nitride Standalone Report

### 2.1 Title candidates

1. **When Transfer Stalls: A Chemical-Family Domain-Shift Evaluation of Pretrained ALIGNN on Nitride Formation Energies**
2. **The Domain-Shift Penalty of Pretrained ALIGNN on Nitride Formation-Energy Prediction: Behavioural and Representational Evidence**
3. **Inert Fine-Tuning and Embedding Geometry: Pretrained ALIGNN on a Chemistry-Distant Nitride Target**
4. **Fine-Tuning Cannot Close a Chemistry-Family Gap: Pretrained ALIGNN on Nitride Formation-Energy Prediction**
5. **Out-of-Distribution Transfer in Crystal-Graph Models: Data-Efficiency and Representation Geometry on JARVIS Nitrides**

Preferred lead: **Title 2** — it names the mechanism under test (domain shift), the measurement surfaces (behavioural and representational), the model family (ALIGNN), and the target (nitride formation energies) without previewing a specific number. Title 1 is a stronger option if a more rhetorical opening is preferred. Titles 3–5 are reserve options.

### 2.2 Abstract candidates

**Abstract A (preferred, ~240 words).**

Pretrained crystal-graph neural networks are widely used to reduce labelled-data requirements in materials-property prediction, but their benefit depends on how closely the target chemistry matches the regime that supported pretraining. We evaluate a single pretrained formation-energy ALIGNN model on a chemistry-distant nitride target drawn from the JARVIS `dft_3d` benchmark, matched to a companion in-distribution oxide control on the same pipeline. Three measurement surfaces are reported: zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes from ten to one thousand structures with five random seeds per size, and matched from-scratch baselines at two of those sizes. We then probe the frozen 256-dimensional `last_alignn_pool` representation for family structure and for a within-family correlate between zero-shot error and distance from an oxide-reference region. Under the canonical Hyperparameter Set 1 protocol, nitride zero-shot error is approximately twice the oxide comparator; fine-tuning at labelled-data sizes of two hundred or fewer is operationally inert — the selected checkpoint is still the pretrained zero-shot state at every seed — and meaningful adaptation begins only at five hundred and one thousand labelled structures, where the best adapted configuration still sits above the nitride zero-shot baseline. Pretrained initialization nonetheless outperforms random initialization by a wide margin at both scratch-tested sizes. In the frozen representation, family labels are near-perfectly recoverable, and nitride prediction error co-varies with distance from the oxide-reference region (Spearman ρ ≈ 0.34, FDR-controlled). Results support a domain-shift reading with a consistent geometric correlate, not a causal mechanism proof.

**Abstract B (sharper, ~225 words).**

Transfer learning with pretrained crystal-graph neural networks is routinely assumed to reduce labelled-data requirements for downstream property prediction, but the benefit is conditional on source–target relatedness, and its behaviour on chemistry-distant targets is less well characterized. We evaluate a single pretrained formation-energy ALIGNN model on a chemistry-distant nitride target from the JARVIS `dft_3d` benchmark, across zero-shot evaluation, fine-tuning at six labelled-data sizes with five random seeds per size, and matched from-scratch baselines at two of those sizes. We additionally interrogate the frozen 256-dimensional `last_alignn_pool` representation for family structure and for a within-family correlate between zero-shot error and distance from an oxide-reference region. Under the canonical Hyperparameter Set 1 protocol, the pretrained checkpoint incurs an approximately two-fold zero-shot penalty on nitrides relative to the oxide control; the canonical fine-tuning loop does not leave the pretrained initialization at labelled-data sizes up to two hundred structures, and the meaningful adaptation regime at five hundred and one thousand structures still does not push below nitride zero-shot. The two-point pretrained-versus-scratch comparison remains large. Frozen-embedding analysis shows near-perfect family recoverability and a moderate but statistically robust association between nitride zero-shot error and distance from the oxide-reference region. The evidence supports a domain-shift reading with a consistent geometric correlate, scoped to the tested protocol and data range, not a causal mechanism proof.

### 2.3 Keywords

`crystal graph neural networks`, `ALIGNN`, `transfer learning`, `domain shift`, `out-of-distribution generalization`, `fine-tuning`, `formation energy`, `nitrides`, `JARVIS DFT-3D`, `frozen embeddings`, `representation geometry`, `data efficiency`

### 2.4 Introduction draft

**Target budget.** ~470–560 words (compressed P1–P3, nitride-emphasized P4/P5 with RQ4 co-primary).

#### P1 — Field opener

Crystal-property prediction from atomic structure is a central workload in materials informatics. Structure-based crystal graph neural networks perform this task by learning directly from atomic coordinates, bonding topology, and element identities rather than relying solely on handcrafted descriptors, and they have become a routine starting point for high-throughput and low-data property modelling alike [CITE: crystal graph baseline for materials property prediction]. CGCNN is the canonical early exemplar of this family and established that a crystal graph can be mapped directly to scalar properties without hand-engineered features [CITE: CGCNN foundational paper].

#### P2 — Architecture and ecosystem bridge

ALIGNN sharpens this family by alternating message passing on the bond graph and its line graph, making bond-angle information explicit in the learned representation and improving accuracy on structure-dependent targets [CITE: ALIGNN foundational paper]. The specific ALIGNN checkpoint and training corpus used in this work — a formation-energy regressor trained on the JARVIS DFT-3D database — are distributed through the JARVIS infrastructure, which provides the dataset, the pretrained-model checkpoints, and the benchmark splits used throughout this report [CITE: JARVIS dataset/repository paper].

#### P3 — Literature gap

Transfer learning from pretrained crystal-graph models has been shown to reduce labelled-data requirements for downstream property tasks, with the largest per-sample benefit typically observed in the low-data regime [CITE: transfer learning in materials informatics]. Whether and how much of this benefit survives on a new target, however, depends on how related the target is to the distribution that supported pretraining. When the target chemistry or structure lies outside that distribution, both accuracy and apparent scaling behaviour can degrade, and a growing body of out-of-distribution evaluations in materials ML makes this failure mode concrete [CITE: domain shift or OOD benchmark in materials property prediction]. What remains harder to read off the existing literature is how a single, widely used pretrained checkpoint behaves across a clean chemical-family split when evaluated as a data-efficiency curve — zero-shot, fine-tuning across labelled-data sizes, and matched from-scratch baselines — together with a representation-space view of the pretrained model, rather than as a single test-MAE number.

#### P4 — Project design (nitride-leaning)

This report addresses the out-of-distribution half of that evaluation. Using the same pretrained formation-energy ALIGNN model [CITE: ALIGNN foundational paper] on the JARVIS `dft_3d` benchmark splits [CITE: JARVIS dataset/repository paper], we study a chemistry-distant nitride target: the regime in which source–target mismatch is most likely to surface and most likely to be misattributed to small-data noise if it is read in isolation. We evaluate the checkpoint zero-shot, fine-tune it across a range of labelled-data sizes at multiple random seeds, and compare fine-tuned runs against matched from-scratch baselines at the sample sizes where both protocols are available. Because the behavioural evidence alone cannot distinguish a representational mismatch from an optimization artefact, we additionally extract frozen intermediate embeddings from the same checkpoint and ask whether the pretrained representation already carries a family-level signature — and whether within nitrides, prediction difficulty co-varies with distance from the region occupied by the chemistry-aligned oxide comparator. The companion oxide report establishes the in-distribution control condition against which this report's evidence is read.

#### P5 — Objective, research questions, paper map

The nitride report asks four linked questions scoped to the out-of-distribution test task: the size of the zero-shot penalty relative to a chemistry-aligned comparator; the rate and onset of adaptation with labelled-data scale; what pretraining still contributes over matched from-scratch training in the presence of chemical mismatch; and whether the pretrained representation shows geometric structure consistent with the behavioural penalty, treated as an interpretive probe rather than a causal proof. The first three questions form the behavioural spine of the report; the fourth is co-primary rather than subsidiary, because the representation-space view is what licenses the domain-shift reading over alternatives such as small-data noise or optimizer pathology. Section 2 describes the dataset, splits, protocols, and hyperparameter settings. Section 3 reports the behavioural evidence — zero-shot, fine-tuning across sizes, and from-scratch comparisons — and the representational evidence extracted from the frozen pretrained model. Sections 4 and 5 discuss the domain-shift interpretation and its limitations, and conclude with the out-of-distribution takeaways that feed the combined manuscript.

---

## 3. Combined Paper

### 3.1 Title candidates

1. **Control Versus Shift: How Chemical-Family Domain Shift Modulates the Data-Efficiency of Pretrained ALIGNN**
2. **A Chemical-Family Domain-Shift Evaluation of Pretrained ALIGNN: Zero-Shot, Fine-Tuning, From-Scratch, and Embedding Geometry on Oxides and Nitrides**
3. **Data-Efficiency and Representation Geometry in Pretrained ALIGNN: An Oxide-Versus-Nitride Domain-Shift Study**
4. **When Pretrained Materials Models Carry Across Chemistries: An Oxide–Nitride Data-Efficiency and Embedding Study of ALIGNN**
5. **The Chemistry-Family Gap in Transfer Learning for Crystal-Graph Models: Pretrained ALIGNN on JARVIS Oxides and Nitrides**

Preferred lead: **Title 1** — it frames the design (control versus shift), the mechanism under test (chemical-family domain shift), the measurement surface (data-efficiency), and the model (pretrained ALIGNN) in a single line, without previewing results. Title 2 is the more descriptive alternative if the conference or course convention favours exhaustive titles. Titles 3–5 are reserve options.

### 3.2 Abstract candidates

**Abstract A (preferred, ~248 words).**

Transfer learning from pretrained crystal-graph neural networks is a standard strategy for reducing labelled-data requirements in materials-property prediction, but its benefit is conditional on source–target relatedness, and the behaviour of a single widely used checkpoint under a clean chemistry-family shift is not yet a standard reference point. We evaluate the pretrained formation-energy ALIGNN model distributed through the JARVIS infrastructure on two target families drawn from the JARVIS `dft_3d` benchmark: an in-distribution oxide control arm and an out-of-distribution nitride test arm. Both arms share an identical protocol comprising zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes with five random seeds per size, and matched from-scratch baselines at two of those sizes. We additionally extract frozen 256-dimensional `last_alignn_pool` embeddings and analyse family structure and a within-family distance–error correlate. Under the canonical Hyperparameter Set 1 protocol, the pretrained checkpoint reproduces the standard chemistry-aligned picture on oxides — strong zero-shot, smooth adaptation, a large pretrained-versus-scratch advantage — and departs from it on nitrides: an approximately two-fold zero-shot penalty, a fine-tuning loop that does not leave the pretrained initialization at labelled-data sizes up to two hundred structures, and a residual gap above nitride zero-shot that persists at five hundred and one thousand structures. In the frozen representation, family labels are near-perfectly recoverable and nitride prediction error co-varies with distance from the oxide-reference region. Scoped to the tested regime, the evidence supports a quantifiable, geometrically legible domain-shift account of when pretrained materials models carry across chemistries and when they do not.

**Abstract B (sharper, ~235 words).**

The data-efficiency value of pretrained crystal-graph neural networks in materials-property prediction depends on how closely the downstream target matches the regime that supported pretraining, yet a clean evaluation design that tests a single widely used checkpoint against a chemistry-family shift as a data-efficiency curve, not as a single test-MAE number, is uncommon. We evaluate a pretrained formation-energy ALIGNN model on two JARVIS `dft_3d` family splits — an in-distribution oxide control and an out-of-distribution nitride test — under an identical protocol of zero-shot evaluation, fine-tuning at six labelled-data sizes with five random seeds per size, and matched from-scratch baselines at two sizes. We additionally analyse the frozen 256-dimensional `last_alignn_pool` representation for family structure and for a within-family distance–error correlate on nitrides. Under Hyperparameter Set 1, the oxide arm matches the chemistry-aligned transfer-learning picture: the pretrained zero-shot checkpoint is already strong, fine-tuning converges toward that benchmark, and pretrained initialization dominates random initialization at both scratch-tested sizes. The nitride arm departs from this picture: the zero-shot penalty is approximately two-fold relative to oxides, the canonical fine-tuning loop is operationally inert at every labelled-data size up to two hundred, and the adapted regime at five hundred and one thousand still sits above nitride zero-shot. Frozen-embedding analysis shows near-perfect family recoverability and a moderate, statistically robust distance–error association. The evidence supports a bounded, geometrically legible domain-shift reading of when pretrained materials models carry across chemistries, scoped to the tested protocol and data range.

### 3.3 Keywords

`crystal graph neural networks`, `ALIGNN`, `transfer learning`, `fine-tuning`, `domain shift`, `out-of-distribution generalization`, `data efficiency`, `formation energy`, `oxides`, `nitrides`, `JARVIS DFT-3D`, `frozen embeddings`, `representation geometry`, `materials informatics`

### 3.4 Introduction draft

**Target budget.** ~560–660 words (full five-paragraph structure; four RQs at roughly equal weight; embedding analysis named as a distinct section).

#### P1 — Field opener

Crystal-property prediction from atomic structure is a central workload in materials informatics. Structure-based crystal graph neural networks perform this task by learning directly from atomic coordinates, bonding topology, and element identities rather than relying solely on handcrafted descriptors, and they have become a routine starting point for both high-throughput screening and low-data property modelling [CITE: crystal graph baseline for materials property prediction]. CGCNN is the canonical early exemplar of the family and established that a crystal graph can be mapped directly to scalar properties without hand-engineered features [CITE: CGCNN foundational paper].

#### P2 — Architecture and ecosystem bridge

ALIGNN extends crystal-graph message passing by alternating updates on the bond graph and its line graph, making bond-angle information explicit in the learned representation and improving accuracy on structure-dependent targets including formation energy [CITE: ALIGNN foundational paper]. The specific ALIGNN checkpoint used throughout this paper — a formation-energy regressor trained on the JARVIS DFT-3D database — is distributed through the JARVIS infrastructure, which supplies the dataset, the pretrained-model checkpoints, and the benchmark splits used here [CITE: JARVIS dataset/repository paper].

#### P3 — Literature gap

Transfer learning from pretrained crystal-graph models has been shown to reduce labelled-data requirements for downstream property tasks, with the largest per-sample benefit typically observed in the low-data regime [CITE: transfer learning in materials informatics]. The magnitude of that benefit, however, depends on how closely the target distribution matches the distribution that supported pretraining. When the target chemistry or structure lies outside the regime that supported pretraining, both accuracy and apparent scaling behaviour can degrade, and a growing body of out-of-distribution evaluations in materials ML makes this failure mode concrete on family-, composition-, and structure-held-out splits [CITE: domain shift or OOD benchmark in materials property prediction]. What remains less standardized is a clean evaluation design built around a single, widely used pretrained checkpoint, a chemistry-family split, and a data-efficiency comparison evaluated together as a unit — zero-shot evaluation, fine-tuning across labelled-data sizes, matched from-scratch baselines, and a view of the pretrained representation — rather than any one of these surfaces in isolation. The existing literature motivates each surface but does not combine them into an isolated reference experiment.

#### P4 — Project design

To isolate chemical-family shift as the moving variable, we contrast an in-distribution oxide arm with an out-of-distribution nitride arm on the same pretrained formation-energy ALIGNN model [CITE: ALIGNN foundational paper] and the same JARVIS `dft_3d` benchmark splits [CITE: JARVIS dataset/repository paper]. The two arms share an identical experimental protocol: zero-shot evaluation of the pretrained checkpoint, fine-tuning across a range of labelled-data sizes at multiple random seeds per size, and matched from-scratch baselines at the two sizes where both protocols are available. To probe why the two arms may behave differently, we extract and analyse intermediate representations from the frozen pretrained model, comparing their geometry across families and asking whether within-family distance from an oxide-reference region co-varies with nitride prediction difficulty. The embedding analysis is framed as an interpretive probe consistent with or inconsistent with the behavioural picture, not as a causal account of it.

#### P5 — Objective, research questions, paper map

The paper asks how chemical-family domain shift modulates the data-efficiency benefit of a single pretrained ALIGNN checkpoint, and whether the behavioural gap between the two families is consistent with representation-space geometry. Four linked questions structure the evaluation. RQ1 asks how the pretrained checkpoint behaves zero-shot on the oxide control task versus the nitride shifted task. RQ2 asks how fine-tuning response changes with labelled-data scale across the two arms. RQ3 asks what pretraining contributes over matched from-scratch training at the sample sizes where both protocols are available. RQ4 asks whether pretrained embedding geometry is consistent with the prediction-side difficulty gap. The four questions are treated at roughly equal weight: RQ1–RQ3 form the behavioural spine, and RQ4 is the mechanism-oriented representation-space follow-up. Section II describes the dataset, splits, protocols, and hyperparameter settings. Section III reports the oxide control results; Section IV reports the nitride results; Section V directly compares the two arms; and Section VI reports the embedding analysis as a distinct mechanism-oriented section. Section VII discusses the combined evidence and its limitations, and Section VIII concludes.

---

## 4. Alignment and anti-pattern checks

These checks were run against the three drafts above before saving.

- **Result-free introductions.** No paragraph in any of the three introduction drafts contains MAE values, learning-curve shapes, mean-best-epoch values, Spearman coefficients, silhouette metrics, or transfer-benefit numbers. All numerical evidence remains deferred to Results and Discussion.
- **Checkpoint phrasing.** All three introductions refer to the checkpoint as "pretrained formation-energy ALIGNN model" or "pretrained ALIGNN model". "Oxide-pretrained" is never used. "Oxide-reference region" appears only in the embedding-distance sentences of the nitride and combined streams.
- **Citation hierarchy.** `[CITE: transfer learning in materials informatics]` is led by Lee & Asahi 2021 by policy from the literature claim map; Hu et al. is not forced into a default lead position. JARVIS 2020 is the primary anchor whenever dataset or repository provenance is named. The ALIGNN tutorial is never cited as an architecture anchor.
- **Gap framing.** The gap sentence in P3 (combined) and its compressed counterparts (oxide, nitride) frame the gap as evaluation-design absence, not as a literature-wide absence of domain-shift awareness. No `[CITE: ...]` placeholder is attached to any of those sentences, consistent with the instruction to avoid misattributing the framing to prior work.
- **Paragraph alignment.** P1 and P2 are textually close across the three streams by design; the divergence is concentrated in P3 (compressed in standalone reports, full length in combined), P4 (oxide-leaning / nitride-leaning / parallel), and P5 (three RQs / four RQs with RQ4 co-primary / four RQs at equal weight, plus corresponding paper maps).
- **No invented references.** Every citation placeholder corresponds to a theme already present in `paper_sources/` per the literature claim map, and no placeholder is attached to sentences flagged as project framing.
- **Abstract citation discipline.** No abstract contains any citation, URL, or placeholder. Every abstract stays at or below 250 words; the preferred candidates sit at ~235 (oxide), ~240 (nitride), and ~248 (combined).
- **Keyword discipline.** Each keyword list names the model family, the method family, the specific target chemistry or chemistries, the benchmark, and the representational view, without repeating full paper titles or phrasing that would double as headings.

---

## 5. What this file does NOT do

For clarity against scope creep:

- It does not introduce new canonical numbers or adjust any number already present in the reviewed Methods, Results, or Discussion drafts.
- It does not change the paragraph plan or the literature claim map.
- It does not decide, for the combined paper, whether to keep or drop the optional Matbench sentence in P2; the drafts above omit that sentence, consistent with the introduction blueprint's default.
- It does not adjudicate between the two alternate abstracts or between the five title candidates per stream; both abstracts are finished drafts, and the preferred lead title is marked but not forced.

End of document.
