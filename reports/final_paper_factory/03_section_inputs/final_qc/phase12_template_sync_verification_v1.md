---
name: Phase 12 Template Sync Verification
description: Confirms preservation of numbers, markers, and placeholders, and removal of internal artifacts, in each template-ready v2 file.
type: project
---

# Phase 12 Template Sync Verification (v1)

Verification date: 2026-04-23  
Verifies: `06_template_ready/*_template_ready_v2.md`  
Against source: `04_drafts/phase12_full_manuscripts/*_polished_v2.md`

---

## 1. oxide_template_ready_v2.md

### Numbers preserved

All grounded numbers from `oxide_polished_v2.md` are present and unaltered:

- Zero-shot MAE: **0.0342 eV/atom** (oxide test set, n = 1 484)
- Fine-tuning table: all six `N`-level rows with mean MAE, std MAE, mean best epoch, and gap-vs-zero-shot values preserved exactly (0.0417 / 0.0111 / 1.0 / +0.0075; 0.0523 / 0.0148 / 18.5 / +0.0181; 0.0465 / 0.0086 / 20.0 / +0.0123; 0.0457 / 0.0086 / 39.0 / +0.0115; 0.0430 / 0.0062 / 39.0 / +0.0088; 0.0417 / 0.0053 / 35.5 / +0.0075)
- From-scratch table: N=50 (0.0523 ± 0.0148 vs 0.5561 ± 0.0523; gaps +0.5038, +0.5219); N=500 (0.0430 ± 0.0062 vs 0.2643 ± 0.0228; gaps +0.2214, +0.2301)
- Parity endpoints: on-figure MAE 0.0391 and 0.0383 eV/atom; R² 0.9944 and 0.9943
- Embedding metrics: 15-NN purity oxide 0.9872; oxide silhouette 0.2546; nitride silhouette 0.1453; family AUC 0.9994; overall 15-NN purity 0.9655
- Dataset counts: 14 991 structures (11 960 / 1 547 / 1 484); pool 13 507; oxynitrides 499

### Figure markers preserved

All `[INSERT FIGURE FIG_* HERE]` markers present:
`FIG_SCHEMATIC`, `FIG_S1_LC_OXIDE`, `FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_OXIDE_N1000`, `FIG_S1_COMP_OXIDE`, `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP` ✓

### Table markers preserved

All `[INSERT TABLE TAB_* HERE]` markers present:
`TAB_METHODS_DATASET_SPLITS`, `TAB_METHODS_EXPERIMENT_SCOPE`, `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_FAMILY_SEPARATION` ✓

### Citation placeholders preserved

All `[CITE: …]` tokens present and unaltered throughout Introduction, Methods, Results, and Discussion. No placeholders added or removed. ✓

### Acknowledgements and references placeholders preserved

`[ACKNOWLEDGEMENTS PLACEHOLDER — insert funding, institutional support, and contributor thanks here.]` ✓  
`[REFERENCES PLACEHOLDER — insert JURI/Nature-formatted references here.]` ✓

### Internal review artifacts removed

No internal artifacts were present in the v1 oxide template_ready. Confirmed clean. ✓

### Wording synchronized to polished v2 source

All 10 prose changes documented in the changelog are reflected in the v2 file:
- Abstract: "we combine three measurement surfaces:" ✓
- Abstract: "establishing the reference condition" ✓
- Introduction: "ALIGNN refines this approach by" ✓
- Introduction: "which also supplies the benchmark splits" ✓
- Introduction: "How much of that benefit survives" ✓
- Introduction: "What is harder to read off" ✓
- Discussion §4.1: "these three findings establish" ✓
- Conclusion para 2: semicolon-separated threefold reading ✓
- Conclusion para 3: "fix the project's reference condition" and em-dash construction ✓
- Conclusion para 3: "renders … an interpretable, quantifiable phenomenon" ✓

### Unresolved ambiguities

None. The oxide file is clean and fully synchronized.

---

## 2. nitride_template_ready_v2.md

### Numbers preserved

All grounded numbers from `nitride_polished_v2.md` are present and unaltered:

- Zero-shot MAE: **0.0695 eV/atom** (nitride test set, n = 242); oxide comparator 0.0342 eV/atom
- Fine-tuning table: all six `N`-level rows preserved (0.0874 / 0.0199 / 1.0; 0.1173 / 0.0451 / 1.0; 0.1722 / 0.0996 / 1.0; 0.1392 / 0.0677 / 1.0; 0.0977 / 0.0178 / 40.5; 0.0907 / 0.0135 / 45.0)
- High-N gaps vs zero-shot: 0.0281 eV/atom at N=500; 0.0211 eV/atom at N=1000
- Parity endpoints: N=10 → 0.0828 / 0.1203 / 0.9841; N=1000 → 0.0829 / 0.1220 / 0.9837
- From-scratch table: N=50 (0.6914 ± 0.0163; gap 0.5741; scratch-zero-shot 0.6219); N=500 (0.3683 ± 0.0233; gap 0.2706; scratch-zero-shot 0.2987)
- Embedding metrics: overall silhouette 0.2392 (CI 0.2332–0.2456); oxide silhouette 0.2546 (CI 0.2476–0.2617); nitride silhouette 0.1453 (CI 0.1316–0.1582); Davies–Bouldin 1.8290 (CI 1.7340–1.9071); 15-NN purity overall 0.9655 (CI 0.9603–0.9708); oxide 0.9872 (CI 0.9832–0.9906); nitride 0.8331 (CI 0.7978–0.8645); AUC 0.9994 (CI 0.9984–0.9999)
- Distance–error stats: hard mean 5NN dist 4.5988; easy mean 3.7821; gap 0.8168 (CI 0.4746–1.1597, q = 1.8 × 10⁻⁴); Spearman 0.3428 (CI 0.2214–0.4597, q = 1.3 × 10⁻⁴); Pearson 0.2770
- Dataset counts: 2 288 structures (1 837 / 209 / 242); pool 2 046; oxynitrides 0

### Figure markers preserved

All `[INSERT FIGURE FIG_* HERE]` markers present:
`FIG_SCHEMATIC`, `FIG_ZS_COMPARISON`, `FIG_S1_LC_NITRIDE` (×2 references), `FIG_S1_PARITY_NITRIDE_N10`, `FIG_S1_PARITY_NITRIDE_N1000`, `FIG_S1_COMP_NITRIDE`, `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER` ✓

### Table markers preserved

All `[INSERT TABLE TAB_* HERE]` markers present:
`TAB_METHODS_DATASET_SPLITS`, `TAB_METHODS_EXPERIMENT_SCOPE`, `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_FAMILY_SEPARATION`, `TAB_EA_DISTANCE_ERROR_STATS` ✓

### Citation placeholders preserved

All `[CITE: …]` tokens present and unaltered (Introduction, Methods, Results discussion text, Discussion). The internal-use `[CITE: vanderMaaten2008_tSNE]` etc. block that was at the end of §3.7 has been removed as an artifact — those same citations appear correctly in the Discussion body text where they belong. ✓

### Acknowledgements and references placeholders preserved

`[ACKNOWLEDGEMENTS PLACEHOLDER — insert funding, institutional support, and contributor thanks here.]` ✓  
`[REFERENCES PLACEHOLDER — insert JURI/Nature-formatted references here.]` ✓

### Internal review artifacts removed

1. **"Citation placeholders used in Results" block** at end of §3.7 — removed ✓

### Wording synchronized to polished v2 source

All 14 prose changes documented in the changelog (items 2–14) are reflected in the v2 file:
- Abstract: "the selected checkpoint is the pretrained zero-shot state" (no "still") ✓
- Abstract: "Scoped to the tested regime, the evidence supports" ✓
- Introduction: "ALIGNN refines this approach by" ✓
- Introduction: "which also supplies the benchmark splits" ✓
- Introduction: "How much of that benefit survives" ✓
- Introduction: "What is harder to read off" ✓
- Introduction: "if read in isolation" ✓
- Introduction: "against which the present evidence is read" ✓
- Introduction: "a correlational probe consistent with it" ✓
- Introduction: "together with the representational evidence" ✓
- Results §3.1: "§§3.2–3.3 examine whether fine-tuning" ✓
- Discussion §4.1: "showing an optimizer that does not move off" ✓
- Conclusion: trailing "Stated more sharply:" sentence removed ✓

### Unresolved ambiguities

None. The nitride file is clean and fully synchronized.

---

## 3. combined_template_ready_v2.md

### Numbers preserved

All grounded numbers from `combined_paper_polished_v2.md` are present and unaltered:

- Zero-shot MAE: oxide 0.0342 eV/atom (n = 1 484); nitride 0.0695 eV/atom (n = 242)
- Zero-shot gap: 0.0354 eV/atom; ratio 2.03×
- Oxide fine-tuning table: all six `N`-level rows preserved identically (matches oxide arm above)
- Nitride fine-tuning table: all six `N`-level rows preserved identically (matches nitride arm above)
- Family gap in fine-tuned MAE: 0.0457 eV/atom at N=10; 0.1257 eV/atom at N=100
- From-scratch table (both families): all four rows (N=50 and N=500 for oxide and nitride) preserved
- Oxide transfer benefits: 0.5038 and 0.2214 eV/atom; nitride: 0.5741 and 0.2706 eV/atom
- Endpoint parity: oxide N=1000 MAE 0.0383; nitride N=1000 MAE 0.0829
- PCA variance: 18.13 % PC1; 9.47 % PC2; 27.60 % cumulative; balanced pool 4 092 structures
- Family-separation analysis set: 1 726 structures (1 484 + 242); oxide-reference pool 13 507
- Embedding metrics: all values match nitride arm table (identical numbers from shared embedding run)
- Distance–error stats: all values match nitride arm table

### Figure markers preserved

All `[INSERT FIGURE FIG_* HERE]` markers present:
`FIG_SCHEMATIC`, `FIG_S1_LC_OXIDE`, `FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_OXIDE_N1000`, `FIG_S1_COMP_OXIDE`, `FIG_ZS_COMPARISON`, `FIG_S1_LC_NITRIDE`, `FIG_S1_PARITY_NITRIDE_N10`, `FIG_S1_PARITY_NITRIDE_N1000`, `FIG_S1_COMP_NITRIDE`, `FIG_TRANSFER_BENEFIT`, `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, `FIG_EA_6D_SCATTER` ✓

### Table markers preserved

All `[INSERT TABLE TAB_* HERE]` markers present (some referenced multiple times across sections, all instances preserved):
`TAB_METHODS_DATASET_SPLITS`, `TAB_METHODS_EXPERIMENT_SCOPE`, `TAB_ZS_SUMMARY` (×3 references), `TAB_S1_FT_SUMMARY_BY_N` (×3 references), `TAB_S1_FS_SUMMARY` (×2 references), `TAB_EA_FAMILY_SEPARATION` (×2 references), `TAB_EA_DISTANCE_ERROR_STATS` ✓

### Citation placeholders preserved

All `[CITE: …]` tokens present and unaltered throughout Introduction, Methods (§2.5 criterion discrepancy note), Results, and Discussion. Note: `[CITE: PROJECT_BRIEF]`, `[CITE: ALIGNN_PAPER]`, `[CITE: JARVIS_INFRA]`, `[CITE: WEEK2_ASSIGNMENT]`, `[CITE: KIM2024]`, `[CITE: LEE_ASAHI2021]` retained as they appear in the polished v2. ✓

### Acknowledgements and references placeholders preserved

`[ACKNOWLEDGEMENTS PLACEHOLDER — insert funding, institutional support, and contributor thanks here.]` ✓  
`[REFERENCES PLACEHOLDER — insert JURI/Nature-formatted references here.]` ✓

### Internal review artifacts removed

1. **Assembly note** header block — removed ✓
2. **"Citation placeholders used in Results" block** at end of §4.7 — removed ✓
3. **"Evidence provenance for review" section** (full table with 6 data rows) — removed ✓
4. **"Known draft-stage caveats to resolve before assembly" section** (numbered list of 5 items) — removed ✓

### Wording synchronized to polished v2 source

All 9 prose changes documented in the changelog (items 5–13) are reflected in the v2 file:
- Introduction: "which also supplies the benchmark splits used here" ✓
- Introduction: "reduce labelled-data requirements on downstream property tasks" ✓
- Introduction: "The magnitude of that benefit depends" (no "however") ✓
- Introduction: "What is less standardized" ✓
- Introduction: "an interpretive probe consistent or inconsistent" ✓
- Section V.A: "a correlational geometric counterpart consistent with the gap" ✓
- Discussion §VII.A: two-sentence split construction ✓
- Conclusion para 2: semicolon after "zero-shot penalty;" ✓
- Conclusion para 3: semicolons, drop "combined", "The practical reading is that" ✓
- Conclusion final para: split at "cost." + new sentence "Under the canonical protocol, that cost separates…" ✓

### Unresolved ambiguities

**One item flagged for human review** (unchanged from the note in `phase12_style_polish_notes_v1.md` §5):

- The word "discrete" in §4.3 (`"indicates a discrete transition"`) may read as "quantized" in a materials-physics context. Preferred alternatives are "sharp" or "step-wise". This was not changed in this sync pass because it is present verbatim in the polished v2 source and any word-level change would constitute new drafting beyond the scope of a sync operation. A human editor should resolve this before submission.

All other items listed in `phase12_style_polish_notes_v1.md` §5 (workflow artefacts, harmonization candidates, remaining style items) that were already resolved in the polished v2 drafts are confirmed resolved in the v2 template-ready files.

---

## Cross-file verification summary

| Check | oxide_v2 | nitride_v2 | combined_v2 |
|-------|:---------:|:----------:|:-----------:|
| Numbers preserved | ✓ | ✓ | ✓ |
| Figure markers preserved | ✓ | ✓ | ✓ |
| Table markers preserved | ✓ | ✓ | ✓ |
| Citation placeholders preserved | ✓ | ✓ | ✓ |
| Acknowledgements placeholder | ✓ | ✓ | ✓ |
| References placeholder | ✓ | ✓ | ✓ |
| Internal review artifacts removed | ✓ (none present) | ✓ (1 removed) | ✓ (4 removed) |
| Wording synchronized to polished v2 | ✓ | ✓ | ✓ |
| Unresolved ambiguities | none | none | 1 (see above) |

**Overall status: PASS.** All three template-ready v2 files are submission-facing, JURI-aligned versions of their respective polished v2 drafts.
