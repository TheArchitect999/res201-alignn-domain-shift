# Phase 10 — Discussion and Conclusion Revision Changelog (v1 → v2)

**Date:** 2026-04-23
**Pass scope:** Discussion (§§4–5 / §§5–6 / §§V–VI) and Conclusion sections of all three manuscripts.
**Files revised:** see table below.

| Original file (v1) | Revised file (v2) | Document role |
|---|---|---|
| `oxide_discussion_conclusion_draft_v1.md` | `oxide_discussion_conclusion_draft_v2.md` | In-distribution control arm |
| `nitride_discussion_conclusion_draft_v1.md` | `nitride_discussion_conclusion_draft_v2.md` | Out-of-distribution test arm |
| `combined_paper_discussion_conclusion_draft_v1.md` | `combined_paper_discussion_conclusion_draft_v2.md` | Comparison-and-mechanism paper |

Both v1 and v2 files are retained in `04_drafts/`. No v1 file was overwritten or moved.
Companion notes file: `phase10_discussion_revision_notes.md`.

---

## 1. Cross-cutting revisions (applied to all three manuscripts)

These six changes were applied uniformly across the oxide, nitride, and combined drafts.

### 1.1 Removed counterfactual certainty about optimization schedules

**What changed.** Passages in v1 that implied the observed nitride penalty *could not* be removed by a different learning-rate schedule were replaced with protocol-bounded phrasing. Affected wording was concentrated in the nitride §5.3, the combined §V.C, and the combined §V.H.

**v1 pattern (example):** language that ruled out alternative schedules in principle.
**v2 replacement:** "under the canonical protocol," "within the tested N range and schedule," "is not resolved by the schedule tested here," "persists under the canonical Set 1 protocol."

**Why.** The tested protocol is Hyperparameter Set 1 only. Claiming schedule-independence in principle was beyond the evidence. The v2 wording confines every schedule-related claim to what the tested configuration actually demonstrates, making the manuscripts reviewer-safe on this point.

### 1.2 Turned Discussion openings from recap into argument

**What changed.** The opening subsection of every Discussion was rewritten to lead with the interpretive answer the Discussion will defend, rather than with a recapitulation of the Results. Numeric content from v1 openings was redistributed to the subsections that own those numbers in their argumentative role.

**Why.** Discussions should argue from evidence, not re-list it. The v1 openings were close to Results summaries — useful for drafting but not for the reader. The v2 openings state the answer first, then name the structure of the argument.

### 1.3 Made practical implications explicitly protocol-bounded

**What changed.** Every practical recommendation is now anchored to the four-part scope of the tested protocol: formation energy per atom, JARVIS `dft_3d` splits, the pretrained formation-energy ALIGNN checkpoint, and Hyperparameter Set 1 within the tested N range. Broader language from v1 (oxide §4.5, combined §V.G) was narrowed accordingly.

**Why.** Practical implications stated more broadly than the tested regime justifies invite reviewer rejection. The v2 language preserves the substance of each implication while keeping the scope defensible.

### 1.4 Reduced numeric replay in Discussion and Conclusion

**What changed.** The v2 Discussion sections retain only the most decisive numeric anchors (three to five per manuscript). The v2 Conclusions are noticeably shorter; numbers that appeared multiple times in v1 are cited once, with subsequent references resolved by pointing back to Results subsections.

**Why.** Repeating numbers that already appear in Results is length without analytical value. The Discussion should interpret the evidence; it should refer back to it, not re-quote it.

### 1.5 Kept embedding interpretation explicitly correlational

**What changed.** Embedding-related claims consistently use: "geometric correlate," "representation-space counterpart," "consistent with," "aligned with the behavioural asymmetry." Any sentence in v1 that risked giving the representation causal agency was identified and rewritten.

Retained in all three manuscripts:
- caution that PCA, t-SNE, and UMAP are descriptive visual support only and that visual inter-cluster distances are not quoted as statistical evidence
- statement that all quantitative embedding claims are computed in raw 256-D `last_alignn_pool` space
- explicit labelling of the distance–error association as correlational

**Why.** The evidence supports a representation-space geometric correlate, not a causal mechanism. Overstating the embedding evidence invites a methodological objection that the data do not warrant.

### 1.6 Sharpened each manuscript's distinct identity

**What changed.** Light back-references to specific Results subsections were added to each major Discussion claim (e.g., "Results §III.A," "Results §4.6") so the argumentative thread from Discussion claim to underlying evidence is traceable without search.

**Why.** In v1, some synthesis claims were strong but not anchored; adding parenthetical pointers makes each manuscript internally auditable and reduces the chance that a reviewer locates an unanchored claim.

---

## 2. Combined-paper-specific revisions

### 2.1 Rewrote §V.A from four-paragraph replay to single comparative-answer paragraph

**Original file:** `combined_paper_discussion_conclusion_draft_v1.md`, §V.A
**Revised file:** `combined_paper_discussion_conclusion_draft_v2.md`, §V.A

**What changed.** The v1 §V.A was a four-paragraph recapitulation of the four Results blocks. The v2 §V.A is a single paragraph that states the comparative answer (oxide arm behaves as predicted; nitride arm departs in a structured way; frozen representation has a consistent geometric correlate), identifies the two lenses (§§V.B–V.E for control-versus-shift; §V.F for representation space), and directs the reader to §V.G for practical implications.

**Why.** The combined paper's Discussion must synthesize, not replay. A single clear paragraph that leads with the answer and maps the structure of what follows is the appropriate entry point for a comparative manuscript.

### 2.2 Tightened §V.C closing paragraph on schedule uncertainty

**Original file:** `combined_paper_discussion_conclusion_draft_v1.md`, §V.C
**Revised file:** `combined_paper_discussion_conclusion_draft_v2.md`, §V.C

**What changed.** The v1 closing paragraph of §V.C contained language that read as ruling out optimization-schedule explanations of the nitride penalty. The v2 paragraph explicitly states that whether a different schedule would change the magnitude or character of any of the three measurement surfaces is not a question the present protocol can answer, and that the combined claim is bounded to what the tested Set 1 protocol demonstrates.

**Why.** Cross-cutting change 1.1 (removed counterfactual certainty) was most visible in this paragraph; the rewrite applies it in the context of the combined paper's three-surface presentation.

### 2.3 Restructured §V.G into two labelled workflow profiles

**Original file:** `combined_paper_discussion_conclusion_draft_v1.md`, §V.G
**Revised file:** `combined_paper_discussion_conclusion_draft_v2.md`, §V.G

**What changed.** The v1 §V.G listed practical implications as a flat sequence. The v2 §V.G is structured as two clearly labelled profiles — **Chemistry-aligned targets (the oxide profile)** and **Chemistry-shifted targets (the nitride profile)** — plus one cross-cutting implication (within-family triage signal) that spans both.

**Why.** The combined paper is the comparative manuscript of the study. Its practical implications should themselves be structurally comparative. The two-profile layout makes the comparative spine unmissable at the level of section structure.

### 2.4 Shortened and sharpened the Conclusion

**Original file:** `combined_paper_discussion_conclusion_draft_v1.md`, §VI
**Revised file:** `combined_paper_discussion_conclusion_draft_v2.md`, §VI

**What changed.** The middle paragraph of the v2 Conclusion retains only the most decisive numeric anchors from v1. The closing paragraph ends on a single sentence naming the practical meaning of chemical-family domain shift — the regime separation between chemistry-aligned and chemistry-shifted workflows — rather than re-citing measured values.

**Why.** Conclusions should state the answer, state the implication, and stop. The v2 structure is: restate the question → state the answer → state the implication → closing sentence.

---

## 3. Nitride-paper-specific revisions

### 3.1 Rewrote §5.1 from sequential arc to single thesis paragraph

**Original file:** `nitride_discussion_conclusion_draft_v1.md`, §5.1
**Revised file:** `nitride_discussion_conclusion_draft_v2.md`, §5.1

**What changed.** The v1 §5.1 retraced the four-step arc of the Results section before stating any interpretation. The v2 §5.1 is a single paragraph titled "The domain-shift answer in one paragraph" that opens with the interpretive answer (cost of pretraining-target mismatch reappears at every measurement surface), names what each step of the arc shows in compressed form, and closes with: "the remainder of this Discussion argues that reading; it is not a replay of the four steps."

**Why.** The nitride report is the scientifically richer arm. Its Discussion must argue from evidence, not retrace it. The v2 opening positions the remainder of the Discussion as an argument for a single interpretation.

### 3.2 Made oxide control the lead discriminator in §5.3

**Original file:** `nitride_discussion_conclusion_draft_v1.md`, §5.3
**Revised file:** `nitride_discussion_conclusion_draft_v2.md`, §5.3

**What changed.** In v1, the oxide comparator appeared partway through the section after working through small-data versus domain-shift alternatives in order. In v2, the section opens with: "Nitride low-`N` inertness cannot be read as ordinary small-data noise, because oxide under the same canonical protocol does not behave this way." The discriminator is now the first sentence after the heading.

**Why.** The most powerful evidence that nitride low-`N` inertness is a domain-shift signature — not small-data noise — is the oxide control under the same protocol. Burying that comparison partway through the section weakened the argument structurally.

### 3.3 Rewrote the lead of §5.4 to foreground the two distinct contributions

**Original file:** `nitride_discussion_conclusion_draft_v1.md`, §5.4
**Revised file:** `nitride_discussion_conclusion_draft_v2.md`, §5.4

**What changed.** The v1 §5.4 opened with a contrast between MAE-based and embedding-based questions. The v2 §5.4 leads with: "The embedding analysis adds two things the behavioural section cannot: a representation-space correlate of the family-level penalty, and a within-family geometric correlate of intra-family difficulty." The two contributions are then unpacked individually.

**Why.** A reader should know what a section adds before reading how it adds it. Foregrounding the two contributions makes the section's contribution immediately readable in a single sentence.

### 3.4 Sharpened the Conclusion's closing sentence

**Original file:** `nitride_discussion_conclusion_draft_v1.md`, §6 (Conclusion)
**Revised file:** `nitride_discussion_conclusion_draft_v2.md`, §6 (Conclusion)

**What changed.** The v1 Conclusion closed with a hedged paragraph about labelled-data planning. The v2 Conclusion closes with: "chemically distant targets require much more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do." This sentence is the protocol-bounded headline practical message.

**Why.** The nitride report's unique scientific contribution is to quantify, concretely, how hard it is to beat a pretrained baseline on a chemically distant target under a standard protocol. The closing sentence should state that contribution directly.

---

## 4. Oxide-paper-specific revisions

### 4.1 Reframed §4.3 from "oxide is easier" to "oxide establishes the reference condition"

**Original file:** `oxide_discussion_conclusion_draft_v1.md`, §4.3
**Revised file:** `oxide_discussion_conclusion_draft_v2.md`, §4.3

**What changed.** The v1 §4.3 described oxide as the easier arm and noted that "easier" did not mean "uninformative." The v2 §4.3 leads with the scientific role of the oxide arm: it establishes the best-case transfer regime — the regime in which the canonical protocol behaves the way the transfer-learning literature predicts — and without that reference, the nitride arm's behaviour cannot be diagnosed as domain shift rather than as small-data noise, optimizer pathology, or chemistry-specific difficulty.

**Why.** The oxide report earns its scientific identity by being the indispensable interpretive frame for the companion nitride report. Framing it as merely "easier" undersells that role and understates the oxide arm's contribution to the study.

### 4.2 Narrowed practical-implication language in §§4.2 and 4.5

**Original file:** `oxide_discussion_conclusion_draft_v1.md`, §§4.2 and 4.5
**Revised file:** `oxide_discussion_conclusion_draft_v2.md`, §§4.2 and 4.5

**What changed.** Sentences about "initialization matters more than fine-tuning budget" and "zero-shot is a defensible first-pass estimator" were scoped explicitly to the four-part tested regime (formation energy per atom, JARVIS `dft_3d` oxide splits, Hyperparameter Set 1, tested scratch sizes and N range). The implications are preserved; their scope is made reviewer-safe.

**Why.** Cross-cutting change 1.3 (protocol-bounded practical implications) was most prominent in these two subsections of the oxide manuscript.

### 4.3 Disciplined §4.4 to keep embedding view consistent-with rather than causal

**Original file:** `oxide_discussion_conclusion_draft_v1.md`, §4.4
**Revised file:** `oxide_discussion_conclusion_draft_v2.md`, §4.4

**What changed.** A few sentences in the v1 §4.4 risked drifting toward a mechanistic argument. The v2 section reads as a representation-space description that is consistent with the behavioural picture, not as a parallel causal account. The forward-reference to the combined manuscript's distance–error analysis is preserved.

**Why.** Cross-cutting change 1.5 (kept embeddings correlational) was applied here.

### 4.4 Added a stronger closing sentence to the Conclusion

**Original file:** `oxide_discussion_conclusion_draft_v1.md`, §5 (Conclusion)
**Revised file:** `oxide_discussion_conclusion_draft_v2.md`, §5 (Conclusion)

**What changed.** The v1 Conclusion's closing paragraph mentioned the oxide report's role in the broader study. The v2 closing paragraph makes that role explicit: by establishing what "transfer working as advertised" looks like under the canonical protocol, the oxide report makes the chemical-family domain shift documented in the companion work an interpretable and quantifiable phenomenon rather than an isolated observation.

**Why.** The oxide report's scientific identity within the project is its role as the interpretive control. The Conclusion should end by naming that identity, not gesturing at it.

---

## 5. What the v2 revision pass did NOT change

For the avoidance of doubt, every item in this list is unchanged from v1 to v2:

- All measured values reported in the v1 drafts
- All citation placeholders of the form `[CITE: …]`
- Section numbering of all three manuscripts
- High-level subsection titles (light wording adjustments only, where useful for thesis-bearing)
- Separation of literature claims from implementation details from our findings
- Use of `last_alignn_pool` as the only main-text embedding layer
- Appendix-support designation of `pre_head` and `last_gcn_pool`
- Nitride N = 50 caveat phrasing ("pretrained-initialization advantage over scratch, not fine-tuning adaptation")
- Description of the checkpoint as "the pretrained formation-energy ALIGNN model" (never "oxide-pretrained")
- Use of "oxide-reference region" only in distance-context language
- Role assignments of the three manuscripts (oxide = control, nitride = OOD test, combined = comparison-and-mechanism)
- Figure and table anchors used by the prose

---

*Changelog generated: 2026-04-23*
