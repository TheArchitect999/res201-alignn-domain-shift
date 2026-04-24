# RES201 Final Word Documents — Build Changelog v2
**Date:** 2026-04-24
**Input documents:** oxide_final.docx · nitride_final.docx · combined_final.docx (from 05_final_docx/)
**Output documents:** oxide_final_v2.docx · nitride_final_v2.docx · combined_final_v2.docx

---

## Changes applied to all three documents

### 1. TAB_* placeholder replacement

Every `[TABLE: TAB_*]` Caption-style paragraph was replaced with an actual formatted Word table (Table Grid style, 9pt font) preceded by a numbered Caption-style caption.

**oxide_final_v2.docx — 4 tables created, 2 placeholders deleted:**

| Action | Table ID | Occurrence | Rows | Caption |
|--------|----------|-----------|------|---------|
| CREATED | TAB_METHODS_DATASET_SPLITS | 1 | 1 (oxide only) | Table 1. Dataset composition and split assignment. |
| CREATED | TAB_METHODS_EXPERIMENT_SCOPE | 1 | 20 (merged section headers + params) | Table 2. Hyperparameter Set 1 and experimental scope. |
| CREATED | TAB_ZS_SUMMARY | 1 | 1 (oxide only) | Table 3. Zero-shot evaluation results. |
| DELETED | TAB_S1_FT_SUMMARY_BY_N | 1 | — | Inline Word table from §3.2 markdown retained below |
| DELETED | TAB_S1_FS_SUMMARY | 1 | — | Inline Word table from §3.4 markdown retained below |
| CREATED | TAB_EA_FAMILY_SEPARATION | 1 | 8 | Table 4. Family-separation metrics in raw 256-D space. |

**nitride_final_v2.docx — 7 tables created, 0 placeholders deleted:**

| Action | Table ID | Occurrence | Rows | Caption |
|--------|----------|-----------|------|---------|
| CREATED | TAB_METHODS_DATASET_SPLITS | 1 | 1 (nitride only) | Table 1. Dataset composition and split assignment. |
| CREATED | TAB_METHODS_EXPERIMENT_SCOPE | 1 | 20 | Table 2. Hyperparameter Set 1 and experimental scope. |
| CREATED | TAB_ZS_SUMMARY | 1 | 2 (both families) | Table 3. Zero-shot evaluation results. |
| CREATED | TAB_S1_FT_SUMMARY_BY_N | 1 | 6 (nitride) | Table 4. Set 1 fine-tuning results by N. |
| CREATED | TAB_EA_FAMILY_SEPARATION | 1 | 8 | Table 5. Family-separation metrics. |
| CREATED | TAB_EA_DISTANCE_ERROR_STATS | 1 | 5 | Table 6. Distance–error association statistics. |
| CREATED | TAB_S1_FS_SUMMARY | 1 | 2 (nitride) | Table 7. Pretrained fine-tuning versus from-scratch. |

**combined_final_v2.docx — 14 tables created, 2 placeholders deleted:**

| Action | Table ID | Occurrence | Section | Rows |
|--------|----------|-----------|---------|------|
| CREATED | TAB_METHODS_DATASET_SPLITS | 1 | §2.3 | 2 (both families) |
| CREATED | TAB_METHODS_EXPERIMENT_SCOPE | 1 | §2.7 | 20 |
| CREATED | TAB_ZS_SUMMARY | 1 | §3.1 oxide | 2 (both) |
| DELETED | TAB_S1_FT_SUMMARY_BY_N | 1 | §3.2 oxide | Inline table retained |
| DELETED | TAB_S1_FS_SUMMARY | 1 | §3.4 oxide | Inline table retained |
| CREATED | TAB_EA_FAMILY_SEPARATION | 1 | §3.5 oxide | 8 |
| CREATED | TAB_ZS_SUMMARY | 2 | §4.1 nitride | 2 (both) |
| CREATED | TAB_S1_FT_SUMMARY_BY_N | 2 | §4.2 nitride | 6 (nitride) |
| CREATED | TAB_EA_FAMILY_SEPARATION | 2 | §4.4 nitride | 8 |
| CREATED | TAB_EA_DISTANCE_ERROR_STATS | 1 | §4.5 nitride | 5 |
| CREATED | TAB_S1_FS_SUMMARY | 2 | §4.6 nitride | 2 (nitride) |
| CREATED | TAB_ZS_SUMMARY | 3 | §V.III.A comparison | 2 (both) |
| CREATED | TAB_S1_FT_SUMMARY_BY_N | 3 | §V.III.B comparison | 12 (oxide+nitride) |
| CREATED | TAB_S1_FS_SUMMARY | 3 | §V.III.C comparison | 4 (oxide+nitride) |
| CREATED | TAB_EA_FAMILY_SEPARATION | 3 | §VI.B embedding | 8 |
| CREATED | TAB_EA_DISTANCE_ERROR_STATS | 2 | §VI.C distance | 5 |

### 2. Data and code availability section

A new "Data and code availability" section (Heading 1 style) was inserted in all three documents immediately before the References heading, after the Acknowledgements section. Text:

> Project code, analysis scripts, processed result summaries, figure-generation files, and manuscript-generation materials are available in the project repository: https://github.com/TheArchitect999/res201-alignn-domain-shift

---

## Retained unchanged from v1

- All 16 main-text figures (oxide: 8, nitride: 12, combined: 29 insertions).
- All Nature-style numbered reference lists (oxide: 12 refs, nitride: 11 refs, combined: 12 refs).
- All in-text citation markers `[n]` — 0 unresolved CITE placeholders.
- All scientific prose — no text rewritten.
- JURI template styles (Title, Heading 1–3, Normal, Caption, Table Grid).
- Inline Word tables converted from markdown in oxide §3.2, oxide §3.4, combined §3.2, combined §3.4.

---

## Inline tables without captions (not patched)

The four Word tables created by the v1 build script from inline markdown (fine-tuning MAE table in oxide §3.2, from-scratch comparison in oxide §3.4, and their counterparts in the combined oxide sections) do not have captions. These can be captioned manually in Word or via a further patch if required.

---

## Items still requiring manual Word work

1. **Author affiliation** — all three documents contain `[Affiliation — confirm with authors; email domain: kfupm.edu.sa]`. Replace with the exact institutional affiliation string before submission.
2. **In-text table cross-references** — prose contains backtick-formatted TAB_ID strings (e.g., `` `TAB_METHODS_DATASET_SPLITS` ``). Replace with "Table N" using Word find-and-replace after confirming sequential numbers.
3. **In-text figure cross-references** — prose contains backtick FIG_ID strings (e.g., `` `FIG_S1_LC_OXIDE` ``). Replace with "Figure N" using find-and-replace.
4. **Acknowledgements** — current text is a minimal standard line. Add specific grant numbers, institutional acknowledgements, and contributor thanks.
5. **Table column widths** — wider tables (TAB_S1_FT_SUMMARY_BY_N with 6 or 7 columns, TAB_S1_FS_SUMMARY with 5–6 columns) may need manual column-width adjustment in Word for print readability.
6. **Inline table captions** — the four markdown-derived inline tables in oxide §3.2/§3.4 and combined §3.2/§3.4 have no captions. Add "Table N." captions manually if required by the journal.
