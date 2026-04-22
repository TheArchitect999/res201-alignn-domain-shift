# Introduction Blueprint v4

Supersedes all prior introduction blueprints (`introduction_paragraph_plan.md` v1, v2, v3). Inherits all source-tier rules from `literature_claim_map_v3.md`.

This is still a **blueprint**, not draft prose. No MAE values, no learning-curve shapes, no project numbers.

**Authority note.** This is the authoritative introduction blueprint for the Stage 5 planning pack. `citation_needed_list_v2.md` covers Methods, Discussion, and Abstract; for the introduction, use this file only.

---

## 0. What this revision changes (v3 → v4)

One targeted consistency patch. No structural changes to the paragraph plan, no changes to citation hierarchies, no changes to anti-patterns.

- **JARVIS 2020 confirmed present.** All stale "to be obtained" and "missing from paper_sources/" language has been removed. JARVIS 2020 is physically present at `paper_sources/Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf` and is now treated as a fully available local source candidate in its established primary-provenance role.

All guardrails from v3 remain in force: introduction stays result-free; the checkpoint is never called "oxide-pretrained"; the tutorial is never the primary architecture citation; internal scaffolding is never cited; the gap sentence carries no citation placeholder; Matbench is optional background only.

---

## 1. Sharpened research motivation (spine of P3–P5)

The introduction must move the reader through this logical chain. Each link is a sentence-sized claim. Drafters should keep them in this order; reordering breaks the argument.

| Link | Claim it carries | Claim layer | Why it has to be here |
|---|---|---|---|
| A | Structure-based GNNs are the current workhorse for crystal-property prediction. | Literature | Sets the family of models the paper is about. |
| B | ALIGNN sharpens this family by encoding bond angles via the line graph, and is distributed with pretrained checkpoints through the JARVIS ecosystem. | Literature | Names the specific model and the specific data context the paper uses. |
| C | Transfer learning from such pretrained checkpoints is attractive in low-data regimes, but its benefit is conditional on source–target relatedness. | Literature | Establishes that the value of pretraining is not uniform. |
| D | When evaluation chemistry or structure sits outside the regime that supported pretraining, both accuracy and scaling behavior can degrade. | Literature | Connects the conditional benefit to a concrete failure mode — OOD. |
| E | Despite growing OOD and transfer literature, the behavior of a *single, widely used pretrained checkpoint* under a *clean, chemistry-family* shift, evaluated as a *data-efficiency curve* rather than a single-point accuracy number, is not yet a standard, isolated reference point. | Literature gap (carefully worded) | This is the *specific* gap we address. See the protection note below. |
| F | A controlled oxide-versus-nitride contrast, on the same pretrained ALIGNN model, across zero-shot, fine-tuning, and matched-from-scratch regimes, is a minimal design that isolates chemical-family shift as the moving variable. | Project design | This is ours. It is supported conceptually by the literature in C–D but is not itself a literature claim. |
| G | Embedding geometry, treated as an interpretive probe rather than a causal proof, lets us ask whether the prediction-side difficulty is mirrored on the representation side. | Project design, hedged by literature | Pre-empts the reader's "why should I believe this isn't just noise" question. |

**Drafting rule:** Link E is the hinge of the motivation. If E is vague, the paper reads like "we ran ALIGNN on two subsets." If E is concrete, the paper reads like "we built a targeted test of when pretrained materials models do and don't carry across chemistries."

**Gap protection note (Link E).** The claimed gap is a gap in *evaluation design*, not a claim that OOD or transfer learning in materials ML is an unexplored phenomenon. Both are active research areas. The gap is the absence of a clean, isolated reference experiment: a single pretrained checkpoint, a chemistry-family split, and a data-efficiency comparison as the measurement surface — evaluated together as a unit.

- **Forbidden style:** "Prior materials-ML literature has not examined domain shift." ← This is false and would invite immediate rejection.
- **Preferred style:** "What remains less standardized is a clean evaluation design built around a single pretrained checkpoint, a chemistry-family shift, and a data-efficiency comparison."

The gap sentence itself carries no citation placeholder. Adding one would misattribute our framing to prior work.

---

## 2. Paragraph plan (combined paper) — revised

Paragraph IDs are planning labels. Word budgets are targets, not hard limits.

### P1 — Field opener (literature-grounded)

**Job.** Establish why structure-based GNNs matter for crystal-property prediction and why CGCNN is the natural historical anchor.

**Sentences (content targets, not prose).**
1. Crystal-property prediction from atomic structure is a central workload in materials ML. — `NONE` (it is general field framing; no citation needed unless the sentence adds a specific mechanistic claim).
2. Crystal graph neural networks do this by learning directly from atomic structure instead of relying solely on handcrafted descriptors. — `ESSENTIAL` (L1): `[CITE: crystal graph baseline for materials property prediction]`.
3. CGCNN is the canonical early exemplar of this family. — `ESSENTIAL` (L2): `[CITE: CGCNN foundational paper]`.

**Must not contain.** Oxide, nitride, project results, MAE, "our approach."

**Word budget.** ~80–110 words.

---

### P2 — Architecture and ecosystem bridge (literature-grounded)

**Job.** Narrow from "crystal GNNs" to ALIGNN specifically, and anchor the pretrained checkpoint ecosystem.

**Sentences.**
1. ALIGNN extends crystal-graph message passing by alternating updates on the bond graph and its line graph, making bond-angle information explicit. — `ESSENTIAL` (L3): `[CITE: ALIGNN foundational paper]`.
2. ALIGNN and its pretrained checkpoints are distributed through the JARVIS infrastructure, which also provides the DFT dataset and benchmark context we use. — `ESSENTIAL` (L4): use JARVIS 2020 when the sentence anchors dataset/repository provenance; use JARVIS 2025 when the sentence describes the broader pretrained-infrastructure ecosystem. See citation note below.
3. (Optional third sentence) Broader benchmarking infrastructure (e.g., Matbench) exists but is not our primary evaluation surface. — `OPTIONAL`. **Include only if Methods or later framing genuinely needs broader benchmark context.** Do not add this sentence to appear scholarly. If included: `[CITE: benchmark infrastructure for materials property prediction]` drawing on Dunn et al.

**JARVIS citation note for P2.** Match the citation to the sentence's actual content:
- If the sentence anchors *where the dataset and repository come from* → cite JARVIS 2020 (`Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf`).
- If the sentence describes the *broader pretrained-model ecosystem* → cite JARVIS 2025.
- If the sentence mentions *leaderboard standing or benchmark infrastructure* → cite JARVIS-Leaderboard 2024.
- Do not force all three into one sentence. Keep P2 compact.

**Must not contain.** "Oxide-pretrained." Performance claims. Implementation details belonging in methods.

**Word budget.** ~90–120 words.

---

### P3 — Literature gap (literature-grounded) — **most upgraded paragraph**

**Job.** Show that transfer learning and OOD are both live areas, and point at the *specific, narrower* gap our design addresses. This paragraph's precision is what makes the rest of the paper feel motivated rather than opportunistic.

**Sentences.**
1. Transfer learning from pretrained crystal-graph models has been shown to reduce labeled-data requirements for downstream property tasks. — `ESSENTIAL` (L5): `[CITE: transfer learning in materials informatics]`. **Lee & Asahi 2021 is the canonical primary anchor and should lead.** Kim et al. 2024 (melting temperature via GeoCGCNN with transfer learning) is a strong secondary anchor and can be added if the sentence references property-specific or scarce-data transfer. Hu et al. 2024 should not lead this sentence; it is contextual support for domain-adaptation framing.
2. Whether and how much this benefit transfers, however, depends on how related the source and target distributions are. — `ESSENTIAL` (L5 continued, or pair with L6). Can be cited with the same placeholder as sentence 1 or paired with an OOD anchor.
3. When the target chemistry or structure lies outside the distribution that supported pretraining, both accuracy and apparent scaling behavior can degrade, and recent OOD benchmarks make this failure mode concrete. — `ESSENTIAL` (L6): `[CITE: domain shift or OOD benchmark in materials property prediction]`. Omee et al. 2024 is the primary benchmark anchor; Li et al. 2025 (Probing OOD) supports the "scaling behavior can degrade" clause; Hu et al. 2024 supports broader domain-adaptation framing if the sentence warrants it.
4. What remains harder to read off the existing literature is how a *single, widely used pretrained checkpoint* behaves across a *clean chemical-family split* when evaluated as a *data-efficiency curve* rather than a single test-MAE number. — `NONE` for the gap statement itself (this is our characterization of the literature, not a citable claim). Do not attach a placeholder here; attaching one would misattribute our framing to prior work.

**Anti-pattern for sentence 4.** Do not write: "Prior materials-ML literature has not examined domain shift." That claim is false and too broad. Write instead something like: "What remains less standardized is a clean evaluation design built around a single pretrained checkpoint, a chemistry-family shift, and a data-efficiency comparison."

**Must not contain.** "Our results show" anything. A promise that we have solved the gap — only that we address it.

**Word budget.** ~130–170 words. This is the longest literature paragraph on purpose.

---

### P4 — Project design (project-specific motivation)

**Job.** Translate the literature gap into the specific experimental shape of this paper. Oxide and nitride must appear together here, in parallel phrasing, so the control-vs-shift design is visually obvious.

**Sentences.**
1. To isolate chemical-family shift, we contrast an in-distribution oxide arm with an out-of-distribution nitride arm on the same pretrained formation-energy ALIGNN model. — `CONDITIONAL`: include `[CITE: ALIGNN foundational paper]` and `[CITE: JARVIS dataset/repository paper]` because the model and checkpoint provenance are named. Do not add a domain-shift citation here; P3 already carried it.
2. The two arms share an identical protocol: zero-shot evaluation of the pretrained model, fine-tuning across a range of labeled-data sizes, and matched from-scratch baselines at selected sizes. — `NONE`. This is our protocol; the constituent concepts are already cited in P3.
3. To probe why the two arms may behave differently, we extract and visualize intermediate representations from the pretrained model and compare their geometry across the two families. — `NONE` in the paragraph itself. The interpretive caveat on embedding analysis belongs in methods/discussion, not here.

**Sentence classification reminder.** Every sentence in P4 should be classifiable as *project design* or *our question*, not as literature. P4 is the transition from what the literature shows to what we built. Do not smuggle a literature claim here that was already carried in P1–P3.

**Must not contain.** Any claim that the embeddings "explain" or "cause" difficulty. Any MAE values. Any phrase that implies the pretrained checkpoint was trained on oxides only.

**Word budget.** ~110–140 words.

---

### P5 — Objective, research questions, paper map (our questions)

**Job.** Compact statement of what the paper asks, in order, and a one-sentence pointer to the rest of the paper.

**Sentences.**
1. One objective sentence: how chemical-family domain shift modulates the data-efficiency benefit of pretrained ALIGNN, with embedding analysis as interpretive support. — `NONE`.
2. The four research questions in prose form (see RQ table in §3 below). — `NONE`. Do not citation-decorate the RQ sentence; the framing is ours.
3. One paper-map sentence matching the combined-paper blueprint order. — `NONE`.

**Must not contain.** Any "we find that …" sentence. Any numerical result. Any restatement of background.

**Word budget.** ~80–120 words.

---

## 3. Research-question payload (unchanged content, tightened phrasing)

| RQ | Content target | Phrasing note |
|---|---|---|
| RQ1 | Zero-shot behavior of the pretrained checkpoint on the oxide control task versus the nitride shifted task. | Use "starting point" or "zero-shot" — do not say "baseline." |
| RQ2 | How fine-tuning response changes with labeled-data scale across the two families. | "Data-efficiency response" is the preferred phrase. |
| RQ3 | What pretraining contributes over matched from-scratch training, at the sizes where scratch baselines exist. | Be explicit that this is only at selected N; do not imply a full scratch curve. |
| RQ4 | Whether pretrained embedding geometry is consistent with the prediction-side difficulty gap. | Use "consistent with," not "explains" or "proves." |

RQ1–RQ3 are the behavioral spine; RQ4 is the mechanism-oriented follow-up. This ordering reflects the paper's actual argument flow.

---

## 4. Standalone-report variants

Paragraphs P1–P3 are shared across both standalone reports and the combined paper, with minor compression. P4 and P5 diverge along the axis below.

### Oxide standalone — rhetorical identity

> **What does pretrained ALIGNN look like when the chemistry is relatively familiar?**

- **P4 emphasis.** Oxide as the in-distribution control. The scientific value is a clean reference point for *data-efficiency saturation* under pretraining when source–target relatedness is reasonably high. The nitride arm is acknowledged in one sentence as the companion OOD test, not described in detail.
- **P5 emphasis.** RQ1 (zero-shot usefulness for familiar chemistry), RQ2 (how fast saturation arrives), RQ3 (what pretraining actually saves at matched N). RQ4 exists but is secondary — the oxide paper does not live or die on embedding geometry.
- **Tone.** Asks a *saturation* question: at what N does pretraining stop buying you accuracy, and where is zero-shot already "good enough."

### Nitride standalone — rhetorical identity

> **What does chemical-family mismatch do to transfer learning, and can embedding geometry make the penalty legible?**

- **P4 emphasis.** Nitride as the out-of-distribution test. The scientific value is measuring the *penalty* on a single well-known checkpoint, and asking whether fine-tuning data can close it. The oxide arm is acknowledged in one sentence as the control that makes the penalty readable, not described in detail.
- **P5 emphasis.** RQ1 (size of the zero-shot penalty), RQ2 (rate of recovery with fine-tuning), RQ3 (does pretraining still help at matched N despite mismatch), RQ4 (is the penalty mirrored in representation space). RQ4 is co-primary here, not secondary.
- **Tone.** Asks a *recovery* question: how bad is the penalty, and how much labeled nitride data does it take to make it survivable.

### Combined paper — rhetorical identity

> **How does chemical-family shift modulate the data-efficiency benefit of a single pretrained ALIGNN checkpoint, and is the behavioral gap consistent with representation-space geometry?**

- **P4 emphasis.** Both arms described in parallel phrasing. The control/shift contrast is the headline design choice.
- **P5 emphasis.** All four RQs carry roughly equal weight. The paper-map sentence explicitly mentions the embedding analysis as a distinct section, not a sub-paragraph.

**Alignment rule.** When a sentence appears in both standalone reports, its wording should not diverge materially. Divergence is earned at P4/P5, not at P1/P2/P3.

---

## 5. Citation essentiality — consolidated table

Citations are only anchors; no references are invented. All placeholders reuse the wording already established in `citation_needed_list_v2.md` and `literature_claim_map_v3.md`.

| Placeholder | Combined P1 | Combined P2 | Combined P3 | Combined P4 | Combined P5 |
|---|---|---|---|---|---|
| `[CITE: crystal graph baseline for materials property prediction]` | ESSENTIAL | — | — | — | — |
| `[CITE: CGCNN foundational paper]` | ESSENTIAL | — | OPTIONAL (only if P3 opens with a historical transfer-learning anchor that is itself a CGCNN study; otherwise drop) | — | — |
| `[CITE: ALIGNN foundational paper]` | — | ESSENTIAL | — | CONDITIONAL (required because model name appears) | — |
| `[CITE: JARVIS dataset/repository paper]` (JARVIS 2020 — primary) | — | ESSENTIAL (when sentence anchors dataset/repository provenance) | — | CONDITIONAL (required because checkpoint/dataset provenance appears) | — |
| `[CITE: JARVIS infrastructure or ecosystem paper]` (JARVIS 2025 — secondary) | — | CONDITIONAL (when sentence describes pretrained-model ecosystem) | — | — | — |
| `[CITE: JARVIS leaderboard/benchmark paper]` (JARVIS-Leaderboard 2024 — contextual) | — | OPTIONAL (only if sentence explicitly concerns leaderboard/benchmark infrastructure) | — | — | — |
| `[CITE: transfer learning in materials informatics]` | — | — | ESSENTIAL | — | — |
| `[CITE: domain shift or OOD benchmark in materials property prediction]` | — | — | ESSENTIAL | OPTIONAL (skip unless P4 opens by re-summarizing the literature gap, which it should not by default) | — |
| `[CITE: benchmark infrastructure for materials property prediction]` (Matbench — optional background) | — | OPTIONAL | — | — | — |

**Reading this table.** A paragraph with no ESSENTIAL entry should not invent citations to "look scholarly." A paragraph with an ESSENTIAL entry must not be drafted without the placeholder visible. Matbench is optional background only — include it if and only if Methods or later framing genuinely requires broader benchmark context.

---

## 6. Local source candidates — mapped to placeholders

No new references. Each placeholder maps only to files already in `paper_sources/`.

| Placeholder | Local file(s) that can fill it | Notes |
|---|---|---|
| `[CITE: crystal graph baseline for materials property prediction]` | `CGCNN_Paper.pdf`; `Chen et al. - 2019 - Graph Networks as a Universal Machine Learning Framework for Molecules and Crystals.pdf` | Chen et al. 2019 is the broader "graph networks as universal framework" framing; use if P1 wants the general GNN framing alongside CGCNN specifically. |
| `[CITE: CGCNN foundational paper]` | `CGCNN_Paper.pdf` | Single file. |
| `[CITE: ALIGNN foundational paper]` | `ALIGNN_Paper.pdf` | Single file. Do not substitute `ALIGNN_Tutorial.pdf`. |
| `[CITE: JARVIS dataset/repository paper]` | `Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf` | **Primary anchor for dataset and repository provenance.** Use when the sentence anchors where the DFT dataset and JARVIS repository come from. |
| `[CITE: JARVIS infrastructure or ecosystem paper]` | `Choudhary - 2025 - The JARVIS Infrastructure is All You Need for Materials Design.pdf` | Use when the sentence describes the broader JARVIS pretrained-model ecosystem, not just the dataset origin. |
| `[CITE: JARVIS leaderboard/benchmark paper]` | `Choudhary et al. - 2024 - JARVIS-Leaderboard a large scale benchmark of materials design methods.pdf` | Use only when the sentence explicitly concerns benchmark infrastructure or leaderboard standing. Do not use as a generic JARVIS citation. |
| `[CITE: transfer learning in materials informatics]` | **Primary:** `Lee and Asahi - 2021 - Transfer learning for materials informatics using crystal graph convolutional neural network.pdf`. **Secondary:** `Kim et al. - 2024 - Predicting melting temperature of inorganic crystals via crystal graph neural network enhanced by transfer learning.pdf`. **Contextual:** `Hu et al. - 2024 - Realistic material property prediction using domain adaptation based machine learning.pdf` | Lee & Asahi 2021 leads. Kim et al. 2024 adds depth for property-specific or scarce-data transfer sentences. Hu et al. 2024 is contextual for domain-adaptation framing only — not the default lead citation. |
| `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee et al. - 2024 - Structure-based out-of-distribution (OOD) materials property prediction a benchmark study.pdf`; `Li et al. - 2025 - Probing out-of-distribution generalization in machine learning for materials.pdf`; `Li et al. - 2025 - Out-of-Distribution Material Property Prediction Using Adversarial Learning.pdf` | Omee et al. 2024 is the primary GNN-OOD benchmark anchor. Li et al. 2025 (Probing) supports scaling-behavior-degradation claims. Li et al. 2025 (Adversarial) is tertiary; only if the paragraph gestures at OOD mitigation, which it should not in the introduction. |
| `[CITE: benchmark infrastructure for materials property prediction]` (optional, P2 only) | `Dunn et al. - 2020 - Benchmarking materials property prediction methods the Matbench test set and Automatminer reference.pdf`; `Jain et al. - 2013 - Commentary The Materials Project A materials genome approach to accelerating materials innovation.pdf` | Include only if an optional third sentence in P2 explicitly talks about benchmarking infrastructure. Otherwise omit. Matbench should appear only if later Methods or framing genuinely needs broader benchmark context — not for scholarly signaling. |

---

## 7. Anti-patterns to watch for during drafting

Each of these has appeared in adjacent materials-ML papers and would undermine ours.

- **Pseudo-citations on our framing.** Attaching `[CITE: domain shift ...]` to the sentence that asserts oxide is our control arm. That assignment is a project design choice, not a literature finding.
- **"ALIGNN was trained on oxides."** The pretrained formation-energy checkpoint is trained on JARVIS-DFT-3D, which is chemistry-diverse. Nothing in the introduction should imply otherwise.
- **Embedding geometry as proof.** Any sentence in the introduction that says embeddings "explain," "cause," or "prove" anything should be rewritten. Allowed verbs: "is consistent with," "supports the interpretation that," "lets us ask whether."
- **Result smuggling.** Previewing a trend ("pretraining is more helpful for oxides than nitrides") in the introduction. The introduction ends with the *question*, not the answer.
- **Collapsing the two arms.** A sentence in P4 of either standalone report that describes both arms symmetrically dilutes the rhetorical identity of that report. Keep the companion arm to a single acknowledging sentence.
- **Tutorial-as-citation.** `ALIGNN_Tutorial.pdf` is implementation guidance; citing it instead of the ALIGNN paper mislocates authority.
- **Inventing a reference.** If a desired claim cannot be anchored to a file in `paper_sources/`, either rewrite the claim so it does not require an external anchor, or defer it to discussion.
- **Overbroad gap claim.** Saying "prior materials-ML literature has not examined domain shift" is factually wrong and too broad. The gap is in evaluation *design*, not in awareness of the phenomenon. Use the preferred phrasing from §1 (Link E).
- **Hu et al. as default transfer-learning lead.** Hu et al. 2024 is contextual support for domain-adaptation framing. Lee & Asahi 2021 leads; Kim et al. 2024 is secondary.
- **Forcing Matbench into P2.** Matbench is optional background. Include it only if the paper's Methods section genuinely requires that context. Do not add it to signal breadth.

---

## 8. Drafting-readiness checklist

Before any P1–P5 prose is written, the drafter should be able to answer yes to all of these:

1. Is the motivation chain A–G from §1 clear to me end-to-end?
2. Can I state, in one sentence, the *specific* gap E addresses, without repeating the generic OOD claim D, and without claiming that domain shift in materials is unstudied?
3. For the report variant I am drafting, can I say in one sentence why this report's P4/P5 emphasis differs from the other one?
4. For every sentence I plan to write, have I classified it as *Literature* / *Project-design* / *Our-question*, and does its citation status in §5 match?
5. Do I have a local source candidate from §6 for every ESSENTIAL placeholder I will use?
6. Have I reviewed the anti-patterns in §7, including the overbroad gap claim and the Hu/Lee citation hierarchy?

Only when all six are yes does drafting begin.

---

## 9. What this blueprint deliberately does not fix

The following are still open and should be resolved later, not during intro drafting:

- Whether to mention dataset counts in the introduction or defer them all to methods. The stricter choice (defer all) is still recommended.
- Whether the Chen et al. 2019 anchor is used alongside CGCNN in P1 or only in methods. Either is acceptable; pick one and apply consistently.
- Whether P2 includes the optional third sentence about broader benchmarking infrastructure. Decide after methods is written, because the decision depends on how heavily methods leans on Matbench or JARVIS-Leaderboard framing.
