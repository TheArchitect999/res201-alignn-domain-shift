# Figure Memo Audit

**Date:** 2026-04-22
**Scope:** All 16 core main-text figures in `figure_queue.csv` / `figure_queue.md`
**Auditor:** Claude Code (claude-sonnet-4-6)

---

## Summary Verdict

The memo set is in good shape. All 16 core figures have memos. All memos carry appropriate Non-Claims / Cautions sections. No figure requires reclassification from main text to appendix or vice versa. Two figures warrant a placement-choice note (FIG_EA_6D dual-variant), and four memos carry specific caution flags that should travel into prose drafting.

No appendix figure memos exist at this stage. This is expected at Phase 4.

---

## Coverage Check

| # | Figure Label | Memo File | Coverage |
|---|---|---|---|
| 01 | `FIG_SCHEMATIC` | `fig01_study_design_schematic_memo.md` | ✓ |
| 02 | `FIG_S1_LC_OXIDE` | `fig02_oxide_learning_curve_memo.md` | ✓ |
| 03 | `FIG_S1_LC_NITRIDE` | `fig03_nitride_learning_curve_memo.md` | ✓ |
| 04 | `FIG_ZS_COMPARISON` | `fig04_zero_shot_family_comparison_memo.md` | ✓ |
| 05 | `FIG_TRANSFER_BENEFIT` | `fig05_transfer_benefit_comparison_memo.md` | ✓ |
| 05a | `FIG_S1_COMP_OXIDE` | `fig05a_oxide_comparison_plot_memo.md` | ✓ |
| 05b | `FIG_S1_COMP_NITRIDE` | `fig05b_nitride_comparison_plot_memo.md` | ✓ |
| 06 | `FIG_S1_PARITY_OXIDE_N10` | `fig06_oxide_lowN_parity_memo.md` | ✓ |
| 07 | `FIG_S1_PARITY_OXIDE_N1000` | `fig07_oxide_highN_parity_memo.md` | ✓ |
| 08 | `FIG_S1_PARITY_NITRIDE_N10` | `fig08_nitride_lowN_parity_memo.md` | ✓ |
| 09 | `FIG_S1_PARITY_NITRIDE_N1000` | `fig09_nitride_highN_parity_memo.md` | ✓ |
| 10 | `FIG_EA_6A_PCA` | `fig10_embedding_pca_memo.md` | ✓ |
| 11 | `FIG_EA_6B_TSNE` | `fig11_embedding_tsne_memo.md` | ✓ |
| 12 | `FIG_EA_6C_UMAP` | `fig12_embedding_umap_memo.md` | ✓ |
| 13 | `FIG_EA_6D_KNN5_BOXPLOT` | `fig13_nitride_distance_error_memo.md` | ✓ |
| 13b | `FIG_EA_6D_KNN5_SCATTER` | `fig13b_nitride_distance_error_scatter_memo.md` | ✓ |

**Coverage: 16/16 core figures have memos.**

Appendix figures: 20 figures, 0 memos. No memos expected at Phase 4.

---

## Queue State Update

The three figures previously marked `to_be_created` in the original `figure_queue.csv` have been created and are now listed as `exists` in both `figure_queue.csv` and `figure_queue.md`. Their source paths point to `core_figures/`.

| Figure | New Status | Files Present |
|---|---|---|
| `FIG_SCHEMATIC` | exists | `FIG_SCHEMATIC.png` |
| `FIG_ZS_COMPARISON` | exists | `FIG_ZS_COMPARISON.png`, `.svg` |
| `FIG_TRANSFER_BENEFIT` | exists | `FIG_TRANSFER_BENEFIT.png`, `.svg`, `.pdf` |

The presence of `.svg` and `.pdf` formats for FIG_ZS_COMPARISON and FIG_TRANSFER_BENEFIT is an asset for final formatting; no action needed.

---

## Scientific Caution Audit

Each memo is evaluated against five criteria:
1. Does it correctly state what the figure shows vs what it does not show?
2. Does it carry the required guardrail language where one exists?
3. Does it accurately match the canonical numbers?
4. Does it avoid over-claiming causation in correlational results?
5. Does it respect scope limitations (from-scratch N=50/N=500 only; nitride N≤200 inertness)?

---

### fig01 — FIG_SCHEMATIC

**Rating: Pass.**
- Pure framing figure; no empirical claims ✓
- Explicitly states that from-scratch is limited to N=50 and N=500 ✓
- Explicitly states the correct checkpoint description ("pretrained formation-energy ALIGNN model") ✓
- Correctly flags that schematic drawings inside workflow boxes are illustrations, not data ✓

---

### fig02 — FIG_S1_LC_OXIDE

**Rating: Pass.**
- Correctly states that the oxide curve does not beat zero-shot at any N ✓
- Correctly flags that N=10 mean_best_epoch=1.0 is a low-motion checkpoint, not adaptation ✓
- Correctly limits scope to Set 1 ✓

**Minor language note (figure_queue purpose field):** The queue says "shows smooth adaptation from N≥50". This is accurate — the curve does show a smooth improvement trajectory from N=50 onward — but it does not mean the curve beats zero-shot. If this language appears in a figure caption or results sentence, the zero-shot ceiling caveat must accompany it. The memo makes this clear.

---

### fig03 — FIG_S1_LC_NITRIDE

**Rating: Pass, with one prose-drafting risk to carry forward.**
- Correctly flags that N≤200 is operationally inert (mean_best_epoch=1.0 at all four sizes) ✓
- Correctly states that N≤200 rows remain **worse** than nitride zero-shot, not equal to it ✓
- Correctly flags N=500 and N=1000 as the adaptation-onset regime ✓

**Prose-drafting risk (Priority: High):** The memo states: "These rows can be described as operationally inert or early-checkpoint fine-tuning, but they should not be described as preserving zero-shot performance, because all four rows remain worse than the zero-shot baseline."

This distinction — inert ≠ zero-shot-preserved — is easy to lose in prose. Mean best epoch = 1.0 means the validation-selected checkpoint is epoch 1, but the actual MAEs (0.0874 at N=10 through 0.1392 at N=200) are all substantially worse than nitride zero-shot (0.0695). Any draft sentence claiming low-N nitride "reverts to the zero-shot state" or "retains zero-shot accuracy" must be rejected.

**Drafting instruction added to audit:** Low-N nitride inertness means checkpoint selection is frozen at epoch 1, not that performance is preserved at zero-shot level. The correct framing is: "fine-tuning is inert and the model underperforms its own zero-shot baseline."

---

### fig04 — FIG_ZS_COMPARISON

**Rating: Pass.**
- Correctly limits the figure to establishing the baseline gap, not explaining it ✓
- Single-point values (no uncertainty intervals) are acknowledged as a limitation ✓
- Values verified: oxide 0.0342 eV/atom, nitride 0.0695 eV/atom ✓

---

### fig05 — FIG_TRANSFER_BENEFIT

**Rating: Pass, with one prose-drafting risk to carry forward.**
- Correctly scoped to N=50 and N=500 only ✓
- Nitride N=50 initialization-advantage caveat is present in the memo and reportedly marked on the figure itself ✓
- Values verified:
  - Oxide N=50: scratch 0.5561 − FT 0.0523 = 0.5038 ≈ 0.504 ✓
  - Nitride N=50: scratch 0.6914 − FT 0.1173 = 0.5741 ≈ 0.574 ✓
  - Oxide N=500: scratch 0.2643 − FT 0.0430 = 0.2213 ≈ 0.221 ✓
  - Nitride N=500: scratch 0.3683 − FT 0.0977 = 0.2706 ≈ 0.271 ✓

**Prose-drafting risk (Priority: High):** The nitride N=50 bar is taller than the oxide N=50 bar (0.574 vs 0.504). A careless draft could read this as "nitrides show greater transfer benefit" or "nitrides adapt more effectively from pretraining." The memo explicitly counters this: "the nitride bars are slightly taller than the oxide bars... but that does not mean nitrides adapt better overall. It means the scratch-to-fine-tune gap is larger in absolute MAE terms for nitrides... Because the nitride scratch baseline is worse." Every Results or Discussion sentence referencing the cross-family bar-height comparison must include this mechanism.

**Prose-drafting risk (Priority: High):** Nitride N=50 bar must never appear without the exact caveat: "pretrained initialization advantage over scratch, not fine-tuning adaptation."

---

### fig05a — FIG_S1_COMP_OXIDE

**Rating: Pass.**
- Correctly limits comparison to N=50 and N=500 ✓
- Correctly preserves the zero-shot ceiling observation ✓
- Values verified against summary tables ✓

---

### fig05b — FIG_S1_COMP_NITRIDE

**Rating: Pass, with guardrail confirmation.**
- Correctly identifies N=50 as mean_best_epoch=1.0 (initialization advantage, not adaptation) ✓
- Correctly identifies N=500 as the first clean comparison between a genuinely fine-tuned and from-scratch model ✓
- Correctly states that neither fine-tuned point beats nitride zero-shot ✓
- Values verified ✓

---

### fig06 — FIG_S1_PARITY_OXIDE_N10

**Rating: Pass.**
- Correctly flags mean_best_epoch=1.0 ✓
- Correctly explains the on-figure MAE vs summary-table MAE aggregation difference (0.0391 ensemble vs 0.0417 per-seed mean) ✓
- Correctly states that visual parity quality does not override the learning-curve ceiling result ✓

**Note for all parity memos:** All four main-text parity memos correctly document the seed-aggregation distinction: the on-figure MAE is computed from predictions averaged across seeds first, while the summary table reports the mean of per-seed MAEs. These two values are not interchangeable. Prose must be specific about which aggregation is being cited.

---

### fig07 — FIG_S1_PARITY_OXIDE_N1000

**Rating: Pass.**
- Correctly states oxide N=1000 does not beat zero-shot ✓
- Correctly identifies that the main N=10→N=1000 gain is reproducibility (std: 0.0111→0.0053), not headline MAE ✓
- On-figure MAE changes from 0.0391 (N=10) to 0.0383 (N=1000): modest improvement ✓

---

### fig08 — FIG_S1_PARITY_NITRIDE_N10

**Rating: Pass.**
- The memo explicitly states: "both the on-figure ensemble MAE (0.0828) and the per-seed mean MAE (0.0874) sit above the nitride zero-shot MAE (0.0695)" ✓
- "Should not be used to claim total model collapse" — correctly notes the parity trend is still visible, just degraded ✓
- Correctly flags that the low-N behavior is inert/early-checkpoint, not successful adaptation ✓

---

### fig09 — FIG_S1_PARITY_NITRIDE_N1000

**Rating: Pass, with one prose-drafting risk to carry forward.**
- Correctly states that N=1000 does not beat zero-shot ✓
- Values: on-figure MAE 0.0829 (N=1000) vs 0.0828 (N=10) — essentially unchanged ✓

**Prose-drafting risk (Priority: Medium):** The headline parity MAE at N=1000 (0.0829 on-figure, 0.0907 per-seed) is essentially identical to N=10 (0.0828 on-figure, 0.0874 per-seed). A draft sentence like "the N=1000 nitride parity plot shows much-improved accuracy relative to N=10" would be inaccurate. The correct emphasis is: the improvement is in training depth (mean_best_epoch 1.0→45.0) and reproducibility (std 0.0199→0.0135), not headline error.

**Drafting instruction:** When presenting the nitride N=1000 parity panel, emphasize that the model is now genuinely fine-tuned and more reproducible, but explicitly state that headline MAE is essentially unchanged from N=10. Do not frame this as a large visual accuracy improvement.

---

### fig10 — FIG_EA_6A_PCA

**Rating: Pass.**
- Correctly states metrics are in raw 256d space, not 2D PCA projection ✓
- Correctly states the separation is partial, not complete ✓
- Correctly identifies the asymmetry: nitride silhouette (0.145) < oxide silhouette (0.255) ✓
- Logistic-regression AUC 0.9994 is presented alongside the lower silhouette scores to prevent over-reading the AUC alone ✓

---

### fig11 — FIG_EA_6B_TSNE

**Rating: Pass.**
- Carries the required t-SNE-specific caution: figure does not justify physical or metric interpretation of axes ✓
- Correctly warns against reading visual compactness as raw-space cohesion: "This figure does not justify claiming that nitrides are more cohesive than oxides based on apparent visual compactness; the raw-space silhouette and kNN-purity values indicate the opposite." ✓
- Correctly states that the metrics cited are from raw 256d space, not the projection ✓

**Important caution to preserve in prose:** t-SNE can make the nitride cluster appear compact and well-separated in the 2D view. The raw-space quantitative metrics tell a different story — nitride silhouette (0.145) is much lower than oxide (0.255), and nitride 15-NN purity (0.833) is lower than oxide (0.987). Any prose sentence about the t-SNE figure must not claim nitride cohesion or compactness in absolute terms.

---

### fig12 — FIG_EA_6C_UMAP

**Rating: Pass.**
- Same UMAP-specific cautions as t-SNE ✓
- Correctly states metrics come from raw 256d space, not UMAP projection ✓
- Same visual-compactness caveat is present ✓

---

### fig13 — FIG_EA_6D_KNN5_BOXPLOT

**Rating: Pass.**
- Values verified: hard mean 4.599, easy mean 3.782, diff 0.817 (CI 0.475–1.160), p=0.0001, FDR p=0.00018 ✓
- Spearman rho=0.343 (CI 0.221–0.460), Pearson r=0.277 (CI 0.174–0.389) ✓
- Correctly uses "oxide-reference region" terminology, not "oxide-pretrained" ✓
- Correctly notes the middle 60% is not shown in the boxplot ✓
- Correctly notes the distributions still overlap ✓
- Correctly frames the association as correlational, not causal ✓

---

### fig13b — FIG_EA_6D_KNN5_SCATTER

**Rating: Pass.**
- Same values as fig13 (continuous-association view of the same relationship) ✓
- Correctly frames as correlational ✓
- Correctly notes the scatter is the continuous-distribution companion to the tail-contrast boxplot ✓

---

## Placement Assessment

### Main-text figures — should any be downgraded to appendix?

| Figure | Decision | Reason |
|---|---|---|
| `FIG_SCHEMATIC` | Keep main text | Framing figure; mandatory for combined paper Methods |
| `FIG_ZS_COMPARISON` | Keep main text | Baseline anchor; cited in blueprints for three reports |
| `FIG_TRANSFER_BENEFIT` | Keep main text | Combined paper Results III anchor |
| `FIG_S1_LC_OXIDE` | Keep main text | Oxide control arm trajectory; blueprints row 4 |
| `FIG_S1_LC_NITRIDE` | Keep main text | Primary behavioral evidence for inertness claim |
| `FIG_S1_PARITY_OXIDE_N10` | Keep main text | Low-N oxide checkpoint visual; control-arm anchor |
| `FIG_S1_PARITY_OXIDE_N1000` | Keep main text | High-N oxide parity endpoint |
| `FIG_S1_PARITY_NITRIDE_N10` | Keep main text | Inert-regime visual; domain-shift error floor |
| `FIG_S1_PARITY_NITRIDE_N1000` | Keep main text | Adaptation-onset visual; best nitride result |
| `FIG_S1_COMP_OXIDE` | Keep main text | Pretraining-vs-scratch on control arm |
| `FIG_S1_COMP_NITRIDE` | Keep main text | Pretraining-vs-scratch on shift arm; N=50 caveat anchor |
| `FIG_EA_6A_PCA` | Keep main text | Family-separation opening figure; blueprints row 7/13 |
| `FIG_EA_6B_TSNE` | Keep main text | Local-neighborhood complement to PCA |
| `FIG_EA_6C_UMAP` | Keep main text | Third projection; cross-method robustness in main text |
| `FIG_EA_6D_KNN5_BOXPLOT` | Keep main text (primary) | Hard/easy tail contrast; blueprints row 8/14 |
| `FIG_EA_6D_KNN5_SCATTER` | Keep main text (companion) | Continuous-association view; see choice note below |

**Choice note — FIG_EA_6D dual-variant:**
Both the boxplot and scatter are currently assigned main-text status. The blueprints specify "FIG_EA_6D" as a single figure slot. If figure count becomes a journal constraint, the boxplot is the primary figure (it shows the group-level effect size and p-values clearly), and the scatter could migrate to supplementary/appendix without losing any canonical number. For now both stay in main text.

**Three-panel embedding choice note (PCA + t-SNE + UMAP):**
All three projection figures are main text, consistent with the combined paper blueprint (rows 13 is "family separation" and lists FIG_EA_6A, 6B, 6C). Three is the planned count. If a journal imposes a main-text figure limit, UMAP is the most reducible (it is the "third view" mentioned in its own memo); PCA and t-SNE together are sufficient.

### Appendix figures — should any be upgraded to main text?

| Figure | Decision | Reason |
|---|---|---|
| Parity plots N=50,100,200,500 (oxide and nitride) | Keep appendix | Progression evidence; not needed for main claims |
| t-SNE p=15, p=50 | Keep appendix | Parameter robustness checks for canonical p=30 |
| UMAP n=15, n=50 | Keep appendix | Parameter robustness checks for canonical n=30 |
| pre_head PCA, last_gcn_pool PCA | Keep appendix | appendix_support layers; near-duplicates of last_alignn_pool |
| Hard/easy PCA | Keep appendix | Visual context for distance-error; boxplot is sufficient in main text |
| Centroid/Mahalanobis boxplots | Keep appendix | Robustness checks for canonical kNN5 |
| Element PCA/t-SNE/UMAP | Keep appendix | Context for element-level representation; not central to domain-shift argument |

No appendix-to-main-text upgrades recommended.

---

## Key Cautions to Carry Into Prose Drafting

These four cautions are the most likely sources of overclaim in prose. They must not be dropped from any draft that cites the relevant figures.

### C1 — Nitride low-N inertness ≠ zero-shot preservation (Priority: High)

**Trigger figures:** FIG_S1_LC_NITRIDE (fig03), FIG_S1_PARITY_NITRIDE_N10 (fig08)
**Risk:** Describing mean_best_epoch=1.0 as "the model reverts to zero-shot state."
**Correct framing:** "Fine-tuning is inert at N≤200 in the sense that the validation-selected checkpoint is epoch 1, but the resulting MAEs (0.0874 at N=10 through 0.1392 at N=200) are worse than the nitride zero-shot baseline (0.0695 eV/atom), not equal to it."

### C2 — Nitride N=50 transfer-benefit bar = initialization advantage only (Priority: High)

**Trigger figures:** FIG_TRANSFER_BENEFIT (fig05), FIG_S1_COMP_NITRIDE (fig05b)
**Risk:** Describing the 0.574 eV/atom nitride N=50 transfer benefit as fine-tuning success or adaptation gain.
**Correct framing:** "Pretrained initialization advantage over scratch (mean_best_epoch=1.0 at N=50 means no real adaptation occurred); not fine-tuning adaptation."

### C3 — FIG_TRANSFER_BENEFIT cross-family height ordering (Priority: High)

**Trigger figure:** FIG_TRANSFER_BENEFIT (fig05)
**Risk:** Reading the taller nitride bars as evidence that nitrides transfer more effectively.
**Correct framing:** "The taller nitride bars reflect a weaker scratch baseline, not better transfer. The nitride scratch MAE is higher, so the scratch-to-fine-tune gap is mechanically larger. Overall nitride performance remains worse than oxide performance at every comparable point."

### C4 — Nitride N=1000 parity improvement is in variability, not headline MAE (Priority: Medium)

**Trigger figure:** FIG_S1_PARITY_NITRIDE_N1000 (fig09)
**Risk:** Claiming a large parity accuracy improvement between N=10 and N=1000.
**Correct framing:** "On-figure MAE changes only from 0.0828 (N=10) to 0.0829 (N=1000). The primary N=10→N=1000 change is that fine-tuning becomes genuine (mean_best_epoch: 1.0→45.0) and more reproducible (per-seed std: 0.0199→0.0135 eV/atom), not that headline parity error improves substantially."

---

## Minor Technical Notes

**Parity MAE aggregation distinction (applies to all four parity memos):**
All four main-text parity memos document two different MAE values for the same figure: the on-figure MAE (from predictions averaged across seeds first) and the summary-table MAE (arithmetic mean of per-seed MAEs). These are not interchangeable. The summary-table value is the canonical number for any performance claim. The on-figure value is the visual-read MAE from the figure itself.

| Figure | On-figure (ensemble) MAE | Summary-table (per-seed mean) MAE |
|---|---|---|
| Oxide N=10 | 0.0391 | 0.0417 |
| Oxide N=1000 | 0.0383 | 0.0417 |
| Nitride N=10 | 0.0828 | 0.0874 |
| Nitride N=1000 | 0.0829 | 0.0907 |

Use the summary-table value for all quantitative claims. The on-figure value is acceptable for caption-level description of what the panel shows.

**t-SNE and UMAP visual compactness warning:**
Both the t-SNE and UMAP figures can appear to show a compact, well-separated nitride cluster. The raw-space quantitative metrics show the opposite pattern: nitride internal cohesion is lower than oxide (silhouette 0.145 vs 0.255; kNN purity 0.833 vs 0.987). Any prose description of the t-SNE or UMAP nitride region as "compact" or "cohesive" without qualifying with the raw-space metrics is a caution failure.

**Embedding causation guardrail:**
All three family-separation figures (PCA, t-SNE, UMAP) and both distance-error figures (boxplot, scatter) are correlational evidence only. The memos uniformly state this. Prose must not convert the distance-error association (Spearman rho=0.343) into a causal claim that "being far from the oxide-reference region causes higher nitride error."

---

## Action Items

| Priority | Item |
|---|---|
| None | All 16 memos are present and cautious. No memo rewrites required. |
| Note for prose | C1: Low-N inertness ≠ zero-shot preservation. Apply in Results II / nitride standalone. |
| Note for prose | C2: Nitride N=50 caveat must appear every time that transfer-benefit value is cited. |
| Note for prose | C3: Nitride taller bars ≠ better transfer. Apply in Results III / combined paper. |
| Note for prose | C4: Nitride N=1000 improvement is variability, not headline MAE. Apply in Results II / nitride parity pair discussion. |
| Optional choice | FIG_EA_6D dual-variant: choose boxplot as primary if figure count is constrained; scatter can move to appendix without losing canonical numbers. |
| Optional choice | Three embedding projections: PCA + t-SNE are the minimum needed if figure count forces a reduction; UMAP is most reducible. |
