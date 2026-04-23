# Phase 13 Final Patch Verification

Date: 2026-04-24

---

## oxide_polished_v3.md

| Check | Status | Notes |
|---|---|---|
| Numbers preserved | PASS | All MAE, SD, gap, epoch, silhouette, AUC values verified unchanged |
| Figure markers preserved | PASS | All `[INSERT FIGURE ... HERE]` markers intact |
| Table markers preserved | PASS | All `[INSERT TABLE ... HERE]` markers intact |
| Standard `[CITE: ...]` placeholders preserved | PASS | No scholarly citation tokens altered |
| Internal workflow artifacts removed | PASS | Assembly note removed in v2; none remain |
| Nitride conclusion fixed | N/A | Oxide report; not applicable |
| Combined-paper critical cleanup | N/A | Oxide report; not applicable |
| Remaining deferred items | Front-matter placeholders (lines 5, 7), acknowledgements, references, appendix figure IDs for parity panels |

---

## nitride_polished_v3.md

| Check | Status | Notes |
|---|---|---|
| Numbers preserved | PASS | All MAE, SD, gap, epoch, Spearman ρ, FDR q, distance values verified unchanged |
| Figure markers preserved | PASS | All `[INSERT FIGURE ... HERE]` markers intact |
| Table markers preserved | PASS | All `[INSERT TABLE ... HERE]` markers intact |
| Standard `[CITE: ...]` placeholders preserved | PASS | No scholarly citation tokens altered |
| Internal workflow artifacts removed | PASS | Assembly note and handover paragraph removed in v2; none remain |
| Nitride conclusion fixed | PASS | Overclaiming cross-family sentence removed; replaced with within-family evidence-bounded language (later adaptation onset, larger residual gap, best adapted config still above zero-shot) |
| Pretraining-regime inference softened | PASS | "consistent with a pretraining regime more aligned with oxides than nitrides" replaced with observation-bounded language consistent with the later limitation §4.6 |
| Combined-paper critical cleanup | N/A | Nitride report; not applicable |
| Remaining deferred items | Front-matter placeholders, acknowledgements, references, appendix figure IDs for distance-analysis alternative definitions |

---

## combined_paper_polished_v3.md

| Check | Status | Notes |
|---|---|---|
| Numbers preserved | PASS | All MAE, SD, gap, epoch, embedding metrics, PCA variance values (18.13 %, 9.47 %, 27.60 %), Spearman ρ, FDR q-values unchanged |
| Figure markers preserved | PASS | All `[INSERT FIGURE ... HERE]` markers intact |
| Table markers preserved | PASS | All `[INSERT TABLE ... HERE]` markers intact |
| Standard `[CITE: ...]` placeholders preserved | PASS | Scholarly `[CITE: ...]` tokens preserved throughout; only internal non-scholarly tokens replaced (see below) |
| Internal workflow artifacts removed (A) | PASS | Assembly note removed in v2; internal handover paragraph removed in v2; Evidence provenance block removed in v2; no review-only material remains |
| Internal citation tokens cleaned (C) | PASS | `ALIGNN_PAPER` → `ALIGNN foundational paper`; `JARVIS_INFRA` → `JARVIS dataset/repository paper`; `PROJECT_BRIEF` removed (sentence recast to self-reference §2.1); `KIM2024; LEE_ASAHI2021` → `Lee & Asahi 2021; Kim et al. 2024`; `WEEK2_ASSIGNMENT` → `van der Maaten & Hinton 2008; McInnes et al. 2018` |
| Raw-space wording fixed (D) | PASS | "All statistical claims" narrowed to "All inferential claims"; PCA variance values explicitly noted as projection-derived descriptors |
| Pretraining-regime inference softened (E) | PASS | §4.1 inference softened to observation-bounded language; matches nitride standalone treatment |
| Numbering harmonized (F) | PASS | §VI subsections renamed VI.A–VI.E; §VII subsections converted to 7.1–7.9; all cross-references updated |
| Nitride conclusion | N/A | Conclusion fix applied in nitride standalone; combined paper conclusion sentence is a different claim (deferred) |
| Remaining deferred items | Front-matter placeholders; acknowledgements; references; combined conclusion sentence about "moving below a pretrained baseline" (line ~440) deferred to Phase 13C; appendix figure anchor references; `smooth adaptation` in combined abstract deferred to Phase 13C |

---

## Summary of remaining open items (intentionally deferred to final citation / Word stage)

| Item | File(s) | Why deferred |
|---|---|---|
| Front-matter placeholders (author, affiliation, email) | All three | Requires author confirmation |
| Acknowledgements text | All three | Requires funding/contributor confirmation |
| References section | All three | Requires Zotero export and JURI/Nature formatting |
| All `[CITE: ...]` placeholder tokens | All three | Require Zotero key mapping (Phase 12 intent) |
| Combined conclusion sentence: "the labelled-data cost of moving below a pretrained baseline is substantially higher than chemistry-aligned task experience would predict" | Combined | Flagged as potentially overreaching; needs Phase 13C ChatGPT verdict before rewrite |
| `smooth adaptation` in combined abstract | Combined | The oxide learning curve has an N=50 penalty before monotonic recovery; deferred to Phase 13C for targeted rewrite |
| Appendix figure IDs for generic "see appendix" references | Oxide (§3.3), nitride (§3.5, §4.4), combined (§5.3, §7.7) | Appendix namespace not yet finalized |
| Combined paper subsection §V (Results III) labels III.A–III.E | Combined | Retained as Results-III ordinal labels; will resolve naturally if results sections are renumbered in JURI template |
