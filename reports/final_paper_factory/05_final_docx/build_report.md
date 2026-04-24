# RES201 Final Document Build Report
**Build date:** 2026-04-24  
**Builder:** build_docx.py (python-docx 1.2.0)  
**Output directory:** `reports/final_paper_factory/05_final_docx/`

---

## 1. Files Used as Sources

| Role | File |
|------|------|
| Oxide manuscript | `reports/final_paper_factory/04_drafts/phase12_full_manuscripts/oxide_polished_v3.md` |
| Nitride manuscript | `reports/final_paper_factory/04_drafts/phase12_full_manuscripts/nitride_polished_v3.md` |
| Combined manuscript | `reports/final_paper_factory/04_drafts/phase12_full_manuscripts/combined_paper_polished_v4.md` |
| JURI template | `paper_sources/JURI_Template.docx` |
| Zotero library | `reports/final_paper_factory/05_final_docx/res201_final_refs.json` (14 items) |
| Citation map | `reports/final_paper_factory/04_drafts/phase12_full_manuscripts/res201_citation_map_final.csv` |
| Figures | `reports/final_paper_factory/02_figure_memos/core_figures/` (all 16 main-text PNGs confirmed present) |

---

## 2. Citation Insertion

**Method:** Single-pass sequential processing of each manuscript. `[CITE: ...]` placeholders were matched against `res201_citation_map_final.csv` using exact string lookup. Citations are numbered in order of first appearance. Multiple Zotero IDs per placeholder are assigned consecutive numbers. The same Zotero ID reuses its assigned number on repeat citation.

**Format:** Nature-style numbered in-text citations `[1]`, `[1,2]`, `[1,2,3]`. Reference list in Nature format: `Authors. Title. *Journal* Volume, pages (Year).` Journal abbreviations rendered in italics. UMAP (preprint) formatted as `Authors. Title. Preprint at https://arxiv.org/abs/1802.03426 (2018).`

**Author name formatting:** Initials derived from given names. Names with non-dropping particles handled correctly (e.g., `van der Maaten, L.`). Author lists with >6 authors use `et al.` (JARVIS-Leaderboard with 38 authors: `Choudhary, K. et al.`).

**Citation counts per document:**

| Document | Unique Zotero IDs cited | References in list |
|----------|------------------------|-------------------|
| oxide_final.docx | 12 / 12 in map | 12 |
| nitride_final.docx | 11 / 12 in map | 11 |
| combined_final.docx | 12 / 12 in map | 12 |

**Nitride discrepancy:** `WD6C24D9` (Choudhary, K. *Comput. Mater. Sci.* 2025 — "The JARVIS Infrastructure is All You Need for Materials Design") is in the citation map for `nitride_report` (row: §4.4, `[CITE: Choudhary & DeCost 2021; Choudhary 2025]`) but the placeholder does not appear in the nitride manuscript on disk. The build correctly uses only what is present in the source file; this entry does not appear in the nitride reference list. See `unresolved_items.md` item 4.

---

## 3. Figure Resolution

**Source directory:** `reports/final_paper_factory/02_figure_memos/core_figures/`  
**Method:** Each `[INSERT FIGURE FIG_X HERE]` marker is replaced with the corresponding PNG at 5.8-inch width, centred, followed by a descriptive caption in Word `Caption` style.

**All 16 main-text figures resolved from core_figures:**

| Figure ID | Source filename | Oxide | Nitride | Combined |
|-----------|----------------|-------|---------|----------|
| FIG_SCHEMATIC | FIG_SCHEMATIC.png | Fig 1 | Fig 1 | Fig 1 |
| FIG_ZS_COMPARISON | FIG_ZS_COMPARISON.png | — | Fig 2 | Fig 7, 17† |
| FIG_TRANSFER_BENEFIT | FIG_TRANSFER_BENEFIT.png | — | — | Fig 20 |
| FIG_S1_LC_OXIDE | FIG_S1_LC_OXIDE.png | Fig 2 | — | Fig 2, 18† |
| FIG_S1_LC_NITRIDE | FIG_S1_LC_NITRIDE.png | — | Fig 3, 4† | Fig 8, 19† |
| FIG_S1_COMP_OXIDE | FIG_S1_COMP_OXIDE.png | Fig 5 | — | Fig 21 |
| FIG_S1_COMP_NITRIDE | FIG_S1_COMP_NITRIDE.png | — | Fig 12 | Fig 22 |
| FIG_S1_PARITY_OXIDE_N10 | FIG_S1_PARITY_OXIDE_N10.png | Fig 3 | — | Fig 3 |
| FIG_S1_PARITY_OXIDE_N1000 | FIG_S1_PARITY_OXIDE_N1000.png | Fig 4 | — | Fig 4, 23† |
| FIG_S1_PARITY_NITRIDE_N10 | FIG_S1_PARITY_NITRIDE_N10.png | — | Fig 5 | Fig 9 |
| FIG_S1_PARITY_NITRIDE_N1000 | FIG_S1_PARITY_NITRIDE_N1000.png | — | Fig 6 | Fig 10, 24† |
| FIG_EA_6A_PCA | FIG_EA_6A_PCA.png | Fig 6 | Fig 7 | Fig 6, 11, 25† |
| FIG_EA_6B_TSNE | FIG_EA_6B_TSNE_P30.png | Fig 7 | Fig 8 | Fig 12, 26† |
| FIG_EA_6C_UMAP | FIG_EA_6C_UMAP_N30.png | Fig 8 | Fig 9 | Fig 13, 27† |
| FIG_EA_6D_BOXPLOT | FIG_EA_6D_KNN5_BOXPLOT.png | — | Fig 10 | Fig 14, 28† |
| FIG_EA_6D_SCATTER | FIG_EA_6D_KNN5_SCATTER.png | — | Fig 11 | Fig 15, 29† |

†The combined paper inserts figures at every `[INSERT FIGURE FIG_X HERE]` marker in the source — which appears multiple times because the manuscript repeats the same figures in the oxide results section, the nitride results section, and the comparative/embedding sections. This matches the manuscript instructions. Authors should decide whether to retain all insertions or cross-reference using "see Figure N" on repeats.

**Captions:** Descriptive captions derived from figure inventory and manuscript context. Authors should verify caption wording against final figure content and adjust as needed.

---

## 4. Formatting Limitations and Automatic Handling

| Item | How handled |
|------|-------------|
| Pandoc not installed | Built with python-docx 1.2.0 directly from markdown |
| JURI template styles inherited | Template loaded via `Document(template_path)`; all body content cleared; JURI styles (`Title`, `Heading 1–3`, `Caption`, `Normal`, `List Paragraph`) applied throughout |
| Inline bold `**text**` | Converted to bold runs |
| Inline italic `*text*` | Converted to italic runs |
| Inline code `` `text` `` | Converted to Courier New 9pt runs |
| Markdown tables (pipe format) | Converted to Word tables with Table Grid style; header row set to bold |
| `[INSERT TABLE TAB_X HERE]` | Replaced with a `Caption`-styled placeholder line: `[TABLE: TAB_X — formatted data table to be inserted here]`. Tables requiring formatted data (like the fine-tuning MAE summary) must be formatted manually in Word. The inline markdown tables in §3.2 of oxide and nitride ARE converted automatically. |
| `---` horizontal rules | Silently removed (no Word equivalent needed) |
| Author block replacement | "First Author Name*..." lines replaced with actual author name, affiliation placeholder, email, and ORCID |
| `[ACKNOWLEDGEMENTS PLACEHOLDER]` | Replaced with brief standard acknowledgement text citing JARVIS infrastructure |
| `[REFERENCES PLACEHOLDER]` | Replaced with auto-generated Nature-style numbered reference list |
| `List Number` style absent from JURI template | Numbered list items rendered as `List Paragraph` style with number prefix preserved in text |
| Unicode characters in headings | Preserved correctly in document XML; any terminal display artefacts are encoding-only |
| Journal names in references | Rendered in italic using separate Word runs (structurally correct italics, not Markdown) |
| Reference number prefix spacing | Standard `. ` separator between number and reference text |

---

## 5. Items Still Requiring Manual Word Inspection

1. **Formatted data tables** — All `[TABLE: TAB_X — formatted data table to be inserted here]` placeholders must be replaced with properly formatted Word tables. There are 5 such placeholders in oxide, 6 in nitride, and 10 in combined. The inline MAE summary tables embedded in the Results sections as markdown pipes ARE rendered automatically.

2. **Figure caption numbers** — Auto-numbered sequentially within each document from Figure 1. In the combined paper, figures are counted per insertion point including repeats. Authors should reconcile figure numbering against any cross-references in the text (which still say "Figure `FIG_S1_LC_OXIDE`" style). A find-and-replace pass in Word is needed to update all in-text figure references to match the sequential numbers.

3. **Author affiliation** — Inserted as `[Affiliation — confirm with authors; email domain: kfupm.edu.sa]`. Replace with the exact institutional affiliation line.

4. **Acknowledgements** — Replaced with a brief standard line. Authors should expand with specific grant numbers, institutional acknowledgements, and contributor thanks.

5. **Figure captions** — Descriptive captions are provided but should be reviewed for exactness against the published figure content, especially axis labels, panel labels (A/B/C/D), and statistical annotation details.

6. **Reference double-period** — Nature format produces `Authors. Title. Journal...` with a double-period before the journal name when the title ends in a period (none in this library). Check for any trailing period artefacts in the final reference list.

7. **Combined paper figure repeats** — Recommend a final editorial pass to remove or replace duplicate figure insertions with cross-references.

8. **Style fine-tuning** — Font size, paragraph spacing, line spacing, and column layout should be verified against the JURI submission guidelines. The template's page layout (A4, margins 1.00" L / 0.71" R / 1.00" T / 1.25" B) is inherited and correct.
