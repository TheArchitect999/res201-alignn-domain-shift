# nitride_final_v3.docx — QC Report
**Date:** 2026-04-24
**Input:** nitride_final_v2.docx
**Output:** nitride_final_v3.docx

## Patch operations

- DELETED duplicate Figure 4 block: body indices [77, 78, 79] (image + caption + spacer)
-   Caption renumbered: Figure 5 -> Figure 4 | 'Figure 5. Nitride parity plot at N = 10. Seed-averaged predi'
-   Caption renumbered: Figure 6 -> Figure 5 | 'Figure 6. Nitride parity plot at N = 1,000. Seed-averaged pr'
-   Caption renumbered: Figure 7 -> Figure 6 | 'Figure 7. PCA projection of frozen last_alignn_pool embeddin'
-   Caption renumbered: Figure 8 -> Figure 7 | 'Figure 8. t-SNE projection of frozen last_alignn_pool embedd'
-   Caption renumbered: Figure 9 -> Figure 8 | 'Figure 9. UMAP projection of frozen last_alignn_pool embeddi'
-   Caption renumbered: Figure 10 -> Figure 9 | 'Figure 10. Distance–error boxplot. Hard (top 20% absolute ze'
-   Caption renumbered: Figure 11 -> Figure 10 | 'Figure 11. Distance–error scatter plot. 5-nearest-oxide-refe'
-   Caption renumbered: Figure 12 -> Figure 11 | 'Figure 12. Nitride Set 1 pretrained fine-tuning vs from-scra'
- Total figure captions renumbered: 8
-   Token replacement in para: 'We preserve the original JARVIS benchmark split identities (provided:manifests/d'
-   Token replacement in para: 'The primary reported metric is test-set MAE in eV/atom; checkpoint selection use'
-   Token replacement in para: 'On matched evaluation, the pretrained formation-energy ALIGNN checkpoint attains'
-   Token replacement in para: 'We compare mean test MAE across five seeds at N ∈ {10, 50, 100, 200} against the'
-   Token replacement in para: 'At N = 500, mean_best_epoch jumps to 40.5 and mean test MAE is 0.0977 ± 0.0178 e'
-   Token replacement in para: 'We characterize whether oxides and nitrides occupy distinguishable regions of th'
-   Token replacement in para: 'Computed in raw 256-D space across the fixed test set (Table 5), the overall sil'
-   Token replacement in para: 'At the tails (Table 6, Figure 9), the hard group has mean 5-nearest-oxide distan'
-   Token replacement in para: 'At the two N values with matched from-scratch runs (Table 7, Figure 11), nitride'
- Summary paragraph replaced with clean version.
- Prose paragraphs with token replacements: 9
- Summary paragraph replaced: True
- Saved: C:\Users\lenovo\res201-alignn-domain-shift\reports\final_paper_factory\06_template_ready\final_word\nitride_final_v3.docx

## QC results

| Check | Result |
|-------|--------|
| Duplicate Figure 4 removed | YES ✓ |
| Figure captions renumbered | 8 captions updated |
| Sequential figure numbering (1–11) | YES ✓ |
| Summary paragraph replaced | YES ✓ |
| Remaining TAB_* tokens | 0 ✓ |
| Remaining FIG_* tokens | 0 ✓ |
| Remaining [INSERT...] placeholders | 0 ✓ |

## Figure caption index

| # | Caption (truncated) |
|---|---------------------|
| 1 | Figure 1. Study design overview. The pretrained formation-energy ALIGNN model is |
| 2 | Figure 2. Zero-shot MAE comparison. Same pretrained checkpoint evaluated on the  |
| 3 | Figure 3. Nitride Set 1 fine-tuning learning curve. Mean test MAE ± 1 SD (five s |
| 4 | Figure 4. Nitride parity plot at N = 10. Seed-averaged predictions vs DFT format |
| 5 | Figure 5. Nitride parity plot at N = 1,000. Seed-averaged predictions vs DFT for |
| 6 | Figure 6. PCA projection of frozen last_alignn_pool embeddings (balanced pool, 4 |
| 7 | Figure 7. t-SNE projection of frozen last_alignn_pool embeddings (balanced pool; |
| 8 | Figure 8. UMAP projection of frozen last_alignn_pool embeddings (balanced pool;  |
| 9 | Figure 9. Distance–error boxplot. Hard (top 20% absolute zero-shot error, n = 49 |
| 10 | Figure 10. Distance–error scatter plot. 5-nearest-oxide-reference distance vs ab |
| 11 | Figure 11. Nitride Set 1 pretrained fine-tuning vs from-scratch at N = 50 and N  |

## Verdict

**PASS — nitride_final_v3.docx is ready for human Word QA pass.**