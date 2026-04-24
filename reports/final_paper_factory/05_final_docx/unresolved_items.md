# RES201 Final Documents — Unresolved Items
**Date:** 2026-04-24  
**Status:** These items require human decisions before the documents are submission-ready.

---

## Genuine Blockers (require decision before submission)

### 1. Author Affiliation Line — ALL THREE DOCUMENTS
**Location:** Author block, line 3 of each document (immediately below the author name line).  
**Current state:** Placeholder text: `[Affiliation — confirm with authors; email domain: kfupm.edu.sa]`  
**Required action:** Replace with the exact affiliation string. Based on the author email domains (`kfupm.edu.sa`), the affiliation is likely King Fahd University of Petroleum and Minerals (KFUPM), but the authors must confirm the exact institutional form, department name, and city/country as required by JURI.  
**Affects:** oxide_final.docx, nitride_final.docx, combined_final.docx

---

### 2. Formatted Data Tables — ALL THREE DOCUMENTS
**Location:** Every `[TABLE: TAB_X — formatted data table to be inserted here]` placeholder in each document.  
**Current state:** Placeholder text in Caption style. The following tables need to be created in Word:

| Table ID | Description | Appears in |
|----------|-------------|-----------|
| TAB_METHODS_DATASET_SPLITS | Family counts: train/val/test/pool per family | Oxide §2.3, Nitride §2.3, Combined §2.3 |
| TAB_METHODS_EXPERIMENT_SCOPE | Full experiment inventory: zero-shot + FT + scratch run counts | Oxide §2.6, Nitride §2.6, Combined §2.7 |
| TAB_ZS_SUMMARY | Zero-shot MAE comparison table | All three (repeated in combined) |
| TAB_S1_FT_SUMMARY_BY_N | Fine-tuning MAE by N, all seeds summary | All three (repeated in combined) |
| TAB_S1_FS_SUMMARY | From-scratch vs fine-tune summary at N=50, N=500 | All three (repeated in combined) |
| TAB_EA_FAMILY_SEPARATION | Silhouette, DB-index, 15-NN purity, AUC in raw 256-D space | Nitride §3.4, Combined §VI.B |
| TAB_EA_DISTANCE_ERROR_STATS | Hard/easy group distances, Spearman stats | Nitride §3.5, Combined §VI.C |

**Source data:** All underlying numbers are in `reports/Hyperparameter Set 1/Summaries/`, `reports/zero_shot/`, and `reports/week4_embedding_analysis/tables/`.  
**Note:** The inline markdown fine-tuning MAE table in oxide and nitride §3.2 (with `N`, `Runs`, `Mean test MAE`, `Std`, `Mean best epoch`, `Gap vs zero-shot` columns) IS already rendered as a Word table automatically.

---

### 3. In-Text Figure Cross-References — ALL THREE DOCUMENTS
**Location:** Throughout all documents wherever the text says "Figure `FIG_S1_LC_OXIDE`" or similar figure ID markers.  
**Current state:** The manuscript text contains figure ID references (e.g., "Figure `FIG_S1_LC_OXIDE`") that have NOT been renumbered to the sequential figure numbers generated during the build. These appear as `FIG_S1_LC_OXIDE` in backtick code-style formatting.  
**Required action:** Identify the sequential number assigned to each figure ID in each document (see build_report.md §3 figure table), then do a find-and-replace pass in Word. Example: in oxide_final.docx, `FIG_S1_LC_OXIDE` was assigned Figure 2, so all in-text references to `FIG_S1_LC_OXIDE` should become "Fig. 2" or "Figure 2".  
**Note:** This is the most labour-intensive manual step in the Word review pass.

---

## Non-Blocking Items (recommended but not required for submission)

### 4. Nitride — Missing Choudhary 2025 Citation
**Background:** `WD6C24D9` (Choudhary, K. *Comput. Mater. Sci.* **259**, 114063 (2025) — "The JARVIS Infrastructure is All You Need for Materials Design") appears in the citation map for `nitride_report` under placeholder `[CITE: Choudhary & DeCost 2021; Choudhary 2025]`. However, this placeholder does not appear in the nitride manuscript file on disk. The build correctly omits it; the nitride reference list has 11 entries.  
**Action options:**  
(a) Accept the current 11-reference list as correct per the manuscript.  
(b) If the citation should be present in the nitride manuscript (§4.4 embedding discussion), manually add the citation in Word and add the reference as entry 12.  
**Affected file:** nitride_final.docx only.

### 5. Combined Paper — Repeated Figure Insertions
**Background:** The combined paper's manuscript has `[INSERT FIGURE FIG_X HERE]` markers in three places (oxide results section, nitride results section, comparative section), so many figures are inserted multiple times. The build log shows 29 figure insertions for the combined paper.  
**Action options:**  
(a) Keep all insertions as-is (figures appear where the manuscript instructs).  
(b) Remove repeated insertions and replace subsequent occurrences with "see Figure N above."  
**Affected file:** combined_final.docx only.

### 6. Acknowledgements — Expand with Funding Details
**Current state:** A brief standard acknowledgement line is provided: "The authors gratefully acknowledge use of the JARVIS infrastructure..."  
**Required addition:** Specific grant numbers, institutional support, and any contributor thanks must be added manually in Word.

### 7. Figure Captions — Verify Against Actual Figures
**Background:** Captions were written based on manuscript context and the figure inventory. Authors should verify that each caption accurately describes the specific version of the figure in the file (axis labels, colour coding, statistical annotations).

### 8. Reference Double-Period Check
**Background:** Nature format generates `Authors. Title. Journal...`. If any title ends in a period, a double-period would result. None of the 14 Zotero items has a trailing period in the title field, but visually inspect the reference list in each document.

---

## No Blockers for These Items
- All 16 main-text figures: **resolved** (core_figures directory, all PNGs present).
- All citations: **resolved** (0 `[CITE: ...]` markers remain in all three documents; 0 `[?]` unresolved markers).
- JURI template styles: **applied** (page size A4, margins inherited, Heading 1–3/Normal/Caption styles active).
- Nature-style reference formatting: **applied** (journal names in italics, author initials, et al. for >6 authors).
- Li et al. 2025 disambiguation: **applied** (Li K. et al. = QGDLHVAF; Li Q. et al. = 7STQCC9U throughout).
- UMAP year: **correct** (Zotero N7UREDXA issued = 2018; rendered as McInnes et al. 2018).
- t-SNE reference: **correct** (TVLLPSQ9 = van der Maaten & Hinton 2008, JMLR 9:2579–2605).
