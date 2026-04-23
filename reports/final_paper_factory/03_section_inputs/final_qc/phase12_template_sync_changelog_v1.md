---
name: Phase 12 Template Sync Changelog
description: Documents every change made to each template-ready v2 file relative to the prior template-ready v1 file, during the Phase 12B sync pass.
type: project
---

# Phase 12 Template Sync Changelog (v1)

Sync date: 2026-04-23  
Source of truth for prose: polished v2 drafts (`04_drafts/phase12_full_manuscripts/`)  
Packaging targets: `06_template_ready/*_template_ready_v2.md`  
Predecessor files: `06_template_ready/*_template_ready.md` (v1)

---

## 1. oxide_template_ready_v2.md

**Source:** `oxide_polished_v2.md`  
**Target:** `oxide_template_ready_v2.md`

### Internal artifacts removed

None present in the v1 template_ready file. Confirmed clean.

### Prose synchronizations (polished v2 → v2 template_ready)

The following changes bring the template_ready wording in line with the Phase 12B style-polish decisions recorded in `phase12_style_polish_notes_v1.md`:

1. **Abstract — measurement surfaces clause.** `"we compare zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes from ten to one thousand structures at five random seeds per size"` → `"we combine three measurement surfaces: zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes from ten to one thousand structures with five random seeds per size"`. Matches the polished v2 abstract framing that folds the three-surface enumeration under a colon.

2. **Abstract — reference-condition verb.** `"providing a reference condition against which the companion chemistry-shifted evaluation can be read"` → `"establishing the reference condition against which the companion chemistry-shifted evaluation is read"`. Crisper verb, drops the modal.

3. **Abstract — scope qualifier.** Removed the redundant `"within the tested range and protocol,"` that appeared before `"the choice of initialization is the dominant data-efficiency lever"`. Polished v2 drops this duplicate qualifier.

4. **Introduction — ALIGNN description.** `"ALIGNN sharpens this family by"` → `"ALIGNN refines this approach by"`. Matches the Phase 12B de-stylization recorded in polish notes §1.

5. **Introduction — JARVIS infrastructure clause.** `"which provides the dataset, the pretrained-model checkpoints, and the benchmark splits used throughout this report"` → `"which also supplies the benchmark splits used throughout this report"`. Matches the trimmed phrasing in polished v2 (polish notes §1).

6. **Introduction — benefit-survives clause.** `"Whether and how much of this benefit survives on a new target"` → `"How much of that benefit survives on a new target"`. Matches polish notes §1.

7. **Introduction — "What remains harder".** `"What remains harder to read off"` → `"What is harder to read off"`. Matches polish notes §1.

8. **Discussion §4.1 — antecedent clarity.** `"Read together, these establish"` → `"Read together, these three findings establish"`. Matches polish notes §2 (clearer antecedent).

9. **Conclusion paragraph 2 — practical reading cadence.** Triple-"that" comma chain (`"that the choice of initialization is…, that fine-tuning is…, that pretrained zero-shot is…"`) replaced with semicolon-separated three-part reading (`"the practical reading is threefold: …; …; and …"`). Matches polish notes §2.

10. **Conclusion paragraph 3 — reference-condition clause.** `"The broader role of these findings is to fix the reference condition for the project. The oxide arm is the case in which the pretrained representation is known to operate in the regime it was prepared for; it is the control without which… this report makes… an interpretable and quantifiable phenomenon"` → `"The broader role of these findings is to fix the project's reference condition. The oxide arm is the case in which the pretrained representation operates inside the regime it was prepared for — the control without which… this report renders… an interpretable, quantifiable phenomenon"`. Matches polish notes §2 (em-dash collapse, crisper verb).

---

## 2. nitride_template_ready_v2.md

**Source:** `nitride_polished_v2.md`  
**Target:** `nitride_template_ready_v2.md`

### Internal artifacts removed

1. **"Citation placeholders used in Results" block** (appeared at the end of §3.7 in both the v1 template_ready and the polished v2). This is a handover note from the reference-filling phase and must not appear in a submission-facing file. Block removed:
   > `**Citation placeholders used in Results:** [CITE: vanderMaaten2008_tSNE], [CITE: McInnes2018_UMAP], [CITE: Lee2021_TransferCGCNN], [CITE: Hu2024_DomainAdaptation]. Literature-heavier citation is deferred to the Introduction and Discussion, per the convention of keeping Results references minimal.`

### Prose synchronizations (polished v2 → v2 template_ready)

2. **Abstract — "still" softener removed.** `"the selected checkpoint is still the pretrained zero-shot state at every seed"` → `"the selected checkpoint is the pretrained zero-shot state at every seed"`. Categorical claim, not a temporal one (polish notes §3).

3. **Abstract — scoped closing.** `"Results support a domain-shift reading"` → `"Scoped to the tested regime, the evidence supports a domain-shift reading"`. Aligns abstract closing with oxide and combined abstract shape (polish notes §3).

4. **Introduction — ALIGNN description.** `"ALIGNN sharpens this family by"` → `"ALIGNN refines this approach by"`. Matches polish notes §1.

5. **Introduction — JARVIS infrastructure clause.** `"which provides the dataset, the pretrained-model checkpoints, and the benchmark splits used throughout this report"` → `"which also supplies the benchmark splits used throughout this report"`. Matches polish notes §1.

6. **Introduction — benefit-survives clause.** `"Whether and how much of this benefit survives on a new target"` → `"How much of that benefit survives on a new target"`. Matches polish notes §1.

7. **Introduction — "What remains harder".** `"What remains harder to read off"` → `"What is harder to read off"`. Matches polish notes §1.

8. **Introduction — "if it is read in isolation".** `"if it is read in isolation"` → `"if read in isolation"`. Polish notes §3.

9. **Introduction — self-reference.** `"against which this report's evidence is read"` → `"against which the present evidence is read"`. Polish notes §3.

10. **Introduction — RQ4 framing.** `"a correlational probe that is consistent with it rather than a causal proof"` → `"a correlational probe consistent with it"`. Drops redundant copula; the "not a causal proof" caveat is carried elsewhere (polish notes §3).

11. **Introduction — section-map verb.** `"Section 3 reports the behavioural evidence … and the representational evidence"` → `"Section 3 reports the behavioural evidence … together with the representational evidence"`. Signals that the representational evidence is a distinct surface (polish notes §3).

12. **Results §3.1 — verb variation.** `"§§3.2–3.3 evaluate whether fine-tuning"` → `"§§3.2–3.3 examine whether fine-tuning"`. Avoids "evaluate" repetition (polish notes §3).

13. **Discussion §4.1 — verb.** `"…reporting an optimizer that does not move off…"` → `"…showing an optimizer that does not move off…"`. More natural verb for what the signature demonstrates (polish notes §3).

14. **Conclusion — trailing restatement removed.** `"Stated more sharply: chemically distant targets require substantially more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do."` — In the polished v2 this sentence was removed; the preceding sentence already lands the point. Removed to match polished v2.

---

## 3. combined_template_ready_v2.md

**Source:** `combined_paper_polished_v2.md`  
**Target:** `combined_template_ready_v2.md`

### Internal artifacts removed

1. **Assembly note** (present in polished v2 but excluded from template_ready per project convention):
   > `**Assembly note.** Built from the approved component drafts on 2026-04-23. Figure and table insertion markers are preserved for manuscript assembly.`

2. **"Citation placeholders used in Results" block** (appeared at the end of §4.7 in both the v1 template_ready and the polished v2):
   > `**Citation placeholders used in Results:** [CITE: vanderMaaten2008_tSNE], …`

3. **"Evidence provenance for review" section** (table mapping sections to figure/table anchors, source packets, and primary numbers). This is a reviewer-facing internal review aid. Section and its table removed in full.

4. **"Known draft-stage caveats to resolve before assembly" section** (numbered list of 5 editorial/assembly instructions). This is an assembly-facing internal note. Section removed in full.

### Prose synchronizations (polished v2 → v2 template_ready)

5. **Introduction — JARVIS infrastructure clause.** `"which supplies the dataset, the pretrained-model checkpoints, and the benchmark splits used here"` → `"which also supplies the benchmark splits used here"`. Matches polish notes §1.

6. **Introduction — transfer-learning clause.** `"Transfer learning from pretrained crystal-graph models has been shown to reduce labelled-data requirements for downstream property tasks"` → `"…reduce labelled-data requirements on downstream property tasks"`. Also: `"The magnitude of that benefit, however, depends"` → `"The magnitude of that benefit depends"`. Matches polished v2 phrasing.

7. **Introduction — "What remains less standardized".** `"What remains less standardized"` → `"What is less standardized"`. Matches polish notes §1.

8. **Introduction — embedding analysis framing.** `"an interpretive probe consistent with or inconsistent with the behavioural picture"` → `"an interpretive probe consistent or inconsistent with the behavioural picture"`. Drops the redundant "with" (polished v2).

9. **Section V.A — closing sentence.** `"§IV introduces a correlational geometric counterpart that is consistent with the gap but does not explain it."` → `"§IV introduces a correlational geometric counterpart consistent with the gap but does not explain it."` Drops "that is" per polish notes §4.

10. **Discussion §VII.A — opening split into two sentences.** The polished v2 splits the long opening sentence at "arm." into two: the headline sentence and a separate "The gap between the two arms…" sentence. Combined template_ready v2 matches this split construction.

11. **Conclusion paragraph 2 — semicolon after "penalty".** `"…the same checkpoint incurs a 2× family-level zero-shot penalty, the canonical fine-tuning loop is operationally inert…"` → `"…the same checkpoint incurs a 2× family-level zero-shot penalty; the canonical fine-tuning loop is operationally inert…"` Matches polish notes §4 (semicolons between distinct findings).

12. **Conclusion paragraph 3 — practical reading cadence.** `"The combined practical reading is that the choice…, that zero-shot…, and that pretrained-space geometry…"` → `"The practical reading is that the choice…; that zero-shot…; and that pretrained-space geometry…"` Drops "combined", replaces commas with semicolons (polish notes §4).

13. **Conclusion final paragraph — split sentence.** `"…as a quantifiable, geometrically legible cost — one that, under the canonical protocol, separates… and that should therefore be planned for rather than discovered after the fact."` → `"…as a quantifiable, geometrically legible cost. Under the canonical protocol, that cost separates… — a cost that should be planned for rather than discovered after the fact."` Matches the polished v2 split-sentence construction (polish notes §4).

---

## Summary count

| File | Artifacts removed | Prose changes |
|------|:-----------------:|:-------------:|
| oxide_template_ready_v2.md | 0 | 10 |
| nitride_template_ready_v2.md | 1 | 13 |
| combined_template_ready_v2.md | 4 | 9 |
| **Total** | **5** | **32** |
