# Oxide Analysis Document

**Role in the project:** internal analysis memo for the oxide standalone report. This document converts the canonical oxide evidence (zero-shot, Set 1 fine-tuning by N, Set 1 from-scratch, last_alignn_pool embedding metrics) into an interpretive narrative that the Results and Discussion sections can draw on. It follows the project's three-layer rule: literature-grounded context, our implementation, and our findings are kept separate.

**Status:** pre-writing analysis. Numerical claims are quoted from `oxide_results_packet.md` and `oxide_analysis_packet.md`; no numbers are invented here. Citation markers use the placeholder form `[CITE: …]` for later substitution.

---

## 1. The question the oxide arm is answering

### 1.1 Literature context

Graph neural networks for crystal property prediction were established by CGCNN [CITE: Xie & Grossman 2018], extended to line-graph formulations that encode bond angles in ALIGNN [CITE: Choudhary & DeCost 2021], and deployed at scale through the JARVIS infrastructure [CITE: Choudhary et al. 2020; Choudhary et al. 2024]. Benchmarks such as MatBench [CITE: Dunn et al. 2020] and the JARVIS-Leaderboard [CITE: Choudhary et al. 2024] have shown that models pretrained on large DFT-computed property datasets generalize well within the chemical distribution they were trained on. Prior transfer-learning work on crystal GNNs has shown that reusing pretrained representations is particularly effective when the target family is chemically close to the source [CITE: Lee & Asahi 2021; Kim et al. 2024], while domain-adaptation work has highlighted that chemical-family shifts — e.g., moving from one anion family to another — degrade transfer [CITE: Hu et al. 2024; Omee et al. 2024; Li et al. 2025, OOD; Li et al. 2025, adversarial].

### 1.2 Our implementation

Our oxide arm acts as the in-distribution control against which the nitride arm's domain-shift penalty is measured. We start from the pretrained `jv_formation_energy_peratom_alignn` checkpoint, which was trained on JARVIS DFT formation energies spanning many chemical families [CITE: ALIGNN paper; JARVIS infrastructure]. Oxides are well represented in this source distribution, so the oxide arm is structured to show best-case transfer behaviour. Fine-tuning and from-scratch runs use Hyperparameter Set 1 (epochs = 50, lr = 1e-4, batch = 16); zero-shot is a shared evaluation of the unmodified pretrained model on the fixed oxide test set of 1,484 structures.

### 1.3 Our findings (stated up front; argued in §§2–5 below)

The oxide evidence supports three claims:

1. The pretrained ALIGNN checkpoint already performs very well on oxides: zero-shot MAE is 0.0342 eV/atom on 1,484 test structures, and Set 1 fine-tuning does **not** surpass this baseline at any N ∈ {10, 50, 100, 200, 500, 1000}.
2. After an N=10 checkpoint-like artefact (mean best epoch = 1.0, meaning the best validation epoch is essentially the pretrained initialization), fine-tuning begins real optimization at N=50, degrades briefly relative to zero-shot, then recovers and converges toward — but not below — the zero-shot line by N=1000 (mean MAE 0.0417 ± 0.0053 eV/atom).
3. Pretrained initialization is vastly better than random initialization at both data sizes where a from-scratch comparison exists: at N=50 the gap is 0.504 eV/atom and at N=500 it is 0.221 eV/atom in favour of fine-tuning, even though fine-tuning itself does not beat the zero-shot baseline.

The oxide embedding results (last_alignn_pool) corroborate the picture by showing that oxides form a highly cohesive, recoverable cluster in the pretrained representation, but embeddings give descriptive support only: they do not by themselves explain why fine-tuning fails to improve on zero-shot.

---

## 2. Zero-shot as the oxide performance ceiling

### 2.1 Literature context

Pretrained crystal-GNN checkpoints are typically used in one of two modes: zero-shot evaluation as a baseline reference, and fine-tuning as a proposed improvement [CITE: Lee & Asahi 2021; Choudhary & DeCost 2021]. In chemistries well represented in the source training set, zero-shot can already be competitive [CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]. The oxide arm falls into that regime.

### 2.2 Our implementation

The zero-shot evaluation uses the unmodified `jv_formation_energy_peratom_alignn` checkpoint and the fixed oxide test set of 1,484 structures drawn from JARVIS dft_3d. No target-family gradient updates are applied. This is the same test set used for every Set 1 oxide fine-tuning and from-scratch row, so zero-shot and fine-tune MAEs are directly comparable.

### 2.3 Our findings

Zero-shot oxide MAE is **0.0342 eV/atom** on n = 1,484. This is the best single oxide performance we observe at any point in the Set 1 main experiments. Every Set 1 fine-tuning row sits above this line:

| N    | Fine-tune mean MAE (eV/atom) | Gap vs zero-shot (eV/atom) |
|-----:|-----------------------------:|---------------------------:|
| 10   | 0.0417                       | +0.0075                    |
| 50   | 0.0523                       | +0.0181                    |
| 100  | 0.0465                       | +0.0123                    |
| 200  | 0.0457                       | +0.0115                    |
| 500  | 0.0430                       | +0.0088                    |
| 1000 | 0.0417                       | +0.0075                    |

**Interpretation we can make.** The pretrained checkpoint already captures oxide-relevant chemistry well enough that small- and moderate-size oxide fine-tuning sets under Set 1 cannot improve on it. The right framing is not "fine-tuning beats zero-shot" (it does not) but "zero-shot is the ceiling under the canonical oxide protocol, and fine-tuning approaches that ceiling from above."

**Interpretation we should resist.** We cannot claim that no oxide fine-tuning protocol could ever improve on zero-shot. Set 2 and Set 3 are robustness-only namespaces and must not be brought in here. The honest scope is: under Set 1, with the fixed test set and 5-seed fine-tuning runs, zero-shot is not surpassed.

---

## 3. The Set 1 fine-tuning trajectory: recovery, not monotonic gain

### 3.1 Literature context

Fine-tuning a pretrained GNN with small amounts of labelled target-domain data is commonly reported to improve task metrics in a roughly monotonic way [CITE: Lee & Asahi 2021; Kim et al. 2024], with the largest per-sample benefit at low N. For in-distribution targets, that benefit can be small because the pretrained model is already close to optimal [CITE: Choudhary et al. 2024].

### 3.2 Our implementation

Set 1 fine-tuning uses 5 seeds per N, with N ∈ {10, 50, 100, 200, 500, 1000} and the same 1,484-structure oxide test set across all rows. The reported numbers are averages of per-seed test MAEs, with standard deviations computed across seeds. `mean_best_epoch` reports the epoch at which the best validation MAE was obtained, averaged across seeds.

### 3.3 Our findings

Three patterns stand out in the canonical fine-tuning table.

First, the N=10 row is a **checkpoint-like artefact**, not low-data adaptation. Its `mean_best_epoch = 1.0` indicates that validation improved negligibly or not at all during the fine-tuning run, so the "best" checkpoint is essentially the pretrained initialization. The strong-looking N=10 MAE (0.0417 eV/atom) is therefore a measurement of the pretrained model on the same test set, not evidence that 10 oxide structures are enough to adapt it.

Second, genuine optimization starts at **N=50**, where `mean_best_epoch = 18.5`. This is also the worst fine-tuned row (0.0523 eV/atom). The trajectory then recovers: N=100 → 0.0465, N=200 → 0.0457, N=500 → 0.0430, N=1000 → 0.0417 eV/atom. The N=50 dip is the expected small-data penalty when real gradient updates begin but the training set is too small to recover the pretrained representation's quality. `mean_best_epoch` rises to around 35–39 from N=200 onward, consistent with increasingly stable multi-epoch optimization.

Third, **cross-seed variability tightens monotonically** with N once fine-tuning is active: standard deviation falls from 0.0111 at N=10 to 0.0148 at N=50, then 0.0086, 0.0086, 0.0062, and finally 0.0053 at N=1000. This is the strongest evidence that oxide fine-tuning becomes more reproducible with more data, even while the mean does not cross the zero-shot line.

**On saturation — the careful version.** The MAE deltas shrink at high N: N=200 → N=500 improves by 0.0027 eV/atom, and N=500 → N=1000 improves by 0.0013 eV/atom. Variability also flattens. Taken together, this is **consistent with flattening of the learning curve** in the N ≥ 500 region. It is not a clean saturation-at-an-optimum pattern, because the asymptote the curve is approaching is the zero-shot baseline it cannot cross, not a fine-tuning-specific minimum. The accurate framing is: under Set 1, the fine-tuning curve appears to flatten as it approaches the zero-shot ceiling from above, with a reasonable read that additional oxide data beyond N = 1000 would yield diminishing returns unless the protocol is changed. We should avoid asserting a specific saturation point; we only have six N values and no fine-tuning data beyond N = 1000.

The parity plots at the two canonical endpoints support this reading without adding new content:

| Figure                       | On-figure MAE | RMSE   | R²     | Mean best epoch | Read                                                      |
|------------------------------|--------------:|-------:|-------:|----------------:|-----------------------------------------------------------|
| `FIG_S1_PARITY_OXIDE_N10`    | 0.0391        | 0.0699 | 0.9944 | 1.0             | Near-pretrained checkpoint view.                          |
| `FIG_S1_PARITY_OXIDE_N1000`  | 0.0383        | 0.0706 | 0.9943 | 35.5            | Genuine high-N optimization with tighter cross-seed runs. |

The panels look visually similar because oxide zero-shot already works well; the meaningful difference is the optimization depth behind each panel, not the geometry of the scatter. (Note: parity MAEs are computed after averaging predictions across seeds, while the summary-table MAEs average per-seed MAEs; the two numbers should not be swapped.)

---

## 4. Pretrained-vs-scratch: the strongest oxide-side evidence for transfer value

### 4.1 Literature context

The standard way to quantify transfer-learning benefit in materials GNNs is to compare fine-tuning from a pretrained checkpoint against training the same architecture from scratch on the same task data [CITE: Lee & Asahi 2021; Kim et al. 2024; Hu et al. 2024]. In chemistry-aligned low-data regimes, pretrained initialization typically dominates by a wide margin [CITE: Lee & Asahi 2021].

### 4.2 Our implementation

We trained randomly-initialized ALIGNN models on the same oxide training splits used for fine-tuning, at N = 50 and N = 500, with 5 seeds each, using the same Hyperparameter Set 1. The same 1,484-structure oxide test set is used. Scratch baselines at N ∈ {10, 100, 200, 1000} are **not** in this experimental scope and are not reported.

### 4.3 Our findings

| N   | Fine-tune mean MAE | From-scratch mean MAE | Scratch − fine-tune | Scratch − zero-shot |
|----:|-------------------:|----------------------:|--------------------:|--------------------:|
| 50  | 0.0523 ± 0.0148    | 0.5561 ± 0.0523       | +0.5038             | +0.5219             |
| 500 | 0.0430 ± 0.0062    | 0.2643 ± 0.0228       | +0.2214             | +0.2301             |

Two things are clear in these numbers.

First, the pretrained route is **dramatically** better than the scratch route at both data sizes. At N=50, scratch is ~10.6× the fine-tune MAE; at N=500 it is ~6.2×. This is the most visually and quantitatively striking oxide-side result we have.

Second, the gap narrows as N grows. Scratch improves substantially from N=50 to N=500 (0.556 → 0.264 eV/atom), while fine-tune improves modestly (0.052 → 0.043 eV/atom). This is consistent with the expectation that randomly-initialized ALIGNN would eventually become competitive given enough oxide data, but that regime is not accessed within our experimental scope.

**Why this matters for the report's narrative.** The oxide arm's best-case-transfer story does not rest on fine-tuning beating zero-shot. It rests on the pretrained-over-scratch gap: even where fine-tuning cannot improve on zero-shot, the pretrained representation delivers an enormous labelled-data saving relative to scratch. In the two scratch-tested regimes, the oxide arm is showing that transfer is working at the initialization level, not at the fine-tuning-update level.

**Scope limits we should respect.** We cannot extrapolate the scratch curve to N ∈ {10, 100, 200, 1000}. Any claim about "data efficiency" must be phrased in terms of the two measured points plus the trajectory's direction, not an assumed smooth curve.

---

## 5. Oxide embedding analysis: what it supports, and where it stops

### 5.1 Literature context

Embedding-level analyses of pretrained GNNs have been used to show that crystal representations cluster by chemical family, composition space, or structural motif [CITE: Choudhary & DeCost 2021; Choudhary 2025]. Subsequent work on OOD prediction has argued that the structure of the pretrained representation predicts where the model generalizes well and where it does not [CITE: Hu et al. 2024; Li et al. 2025, OOD; Li et al. 2025, adversarial; Omee et al. 2024]. These analyses are typically framed as **consistent-with** rather than **causal** evidence.

### 5.2 Our implementation

We extract pretrained embeddings at the `last_alignn_pool` layer (256-dimensional) for the fixed oxide and nitride test sets. Raw-space metrics (silhouette score, Davies–Bouldin index, 15-NN family purity, logistic-regression family AUC) are computed on these 256-D vectors. Projection methods (PCA, t-SNE, UMAP) are used only as descriptive visuals; all quantitative claims come from the raw-space numbers.

### 5.3 Our findings

The oxide side of the embedding analysis shows a **highly cohesive oxide region** in the pretrained representation:

| Metric                          | Value    |
|---------------------------------|---------:|
| Overall silhouette              | 0.2392   |
| Oxide silhouette                | 0.2546   |
| 15-NN family purity, overall    | 0.9655   |
| 15-NN family purity, oxide      | 0.9872   |
| Logistic-regression family AUC  | 0.9994   |

For the oxide standalone report, this supports one limited statement: the pretrained ALIGNN already places oxides in a tight, well-separated region of its representation space, and local neighborhoods in that region are almost purely oxide (15-NN purity 0.9872). This is **consistent with** the observation that zero-shot performs well and fine-tuning fails to move meaningfully below it.

**What the embedding evidence does not do for the oxide report.**

- It does not prove that oxide-region cohesion is why zero-shot works; the arrow runs only one way, and only descriptively.
- It does not say anything specific about oxide fine-tuning dynamics or saturation. `mean_best_epoch` and cross-seed std are the right diagnostics for those questions, not embedding metrics.
- The strongest distance-error result in the embedding analysis is a **nitride-facing** one: hard nitrides are farther from their 5 nearest oxide neighbors in `last_alignn_pool` space than easy nitrides (Spearman 0.343, FDR q ≈ 1.3×10⁻⁴; hard-minus-easy mean 5NN distance gap 0.817, FDR q ≈ 1.8×10⁻⁴). That result belongs to the nitride or combined paper. The oxide standalone report should forward-reference it at most.

**Projection guardrail.** PCA, t-SNE, UMAP panels can appear as visual support in the oxide report, but any numeric claim must come from the raw 256-D metrics, not from apparent distances or cluster sizes in the 2-D projections.

---

## 6. Synthesis: the oxide arm's message

Putting the four evidence strands together:

1. The pretrained ALIGNN checkpoint reaches **0.0342 eV/atom** on 1,484 oxide test structures with no target-family updates. That is the best oxide performance we observe anywhere in the Set 1 main experiments.
2. Set 1 fine-tuning does not improve on that baseline at any N up to 1,000. It recovers from a small-N penalty, flattens in the high-N region, and becomes substantially more reproducible (std 0.0111 → 0.0053 eV/atom). The behaviour is consistent with convergence toward the zero-shot ceiling, not with crossing it.
3. Pretrained initialization beats random initialization by very large margins at both scratch-tested points (0.504 eV/atom at N=50; 0.221 eV/atom at N=500). This is the oxide report's clearest evidence that transfer is providing real labelled-data savings, even without an improvement over zero-shot.
4. Pretrained embeddings place oxides in a cohesive, easily recoverable region of representation space (15-NN purity 0.9872, logistic AUC 0.9994). This is consistent with the above picture but does not explain it on its own.

The oxide report's honest headline is therefore: **in the in-distribution oxide control, the pretrained formation-energy ALIGNN checkpoint is already near its best under Set 1, fine-tuning approaches that ceiling without crossing it, and the pretrained-over-scratch gap is the cleanest on-oxide signature of transfer value.** This is also the frame the nitride report needs, because the domain-shift penalty there should be measured relative to the oxide control's best-case behavior, not relative to a hypothetical fine-tuning-beats-zero-shot story that the oxide data do not support.

---

## 7. Open questions and limitations (for Discussion)

- **Protocol-sensitivity of the zero-shot ceiling.** We observe zero-shot as the ceiling under Set 1. Whether a different hyperparameter regime (Set 2, Set 3, or other) could change that is explicitly out of scope for the main oxide narrative and should only be discussed as a robustness caveat.
- **Unmeasured scratch points.** The N ∈ {10, 100, 200, 1000} scratch baselines are not in scope. The oxide report should not imply a smooth scratch learning curve across all N.
- **Saturation language.** The flattening we observe at N ≥ 500 is suggestive, not decisive. We have six data points and no N > 1,000 fine-tuning. The report should phrase this as "approach toward the zero-shot baseline" or "flattening of the fine-tuning curve," not as a demonstrated saturation.
- **Embedding causality.** Embedding cohesion is descriptive. It supports the interpretation that the pretrained model is familiar with oxides, but does not prove that familiarity is responsible for zero-shot performance. This should be stated explicitly.
- **Generalization to other oxide properties.** Our target is formation energy per atom. Whether the same pattern holds for other oxide properties is not demonstrated by this work and should not be asserted.

---

## 8. Recommended framing for Results and Discussion

For the Results section: present in the order **zero-shot → fine-tuning-by-N → fine-tune-vs-scratch → embedding bridge**, mirroring the evidence hierarchy above. Each subsection should follow the project's 5-step template (what is compared; what the figure/table shows; what pattern is consistent; what interpretation is justified; what is uncertain).

For the Discussion section, the load-bearing claims are:

1. Pretrained ALIGNN is already well matched to oxide formation-energy prediction; fine-tuning under Set 1 does not improve on zero-shot.
2. Transfer value shows up as a massive pretrained-over-scratch gap in the two scratch-tested regimes, not as a fine-tune-over-zero-shot gap.
3. The oxide embedding structure is consistent with, but does not by itself explain, these observations.
4. The nitride arm should be read against this best-case control, not against an idealized fine-tune-beats-zero-shot expectation.

Everything else — projection-level embedding geometry, Set 2/3 comparisons, scratch behavior at unmeasured N — either belongs to the appendix, the combined paper, or the nitride report.
