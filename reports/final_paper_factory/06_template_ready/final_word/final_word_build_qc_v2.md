# RES201 Final Word Documents — Quality Control Report v2
**Date:** 2026-04-24
**Documents inspected:** oxide_final_v2.docx · nitride_final_v2.docx · combined_final_v2.docx
**Method:** Automated scan of all paragraph and body elements in each document.

---

## Per-document QC metrics

### Oxide (`oxide_final_v2.docx` — 6,820,139 bytes)

| Item | Result |
|------|--------|
| 1. Unresolved `[TABLE: ...]` placeholders remaining | **0** ✓ |
| 2. Unresolved `[INSERT FIGURE ...]` placeholders remaining | **0** ✓ |
| 3. Unresolved `[CITE: ...]` citation placeholders remaining | **0** ✓ |
| 4. Affiliation placeholders remaining | **1** ⚠ |
| 5. Acknowledgements placeholders remaining | **0** ✓ |
| 6. Repository link present in document | **YES** ✓ |
| 7. Data and code availability section present | **YES** ✓ |
| 8. References section present | **YES** ✓ |
| 9. Missing figure images | **0** ✓ |
| 10. Total Word tables in document | 6 (4 new + 2 inline from v1) |

---

### Nitride (`nitride_final_v2.docx` — 7,179,584 bytes)

| Item | Result |
|------|--------|
| 1. Unresolved `[TABLE: ...]` placeholders remaining | **0** ✓ |
| 2. Unresolved `[INSERT FIGURE ...]` placeholders remaining | **0** ✓ |
| 3. Unresolved `[CITE: ...]` citation placeholders remaining | **0** ✓ |
| 4. Affiliation placeholders remaining | **1** ⚠ |
| 5. Acknowledgements placeholders remaining | **0** ✓ |
| 6. Repository link present in document | **YES** ✓ |
| 7. Data and code availability section present | **YES** ✓ |
| 8. References section present | **YES** ✓ |
| 9. Missing figure images | **0** ✓ |
| 10. Total Word tables in document | 7 (all new in v2) |

---

### Combined (`combined_final_v2.docx` — 7,794,989 bytes)

| Item | Result |
|------|--------|
| 1. Unresolved `[TABLE: ...]` placeholders remaining | **0** ✓ |
| 2. Unresolved `[INSERT FIGURE ...]` placeholders remaining | **0** ✓ |
| 3. Unresolved `[CITE: ...]` citation placeholders remaining | **0** ✓ |
| 4. Affiliation placeholders remaining | **1** ⚠ |
| 5. Acknowledgements placeholders remaining | **0** ✓ |
| 6. Repository link present in document | **YES** ✓ |
| 7. Data and code availability section present | **YES** ✓ |
| 8. References section present | **YES** ✓ |
| 9. Missing figure images | **0** ✓ |
| 10. Total Word tables in document | 16 (14 new + 2 inline from v1) |

---

## Notes on remaining items

### Item 4 — Affiliation placeholder (all three documents)

Current text in all three documents:
```
[Affiliation — confirm with authors; email domain: kfupm.edu.sa]
```
**Action required:** Replace with the exact institutional affiliation string. Based on email domains (`kfupm.edu.sa`) this is likely King Fahd University of Petroleum and Minerals (KFUPM); authors must confirm the full form (department, city, country) as required by JURI.

### Items not flagged by automated QC — require visual Word inspection

**In-text TAB_ID cross-references**  
Prose throughout the manuscripts contains backtick-formatted table ID strings (e.g., `` `TAB_METHODS_DATASET_SPLITS` ``, `` `TAB_S1_FT_SUMMARY_BY_N` ``). These were never replaced in the original manuscripts with sequential "Table N" labels. Use Word find-and-replace to update them. The table numbering per document is:

| Table ID | Oxide doc | Nitride doc | Combined doc (primary) |
|----------|-----------|-------------|----------------------|
| TAB_METHODS_DATASET_SPLITS | Table 1 | Table 1 | Table 1 |
| TAB_METHODS_EXPERIMENT_SCOPE | Table 2 | Table 2 | Table 2 |
| TAB_ZS_SUMMARY | Table 3 | Table 3 | Table 3, 5, 10 |
| TAB_S1_FT_SUMMARY_BY_N | (inline) | Table 4 | (inline), Table 6, 11 |
| TAB_S1_FS_SUMMARY | (inline) | Table 7 | (inline), Table 9, 12 |
| TAB_EA_FAMILY_SEPARATION | Table 4 | Table 5 | Table 4, 7, 13 |
| TAB_EA_DISTANCE_ERROR_STATS | — | Table 6 | Table 8, 14 |

**In-text FIG_ID cross-references**  
Similarly, backtick FIG_ID strings (e.g., `` `FIG_S1_LC_OXIDE` ``, `` `FIG_EA_6A_PCA` ``) remain in the prose. Replace with the sequential Figure N label assigned during the v1 build (see build_report.md §3).

**Inline table captions**  
The four Word tables derived from inline markdown (oxide §3.2 and §3.4; combined §3.2 and §3.4) have no captions in v2. Add "Table N." captions manually if required.

**Acknowledgements content**  
The current acknowledgements text is:
> The authors gratefully acknowledge use of the JARVIS infrastructure (https://jarvis.nist.gov) for datasets, pretrained models, and benchmark splits used throughout this work.

Add specific grant numbers, institutional support statements, and contributor acknowledgements.

**Table column widths**  
Tables with 6–7 columns (TAB_S1_FT_SUMMARY_BY_N, TAB_S1_FS_SUMMARY_BOTH, TAB_EA_DISTANCE_ERROR_STATS) may be narrow on A4 at default column widths. Adjust manually in Word using Table Properties → Column widths.

---

## Final verdict

| Document | Table placeholders resolved | Repo link | DCA section | Affiliation | Verdict |
|----------|:---------------------------:|:---------:|:-----------:|:-----------:|---------|
| oxide_final_v2.docx | ✓ | ✓ | ✓ | ⚠ pending | **READY for human Word QA pass** |
| nitride_final_v2.docx | ✓ | ✓ | ✓ | ⚠ pending | **READY for human Word QA pass** |
| combined_final_v2.docx | ✓ | ✓ | ✓ | ⚠ pending | **READY for human Word QA pass** |

**All automated blockers are resolved.** The only remaining mandatory pre-submission action is replacing the affiliation placeholder in each document. In-text TAB/FIG cross-reference updates and acknowledgements expansion are editorial tasks that do not block the QA pass.
