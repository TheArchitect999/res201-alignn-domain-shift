# Oxide Analysis Document (v3)

**Role in the project.** Internal analysis memo for the oxide standalone report. Converts the canonical oxide evidence — zero-shot, Set 1 fine-tuning across N, Set 1 from-scratch at N ∈ {50, 500}, and raw-space `last_alignn_pool` family-separation metrics — into an interpretive narrative for Results and Discussion.

**Identity of the oxide paper.** The oxide report is a **control-arm paper**. Its contribution is disciplined in-distribution evidence that calibrates the broader study's claims about pretraining value and data efficiency. It is neither a dramatic failure case nor a breakthrough result. Its scientific weight comes from being the clean reference condition against which the nitride arm's domain-shift penalty is measured.

**Status.** Pre-writing analysis. All numerical claims are quoted from `canonical_numbers_v2.md`, `oxide_results_packet.md`, and `oxide_analysis_packet.md`; no numbers are invented here. Citation markers use the placeholder form `[CITE: …]` for later substitution. The analysis follows the three-layer discipline of the project instructions: literature context, our implementation, and our findings are kept separate within each section.

---

## 1. What the oxide arm is designed to establish

### 1.1 Literature context

Graph neural networks for crystal property prediction were established by CGCNN [CITE: Xie & Grossman 2018] and extended with line-graph bond-angle features in ALIGNN [CITE: Choudhary & DeCost 2021]. Large, pretrained crystal-GNN checkpoints are deployed at scale through the JARVIS infrastructure and JARVIS-Leaderboard [CITE: Choudhary et al. 2020; Choudhary et al. 2024] and benchmarked across many targets in Matbench [CITE: Dunn et al. 2020]. Prior transfer-learning work has shown that reusing pretrained representations is most effective when the target family is chemically close to the training regime [CITE: Lee & Asahi 2021; Kim et al. 2024], while domain-adaptation studies have shown that family-level chemical shifts degrade transfer [CITE: Hu et al. 2024; Omee et al. 2024; Li et al. 2025 — OOD; Li et al. 2025 — adversarial].

### 1.2 Our implementation

The oxide arm is structured within this study as the **in-distribution control condition by project design**. All oxide experiments start from the pretrained `jv_formation_energy_peratom_alignn` checkpoint; fine-tuning and from-scratch runs use Hyperparameter Set 1 (epochs = 50, learning rate = 1 × 10⁻⁴, batch size = 16); zero-shot is a shared evaluation of the unmodified checkpoint on the fixed oxide test set of 1,484 structures. We do not make independent claims about the exact chemical composition of the pretraining corpus; oxides are the chemistry-aligned control arm as defined by this project, and the nitride arm (reported in the companion paper) is the out-of-distribution counterpart.

### 1.3 Our findings (stated up front; argued in §§2–5 below)

The oxide arm supports four load-bearing claims, stated in the order of scientific weight for this report:

1. **Pretrained initialization dominates random initialization by a large margin at both oxide scratch-tested sizes.** At N = 50 the transfer-benefit gap is 0.504 eV/atom; at N = 500 it is 0.221 eV/atom. This is the oxide arm's central evidence that transfer is delivering real labelled-data savings on the control task.
2. **The pretrained checkpoint is already strong on oxides.** Zero-shot reaches 0.0342 eV/atom MAE on 1,484 test structures, which is the best observed oxide performance under Set 1 anywhere in this study.
3. **Set 1 fine-tuning does not surpass that benchmark at any tested N ∈ {10, 50, 100, 200, 500, 1000}.** After an N = 10 near-pretrained checkpoint row (`mean_best_epoch = 1.0`, carrying the lighter `zero_shot_checkpoint_at_low_N` flag) and an N = 50 small-data penalty, the mean test MAE converges toward the zero-shot benchmark from above, reaching 0.0417 ± 0.0053 eV/atom at N = 1,000, with cross-seed variability narrowing from 0.0111 to 0.0053 eV/atom.
4. **The pretrained `last_alignn_pool` representation places oxides in a cohesive, locally pure region** (15-NN family purity 0.9872; oxide silhouette 0.2546), descriptively consistent with the behavioural picture above.

The oxide arm's headline is therefore not "fine-tuning improves on zero-shot" (it does not, under Set 1) but "pretrained initialization delivers a very large advantage over scratch on a chemistry-aligned target, while the zero-shot benchmark remains the best observed oxide performance at all tested data sizes." This is the disciplined control evidence the combined study relies on.

---

## 2. Zero-shot performance on oxides under Set 1

### 2.1 Literature context

Pretrained crystal-GNN checkpoints are typically used either as a zero-shot baseline reference or as a starting point for fine-tuning [CITE: Lee & Asahi 2021; Choudhary & DeCost 2021]. On chemistry-aligned targets, zero-shot performance can be strong enough that additional supervised fine-tuning yields only modest gains [CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]. The oxide arm operates in that regime.

### 2.2 Our implementation

Zero-shot evaluation uses the unmodified pretrained checkpoint on the 1,484-structure oxide test set. No target-family gradient updates are applied. The same 1,484-structure test set is used for every Set 1 oxide fine-tuning row and every Set 1 oxide from-scratch row, so zero-shot, fine-tune, and scratch MAEs are directly comparable.

### 2.3 Our findings

Zero-shot oxide MAE is **0.0342 eV/atom** on n = 1,484. This is the best observed oxide performance under Set 1 in the canonical experiments; every Set 1 fine-tuning row sits above it (see §3), and every Set 1 from-scratch row sits far above it (see §4).

| N    | Fine-tune mean MAE (eV/atom) | Gap vs zero-shot (eV/atom) |
|-----:|-----------------------------:|---------------------------:|
| 10   | 0.0417                       | +0.0075                    |
| 50   | 0.0523                       | +0.0181                    |
| 100  | 0.0465                       | +0.0123                    |
| 200  | 0.0457                       | +0.0115                    |
| 500  | 0.0430                       | +0.0088                    |
| 1000 | 0.0417                       | +0.0075                    |

**Interpretation we can make.** Under the canonical Set 1 protocol, zero-shot is not surpassed at any tested oxide fine-tuning size. The appropriate framing is not "fine-tuning beats zero-shot" (it does not) but "zero-shot is the best observed oxide performance under Set 1, and fine-tuning approaches it from above."

**Interpretation we should resist.** We do not claim that no oxide protocol can ever improve on zero-shot. The honest scope is: under Set 1, with the fixed oxide test set and 5-seed fine-tuning runs, zero-shot is not surpassed. Set 2 and Set 3 are robustness-only namespaces and are not used as main evidence.

---

## 3. The Set 1 fine-tuning trajectory: recovery, not monotonic gain

### 3.1 Literature context

Fine-tuning pretrained GNNs with small amounts of target-domain data is commonly reported to improve task metrics in a roughly monotonic way [CITE: Lee & Asahi 2021; Kim et al. 2024], with the largest per-sample benefit at low N. When the pretrained model is already strong on the target, however, that benefit can be small or absent [CITE: Choudhary et al. 2024].

### 3.2 Our implementation

Set 1 fine-tuning uses 5 seeds per N, with N ∈ {10, 50, 100, 200, 500, 1000} and the same 1,484-structure oxide test set across all rows. Reported numbers are averages of per-seed test MAEs, with standard deviations computed across seeds. `mean_best_epoch` reports the epoch at which the best validation MAE was obtained, averaged across seeds.

### 3.3 Our findings

Three patterns are visible in the canonical fine-tuning table (see §1.3 summary for values).

First, the **N = 10 row is a near-pretrained-checkpoint view**, not low-data adaptation. `mean_best_epoch = 1.0` indicates that validation improved negligibly during fine-tuning, so the retained checkpoint is effectively the pretrained initialization. This row carries the lighter `zero_shot_checkpoint_at_low_N` flag in the canonical numbers file.

Second, **genuine optimization begins at N = 50**, where `mean_best_epoch = 18.5`; this is also the worst fine-tuned row (0.0523 eV/atom). The trajectory then recovers: N = 100 → 0.0465, N = 200 → 0.0457, N = 500 → 0.0430, N = 1000 → 0.0417 eV/atom. The N = 50 dip is the expected small-data penalty when real gradient updates begin but the training set is not yet large enough to re-match the pretrained representation's quality. `mean_best_epoch` stabilizes at 35–39 epochs from N = 200 onward, consistent with sustained multi-epoch optimization.

Third, **cross-seed variability tightens monotonically with N** once fine-tuning is active: standard deviation falls from 0.0111 at N = 10 to 0.0148 at N = 50, then 0.0086, 0.0086, 0.0062, and 0.0053 at N = 1000. This is the clearest trend in the oxide fine-tuning table: the learning curve becomes more reproducible with more data, even as the mean fails to cross the zero-shot benchmark.

**On saturation — the careful version.** Late-N decrements are small (N = 500 → N = 1000 improves the mean by 0.0013 eV/atom) and variability flattens. This is **consistent with flattening of the learning curve** as it approaches the zero-shot benchmark from above. It is not a clean saturation-at-an-optimum pattern, because the asymptote the curve is approaching is the zero-shot line it does not cross, not a fine-tuning-specific minimum. We describe this as "flattening toward the zero-shot benchmark" or "convergence from above," not as a demonstrated saturation. Only six N values are tested and no fine-tuning data exist above N = 1,000.

**Parity-plot support.** The paired parity plots at the two canonical endpoints — `FIG_S1_PARITY_OXIDE_N10` (on-figure MAE 0.0391, RMSE 0.0699, R² 0.9944, `mean_best_epoch = 1.0`) and `FIG_S1_PARITY_OXIDE_N1000` (on-figure MAE 0.0383, RMSE 0.0706, R² 0.9943, `mean_best_epoch = 35.5`) — look visually similar because zero-shot already handles oxides well. The meaningful difference between the two panels is not the geometry of the scatter but the optimization depth behind them and the cross-seed stability (std 0.0111 → 0.0053). A technical note for the report: parity MAEs are computed after averaging predictions across seeds, whereas the summary-table MAEs average per-seed MAEs; the two values should not be swapped.

---

## 4. Pretrained-vs-scratch: the central oxide result

### 4.1 Literature context

The standard way to quantify transfer-learning benefit in materials GNNs is to compare fine-tuning from a pretrained checkpoint against training the same architecture from scratch on the same task data [CITE: Lee & Asahi 2021; Kim et al. 2024; Hu et al. 2024]. In chemistry-aligned low-data regimes, pretrained initialization typically dominates by a wide margin [CITE: Lee & Asahi 2021].

### 4.2 Our implementation

We trained randomly-initialized ALIGNN models on the same oxide training splits used for fine-tuning, at N = 50 and N = 500, with 5 seeds each, using the same Hyperparameter Set 1 and the same 1,484-structure oxide test set. Scratch baselines at N ∈ {10, 100, 200, 1000} are **not** in scope and are not reported.

### 4.3 Our findings

This comparison is the oxide arm's clearest on-family signature of transfer value, and it is the result the oxide report is built around.

| N   | Fine-tune mean MAE | From-scratch mean MAE | Scratch − fine-tune | Scratch − zero-shot |
|----:|-------------------:|----------------------:|--------------------:|--------------------:|
| 50  | 0.0523 ± 0.0148    | 0.5561 ± 0.0523       | +0.5038             | +0.5219             |
| 500 | 0.0430 ± 0.0062    | 0.2643 ± 0.0228       | +0.2214             | +0.2301             |

Two observations dominate.

First, **the pretrained route is dramatically better than the scratch route at both data sizes**. At N = 50 the scratch MAE is roughly 10.6× the fine-tune MAE; at N = 500 it is roughly 6.2×. Scratch is also substantially worse than zero-shot by similar margins (0.522 eV/atom at N = 50; 0.230 eV/atom at N = 500).

Second, **the transfer-benefit gap narrows with N**. Scratch improves substantially from N = 50 to N = 500 (0.556 → 0.264 eV/atom) while fine-tune improves only modestly (0.052 → 0.043 eV/atom), because fine-tune is already bounded near the zero-shot benchmark. The pretrained-over-scratch gap therefore falls from 0.504 to 0.221 eV/atom as N grows from 50 to 500. We do not extrapolate either curve beyond these two points.

**Why this is the central oxide result.** The oxide arm's best-case-transfer story does not rest on fine-tuning beating zero-shot — it does not, under Set 1. It rests on this comparison. Even where fine-tuning cannot improve on the zero-shot benchmark, the pretrained representation delivers an enormous labelled-data saving relative to scratch. A useful internal contrast makes the point sharp: at N = 500, fine-tuning sits 0.221 eV/atom below scratch while sitting only 0.009 eV/atom above zero-shot, so under Set 1 at N = 500 the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark. This is the oxide report's disciplined evidence that transfer is real and valuable on the chemistry-aligned control task.

**Scope limits.** Scratch is measured at only two data sizes. We do not extrapolate a continuous scratch learning curve to N ∈ {10, 100, 200, 1000} and we do not claim where, if anywhere, scratch would intersect fine-tune or zero-shot at much larger N.

---

## 5. Oxide embeddings: a cohesive, locally pure region

### 5.1 Literature context

Embedding-level analyses of pretrained GNNs have been used to show that crystal representations cluster by chemical family, composition space, or structural motif [CITE: Choudhary & DeCost 2021; Choudhary 2025]. Subsequent OOD work has argued that the structure of the pretrained representation correlates with where the model generalizes well [CITE: Hu et al. 2024; Li et al. 2025 — OOD; Li et al. 2025 — adversarial; Omee et al. 2024]. Such analyses are framed as **consistent-with** rather than **causal** evidence.

### 5.2 Our implementation

We extract pretrained embeddings at the `last_alignn_pool` layer (256-D) for the fixed oxide and nitride test sets and compute raw-space family-separation metrics: silhouette score (overall and per family), Davies–Bouldin index, 15-NN family purity, and logistic-regression family AUC. All quantitative claims come from the raw 256-D vectors; PCA, t-SNE, and UMAP are descriptive projections and are not used for numerical claims. `last_alignn_pool` is the primary main-text layer; `pre_head` and `last_gcn_pool` are appendix-support.

### 5.3 Our findings

The oxide side of the embedding analysis yields a self-contained, oxide-specific payoff for this report: in the pretrained representation, **oxides form a cohesive, locally pure region**, and the family label is almost perfectly recoverable from raw embeddings.

| Metric                              | Value    |
|-------------------------------------|---------:|
| Overall silhouette                  | 0.2392   |
| Oxide silhouette                    | 0.2546   |
| 15-NN family purity, overall        | 0.9655   |
| 15-NN family purity, oxide          | 0.9872   |
| Logistic-regression family AUC      | 0.9994   |

The oxide-side numbers carry three concrete implications for this report. First, **oxide local neighbourhoods in pretrained space are almost entirely oxide-only** (15-NN family purity 0.9872): there is no meaningful cross-family contamination of the oxide region. Second, **the oxide region is internally more coherent than the nitride region** (oxide silhouette 0.2546 vs nitride 0.1453 — reported here only to calibrate what "cohesive" means quantitatively). Third, the family label is recoverable with near-perfect separability (AUC 0.9994), showing that the pretrained representation already organizes the test set along the oxide/non-oxide axis without any supervision on that axis.

**What this adds to the oxide report.** The embedding evidence gives the oxide paper a representation-level picture that is consistent with its behavioural results: oxides occupy a tight, internally coherent neighborhood in pretrained space, and the model's strong zero-shot performance and the flattening of the fine-tuning curve are both consistent with that geometry. This is a real oxide-specific finding, not a handoff.

**What this does not claim.** Cohesion in the pretrained representation is descriptive and correlational; we do not claim it causes the behavioural results. Quantitative distance-error mechanisms relating representation geometry to prediction error are nitride-facing and are developed in the nitride and combined manuscripts; the oxide report forward-references them only. Projection panels (PCA, t-SNE, UMAP) are visual support for this subsection; all numerical claims use the raw 256-D metrics.

---

## 6. Synthesis: what the oxide arm proves

Stated in the order that best reflects the evidence's scientific weight:

1. **Pretrained initialization is dramatically better than random initialization on oxides at both scratch-tested sizes.** Transfer-benefit gaps of 0.504 eV/atom at N = 50 and 0.221 eV/atom at N = 500 against the same test set, under the same Set 1 protocol. This is the oxide arm's central on-family evidence that transfer works, and it is the result the oxide standalone report is built around.
2. **Pretrained zero-shot performance on oxides is already strong.** 0.0342 eV/atom MAE on 1,484 test structures is the best observed oxide performance under Set 1 in this study.
3. **Set 1 fine-tuning does not surpass that benchmark at any tested N.** After a near-pretrained-checkpoint row at N = 10 and a small-data penalty at N = 50, the mean converges toward the zero-shot benchmark from above and becomes substantially more reproducible (std 0.0111 → 0.0053). The observed flattening at high N is consistent with convergence toward the zero-shot line, not with crossing it.
4. **Pretrained embeddings place oxides in a cohesive, locally pure region** (15-NN purity 0.9872, family AUC 0.9994). This is a real representation-level finding that is consistent with — but does not on its own explain — the behavioural picture.

The oxide arm's honest headline is therefore: **on the in-distribution control task, pretraining delivers a very large advantage over scratch, the zero-shot benchmark is already strong and not surpassed under Set 1 fine-tuning, and the pretrained representation places oxides in a tight, well-separated region that is consistent with that behaviour.** This is the reference condition the nitride arm's domain-shift penalty is measured against.

---

## 7. Open questions and limitations (for Discussion)

- **Protocol-sensitivity of the zero-shot result.** We observe zero-shot as the best Set 1 oxide performance. Whether a different protocol could change that is out of scope for the main narrative and belongs in a robustness caveat.
- **Unmeasured scratch points.** Scratch baselines exist only at N = 50 and N = 500. The report should not imply a smooth scratch learning curve across other N.
- **Saturation language.** The flattening at N ≥ 500 is suggestive, not decisive. With only six N values and no fine-tuning above N = 1,000, we describe this as flattening toward the zero-shot benchmark rather than as a demonstrated saturation.
- **Embedding causality.** Embedding cohesion is descriptive. It supports the interpretation that the pretrained model is organized around chemical family, but does not prove that this organization causes the behavioural results.
- **Generalization beyond formation energy.** The target is formation energy per atom. The report does not claim the same pattern for other oxide properties.
- **Checkpoint provenance.** The checkpoint is the pretrained formation-energy ALIGNN model; the report does not characterize its training corpus chemically and should not be described as "oxide-pretrained."

---

## 8. Recommended framing for Results and Discussion

**Results order (matches blueprint v3 rows 3–7).** Present in the order **zero-shot → fine-tuning → parity → pretrained-vs-scratch → embedding bridge**. Each subsection follows the project's 5-step template (what is compared; what the figure/table shows; what pattern is consistent; what interpretation is justified; what is uncertain). The scratch subsection is the rhetorical anchor; the text before it should set up the control benchmark and the fine-tuning behaviour in a way that makes the scratch comparison land as the headline transfer-value result.

**Discussion load-bearing claims.**

1. On the in-distribution control task, pretrained initialization delivers a very large and consistent advantage over scratch in the data regime studied.
2. Pretrained zero-shot is already strong on oxides and is the best observed Set 1 oxide performance; Set 1 fine-tuning does not surpass it.
3. The oxide arm's fine-tuning curve flattens toward the zero-shot benchmark as data grows, with substantially improved cross-seed reproducibility at high N.
4. Pretrained embeddings place oxides in a cohesive, locally pure region, consistent with — but not causal explanation of — the above.
5. The nitride arm should be read against this disciplined control, not against an idealized fine-tune-beats-zero-shot expectation.

Everything else — projection-level embedding geometry, Set 2/3 comparisons, scratch behaviour at unmeasured N, the nitride distance-error mechanism — belongs to the appendix, the combined paper, or the nitride standalone report.
