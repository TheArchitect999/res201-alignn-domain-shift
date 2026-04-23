# Oxide Standalone Report — Results (Edited v3.1)

**Editorial pass:** heavy polish; ordering preserved, repetitive five-bullet framing compressed into flowing paragraphs. Numbers, figure references, and citation placeholders unchanged.

---

## 3. Results

The oxide arm is reported in five parts. Section 3.1 establishes the Set 1 zero-shot benchmark of the pretrained ALIGNN checkpoint [CITE: Choudhary & DeCost 2021 — ALIGNN] on the fixed oxide test set. Section 3.2 characterizes Set 1 fine-tuning across `N ∈ {10, 50, 100, 200, 500, 1 000}`. Section 3.3 summarizes the parity view at the two canonical endpoints. Section 3.4 — the central on-oxide transfer-value result — contrasts fine-tuning against training from scratch at the two data sizes where scratch baselines were run. Section 3.5 reports the oxide-side of the pretrained-embedding analysis as a self-contained representation-level finding.

### 3.1 The pretrained zero-shot MAE is the best observed oxide configuration under Set 1

We evaluated the unmodified pretrained formation-energy ALIGNN checkpoint (`jv_formation_energy_peratom_alignn`) on the 1 484-structure oxide test set without any target-family fine-tuning, establishing the control benchmark against which every fine-tuning, parity, and from-scratch result reported below is compared. The checkpoint attains a test mean absolute error of **0.0342 eV/atom** on the oxide test set (Table `TAB_ZS_SUMMARY`). This is the best observed oxide MAE under Set 1 anywhere in this study: no fine-tuning row at any `N` sits below it (§3.2), and every from-scratch row sits far above it (§3.4). Oxides serve as the in-distribution control arm by project design; the pretrained model and training data used here derive from the JARVIS materials infrastructure [CITE: Choudhary et al. 2020 — JARVIS; Choudhary et al. 2024 — JARVIS-Leaderboard]. We make no separate claim about the exact chemical composition of the pretraining corpus, and we do not claim that no alternative fine-tuning protocol could improve on this baseline — such claims are out of scope for the Set 1 main narrative.

### 3.2 Set 1 fine-tuning converges toward, but does not surpass, the zero-shot benchmark

We fine-tuned the same pretrained checkpoint on oxide training subsets of size `N ∈ {10, 50, 100, 200, 500, 1 000}` under Hyperparameter Set 1, with five seeds per `N` and the fixed 1 484-structure test set throughout. For each `N` we report the mean and standard deviation of per-seed test MAE and the cross-seed mean of the best validation epoch (Table `TAB_S1_FT_SUMMARY_BY_N`, Figure `FIG_S1_LC_OXIDE`):

| `N`  | Runs | Mean test MAE (eV/atom) | Std test MAE | Mean best epoch | Gap vs zero-shot |
|-----:|-----:|------------------------:|-------------:|----------------:|-----------------:|
| 10   | 5    | 0.0417                  | 0.0111       | 1.0             | +0.0075          |
| 50   | 5    | 0.0523                  | 0.0148       | 18.5            | +0.0181          |
| 100  | 5    | 0.0465                  | 0.0086       | 20.0            | +0.0123          |
| 200  | 5    | 0.0457                  | 0.0086       | 39.0            | +0.0115          |
| 500  | 5    | 0.0430                  | 0.0062       | 39.0            | +0.0088          |
| 1000 | 5    | 0.0417                  | 0.0053       | 35.5            | +0.0075          |

Three features of the trajectory stand out. First, every fine-tuning row sits above the 0.0342 eV/atom zero-shot benchmark, with positive gaps ranging from 0.0075 to 0.0181 eV/atom. Second, the `N = 10` row has a mean best epoch of 1.0, indicating that validation error did not meaningfully improve during fine-tuning and the retained checkpoint is effectively the pretrained initialization; this row is therefore a near-pretrained-checkpoint view rather than evidence of low-data adaptation, and it is flagged as `zero_shot_checkpoint_at_low_N` in the canonical numbers file. Genuine multi-epoch optimization begins at `N = 50`, where mean best epoch rises to 18.5, and stabilizes at 35–39 epochs from `N = 200` onward. Third, cross-seed variability tightens substantially as `N` grows: per-seed standard deviation falls from 0.0111 at `N = 10` to 0.0053 at `N = 1 000`, the clearest trend in the oxide fine-tuning table.

The trajectory is consistent with a small-data penalty at `N = 50` — the first point at which real gradient updates occur on a training set not yet large enough to re-match the pretrained representation's quality — followed by a monotonic recovery from `N = 100` onward. The convergence target of that recovery is the zero-shot benchmark itself, not a better-than-benchmark minimum. Under Set 1, oxide fine-tuning does not surpass zero-shot: the `N = 10` result should not be read as successful low-data adaptation, and the late-`N` decrements shrink (`N = 500 → N = 1 000` improves the mean by 0.0013 eV/atom) while variability continues to narrow — consistent with the learning curve flattening as it approaches the zero-shot benchmark from above. We describe this as flattening, not as formal saturation: only six `N` values are tested and no fine-tuning data exist above `N = 1 000`.

### 3.3 Parity view at the low- and high-`N` fine-tuning endpoints

We report the oxide parity plots at the two canonical endpoints: `N = 10` (`FIG_S1_PARITY_OXIDE_N10`) and `N = 1 000` (`FIG_S1_PARITY_OXIDE_N1000`). Each panel shows seed-averaged predictions against ground-truth formation energies on the 1 484-structure test set, with on-figure MAE, RMSE, and R² computed on those seed-averaged predictions. Intermediate panels at `N = 50, 100, 200, 500` are provided in the Appendix.

The two endpoints look visually similar (on-figure MAE 0.0391 and 0.0383 eV/atom; R² 0.9944 and 0.9943) because the pretrained model already performs well on the oxide test set. The substantive difference is not the scatter structure but the optimization depth and reproducibility behind each panel: `mean_best_epoch` rises from 1.0 to 35.5, and per-seed standard deviation narrows from 0.0111 to 0.0053 eV/atom. The `N = 10` panel is best read as a near-pretrained-checkpoint snapshot; the `N = 1 000` panel, as a genuinely optimized and substantially more reproducible fine-tuned model. A technical note: on-figure MAEs are computed on seed-averaged predictions, whereas summary-table MAEs average per-seed MAEs, so the two values are not interchangeable. Parity panels describe prediction quality, not mechanism; they are bounded by the same Set 1 protocol as the underlying fine-tuning results.

### 3.4 Pretrained initialization dominates random initialization at both scratch-tested sizes

Sections 3.1–3.3 established that the pretrained checkpoint is already strong on oxides under Set 1 and that Set 1 fine-tuning does not surpass it. That alone would not demonstrate transfer value. The oxide arm's transfer-value evidence lives in this subsection: if pretrained initialization were not itself responsible for the strong oxide performance, it should be possible to reach similar error by training the same architecture from scratch on the same oxide data under the same protocol. It is not — by a very large margin.

At `N = 50` and `N = 500` — the two oxide training sizes for which from-scratch baselines were run — we compare the Set 1 fine-tuning MAE against the MAE of randomly-initialized ALIGNN models trained on the same oxide splits with the same hyperparameters, protocol, and test set (Table `TAB_S1_FS_SUMMARY`, Figure `FIG_S1_COMP_OXIDE`):

| `N` | Fine-tune mean MAE ± SD (eV/atom) | From-scratch mean MAE ± SD (eV/atom) | Scratch − fine-tune (eV/atom) | Scratch − zero-shot (eV/atom) |
|----:|----------------------------------:|-------------------------------------:|------------------------------:|------------------------------:|
| 50  | 0.0523 ± 0.0148                   | 0.5561 ± 0.0523                      | +0.5038                       | +0.5219                       |
| 500 | 0.0430 ± 0.0062                   | 0.2643 ± 0.0228                      | +0.2214                       | +0.2301                       |

At `N = 50`, from-scratch MAE is roughly an order of magnitude higher than fine-tune MAE; at `N = 500`, roughly six times higher. Between these two points, from-scratch MAE drops substantially (0.5561 → 0.2643 eV/atom) while fine-tune MAE changes only modestly (0.0523 → 0.0430 eV/atom), narrowing the transfer-benefit gap from 0.5038 to 0.2214 eV/atom. Both from-scratch points sit far above the zero-shot benchmark as well (scratch − zero-shot of 0.5219 and 0.2301 eV/atom).

The pattern is consistent with pretrained initialization providing a large labelled-data saving relative to random initialization in the oxide regime studied, and with randomly-initialized ALIGNN improving at a faster rate with more data than fine-tuning does, because fine-tuning is already bounded near the zero-shot benchmark. This gap is the oxide arm's clearest on-family signature of transfer value: fine-tuning does not need to surpass zero-shot for the pretrained representation to be delivering a substantial benefit. At `N = 500` under Set 1, fine-tuning sits 0.2214 eV/atom below scratch while sitting only 0.0088 eV/atom above zero-shot, so the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark. The gap is measured at only two data sizes; we do not extrapolate a continuous scratch learning curve or claim where, if anywhere, scratch would intersect fine-tune or zero-shot at much larger `N`.

### 3.5 Oxide embeddings form a cohesive, locally pure region in pretrained representation space

We extract 256-dimensional pretrained embeddings at the `last_alignn_pool` layer for the fixed oxide and nitride test sets and compute raw-space family-separation metrics: silhouette score (overall and per family), Davies–Bouldin index, 15-nearest-neighbour family purity, and logistic-regression family AUC. All quantitative claims in this subsection derive from these raw 256-D statistics; PCA, t-SNE, and UMAP panels (`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`) serve only as descriptive visual support.

In the `last_alignn_pool` layer, oxide points form a cohesive, locally pure region in pretrained representation space. The 15-NN family purity on oxide test points is **0.9872** — oxide local neighbourhoods in this layer are almost entirely oxide-only — and the oxide silhouette is **0.2546**, higher than the nitride silhouette of 0.1453 (Table `TAB_EA_FAMILY_SEPARATION`). Across the full test set, family labels are recoverable from the raw embeddings with near-perfect separability: logistic-regression family AUC is **0.9994** and overall 15-NN family purity is 0.9655.

Three oxide-specific statements are supported by these numbers: (i) oxide local neighbourhoods in pretrained space have negligible cross-family contamination; (ii) the oxide region is internally more coherent than the nitride region; and (iii) the pretrained representation already organizes the test set along the oxide/non-oxide axis without any supervision on that axis. These descriptive observations are consistent with the behavioural picture in §§3.1–3.4: the pretrained checkpoint handles oxides well zero-shot, Set 1 fine-tuning cannot improve on that, and pretrained initialization delivers a very large advantage over scratch. The embedding evidence supports a self-contained representation-level finding — in the pretrained `last_alignn_pool` layer, oxides occupy a tight, locally pure, family-recoverable region — but the evidence is descriptive and correlational. We do not claim it causes the behavioural results in §§3.1–3.4. Quantitative distance–error analyses relating representation geometry to prediction error are nitride-facing and are reported in the nitride and combined manuscripts. Two-dimensional projections are visualization only; no numerical claim here depends on them.

---

## 3.6 Summary of oxide results

In descending order of scientific weight:

1. **Pretrained initialization dominates random initialization on oxides at both scratch-tested sizes.** The transfer-benefit gap is 0.5038 eV/atom at `N = 50` and 0.2214 eV/atom at `N = 500`, far larger than the residual gap between fine-tuning and the zero-shot benchmark. This is the oxide arm's central on-oxide evidence that transfer is real and valuable on the chemistry-aligned control task.
2. **The pretrained zero-shot MAE of 0.0342 eV/atom on 1 484 oxide test structures is the best observed oxide performance under Set 1 in this study.** Every fine-tuning row sits above it; every from-scratch row sits far above it.
3. **Set 1 fine-tuning converges toward, but does not surpass, the zero-shot benchmark.** After an `N = 10` near-pretrained-checkpoint row and an `N = 50` small-data penalty, mean test MAE recovers monotonically to 0.0417 eV/atom at `N = 1 000` and becomes substantially more reproducible as cross-seed standard deviation narrows from 0.0111 to 0.0053 eV/atom.
4. **The pretrained `last_alignn_pool` representation places oxides in a cohesive, locally pure region** (15-NN family purity 0.9872; oxide silhouette 0.2546; family AUC 0.9994) — a representation-level finding consistent with the above but not a causal explanation of it.

Together, these results constitute the oxide arm's disciplined control evidence: pretraining delivers a very large advantage over scratch on an in-distribution target, the pretrained benchmark is already strong and is not surpassed under Set 1 fine-tuning, and the pretrained representation organizes oxides into a tight, well-separated region consistent with that behaviour. These findings set the reference condition against which the nitride arm's domain-shift analysis is carried out in the companion report.
