# Introduction Blueprint v2

Supersedes the planning content in `introduction_paragraph_plan.md` and `citation_needed_list.md` for the introduction only. Inherits all source-tier rules from `literature_claim_map.md`.

This is still a **blueprint**, not draft prose. No MAE values, no learning-curve shapes, no project numbers.

---

## 0. What this revision changes

Three substantive upgrades over v1:

1. **Research motivation is now built from a two-step gap**, not a single sentence. The gap separates (a) transfer-learning promise in low-data settings from (b) the specific, underexamined question of *chemical-family* mismatch on a *single pretrained checkpoint*. This is what our project actually isolates.
2. **Oxide and nitride arms carry distinct rhetorical loads** in the standalone reports. Oxide asks a *data-efficiency saturation* question; nitride asks a *recovery-under-penalty* question. These are not mirrors of each other.
3. **Citation essentiality is annotated per-sentence** as `ESSENTIAL` / `CONDITIONAL` / `OPTIONAL` / `NONE`, so drafters can see exactly where a placeholder must appear and where the sentence is ours alone.

Guardrails from v1 that remain in force: introduction stays result-free; the checkpoint is never called "oxide-pretrained"; the tutorial is never the primary architecture citation; internal scaffolding is never cited.

---

## 1. Sharpened research motivation (spine of P3–P5)

The introduction must move the reader through this logical chain. Each link is a sentence-sized claim. Drafters should keep them in this order; reordering breaks the argument.

| Link | Claim it carries | Claim layer | Why it has to be here |
|---|---|---|---|
| A | Structure-based GNNs are the current workhorse for crystal-property prediction. | Literature | Sets the family of models the paper is about. |
| B | ALIGNN sharpens this family by encoding bond angles via the line graph, and is distributed with pretrained checkpoints through the JARVIS ecosystem. | Literature | Names the specific model and the specific data context the paper uses. |
| C | Transfer learning from such pretrained checkpoints is attractive in low-data regimes, but its benefit is conditional on source–target relatedness. | Literature | Establishes that the value of pretraining is not uniform. |
| D | When evaluation chemistry or structure sits outside the regime that supported pretraining, both accuracy and scaling behavior can degrade. | Literature | Connects the conditional benefit to a concrete failure mode — OOD. |
| E | Despite growing OOD and transfer literature, the behavior of a *single, widely used pretrained checkpoint* under a *clean, chemistry-family* shift, evaluated as a *data-efficiency curve* rather than a single-point accuracy number, is not yet a standard, isolated reference point. | Literature gap (carefully worded) | This is the *specific* gap we address. It must be phrased as a gap in the evaluation design, not as a gap in the underlying phenomenon. |
| F | A controlled oxide-versus-nitride contrast, on the same pretrained ALIGNN model, across zero-shot, fine-tuning, and matched-from-scratch regimes, is a minimal design that isolates chemical-family shift as the moving variable. | Project design | This is ours. It is supported conceptually by the literature in C–D but is not itself a literature claim. |
| G | Embedding geometry, treated as an interpretive probe rather than a causal proof, lets us ask whether the prediction-side difficulty is mirrored on the representation side. | Project design, hedged by literature | Pre-empts the reader's "why should I believe this isn't just noise" question. |

**Drafting rule:** Link E is the hinge of the motivation. If E is vague, the paper reads like "we ran ALIGNN on two subsets." If E is concrete, the paper reads like "we built a targeted test of when pretrained materials models do and don't carry across chemistries."

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
2. ALIGNN and its pretrained checkpoints are distributed through the JARVIS infrastructure, which also provides the DFT dataset and benchmark context we use. — `ESSENTIAL` (L4): `[CITE: JARVIS infrastructure or dataset paper]`.
3. (Optional third sentence) Broader benchmarking infrastructure (e.g., Matbench) exists but is not our primary evaluation surface. — `OPTIONAL`. Only include if P4 or the methods later explicitly contrast with Matbench; otherwise cut. If included: `[CITE: benchmark infrastructure for materials property prediction]` drawing on Dunn et al.

**Must not contain.** "Oxide-pretrained." Performance claims. Implementation details belonging in methods.

**Word budget.** ~90–120 words.

---

### P3 — Literature gap (literature-grounded) — **most upgraded paragraph**

**Job.** Show that transfer learning and OOD are both live areas, and point at the *specific, narrower* gap our design addresses. This paragraph's precision is what makes the rest of the paper feel motivated rather than opportunistic.

**Sentences.**
1. Transfer learning from pretrained crystal-graph models has been shown to reduce labeled-data requirements for downstream property tasks. — `ESSENTIAL` (L5): `[CITE: transfer learning in materials informatics]`. Lee & Asahi 2021 is the canonical anchor; Kim et al. 2024 (melting temperature via GeoCGCNN with transfer learning) is a strong supporting anchor and can be added if the sentence references property-specific transfer.
2. Whether and how much this benefit transfers, however, depends on how related the source and target distributions are. — `ESSENTIAL` (L5 continued, or pair with L6). Can be cited with the same placeholder as sentence 1 or paired with an OOD anchor.
3. When the target chemistry or structure lies outside the distribution that supported pretraining, both accuracy and apparent scaling behavior can degrade, and recent OOD benchmarks make this failure mode concrete. — `ESSENTIAL` (L6): `[CITE: domain shift or OOD benchmark in materials property prediction]`. Omee et al. 2024 is the primary benchmark anchor; Li et al. 2025 (Probing OOD) supports the "scaling behavior can degrade" clause; Hu et al. 2024 supports the broader domain-adaptation framing.
4. What remains harder to read off the existing literature is how a *single, widely used pretrained checkpoint* behaves across a *clean chemical-family split* when evaluated as a *data-efficiency curve* rather than a single test-MAE number. — `NONE` for the gap statement itself (this is our characterization of the literature, not a citable claim). Do not attach a placeholder here; attaching one would misattribute our framing to prior work.

**Must not contain.** "Our results show" anything. A promise that we have solved the gap — only that we address it.

**Word budget.** ~130–170 words. This is the longest literature paragraph on purpose.

---

### P4 — Project design (project-specific motivation)

**Job.** Translate the literature gap into the specific experimental shape of this paper. Oxide and nitride must appear together here, in parallel phrasing, so the control-vs-shift design is visually obvious.

**Sentences.**
1. To isolate chemical-family shift, we contrast an in-distribution oxide arm with an out-of-distribution nitride arm on the same pretrained formation-energy ALIGNN model. — `CONDITIONAL`: include `[CITE: ALIGNN foundational paper]` and `[CITE: JARVIS infrastructure or dataset paper]` because the model and checkpoint provenance are named. Do not add a domain-shift citation here; P3 already carried it.
2. The two arms share an identical protocol: zero-shot evaluation of the pretrained model, fine-tuning across a range of labeled-data sizes, and matched from-scratch baselines at selected sizes. — `NONE`. This is our protocol; the constituent concepts are already cited in P3.
3. To probe why the two arms may behave differently, we extract and visualize intermediate representations from the pretrained model and compare their geometry across the two families. — `NONE` in the paragraph itself. The interpretive caveat on embedding analysis belongs in methods/discussion, not here.

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

Citations are only anchors; no references are invented. All placeholders reuse the wording already established in `citation_needed_list.md` and `literature_claim_map.md`.

| Placeholder | Combined P1 | Combined P2 | Combined P3 | Combined P4 | Combined P5 |
|---|---|---|---|---|---|
| `[CITE: crystal graph baseline for materials property prediction]` | ESSENTIAL | — | — | — | — |
| `[CITE: CGCNN foundational paper]` | ESSENTIAL | — | OPTIONAL (only if P3 opens with a historical transfer-learning anchor that is itself a CGCNN study; otherwise drop) | — | — |
| `[CITE: ALIGNN foundational paper]` | — | ESSENTIAL | — | CONDITIONAL (required because model name appears) | — |
| `[CITE: JARVIS infrastructure or dataset paper]` | — | ESSENTIAL | — | CONDITIONAL (required because checkpoint/dataset provenance appears) | — |
| `[CITE: transfer learning in materials informatics]` | — | — | ESSENTIAL | — | — |
| `[CITE: domain shift or OOD benchmark in materials property prediction]` | — | — | ESSENTIAL | OPTIONAL (skip unless P4 opens by re-summarizing the literature gap, which it should not by default) | — |
| `[CITE: benchmark infrastructure for materials property prediction]` (Matbench family, not in v1) | — | OPTIONAL | — | — | — |

**Reading this table.** A paragraph with no ESSENTIAL entry should not invent citations to "look scholarly." A paragraph with an ESSENTIAL entry must not be drafted without the placeholder visible.

---

## 6. Local source candidates — mapped to placeholders

No new references. Each placeholder maps only to files already in the project.

| Placeholder | Local file(s) that can fill it | Notes |
|---|---|---|
| `[CITE: crystal graph baseline for materials property prediction]` | `CGCNN_Paper.pdf`; `Chen_et_al___2019__Graph_Networks_as_a_Universal_Machine_Learning_Framework_for_Molecules_and_Crystals.pdf` | Chen et al. 2019 is the broader "graph networks as universal framework" framing; use if P1 wants the general GNN framing alongside CGCNN specifically. |
| `[CITE: CGCNN foundational paper]` | `CGCNN_Paper.pdf` | Single file. |
| `[CITE: ALIGNN foundational paper]` | `ALIGNN_Paper.pdf` | Single file. Do not substitute `ALIGNN_Tutorial.pdf`. |
| `[CITE: JARVIS infrastructure or dataset paper]` | `Choudhary__2025__The_JARVIS_Infrastructure_is_All_You_Need_for_Materials_Design.pdf`; `Choudhary_et_al___2024__JARVISLeaderboard_a_large_scale_benchmark_of_materials_design_methods.pdf` | Use the 2024 Leaderboard paper when the sentence is about benchmark infrastructure; use the 2025 Infrastructure paper when it is about the broader JARVIS ecosystem and pretrained model availability. Either is acceptable; both if the sentence spans both ideas. |
| `[CITE: transfer learning in materials informatics]` | `Lee_and_Asahi__2021__Transfer_learning_for_materials_informatics_using_crystal_graph_convolutional_neural_network.pdf`; `Kim_et_al___2024__Predicting_melting_temperature_of_inorganic_crystals_via_crystal_graph_neural_network_enhanced_by_tr.pdf`; `Hu_et_al___2024__Realistic_material_property_prediction_using_domain_adaptation_based_machine_learning.pdf` | Lee & Asahi is the cleanest canonical anchor. Kim et al. 2024 strengthens the specific "pretrain-then-fine-tune for a scarce property" framing. Hu et al. 2024 belongs here when the sentence leans toward domain adaptation rather than vanilla transfer. |
| `[CITE: domain shift or OOD benchmark in materials property prediction]` | `Omee_et_al___2024__Structurebased_outofdistribution_OOD_materials_property_prediction_a_benchmark_study.pdf`; `Li_et_al___2025__Probing_outofdistribution_generalization_in_machine_learning_for_materials.pdf`; `Li_et_al___2025__OutofDistribution_Material_Property_Prediction_Using_Adversarial_Learning.pdf` | Omee et al. 2024 is the primary GNN-OOD benchmark anchor and the most direct support for the "OOD on structure-based models" framing. Li et al. 2025 (Probing) supports the specific claim about scaling behavior degrading on harder OOD tasks. Li et al. 2025 (Adversarial) is tertiary and only needed if the paragraph also gestures at OOD mitigation methods, which it should not in this introduction. |
| `[CITE: benchmark infrastructure for materials property prediction]` (optional, P2 only) | `Dunn_et_al___2020__Benchmarking_materials_property_prediction_methods_the_Matbench_test_set_and_Automatminer_reference.pdf`; `Jain_et_al___2013__Commentary_The_Materials_Project_A_materials_genome_approach_to_accelerating_materials_innovation.pdf` | Include only if an optional third sentence in P2 explicitly talks about benchmarking infrastructure. Otherwise omit. |

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

---

## 8. Drafting-readiness checklist

Before any P1–P5 prose is written, the drafter should be able to answer yes to all of these:

1. Is the motivation chain A–G from §1 clear to me end-to-end?
2. Can I state, in one sentence, the *specific* gap E addresses, without repeating the generic OOD claim D?
3. For the report variant I am drafting, can I say in one sentence why this report's P4/P5 emphasis differs from the other one?
4. For every sentence I plan to write, have I classified it as Literature / Project-design / Our-question, and does its citation status in §5 match?
5. Do I have a local source candidate from §6 for every ESSENTIAL placeholder I will use?
6. Have I reviewed the anti-patterns in §7?

Only when all six are yes does drafting begin.

---

## 9. What this blueprint deliberately does not fix

The following are still open and should be resolved later, not during intro drafting:

- Whether to mention dataset counts in the introduction or defer them all to methods. The stricter choice (defer all) is still recommended.
- Whether the Chen et al. 2019 anchor is used alongside CGCNN in P1 or only in methods. Either is acceptable; pick one and apply consistently.
- Whether P2 includes the optional third sentence about broader benchmarking infrastructure. Decide after methods is written, because the decision depends on how heavily methods leans on Matbench or JARVIS-Leaderboard framing.

These are intentionally deferred to avoid premature commitments that would have to be reversed during cross-report alignment.
