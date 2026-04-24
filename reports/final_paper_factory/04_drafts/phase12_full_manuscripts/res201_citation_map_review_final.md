# RES201 Citation Map Review — Final
**Generated:** 2026-04-24  
**Source manuscripts:** oxide_polished_v3.md, nitride_polished_v3.md, combined_paper_polished_v4.md  
**Zotero export:** res201_final_refs.json (14 items; UMAP issued field corrected to 2018)  
**Changes from v2:** Li et al. 2025 disambiguation applied throughout CSV; UMAP year confirmed in Zotero. No further pre-build actions required.

---

## Blocker Status

**No blockers remain.** All 64 citation slots across all three manuscripts are fully resolved to Zotero items with complete metadata. The Li et al. 2025 pair is disambiguated throughout the map. The UMAP year is confirmed as 2018 in the Zotero library. The map is ready for the citation-insertion build stage.

---

## Zotero Library Index (Final)

| Short ID | Authors | Year | Title (abbreviated) | Journal |
|----------|---------|------|---------------------|---------|
| VNA4JJ3A | Omee et al. | 2024 | Structure-based OOD materials property prediction: a benchmark study | npj Comput Mater |
| NLBNY4TV | Hu et al. | 2024 | Realistic material property prediction using domain adaptation | Digital Discovery |
| E9PT9HW4 | Kim et al. | 2024 | Predicting melting temperature via crystal GNN enhanced by transfer learning | Comput Mater Sci |
| EIITR8T3 | Lee & Asahi | 2021 | Transfer learning for materials informatics using TL-CGCNN | Comput Mater Sci |
| 4K3VGEUE | Xie & Grossman | 2018 | Crystal Graph Convolutional Neural Networks (CGCNN) | Phys Rev Lett |
| DKG62IFQ | Chen et al. | 2019 | Graph Networks as a Universal ML Framework for Molecules and Crystals (MEGNet) | Chem Mater |
| WD6C24D9 | Choudhary | 2025 | The JARVIS Infrastructure is All You Need for Materials Design | Comput Mater Sci |
| ZNSBRAGX | Choudhary et al. | 2024 | JARVIS-Leaderboard: a large scale benchmark of materials design methods | npj Comput Mater |
| TR6CHAD2 | Choudhary et al. | 2020 | The joint automated repository for various integrated simulations (JARVIS) | npj Comput Mater |
| U9NHTD8R | Choudhary & DeCost | 2021 | Atomistic Line Graph Neural Network (ALIGNN) | npj Comput Mater |
| 7STQCC9U | Li, Qinyang et al. | 2025 | Out-of-Distribution Material Property Prediction Using Adversarial Learning | J Phys Chem C |
| QGDLHVAF | Li, Kangming et al. | 2025 | Probing out-of-distribution generalization in machine learning for materials | Commun Mater |
| N7UREDXA | McInnes et al. | 2018 | UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction | arXiv:1802.03426 |
| TVLLPSQ9 | van der Maaten & Hinton | 2008 | Visualizing Data using t-SNE | J Mach Learn Res 9:2579–2605 |

**Note:** DKG62IFQ (MEGNet, Chen et al. 2019) is in the library but is not used by any placeholder in these manuscripts. It was the candidate considered for `[CITE: crystal graph baseline]` in v1 but superseded by the author decision to use CGCNN + ALIGNN.

---

## 1. Changes Applied from v1 to v2 (Unchanged in Final)

### 1A. `[CITE: crystal graph baseline for materials property prediction]` — resolved

**Decision:** CGCNN (4K3VGEUE) + ALIGNN (U9NHTD8R).

**Rationale:** Citing both papers names the class through its two most directly relevant exemplars within the manuscript context — the model already under study (ALIGNN) and the foundational baseline it improves on (CGCNN). CGCNN also appears one sentence later as the "canonical early exemplar" with `[CITE: CGCNN foundational paper]`; the two appearances are independent claims (class-level introduction vs. historical specifics) and the repetition is consistent with standard academic practice.

**Affects:** oxide §1, nitride §1, combined §I — 3 rows. Status changed from NEEDS_REVIEW → RESOLVED_MULTI.

---

### 1B. `[CITE: transfer learning in materials informatics]` — resolved

**Decision:** Lee & Asahi 2021 (EIITR8T3) + Kim et al. 2024 (E9PT9HW4).

**Rationale:** These are the same papers cited as `[CITE: Lee & Asahi 2021; Kim et al. 2024]` in Discussion §4.2 of both the oxide and combined manuscripts, anchoring the same general transfer-learning claim. The vague Introduction placeholder is now the consistent early-citation form of the pair.

**Affects:** oxide §1, nitride §1, combined §I — 3 rows. Status changed from NEEDS_REVIEW → RESOLVED_MULTI.

---

### 1C. `[CITE: domain shift or OOD benchmark in materials property prediction]` — resolved

**Decision:** Omee et al. 2024 (VNA4JJ3A) + Li, Kangming et al. 2025 OOD (QGDLHVAF).

**Rationale:** The Introduction citation sits at a "failure mode is concrete" claim; the two benchmark/evaluation papers (comprehensive GNN OOD benchmark; OOD generalization probing) directly make the failure mode concrete. The two method papers in the library (7STQCC9U adversarial learning; NLBNY4TV domain adaptation) propose solutions rather than demonstrating the failure and are better suited to the Discussion sections where they already appear explicitly.

**Affects:** oxide §1, nitride §1, combined §I — 3 rows. Status changed from NEEDS_REVIEW → RESOLVED_MULTI. The four-paper cluster used in v1 is now trimmed to two at the Introduction.

---

### 1D. `[CITE: van der Maaten & Hinton 2008; McInnes et al. 2018]` — blocker resolved

**Resolution:** Zotero item HQBXJ4GH (title-only, no metadata) was replaced by TVLLPSQ9 with full metadata: van der Maaten, Laurens & Hinton, Geoffrey (2008). *Visualizing Data using t-SNE*. *Journal of Machine Learning Research*, 9, 2579–2605. ISSN 1532-4435.

**UMAP year:** The Zotero item N7UREDXA `issued` field has been corrected to 2018, matching the arXiv identifier 1802.03426 (February 2018) and the placeholder text "McInnes et al. 2018" in all three manuscripts. No year override is required at the build stage.

**Affects:** oxide §4.4, nitride §4.4, combined §VI.A, combined §VII.6 — 4 rows. Status changed from NEEDS_REVIEW → RESOLVED_MULTI.

---

### 1E. `[CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]` — internal handles normalized

These internal citation key handles appear in nitride §3.6 and combined §IV.4.6. They are already mapped to the correct Zotero items (EIITR8T3 and NLBNY4TV). The `notes` column in the CSV records this for the build stage.

**Affects:** 2 rows. Status was already RESOLVED_MULTI; notes column updated.

---

## 2. Placeholders Resolved in Both v1 and v2 (Unchanged)

These were already cleanly mapped in v1 and are unchanged in the final map.

| Placeholder | Zotero IDs | Status |
|-------------|-----------|--------|
| `[CITE: CGCNN foundational paper]` | 4K3VGEUE | RESOLVED |
| `[CITE: ALIGNN foundational paper]` | U9NHTD8R | RESOLVED |
| `[CITE: JARVIS dataset/repository paper]` | TR6CHAD2 | RESOLVED |
| `[CITE: JARVIS 2020 dataset/repository paper]` | TR6CHAD2 | RESOLVED |
| `[CITE: Choudhary & DeCost 2021 — ALIGNN]` | U9NHTD8R | RESOLVED |
| `[CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]` | ZNSBRAGX | RESOLVED |
| `[CITE: Choudhary et al. 2020 — JARVIS; Choudhary et al. 2024 — JARVIS-Leaderboard]` | TR6CHAD2; ZNSBRAGX | RESOLVED_MULTI |
| `[CITE: Lee & Asahi 2021; Kim et al. 2024]` | EIITR8T3; E9PT9HW4 | RESOLVED_MULTI |
| `[CITE: Lee & Asahi 2021; Kim et al. 2024; Hu et al. 2024]` | EIITR8T3; E9PT9HW4; NLBNY4TV | RESOLVED_MULTI |
| `[CITE: Lee & Asahi 2021; Hu et al. 2024]` | EIITR8T3; NLBNY4TV | RESOLVED_MULTI |
| `[CITE: Choudhary et al. 2020 — JARVIS; Choudhary & DeCost 2021 — ALIGNN]` | TR6CHAD2; U9NHTD8R | RESOLVED_MULTI |
| `[CITE: Choudhary & DeCost 2021; Choudhary 2025]` | U9NHTD8R; WD6C24D9 | RESOLVED_MULTI |
| `[CITE: Omee et al. 2024; Li et al. 2025 — OOD; Hu et al. 2024]` | VNA4JJ3A; QGDLHVAF; NLBNY4TV | RESOLVED_MULTI |
| `[CITE: Omee et al. 2024; Li et al. 2025 — OOD; Li et al. 2025 — adversarial; Hu et al. 2024]` | VNA4JJ3A; QGDLHVAF; 7STQCC9U; NLBNY4TV | RESOLVED_MULTI |
| `[CITE: Omee et al. 2024; Li et al. 2025 — OOD; Li et al. 2025 — adversarial]` | VNA4JJ3A; QGDLHVAF; 7STQCC9U | RESOLVED_MULTI |
| `[CITE: Omee et al. 2024; Li et al. 2025 — adversarial]` | VNA4JJ3A; 7STQCC9U | RESOLVED_MULTI |
| `[CITE: Omee et al. 2024; Li et al. 2025 — OOD]` | VNA4JJ3A; QGDLHVAF | RESOLVED_MULTI |
| `[CITE: Xie & Grossman 2018 — CGCNN; Choudhary & DeCost 2021 — ALIGNN; Choudhary et al. 2020 — JARVIS; Choudhary et al. 2024 — JARVIS-Leaderboard]` | 4K3VGEUE; U9NHTD8R; TR6CHAD2; ZNSBRAGX | RESOLVED_MULTI |

---

## 3. Duplicate Placeholder Strings That Map to the Same Paper(s)

These pairs use different placeholder text in the manuscripts but resolve to identical Zotero items. The build stage must assign them the same citation key.

| Placeholder A | Placeholder B | Shared Zotero IDs |
|---------------|---------------|-------------------|
| `[CITE: JARVIS dataset/repository paper]` | `[CITE: JARVIS 2020 dataset/repository paper]` | TR6CHAD2 |
| `[CITE: ALIGNN foundational paper]` | `[CITE: Choudhary & DeCost 2021 — ALIGNN]` | U9NHTD8R |
| `[CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]` | `[CITE: Lee & Asahi 2021; Hu et al. 2024]` | EIITR8T3; NLBNY4TV |
| `[CITE: crystal graph baseline for materials property prediction]` (v2) | `[CITE: CGCNN foundational paper]` (one component) | 4K3VGEUE appears in both |

The last entry is expected: CGCNN appears in the "crystal graph baseline" cluster citation and again standalone. No deduplication is needed — both are intentional and functionally independent.

---

## 4. Li et al. 2025 Disambiguation — Applied

Both Li et al. 2025 papers shared the same author-year string in author-year styles. Disambiguation has been applied consistently throughout the citation map using first-initial form.

| Zotero ID | First author | Applied in-text label |
|-----------|-------------|----------------------|
| QGDLHVAF | Li, Kangming | **Li K. et al.** (2025) — "Probing out-of-distribution generalization in machine learning for materials" |
| 7STQCC9U | Li, Qinyang | **Li Q. et al.** (2025) — "Out-of-Distribution Material Property Prediction Using Adversarial Learning" |

All `zotero_authors` cells in the CSV now use `Li K. et al.` and `Li Q. et al.` respectively. The placeholder suffixes "— OOD" and "— adversarial" remain in the `placeholder_text` column for traceability but must not appear in formatted citations. Apply the same K./Q. labels in the Word reference list and bibliography.

---

## 5. UMAP Year Discrepancy — Resolved

The Zotero item N7UREDXA `issued` field has been corrected to 2018 in the re-exported library, matching both the arXiv identifier (1802.03426 = February 2018) and the placeholder text "McInnes et al. 2018" in all three manuscripts. No year override is required at the build stage; the library is authoritative.

---

## 6. Unused Zotero Item

DKG62IFQ (Chen et al. 2019, MEGNet) is present in the Zotero library but is not used by any placeholder in the final citation map. It was considered for `[CITE: crystal graph baseline]` in v1 but superseded by the author's CGCNN + ALIGNN decision. It can remain in the library without impact.

---

## Summary

| Metric | v1 | v2 | Final |
|--------|----|----|-------|
| Total placeholder occurrences (rows) | 64 | 64 | 64 |
| RESOLVED | 26 | 26 | 26 |
| RESOLVED_MULTI | 25 | 38 | 38 |
| NEEDS_REVIEW | 13 | 0 | 0 |
| Hard blockers | 1 (HQBXJ4GH missing metadata) | 0 | 0 |
| Remaining pre-build actions | — | UMAP year correction in Zotero | **None** |
