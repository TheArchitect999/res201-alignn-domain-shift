# Requested Latest File Manifest

Date: 2026-04-23

This manifest maps the requested paper assets to the latest file(s) present in the local repository.

Selection rules used:
- Prefer explicit handoff / supersession notes over timestamps.
- Otherwise, prefer the highest `_vN` file.
- For manuscript prose, prefer the newer `04_drafts/*_edited.md` files over earlier `*_draft_vN.md` checkpoints when both exist.
- No newer copies of these items were found in `05_reviewed_drafts/`, `06_template_ready/`, or `07_final_qc/` beyond this manifest itself.

---

## 1. JURI Template

- `paper_sources/JURI_Template.docx`

---

## 2. Master Figure-Placement File

Primary latest file:
- `reports/final_paper_factory/02_figure_memos/figure_queue.md`

Companion machine-readable file:
- `reports/final_paper_factory/02_figure_memos/figure_queue.csv`

Why this was selected:
- `figure_queue.md` explicitly describes itself as the human-readable companion that lists figure source paths, report membership, and placement (`main text` vs `appendix`).

---

## 3. Shared Methods File

Primary latest shared methods file:
- `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton_v2.md`

Authority / supersession file used to confirm that choice:
- `reports/final_paper_factory/03_section_inputs/STAGE6_METHODS_HANDOFF_v2.md`

Related latest report-specific methods notes:
- `reports/final_paper_factory/03_section_inputs/oxide_methods_notes_v2.md`
- `reports/final_paper_factory/03_section_inputs/nitride_methods_notes_v2.md`
- `reports/final_paper_factory/03_section_inputs/combined_methods_notes_v2.md`

---

## 4. Opening Files

Important repo-structure note:
- The latest opening output is consolidated into one shared draft file rather than stored as three separate physical files.

Consolidated latest openings file:
- `reports/final_paper_factory/04_drafts/08_intros_titles_abstracts_keywords_v_2.md`

Within that file:
- Oxide opening content: Section `1`
- Nitride opening content: Section `2`
- Combined opening content: Section `3`

Stage 5 opening authority files:
- `reports/final_paper_factory/03_section_inputs/STAGE5_DRAFTING_HANDOFF.md`
- `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
- `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v4.md`
- `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`

Cross-report opening identity control:
- `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md`

### 4.1 Oxide Opening Package

- Latest opening draft location:
  - `reports/final_paper_factory/04_drafts/08_intros_titles_abstracts_keywords_v_2.md` (Section `1`)
- Stream blueprint:
  - `reports/final_paper_factory/01_blueprints/oxide_report_blueprint_v3.md`
- Shared Stage 5 opening authority:
  - `reports/final_paper_factory/03_section_inputs/STAGE5_DRAFTING_HANDOFF.md`
  - `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
  - `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v4.md`
  - `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`
- Closest reviewed manuscript context used by the opening draft:
  - `reports/final_paper_factory/04_drafts/01_methods_prose_edited.md`
  - `reports/final_paper_factory/04_drafts/02_oxide_results_edited.md`
  - `reports/final_paper_factory/04_drafts/05_oxide_discussion_conclusion_edited.md`

### 4.2 Nitride Opening Package

- Latest opening draft location:
  - `reports/final_paper_factory/04_drafts/08_intros_titles_abstracts_keywords_v_2.md` (Section `2`)
- Stream blueprint:
  - `reports/final_paper_factory/01_blueprints/nitride_report_blueprint_v3.md`
- Shared Stage 5 opening authority:
  - `reports/final_paper_factory/03_section_inputs/STAGE5_DRAFTING_HANDOFF.md`
  - `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
  - `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v4.md`
  - `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`
- Closest reviewed manuscript context used by the opening draft:
  - `reports/final_paper_factory/04_drafts/01_methods_prose_edited.md`
  - `reports/final_paper_factory/04_drafts/03_nitride_results_edited.md`
  - `reports/final_paper_factory/04_drafts/06_nitride_discussion_conclusion_edited.md`

### 4.3 Combined Opening Package

- Latest opening draft location:
  - `reports/final_paper_factory/04_drafts/08_intros_titles_abstracts_keywords_v_2.md` (Section `3`)
- Stream blueprint:
  - `reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md`
- Shared Stage 5 opening authority:
  - `reports/final_paper_factory/03_section_inputs/STAGE5_DRAFTING_HANDOFF.md`
  - `reports/final_paper_factory/03_section_inputs/literature_claim_map_v3.md`
  - `reports/final_paper_factory/03_section_inputs/introduction_paragraph_plan_v4.md`
  - `reports/final_paper_factory/03_section_inputs/citation_needed_list_v2.md`
- Cross-report identity control:
  - `reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md`
- Closest reviewed manuscript context used by the opening draft:
  - `reports/final_paper_factory/04_drafts/01_methods_prose_edited.md`
  - `reports/final_paper_factory/04_drafts/04_combined_results_III_IV_edited.md`
  - `reports/final_paper_factory/04_drafts/07_combined_discussion_conclusion_edited.md`

---

## 5. Results Files

### 5.1 Oxide Results

Latest edited manuscript file:
- `reports/final_paper_factory/04_drafts/02_oxide_results_edited.md`

Latest upstream section-input files:
- `reports/final_paper_factory/03_section_inputs/oxide_results_packet.md`
- `reports/final_paper_factory/03_section_inputs/oxide_analysis_packet.md`
- `reports/final_paper_factory/03_section_inputs/oxide_results_section_draft_v3.md`

### 5.2 Nitride Results

Latest edited manuscript file:
- `reports/final_paper_factory/04_drafts/03_nitride_results_edited.md`

Latest upstream section-input files:
- `reports/final_paper_factory/03_section_inputs/nitride_results_packet.md`
- `reports/final_paper_factory/03_section_inputs/nitride_analysis_packet.md`
- `reports/final_paper_factory/03_section_inputs/nitride_results_section_draft_v3.md`

### 5.3 Combined Results

Latest edited manuscript file:
- `reports/final_paper_factory/04_drafts/04_combined_results_III_IV_edited.md`

Latest upstream section-input files:
- `reports/final_paper_factory/03_section_inputs/joint_comparison_packet.md`
- `reports/final_paper_factory/03_section_inputs/embedding_interpretation_packet.md`
- `reports/final_paper_factory/03_section_inputs/combined_paper_results_III_and_IV_draft_v3.md`

---

## 6. Discussion / Conclusion Files

### 6.1 Oxide Discussion / Conclusion

Latest edited manuscript file:
- `reports/final_paper_factory/04_drafts/05_oxide_discussion_conclusion_edited.md`

Earlier checkpoints also present:
- `reports/final_paper_factory/04_drafts/oxide_discussion_conclusion_draft_v2.md`
- `reports/final_paper_factory/04_drafts/oxide_discussion_conclusion_draft_v1.md`

### 6.2 Nitride Discussion / Conclusion

Latest edited manuscript file:
- `reports/final_paper_factory/04_drafts/06_nitride_discussion_conclusion_edited.md`

Earlier checkpoints also present:
- `reports/final_paper_factory/04_drafts/nitride_discussion_conclusion_draft_v2.md`
- `reports/final_paper_factory/04_drafts/nitride_discussion_conclusion_draft_v1.md`

### 6.3 Combined Discussion / Conclusion

Latest edited manuscript file:
- `reports/final_paper_factory/04_drafts/07_combined_discussion_conclusion_edited.md`

Earlier checkpoints also present:
- `reports/final_paper_factory/04_drafts/combined_paper_discussion_conclusion_draft_v2.md`
- `reports/final_paper_factory/04_drafts/combined_paper_discussion_conclusion_draft_v1.md`

---

## 7. Short Active-Latest Summary

If you only want the top-level latest files to open first, start here:

- JURI template:
  - `paper_sources/JURI_Template.docx`
- Figure placement:
  - `reports/final_paper_factory/02_figure_memos/figure_queue.md`
- Shared methods:
  - `reports/final_paper_factory/03_section_inputs/shared_methods_skeleton_v2.md`
- Openings:
  - `reports/final_paper_factory/04_drafts/08_intros_titles_abstracts_keywords_v_2.md`
- Oxide results:
  - `reports/final_paper_factory/04_drafts/02_oxide_results_edited.md`
- Nitride results:
  - `reports/final_paper_factory/04_drafts/03_nitride_results_edited.md`
- Combined results:
  - `reports/final_paper_factory/04_drafts/04_combined_results_III_IV_edited.md`
- Oxide discussion / conclusion:
  - `reports/final_paper_factory/04_drafts/05_oxide_discussion_conclusion_edited.md`
- Nitride discussion / conclusion:
  - `reports/final_paper_factory/04_drafts/06_nitride_discussion_conclusion_edited.md`
- Combined discussion / conclusion:
  - `reports/final_paper_factory/04_drafts/07_combined_discussion_conclusion_edited.md`
