# Nitride Analysis Document

**Role in the project.** This document is the written analytical companion to the nitride arm of the RES201 pretrained-ALIGNN study. It is not the Results section. Its job is to take the frozen nitride evidence — zero-shot MAE, Set 1 fine-tuning across `N`, the two from-scratch rows, the parity-plot pair, and the Week 4 embedding tables — and interpret it as a coherent out-of-distribution (OOD) story. Throughout, literature-grounded claims, our implementation choices, and our experimental findings are kept on separate lines so the argument is auditable.

**Scientific thesis this document supports.** Pretraining helps both families, but it is substantially less data-efficient on nitrides than on oxides; the nitride penalty is already visible at the zero-shot checkpoint, persists under the canonical fine-tuning protocol through at least `N = 1000`, and co-varies with geometric distance from the oxide-reference region in the frozen pretrained representation. We treat this as behavioral + representational evidence consistent with a chemical-family domain shift, not as a causal claim about what the network is "doing."

---

## 1. Framing: why nitride is our OOD test

**Literature-grounded claims.** Crystal-graph neural networks such as CGCNN [CITE: Xie2018_CGCNN] and its angle-aware extension ALIGNN [CITE: Choudhary2021_ALIGNN] are trained on broad DFT repositories (e.g., Materials Project [CITE: Jain2013_MP]; JARVIS-DFT [CITE: Choudhary2020_JARVIS]) whose element and bonding statistics are dominated by oxide-heavy chemistries [CITE: Dunn2020_Matbench]. A substantial body of OOD-generalization work on materials GNNs [CITE: Omee2024_OOD_Benchmark; Li2025_OOD_Generalization; Hu2024_DomainAdaptation] reports that family- or composition-held-out splits produce larger errors than random splits, and that transfer-learning gains shrink as the chemical distance between source and target grows [CITE: Lee2021_TransferCGCNN; Kim2024_MeltingT_Transfer]. This motivates treating nitrides — a chemically distinct family with a characteristically different bonding regime (less electronegative anion, higher covalency, different coordination preferences) — as an OOD probe for a formation-energy ALIGNN pretrained on a broad but oxide-dominated corpus.

**Our implementation.** We evaluate the pretrained formation-energy ALIGNN model (`jv_formation_energy_peratom_alignn`) on a fixed-test nitride split of 242 structures filtered from JARVIS `dft_3d`. We deliberately avoid calling this checkpoint "oxide-pretrained": it was pretrained on the broad JARVIS-DFT formation-energy distribution rather than on oxides per se. We then fine-tune on six target-family budgets `N ∈ {10, 50, 100, 200, 500, 1000}` under Hyperparameter Set 1 (50 epochs, learning rate 1e-4, batch size 16, five random seeds per `N`), with from-scratch ALIGNN baselines available only at `N = 50` and `N = 500`. Zero-shot evaluation and fine-tuning evaluation use the same 242-structure test set, so every comparison shares an identical denominator.

**Our experimental findings, at a glance.** On this test set the pretrained model achieves a nitride zero-shot MAE of 0.0695 eV/atom, roughly twice the oxide-comparator zero-shot MAE of 0.0342 eV/atom (n=1484). No Set 1 fine-tuning budget — including `N = 1000` — recovers this nitride zero-shot baseline on mean test MAE. Pretraining nevertheless delivers a large mean-error advantage over training ALIGNN from scratch at both available scratch-tested sizes (N=50 and N=500). In frozen `last_alignn_pool` space, nitrides and oxides form distinguishable regions, and nitride structures with larger zero-shot prediction error sit farther from the oxide-reference region on average.

---

## 2. The zero-shot domain-shift baseline

**What the evidence is.** From `reports/zero_shot/zero_shot_summary.csv`: nitride zero-shot MAE = 0.0695 eV/atom on n=242; oxide zero-shot MAE = 0.0342 eV/atom on n=1484. Both are evaluated with the same pretrained checkpoint, no target-family training, and parity-style per-structure predictions retained in `Results_Before_Correction/nitride/zero_shot/predictions.csv`.

**What this tells us.** Zero-shot is the cleanest domain-shift probe we have, because it removes every confound introduced by fine-tuning (checkpoint selection, early-stopping behavior, seed-to-seed variance, training-set size). A two-fold MAE gap at the pretrained starting point is therefore the purest behavioral signature of a family-level representational mismatch. It is also the single fact in the report that any later claim about "adaptation" has to be anchored to: fine-tuning is only meaningful if it moves the mean test MAE below this number, and on nitrides that does not happen under Set 1.

**What we are not claiming.** We are not claiming the zero-shot gap is produced by the absence of nitrides in pretraining. The JARVIS-DFT pretraining corpus does include nitrides; it simply contains many more oxides. We are also not claiming that the gap is an intrinsic property of nitrides as a class — it is a property of this checkpoint evaluated on this split.

---

## 3. The fine-tuning trajectory: inert at low `N`, adapted at high `N`, never recovered

The Set 1 fine-tuning table (`finetune_summary_by_N.csv`) has two distinct operational regimes that should not be averaged together in prose. Separating them is the single most important interpretive move in the nitride write-up.

### 3.1 Low-`N` regime (`N ≤ 200`) is effectively inert

**Finding.** At `N = 10, 50, 100, 200`, the mean best epoch across five seeds is exactly `1.0`. This is not a coincidence — it means that for every seed at every one of these four sizes, the validation-tracked "best" checkpoint was the very first epoch. Under our selection rule, the returned fine-tuned model is therefore almost indistinguishable from the zero-shot checkpoint with a single optimizer step applied. The mean test MAEs are `0.0874 ± 0.0199` at N=10, `0.1173 ± 0.0451` at N=50, `0.1722 ± 0.0996` at N=100, and `0.1392 ± 0.0677` at N=200 — all worse than the `0.0695` zero-shot baseline, with the worst mean and by far the largest seed variance at N=100.

**Interpretation.** With 10–200 labeled nitrides, ALIGNN fine-tuning under Set 1 does not produce adaptation in any meaningful sense: either the validation loss increases after epoch 1 and the trainer keeps the epoch-1 checkpoint, or the model updates into a worse region of parameter space. The numerically lowest mean MAE in this band (N=10) is therefore not the "best low-`N` fine-tuning result"; it is an effective zero-shot checkpoint with added epoch-1 perturbation, which happens to land close to zero-shot but still above it.

**Literature grounding.** The pattern — small target-family budgets failing to yield measurable improvement over a pretrained backbone and sometimes degrading it — is consistent with transfer-learning behavior reported in materials-informatics contexts when source and target distributions are mismatched [CITE: Lee2021_TransferCGCNN; Kim2024_MeltingT_Transfer; Hu2024_DomainAdaptation].

### 3.2 High-`N` regime (`N = 500, 1000`) is genuine but partial adaptation

**Finding.** At N=500 the mean best epoch rises to 40.5, and at N=1000 it rises to 45.0. These are the only Set 1 nitride rows in which fine-tuning actually traverses a substantial portion of the 50-epoch budget before validation loss stops improving. The mean test MAEs are `0.0977 ± 0.0178` at N=500 and `0.0907 ± 0.0135` at N=1000. The latter is the tightest nitride fine-tuning row we have, both in mean and in seed variance.

**Interpretation.** Two observations matter here. First, adaptation has switched on — the optimizer is no longer immediately preferring the initialization. Second, adaptation is partial: even the best genuinely-adapted row (`N = 1000`) sits 0.0211 eV/atom above the zero-shot baseline on mean test MAE. Put together, these two facts say that on nitrides, the fine-tuning signal is strong enough at `N ≥ 500` to pull the checkpoint away from the pretrained starting point, but not strong enough under 1000 labeled structures and Set 1 hyperparameters to produce a model that is better on this test set than the checkpoint we started from.

**What we are not claiming.** We are not claiming that nitride fine-tuning is globally useless: a model trained with 40–45 genuine epochs of gradient updates on 500–1000 nitrides is substantively different from zero-shot in its internal state, and can become preferable on downstream uses that zero-shot cannot serve. We are only claiming that on the mean test MAE metric we use for evaluation, no Set 1 row beats zero-shot.

### 3.3 Parity-plot snapshot: two sizes, two stories, one caveat

**Finding.** The two main-text parity figures (`FIG_S1_PARITY_NITRIDE_N10` and `FIG_S1_PARITY_NITRIDE_N1000`) give headline on-figure metrics of MAE 0.0828, RMSE 0.1203, R² 0.9841 at N=10, and MAE 0.0829, RMSE 0.1220, R² 0.9837 at N=1000. These are seed-averaged prediction parity statistics, not the seed-averaged-MAE summaries above (0.0874 and 0.0907 respectively). The distinction is structural, not cosmetic: parity figure MAEs average predictions first and then compute error, while the summary-table MAEs average per-seed errors.

**Interpretation.** The parity figures should be read as complementary to, not substitutes for, the summary table. They show that across both a fully-inert low-`N` snapshot and the best genuinely-adapted high-`N` snapshot, broad parity structure is similar — headline R² ≈ 0.98 in both panels — while the summary table is what changes meaningfully: best-epoch, variance across seeds, and the fine-tune-minus-zero-shot gap. The cleanest reading is that `N` changes the *regime* of fine-tuning more than it changes the overall parity appearance.

---

## 4. The from-scratch comparison: pretraining is valuable, but asymmetric in meaning

**Coverage.** From-scratch nitride baselines exist at only two data sizes: `N = 50` and `N = 500`. All other fine-tuning `N` values lack matched scratch runs and therefore cannot support scratch comparisons.

**Finding.** At `N = 50`, from-scratch MAE is `0.6914 ± 0.0163` vs fine-tuning `0.1173`, a gap of `0.5741 eV/atom`. At `N = 500`, from-scratch MAE is `0.3683 ± 0.0233` vs fine-tuning `0.0977`, a gap of `0.2706 eV/atom`. Both from-scratch means are far above the zero-shot MAE (`0.0695`), confirming that random initialization on nitride alone cannot match what a broadly pretrained ALIGNN gives you on this test set.

**Interpretive split.** These two gaps are not the same kind of evidence, and collapsing them costs the nitride story its rigor:

- The `N = 50` gap is a **pretrained-initialization advantage over scratch, not fine-tuning adaptation.** The fine-tuned model at `N = 50` has `mean_best_epoch = 1.0`, so it is effectively the zero-shot checkpoint. The "gap" therefore measures "zero-shot vs a scratch model trained on 45 structures" — which is almost tautologically large. The right read of this number is: even without *any* adaptation, initializing from a broadly pretrained checkpoint beats initializing from random by an enormous margin at low data.
- The `N = 500` gap is a **clean comparison.** The fine-tuned model at `N = 500` has `mean_best_epoch = 40.5`, so it has actually been adapted. The `0.2706 eV/atom` gap here measures "adapted fine-tuned model vs scratch model trained on the same 450 structures." This is the datapoint that justifies the claim that pretraining remains operationally valuable on nitrides at realistic adaptation regimes, not only at the extreme low-data extrapolation.

**Literature grounding.** That random-initialized GNNs need orders-of-magnitude more data than pretrained ones to reach comparable accuracy on structural property tasks is a standard finding in crystal-graph transfer-learning literature [CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]. Our nitride result is consistent with this; the novel observation here is the asymmetric interpretation required at `N = 50`.

**What we are not claiming.** We are not claiming that scratch would fail to catch up given sufficiently large `N`. We do not have the data to say that. We are also not claiming a constant "transfer benefit" across `N`: the two scratch-tested sizes are of different kinds and should not be interpolated.

---

## 5. Embedding analysis as a mechanistic interpretation layer

The embedding section does not produce a new behavioral number. Its function is to give the behavioral story — nitride penalty at zero-shot, inert low-`N`, partial high-`N` adaptation — a geometric reading in the representation space the pretrained model has already learned. Main-text claims use the raw 256-dimensional `last_alignn_pool` layer; `pre_head` and `last_gcn_pool` are appendix-support layers only.

### 5.1 Families are separated in frozen pretrained space

**Finding.** Quantitative family-separation statistics on the raw 256D `last_alignn_pool` representation give: silhouette 0.2392 overall (oxide 0.2546, nitride 0.1453); Davies–Bouldin 1.8290; 15-nearest-neighbor family purity 0.9655 overall (oxide 0.9872, nitride 0.8331); logistic-regression family AUC 0.9994. A linear probe can therefore recover family labels from the frozen representation essentially perfectly, and local neighborhoods are overwhelmingly single-family — especially on the oxide side.

**Interpretation.** The pretrained network has already built a representation in which oxides and nitrides live in distinguishable regions, without ever being trained to do so. This is what one would expect if it had learned features correlated with chemical family during pretraining on a broad DFT corpus [CITE: Choudhary2021_ALIGNN]. Crucially, the nitride side of this separation is noticeably *looser* than the oxide side: lower silhouette, lower 15-NN purity. The nitride region is recognizable but less internally cohesive, which is consistent with nitrides being the less "native" family for this checkpoint.

**Caveat.** PCA, t-SNE, and UMAP projections serve as descriptive support only; we do not use visual cluster distances as statistical evidence. The ALIGNN tutorial and Week 2 material both caution that t-SNE in particular preserves local neighborhood structure but not global inter-cluster distances in a physically interpretable way [CITE: vanderMaaten2008_tSNE; McInnes2018_UMAP; Choudhary2021_ALIGNN_tutorial].

### 5.2 Nitride prediction difficulty tracks distance from the oxide-reference region

**Finding.** Using all 242 test nitrides and the 13,507-structure oxide train+val pool as a reference region, we compute the mean distance from each nitride test structure to its five nearest oxide neighbors in raw 256D `last_alignn_pool` space. Grouping the 49 hardest nitrides (top 20% by absolute zero-shot error) and the 49 easiest (bottom 20%), the hard group has mean oxide-neighbor distance 4.5988 vs 3.7821 for the easy group — a hard-minus-easy gap of 0.8168 with 95% CI [0.4746, 1.1597] and FDR q = 1.8 × 10⁻⁴. A full-sample Spearman correlation of 0.3428 (95% CI [0.2214, 0.4597], FDR q = 1.3 × 10⁻⁴) shows the same association continuously, without binning.

**Interpretation.** Nitrides that sit farther from the oxide-reference region in frozen pretrained space tend to be the ones on which the pretrained model's zero-shot prediction is worst. This is the geometric counterpart of the zero-shot family gap. The behavioral evidence says "the pretrained checkpoint is worse on nitrides than oxides"; the representational evidence says "and within the nitride family, the gap is largest exactly where the embedding is most unlike the oxide pool."

**What we are not claiming.** We are explicitly not claiming that embedding distance *causes* zero-shot error. The association is correlational. Several plausible common causes — bonding chemistry, coordination, local symmetry — could push a structure both farther from the oxide pool in feature space and into a regime where the pretrained formation-energy head is less reliable. The distance–error relationship is best described as a geometric indicator consistent with a representation-space shift, not as a mechanism proof. This caution is standard for representation-based OOD diagnostics in materials ML [CITE: Omee2024_OOD_Benchmark; Li2025_OOD_AdversarialLearning].

---

## 6. Consolidated reading

The four evidence layers converge on a single OOD-penalty picture:

1. **Zero-shot** already places nitrides at about 2× the oxide baseline MAE on matched evaluation. The family gap exists before any fine-tuning.
2. **Fine-tuning** does not close this gap under Set 1 at any tested `N`. Four of the six `N` budgets (10, 50, 100, 200) are operationally inert by checkpoint-selection criteria, and the two genuinely adapted budgets (500, 1000) remain above zero-shot.
3. **Scratch comparisons** confirm that pretraining remains practically valuable on nitrides — but with an asymmetric reading: the `N = 50` gap quantifies an initialization advantage, and only the `N = 500` gap is a clean adapted-vs-scratch comparison.
4. **Embeddings** tell a consistent geometric story: families are separated in frozen pretrained space; the nitride side is looser than the oxide side; and hard-to-predict nitrides are precisely those farthest from the oxide-reference region.

This is why nitride belongs as the OOD arm of the study. Oxides show what pretrained ALIGNN looks like when chemistry is familiar. Nitrides show what it looks like when chemistry is not — including how the penalty is still partially alive after a thousand labeled target structures of fine-tuning.

---

## 7. Guardrails respected in this document

- No nitride fine-tuning row is described as outperforming zero-shot.
- `N ≤ 200` is never framed as successful adaptation.
- The `N = 50` scratch gap is tagged as pretrained-initialization advantage, not fine-tuning adaptation.
- No scratch comparison is implied outside `N = 50` and `N = 500`.
- The checkpoint is not called "oxide-pretrained."
- Embedding distance is described as correlational / geometric indicator, not as a cause of prediction error.
- Only `last_alignn_pool` is main-text; `pre_head` and `last_gcn_pool` are appendix support.
- Only Hyperparameter Set 1 numbers are used in the main narrative; Set 2 and Set 3 are not invoked here.
- All numeric values trace directly to the nitride analysis and results packets; no values are invented.

---

## 8. Citation placeholders used

`[CITE: Xie2018_CGCNN]`, `[CITE: Choudhary2021_ALIGNN]`, `[CITE: Choudhary2021_ALIGNN_tutorial]`, `[CITE: Jain2013_MP]`, `[CITE: Choudhary2020_JARVIS]`, `[CITE: Dunn2020_Matbench]`, `[CITE: Lee2021_TransferCGCNN]`, `[CITE: Kim2024_MeltingT_Transfer]`, `[CITE: Hu2024_DomainAdaptation]`, `[CITE: Omee2024_OOD_Benchmark]`, `[CITE: Li2025_OOD_Generalization]`, `[CITE: Li2025_OOD_AdversarialLearning]`, `[CITE: vanderMaaten2008_tSNE]`, `[CITE: McInnes2018_UMAP]`.
