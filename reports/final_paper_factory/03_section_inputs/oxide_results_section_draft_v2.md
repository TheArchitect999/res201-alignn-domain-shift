# Oxide Standalone Report — Results (Draft v2)

**Section role.** Section 3 / Results of the oxide standalone report. Follows the shared Methods section (not drafted here) and precedes Discussion. Literature context belongs in Section 1 (Introduction); this section reports findings only, with brief implementation reminders where necessary to interpret the numbers.

**Report identity.** The oxide report is the in-distribution control arm of the broader study. Its contribution is disciplined, chemistry-aligned reference evidence for the nitride arm's domain-shift analysis; it is not a dramatic failure case or a breakthrough result. Results are presented in an order that makes this control-arm identity explicit: the zero-shot benchmark is established first, Set 1 fine-tuning is characterized, the parity view is summarized briefly at the two endpoints, the pretrained-vs-scratch comparison is presented as the central on-oxide transfer-value result, and a short embedding subsection reports a self-contained representation-level finding.

**Canonical evidence base.** Zero-shot: `reports/zero_shot/zero_shot_summary.csv`. Set 1 fine-tuning: `reports/Hyperparameter Set 1/Summaries/Finetuning/finetune_summary_by_N.csv`. Set 1 from-scratch: `reports/Hyperparameter Set 1/Summaries/From Scratch/fromscratch_summary.csv`. Embedding: `reports/week4_embedding_analysis/tables/`. The oxide test set is the fixed 1,484-structure split; all fine-tuning and from-scratch runs use 5 seeds under Hyperparameter Set 1 (epochs = 50, learning rate = 1 × 10⁻⁴, batch size = 16).

**Citation convention.** Placeholders of the form `[CITE: …]` mark where external references will be inserted. Appendix figures are referenced where relevant but not reproduced in the main text.

---

## 3. Results

We report the oxide arm in five parts. Section 3.1 establishes the Set 1 oxide zero-shot benchmark of the pretrained ALIGNN checkpoint [CITE: Choudhary & DeCost 2021 — ALIGNN] on the fixed oxide test set. Section 3.2 reports Set 1 fine-tuning behaviour across N ∈ {10, 50, 100, 200, 500, 1000}. Section 3.3 summarizes the parity view at the two canonical fine-tuning endpoints. Section 3.4 — the central on-oxide transfer-value result — contrasts fine-tuning against training from scratch at the two data sizes where scratch baselines were run (N = 50 and N = 500). Section 3.5 reports the oxide-side of the pretrained-embedding analysis as a self-contained representation-level finding.

### 3.1 Zero-shot oxide performance establishes the best Set 1 oxide benchmark

**What is compared.** We evaluate the unmodified pretrained formation-energy ALIGNN checkpoint (`jv_formation_energy_peratom_alignn`) on the 1,484-structure oxide test set without any target-family fine-tuning. This zero-shot number is the control benchmark against which the fine-tuning, parity, and from-scratch results reported below are compared.

**What the evidence shows.** The pretrained checkpoint achieves a test mean absolute error (MAE) of **0.0342 eV/atom** on the oxide test set (Table `TAB_ZS_SUMMARY`). This is the best observed oxide MAE under Set 1 anywhere in this study: no fine-tuning row at any N sits below it (Section 3.2), and every from-scratch row sits far above it (Section 3.4).

**What the pattern is consistent with.** The zero-shot result is consistent with the oxide arm functioning as the in-distribution control condition in this study [CITE: Choudhary et al. 2020 — JARVIS; CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]. We do not make separate claims here about the exact chemical composition of the pretraining corpus; oxides are the chemistry-aligned control arm by project design.

**What interpretation is justified.** We treat the zero-shot MAE as the best observed oxide performance under Set 1 — a baseline not surpassed under the canonical fine-tuning or from-scratch protocols reported in the following subsections.

**What is uncertain.** The result is established under the canonical evaluation protocol only. We do not claim that no alternative fine-tuning protocol could improve on it; such claims are out of scope for the Set 1 main narrative.

### 3.2 Set 1 fine-tuning converges toward, but does not surpass, the zero-shot benchmark

**What is compared.** We fine-tune the same pretrained checkpoint on oxide training subsets of size N ∈ {10, 50, 100, 200, 500, 1000}, with 5 seeds per N, under Hyperparameter Set 1. All runs are evaluated on the same 1,484-structure oxide test set. For each N we report the mean and standard deviation of the per-seed test MAE and the mean across seeds of the best validation epoch.

**What the evidence shows.** Table `TAB_S1_FT_SUMMARY_BY_N` (oxide rows) and Figure `FIG_S1_LC_OXIDE` summarize the trajectory.

| N    | Runs | Mean test MAE (eV/atom) | Std test MAE | Mean best epoch | Gap vs zero-shot |
|-----:|-----:|------------------------:|-------------:|----------------:|-----------------:|
| 10   | 5    | 0.0417                  | 0.0111       | 1.0             | +0.0075          |
| 50   | 5    | 0.0523                  | 0.0148       | 18.5            | +0.0181          |
| 100  | 5    | 0.0465                  | 0.0086       | 20.0            | +0.0123          |
| 200  | 5    | 0.0457                  | 0.0086       | 39.0            | +0.0115          |
| 500  | 5    | 0.0430                  | 0.0062       | 39.0            | +0.0088          |
| 1000 | 5    | 0.0417                  | 0.0053       | 35.5            | +0.0075          |

Three features of the trajectory stand out. First, every fine-tuning row sits above the 0.0342 eV/atom zero-shot benchmark, with positive gaps ranging from 0.0075 to 0.0181 eV/atom. Second, the N = 10 row has a mean best epoch of 1.0, indicating that validation error did not meaningfully improve during fine-tuning and the retained checkpoint is effectively the pretrained initialization; this row is therefore a near-pretrained-checkpoint view rather than evidence of low-data adaptation, and it is flagged as `zero_shot_checkpoint_at_low_N` in the canonical numbers file. Genuine multi-epoch optimization begins at N = 50, where mean best epoch rises to 18.5, and stabilizes at 35–39 epochs from N = 200 onward. Third, cross-seed variability tightens substantially as N grows: the per-seed standard deviation falls from 0.0111 at N = 10 to 0.0053 at N = 1000, the clearest trend in the oxide fine-tuning table.

**What the pattern is consistent with.** The trajectory is consistent with a small-data penalty at N = 50 — the first point at which real gradient updates occur on a training set not yet large enough to re-match the pretrained representation's quality — followed by a monotonic recovery from N = 100 onward. The convergence target of that recovery is the zero-shot benchmark itself, not a better-than-benchmark minimum.

**What interpretation is justified.** Under Set 1, oxide fine-tuning does not surpass zero-shot. The N = 10 result should not be read as successful low-data adaptation. The late-N decrements shrink (N = 500 → N = 1,000 improves the mean by 0.0013 eV/atom) and variability continues to narrow, which is consistent with the learning curve flattening as it approaches the zero-shot benchmark from above.

**What is uncertain.** We observe flattening, not formal saturation. Only six N values are tested and no fine-tuning data exist above N = 1,000; we do not claim a specific saturation sample size. Whether further fine-tuning data would eventually cross the zero-shot line under a different protocol is out of scope here.

### 3.3 Parity view at low- and high-N fine-tuning endpoints

**What is compared.** We report the oxide parity plots at the two canonical fine-tuning endpoints: N = 10 (`FIG_S1_PARITY_OXIDE_N10`) and N = 1000 (`FIG_S1_PARITY_OXIDE_N1000`). Each panel shows seed-averaged predictions against ground-truth formation energies on the 1,484-structure test set, with on-figure MAE, RMSE, and R² computed on those seed-averaged predictions. The intermediate N = 50, 100, 200, 500 parity panels are provided in the Appendix.

**What the evidence shows and what it means.** The two endpoint panels look visually similar (on-figure MAE 0.0391 and 0.0383 eV/atom; R² 0.9944 and 0.9943) because the pretrained model already performs well on the oxide test set. The substantive difference between them is not the pointwise scatter structure but the optimization depth and reproducibility behind each panel: `mean_best_epoch` rises from 1.0 to 35.5, and the per-seed standard deviation narrows from 0.0111 to 0.0053 eV/atom. The N = 10 panel is best read as a near-pretrained-checkpoint snapshot, and the N = 1000 panel as a genuinely optimized and substantially more reproducible fine-tuned model. A technical note: the on-figure MAEs are computed on seed-averaged predictions, whereas the summary-table MAEs average per-seed MAEs, so the two values are not interchangeable.

**What is uncertain.** Parity panels describe prediction quality, not mechanism; they do not identify why particular points deviate from the identity line, and they are bounded by the same Set 1 protocol as the underlying fine-tuning results.

### 3.4 Pretrained initialization dominates random initialization at both scratch-tested data sizes — the central on-oxide transfer-value result

**Transition into this subsection.** Sections 3.1–3.3 established that the pretrained checkpoint is already strong on oxides under Set 1 and that Set 1 fine-tuning does not surpass it. That alone would not demonstrate transfer value. The oxide arm's transfer-value evidence lives in this subsection: if pretrained initialization were not itself responsible for the strong oxide performance, it would be possible to reach similar error by training the same architecture from scratch on the same oxide data under the same protocol. It is not, by a very large margin.

**What is compared.** At N = 50 and N = 500 — the two oxide training sizes for which from-scratch baselines were run — we compare the Set 1 fine-tuning MAE against the MAE of randomly-initialized ALIGNN models trained on the same oxide splits with the same hyperparameters, protocol, and test set. Both use 5 seeds. Scratch baselines at N ∈ {10, 100, 200, 1000} are not in scope and are not reported.

**What the evidence shows.** Table `TAB_S1_FS_SUMMARY` and Figure `FIG_S1_COMP_OXIDE` summarize the comparison.

| N   | Fine-tune mean MAE ± std (eV/atom) | From-scratch mean MAE ± std (eV/atom) | Scratch − fine-tune (eV/atom) | Scratch − zero-shot (eV/atom) |
|----:|-----------------------------------:|--------------------------------------:|------------------------------:|------------------------------:|
| 50  | 0.0523 ± 0.0148                    | 0.5561 ± 0.0523                       | +0.5038                       | +0.5219                       |
| 500 | 0.0430 ± 0.0062                    | 0.2643 ± 0.0228                       | +0.2214                       | +0.2301                       |

At N = 50, the from-scratch MAE is roughly an order of magnitude higher than the fine-tune MAE. At N = 500, it is roughly six times higher. Between these two points, from-scratch MAE drops substantially (0.5561 → 0.2643 eV/atom) while fine-tune MAE changes only modestly (0.0523 → 0.0430 eV/atom), so the transfer-benefit gap narrows from 0.5038 eV/atom at N = 50 to 0.2214 eV/atom at N = 500. Both from-scratch points also sit far above the zero-shot benchmark (scratch − zero-shot of 0.5219 and 0.2301 eV/atom).

**What the pattern is consistent with.** The pattern is consistent with pretrained initialization providing a large labelled-data saving relative to random initialization in the oxide data regime studied, and with randomly-initialized ALIGNN improving with more data at a faster rate than fine-tuning does because fine-tuning is already bounded near the zero-shot benchmark.

**What interpretation is justified.** The pretrained-vs-scratch gap is the oxide arm's clearest on-family signature of transfer value and the central result this report is organized around. Fine-tuning does not need to surpass zero-shot for the pretrained representation to be delivering a substantial benefit: at N = 500, fine-tuning sits 0.2214 eV/atom below scratch while sitting only 0.0088 eV/atom above zero-shot, so the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark. This is the oxide arm's disciplined evidence that transfer is real and valuable on the chemistry-aligned control task.

**What is uncertain.** The gap is measured at only two data sizes. We do not extrapolate a continuous scratch learning curve to N ∈ {10, 100, 200, 1000}, and we do not claim where, if anywhere, scratch would intersect fine-tune or zero-shot at much larger N.

### 3.5 Oxide embeddings form a cohesive, locally pure region in pretrained representation space

**What is compared.** We extract 256-dimensional pretrained embeddings at the `last_alignn_pool` layer for the fixed oxide and nitride test sets and compute raw-space family-separation metrics: silhouette score (overall and per family), Davies–Bouldin index, 15-nearest-neighbour family purity, and logistic-regression family AUC. All quantitative claims here come from raw 256-D statistics. PCA, t-SNE, and UMAP panels (Figures `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`) are descriptive visual support only.

**What the evidence shows.** In the `last_alignn_pool` layer, oxide points form a cohesive, locally pure region in pretrained representation space. The 15-NN family purity on oxide test points is **0.9872** — oxide local neighbourhoods in this layer are almost entirely oxide-only — and the oxide silhouette is **0.2546**, higher than the nitride silhouette of 0.1453 (Table `TAB_EA_FAMILY_SEPARATION`). Across the full test set, family labels are recoverable from the raw embeddings at essentially ceiling level: logistic-regression family AUC is **0.9994** and overall 15-NN family purity is 0.9655.

**What the pattern is consistent with.** Three oxide-specific statements are supported by these numbers. (i) Oxide local neighbourhoods in pretrained space have negligible cross-family contamination. (ii) The oxide region is internally more coherent than the nitride region. (iii) The pretrained representation already organizes the test set along the oxide/non-oxide axis without any supervision on that axis. These descriptive observations are consistent with the behavioural picture in Sections 3.1–3.4: the pretrained checkpoint handles oxides well zero-shot, Set 1 fine-tuning cannot improve on that, and pretrained initialization delivers a very large advantage over scratch.

**What interpretation is justified.** The oxide arm's embedding evidence supports a self-contained representation-level finding: in the pretrained `last_alignn_pool` layer, oxides occupy a tight, locally pure, family-recoverable region. This is a real oxide-specific result for the oxide standalone report.

**What is uncertain.** Embedding-space cohesion is descriptive and correlational; we do not claim it causes the behavioural results in Sections 3.1–3.4. Quantitative distance-error analyses relating representation geometry to prediction error are nitride-facing and are reported in the nitride and combined manuscripts. Two-dimensional projections are visualization only; no numerical claim in this subsection depends on them.

---

## 3.6 Summary of oxide results

Stated in the order that reflects the evidence's scientific weight:

(i) **Pretrained initialization dominates random initialization on oxides at both scratch-tested data sizes.** The transfer-benefit gap is 0.5038 eV/atom at N = 50 and 0.2214 eV/atom at N = 500, far larger than the residual gap between fine-tuning and the zero-shot benchmark. This is the oxide arm's central on-oxide evidence that transfer is real and valuable on the chemistry-aligned control task.

(ii) **The pretrained zero-shot MAE of 0.0342 eV/atom on 1,484 oxide test structures is the best observed oxide performance under Set 1 in this study.** Every fine-tuning row sits above it; every from-scratch row sits far above it.

(iii) **Set 1 fine-tuning converges toward, but does not surpass, the zero-shot benchmark.** After an N = 10 near-pretrained-checkpoint row and an N = 50 small-data penalty, the mean test MAE recovers monotonically to 0.0417 eV/atom at N = 1,000 and becomes substantially more reproducible as cross-seed standard deviation narrows from 0.0111 to 0.0053 eV/atom.

(iv) **The pretrained `last_alignn_pool` representation places oxides in a cohesive, locally pure region** (15-NN family purity 0.9872; oxide silhouette 0.2546; family AUC 0.9994), a representation-level finding that is consistent with the above but not a causal explanation of it.

Together, these results constitute the oxide arm's disciplined control evidence: pretraining delivers a very large advantage over scratch on an in-distribution target, the pretrained benchmark is already strong and is not surpassed under Set 1 fine-tuning, and the pretrained representation organizes oxides into a tight, well-separated region consistent with that behaviour. These findings set the reference condition against which the nitride arm's domain-shift analysis is carried out in the companion report.
