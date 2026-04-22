# Oxide Standalone Report — Results (Draft)

**Section role:** Section 3 / Results of the oxide standalone report. Follows the shared Methods section (not drafted here) and precedes Discussion. Literature context belongs in Section 1 (Introduction); this section reports findings only, with brief implementation reminders where necessary for the reader to interpret numbers.

**Canonical evidence base.** All numbers below come from: the shared zero-shot evaluation in `reports/zero_shot/zero_shot_summary.csv`; the Hyperparameter Set 1 fine-tuning summary `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`; the Set 1 from-scratch summary `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`; and the Week-4 embedding tables in `reports/week4_embedding_analysis/tables/`. The oxide test set is the fixed 1,484-structure split; all fine-tuning and from-scratch runs use 5 seeds.

**Citation convention.** Placeholders of the form `[CITE: …]` indicate where external references will be inserted during finalization. Only figures and tables that are central to the oxide standalone report are called out in the main text; appendix figures are referenced where relevant but not reproduced.

---

## 3. Results

We report the oxide arm in four parts. Section 3.1 establishes the zero-shot control benchmark of the pretrained ALIGNN checkpoint [CITE: Choudhary & DeCost 2021 — ALIGNN] on the fixed oxide test set. Section 3.2 reports Set 1 fine-tuning behavior across training sizes N ∈ {10, 50, 100, 200, 500, 1000}. Section 3.3 contrasts fine-tuning against training from scratch at the two data sizes where scratch baselines were run (N = 50 and N = 500). Section 3.4 briefly reports the oxide-side of the pretrained-embedding analysis, intended as a bridge to the representation-level interpretation developed more fully in the nitride and combined manuscripts.

### 3.1 Zero-shot oxide performance sets the in-distribution ceiling

**What is compared.** We evaluate the unmodified pretrained formation-energy ALIGNN checkpoint (`jv_formation_energy_peratom_alignn`) on the 1,484-structure oxide test set without any target-family fine-tuning. This zero-shot number serves as the control benchmark against which all oxide fine-tuning and from-scratch rows in Sections 3.2 and 3.3 are compared.

**What the evidence shows.** The pretrained checkpoint achieves a test mean absolute error (MAE) of **0.0342 eV/atom** on the oxide test set (Table `TAB_ZS_SUMMARY`). This is the single best oxide MAE observed across any Set 1 experiment in this study: no fine-tuning row at any N reaches a lower value (Section 3.2).

**What the pattern is consistent with.** The zero-shot result is consistent with the expectation that a large-dataset JARVIS-pretrained ALIGNN model [CITE: Choudhary et al. 2020 — JARVIS; CITE: Choudhary et al. 2024 — JARVIS-Leaderboard] is already well-matched to oxide formation-energy prediction, which is a chemically familiar target within the source distribution.

**What interpretation is justified.** We treat the zero-shot MAE as the in-distribution control benchmark and, under Set 1, as a practical performance ceiling that downstream fine-tuning experiments approach but do not cross.

**What is uncertain.** The zero-shot ceiling is established under the canonical evaluation protocol only. We do not claim that no alternative fine-tuning protocol could improve on it; such claims are out of scope for the Set 1 main narrative.

### 3.2 Set 1 fine-tuning recovers toward, but does not cross, the zero-shot ceiling

**What is compared.** We fine-tune the same pretrained checkpoint on oxide training subsets of size N ∈ {10, 50, 100, 200, 500, 1000}, with 5 seeds per N, using Hyperparameter Set 1 (epochs = 50, learning rate = 1 × 10⁻⁴, batch size = 16). All runs are evaluated on the same 1,484-structure oxide test set. For each N, we report the mean and standard deviation of the per-seed test MAE, together with the mean across seeds of the best validation epoch.

**What the evidence shows.** Table `TAB_S1_FT_SUMMARY_BY_N` (oxide rows) and Figure `FIG_S1_LC_OXIDE` summarize the trajectory.

| N    | Runs | Mean test MAE (eV/atom) | Std test MAE | Mean best epoch | Gap vs zero-shot |
|-----:|-----:|------------------------:|-------------:|----------------:|-----------------:|
| 10   | 5    | 0.0417                  | 0.0111       | 1.0             | +0.0075          |
| 50   | 5    | 0.0523                  | 0.0148       | 18.5            | +0.0181          |
| 100  | 5    | 0.0465                  | 0.0086       | 20.0            | +0.0123          |
| 200  | 5    | 0.0457                  | 0.0086       | 39.0            | +0.0115          |
| 500  | 5    | 0.0430                  | 0.0062       | 39.0            | +0.0088          |
| 1000 | 5    | 0.0417                  | 0.0053       | 35.5            | +0.0075          |

Three features of the trajectory are notable. First, every fine-tuning row sits above the 0.0342 eV/atom zero-shot baseline, with positive gaps ranging from 0.0075 to 0.0181 eV/atom. Second, the N = 10 row has a mean best epoch of 1.0, indicating that validation error did not meaningfully improve during fine-tuning and the retained checkpoint is effectively the pretrained initialization; this row is therefore a near-pretrained checkpoint view rather than evidence of low-data adaptation. Genuine multi-epoch optimization begins at N = 50, where mean best epoch rises to 18.5, and it stabilizes around 35–39 epochs from N = 200 onward. Third, cross-seed variability tightens substantially with N once fine-tuning is active, with the standard deviation decreasing from 0.0111 at N = 10 to 0.0053 at N = 1000.

The paired parity plots at the low-N and high-N endpoints (Figures `FIG_S1_PARITY_OXIDE_N10` and `FIG_S1_PARITY_OXIDE_N1000`) show visually similar, tight scatters around the identity line, with seed-averaged on-figure MAEs of 0.0391 and 0.0383 eV/atom respectively and R² values of 0.9944 and 0.9943. The similarity reflects that the pretrained model already performs well on the oxide test set; the meaningful distinction between the two panels is the optimization depth behind them (mean best epoch 1.0 vs 35.5) and the cross-seed stability (std 0.0111 vs 0.0053), not the pointwise error structure in the plots. Appendix Figures `FIG_S1_PARITY_OXIDE_N50`, `…N100`, `…N200`, and `…N500` complete the parity progression.

**What the pattern is consistent with.** The trajectory is consistent with a small-data penalty at N = 50 — the first point at which real gradient updates occur on a training set too small to recover the pretrained representation's quality — followed by a monotonic recovery from N = 100 to N = 1,000. The convergence target of that recovery is the zero-shot baseline itself, not a better-than-baseline minimum.

**What interpretation is justified.** Under Set 1, oxide fine-tuning does not improve upon zero-shot. The N = 10 result should not be read as successful low-data adaptation. The curve becomes more reproducible with more data, and its late-N decrements shrink (N = 500 → N = 1,000 improves the mean by 0.0013 eV/atom), which is consistent with the learning curve flattening as it approaches the zero-shot ceiling from above.

**What is uncertain.** We observe flattening, not formal saturation. Only six N values are tested and no data point exists above N = 1,000; we do not claim a specific saturation sample size. Whether further fine-tuning data would eventually cross the zero-shot line under a different protocol is out of scope for these Set 1 results.

### 3.3 Pretrained initialization dominates random initialization at both scratch-tested sizes

**What is compared.** At N = 50 and N = 500 — the two oxide training sizes for which from-scratch baselines were run — we compare the Set 1 fine-tuning MAE against the MAE of randomly-initialized ALIGNN models trained on the same oxide splits with the same hyperparameters and evaluation protocol. Both use 5 seeds. Scratch baselines at N ∈ {10, 100, 200, 1000} are not in scope and are not reported.

**What the evidence shows.** Table `TAB_S1_FS_SUMMARY` and Figure `FIG_S1_COMP_OXIDE` summarize the comparison.

| N   | Fine-tune mean MAE ± std (eV/atom) | From-scratch mean MAE ± std (eV/atom) | Scratch − fine-tune (eV/atom) | Scratch − zero-shot (eV/atom) |
|----:|-----------------------------------:|--------------------------------------:|------------------------------:|------------------------------:|
| 50  | 0.0523 ± 0.0148                    | 0.5561 ± 0.0523                       | +0.5038                       | +0.5219                       |
| 500 | 0.0430 ± 0.0062                    | 0.2643 ± 0.0228                       | +0.2214                       | +0.2301                       |

At N = 50, the from-scratch MAE is roughly an order of magnitude higher than the fine-tune MAE. At N = 500, it is roughly six times higher. Between these two points, from-scratch MAE drops substantially (0.5561 → 0.2643 eV/atom) while fine-tune MAE changes only modestly (0.0523 → 0.0430 eV/atom), so the transfer-benefit gap narrows from 0.5038 eV/atom at N = 50 to 0.2214 eV/atom at N = 500.

**What the pattern is consistent with.** The pattern is consistent with a pretrained initialization providing a large labelled-data saving relative to random initialization in the oxide data regime studied, and with randomly-initialized ALIGNN improving with more data at a faster rate than fine-tuning does, because fine-tuning is already bounded near the zero-shot ceiling.

**What interpretation is justified.** The pretrained-vs-scratch gap is the oxide arm's clearest on-family signature of transfer value. Fine-tuning does not need to beat zero-shot in order for the pretrained representation to be delivering a substantial benefit: at N = 500, fine-tuning sits 0.221 eV/atom below scratch while sitting 0.009 eV/atom above zero-shot, so the transfer gain relative to a no-pretraining world is about 25 times larger than the residual gap to the zero-shot ceiling.

**What is uncertain.** The gap is measured at only two data sizes. We do not extrapolate a continuous scratch learning curve to N ∈ {10, 100, 200, 1000}, and we do not claim where, if at all, scratch would intersect fine-tune or zero-shot at much larger N.

### 3.4 Oxide embeddings form a cohesive, easily recoverable region

**What is compared.** We extract 256-dimensional pretrained embeddings at the `last_alignn_pool` layer for the fixed oxide and nitride test sets and compute raw-space family-separation metrics: silhouette score (overall and per-family), Davies–Bouldin index, 15-nearest-neighbor family purity, and logistic-regression family AUC. All quantitative claims in this subsection come from raw-space statistics; PCA, t-SNE, and UMAP panels (Figures `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`) are used only as descriptive visual support.

**What the evidence shows.** In the `last_alignn_pool` layer, oxide points form a visibly compact region. The 15-NN family purity on oxide test points is **0.9872** and the overall oxide–nitride logistic-regression family AUC is **0.9994** (Table `TAB_EA_FAMILY_SEPARATION`). Oxide silhouette is 0.2546 (95% CI 0.2476–0.2617), higher than nitride silhouette 0.1453 (95% CI 0.1316–0.1582). The descriptive PCA, t-SNE, and UMAP projections show oxides and nitrides in clearly distinct regions.

**What the pattern is consistent with.** The oxide-region cohesion and the near-perfect family recoverability in the pretrained embedding space are consistent with the interpretation that the pretrained ALIGNN representation treats oxides as a tight, chemically-familiar neighborhood — which is also the picture suggested independently by the strong zero-shot MAE in Section 3.1 and by the inability of Set 1 fine-tuning to improve on it in Section 3.2.

**What interpretation is justified.** The oxide arm's embedding evidence supports a limited statement: in the pretrained representation, oxides form a cohesive, locally-pure cluster. This is consistent with, but does not by itself explain, the strong zero-shot performance or the flattening of the fine-tuning curve.

**What is uncertain.** Embedding-space cohesion is descriptive and correlational; we do not claim it causes the observed prediction behavior. Quantitative distance-error analyses (e.g., nearest-oxide distance vs nitride prediction error) are nitride-facing and are developed in the nitride and combined manuscripts rather than here. Finally, 2-D projections are for visualization only and no numerical claim in this subsection depends on them.

---

## 3.5 Summary of results

The oxide arm establishes four findings that the Discussion will interpret. (i) The pretrained formation-energy ALIGNN checkpoint reaches a zero-shot MAE of 0.0342 eV/atom on 1,484 oxide test structures, which is the best Set 1 oxide performance observed in this study. (ii) Set 1 fine-tuning does not cross this ceiling at any N ∈ {10, 50, 100, 200, 500, 1000}: after an N = 10 near-pretrained-checkpoint row and an N = 50 small-data penalty, the mean test MAE recovers monotonically to 0.0417 eV/atom at N = 1,000 and becomes more reproducible as cross-seed std narrows from 0.0111 to 0.0053 eV/atom. (iii) At both data sizes where a from-scratch comparison exists, pretrained fine-tuning is dramatically lower in error than random-initialization training, with transfer-benefit gaps of 0.5038 eV/atom at N = 50 and 0.2214 eV/atom at N = 500. (iv) The pretrained `last_alignn_pool` representation places oxides in a cohesive, locally-pure region (15-NN purity 0.9872; family AUC 0.9994), consistent with the above but not explanatory on its own.

Taken together, the oxide arm's in-distribution behavior under Set 1 is best described as the zero-shot baseline defining the performance ceiling, fine-tuning approaching but not crossing it, and the pretrained-over-scratch gap being the cleanest oxide-side signature of transfer value. These observations set the control against which the nitride arm's domain-shift penalty is measured in the companion report.
