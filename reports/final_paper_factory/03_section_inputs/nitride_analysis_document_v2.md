# Nitride Analysis Document (v2)

**Role in the project.** This document is the written analytical companion to the nitride arm of the RES201 pretrained-ALIGNN study. It is not the Results section. Its job is to take the frozen nitride evidence — zero-shot MAE, Set 1 fine-tuning across `N`, the two from-scratch rows, the parity-plot pair, and the Week 4 embedding tables — and read it as a coherent domain-shift story. Throughout, literature-grounded claims, our implementation choices, and our experimental findings are kept on separate lines.

**Scientific thesis.** On the nitride arm, a **domain-shift penalty** is visible at four separable stages under the canonical protocol:

1. **Step 1 — zero-shot family penalty.** Zero-shot evaluation places nitrides at roughly twice the oxide-comparator MAE before any target-family training.
2. **Step 2 — low-`N` fine-tuning inertness.** At `N ∈ {10, 50, 100, 200}` the fine-tuning loop is operationally inert; every selected checkpoint is the epoch-1 state. Oxide, by contrast, has already begun genuine optimization by `N = 50`.
3. **Step 3 — genuine but incomplete high-`N` adaptation.** Fine-tuning becomes operationally adapted at `N = 500` and stabilizes at `N = 1000`, but no tested budget closes the gap to the nitride zero-shot baseline.
4. **Step 4 — embedding-space geometry consistent with the penalty.** In frozen pretrained space, nitrides occupy a distinguishable but less cohesive region than the oxide control, and within the nitride family, distance from the oxide-reference region co-varies with zero-shot error.

These four steps are the spine of the nitride report. Supporting evidence from pretrained-vs-from-scratch comparisons confirms that pretraining remains operationally valuable on nitrides, but the headline OOD result is not merely "pretraining helps"; it is that the penalty survives even after genuine high-`N` adaptation begins.

---

## 1. Framing: nitride as the OOD arm of this study

**Literature-grounded claims.** Crystal-graph neural networks such as CGCNN [CITE: Xie2018_CGCNN] and its angle-aware extension ALIGNN [CITE: Choudhary2021_ALIGNN] are trained on broad DFT repositories (e.g., Materials Project [CITE: Jain2013_MP]; JARVIS-DFT [CITE: Choudhary2020_JARVIS]). The element and bonding statistics of these corpora are consistent with an oxide-skewed reference regime rather than a uniform coverage of chemistries [CITE: Dunn2020_Matbench]. Work on OOD generalization in materials GNNs [CITE: Omee2024_OOD_Benchmark; Li2025_OOD_Generalization; Hu2024_DomainAdaptation] reports that family- or composition-held-out splits produce larger errors than random splits, and that transfer-learning gains shrink as the chemical distance between source and target grows [CITE: Lee2021_TransferCGCNN; Kim2024_MeltingT_Transfer]. Together, these motivate treating nitrides — a chemically distinct family with a less electronegative anion, higher covalency, and different coordination preferences — as an OOD probe for a broadly pretrained formation-energy ALIGNN. This is why nitride functions as the OOD arm in this study.

**Our implementation.** We evaluate the pretrained formation-energy ALIGNN model (`jv_formation_energy_peratom_alignn`) on a fixed-test nitride split of 242 structures filtered from JARVIS `dft_3d`. We then fine-tune on six target-family budgets `N ∈ {10, 50, 100, 200, 500, 1000}` under Hyperparameter Set 1 (50 epochs, learning rate 1e-4, batch size 16, five seeds per `N`), with from-scratch ALIGNN baselines at `N = 50` and `N = 500`. Zero-shot and fine-tuning evaluation share the same 242-structure test set, so every comparison has an identical denominator. Oxide numbers used for control comparison come from the parallel oxide arm, which uses the same protocol on a fixed 1484-structure oxide test split.

**Our experimental findings, at a glance.** The pretrained model reaches a nitride zero-shot MAE of 0.0695 eV/atom vs an oxide-comparator zero-shot MAE of 0.0342 eV/atom. No Set 1 nitride fine-tuning budget — including `N = 1000` — recovers the nitride zero-shot baseline on mean test MAE. Pretraining nevertheless beats random initialization by a wide margin at both scratch-tested sizes. In frozen `last_alignn_pool` space, nitrides and oxides occupy distinguishable regions with the nitride side less cohesive, and harder-to-predict nitrides lie farther from the oxide-reference region on average.

---

## 1b. Caveats applied throughout this document

These four caveats govern the full analysis below. They are stated once here and referenced economically later rather than re-argued each section.

- **C1. Checkpoint terminology.** The pretrained formation-energy ALIGNN model is not described as "oxide-pretrained." The JARVIS-DFT pretraining corpus includes nitrides; it is consistent with an oxide-skewed reference regime, not an oxide-exclusive one. "Oxide-reference region" is used only in distance-context language in Section 4.
- **C2. Low-`N` inertness.** At `N ∈ {10, 50, 100, 200}`, `mean_best_epoch = 1.0` across all seeds. The returned fine-tuned model is operationally the zero-shot checkpoint with a single-epoch perturbation. No row in this band is reported as successful adaptation.
- **C3. `N = 50` scratch gap.** Because the `N = 50` fine-tuning row is itself an epoch-1 checkpoint under **C2**, the `N = 50` scratch-vs-fine-tune gap reflects pretrained-initialization advantage over random initialization, not fine-tuning adaptation. Only the `N = 500` scratch comparison is a clean adapted-vs-scratch measurement.
- **C4. Embedding correlational framing.** The distance–error association reported in Section 4.2 is correlational. Embedding distance is not claimed to cause prediction error, only to co-vary with it.

A further scope rule: from-scratch nitride baselines exist only at `N = 50` and `N = 500`; no scratch comparison is implied at other `N`.

---

## 2. Step 1 — zero-shot family penalty

**Evidence.** From `reports/zero_shot/zero_shot_summary.csv`: nitride zero-shot MAE = 0.0695 eV/atom on n = 242; oxide zero-shot MAE = 0.0342 eV/atom on n = 1484. Both come from the same pretrained checkpoint (**C1**), with no target-family training, on disjoint fixed test splits.

**Reading.** A ~2× family-level MAE gap at the pretrained starting point is the cleanest behavioral indicator of a family-level shift under this protocol, because zero-shot removes every confound introduced by fine-tuning (checkpoint selection, early stopping, seed variance, data-budget interaction). It is also the reference baseline against which every later claim about "adaptation" must be judged: fine-tuning is only meaningful if it moves mean test MAE below this number, and Section 3 will show that this does not occur on nitrides under Set 1.

**Oxide-as-control transition.** Nitride starts at roughly 2× the oxide zero-shot MAE. This baseline asymmetry is what Steps 2–4 below have to be explained against.

---

## 3. Steps 2 and 3 — the fine-tuning trajectory

The Set 1 fine-tuning table (`finetune_summary_by_N.csv`) splits into two operational regimes that should not be averaged together in prose. Separating them is the single most important interpretive move in the nitride write-up.

### 3.1 Step 2 — low-`N` regime (`N ≤ 200`) is operationally inert

**Finding.** At `N = 10, 50, 100, 200`, `mean_best_epoch = 1.0` for every seed (**C2**). The mean test MAEs are 0.0874 ± 0.0199 at N = 10, 0.1173 ± 0.0451 at N = 50, 0.1722 ± 0.0996 at N = 100, and 0.1392 ± 0.0677 at N = 200 — all worse than the 0.0695 eV/atom zero-shot baseline, with the largest mean and variance at N = 100.

**Interpretation.** Under Set 1 with 10–200 labeled nitrides, the fine-tuning loop does not produce adaptation in any operational sense: validation either stops improving after epoch 1 and the trainer keeps that checkpoint, or the model updates into a worse parameter region. The numerically lowest mean MAE in this band (N = 10) is therefore not the "best low-`N` fine-tuning result" — it is an epoch-1 artifact that happens to land close to zero-shot but still above it.

**Literature grounding.** That small target-family budgets can fail to yield measurable improvement over a pretrained backbone — and sometimes degrade it — is consistent with transfer-learning behavior reported for crystal-graph models under source/target mismatch [CITE: Lee2021_TransferCGCNN; Kim2024_MeltingT_Transfer; Hu2024_DomainAdaptation].

**Oxide-as-control transition.** Unlike oxide, which begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5` and subsequently rising to 35.5–39.0 at N ≥ 200), nitride remains operationally inert through N = 200. The asymmetry is not in final MAE alone but in when multi-epoch optimization engages at all.

### 3.2 Step 3 — high-`N` regime (`N = 500, 1000`) is genuine but incomplete adaptation

**Finding.** At N = 500 the mean best epoch rises to 40.5; at N = 1000 it rises to 45.0. These are the only Set 1 nitride rows in which fine-tuning traverses a substantial portion of the 50-epoch budget before validation loss stops improving. Mean test MAE is 0.0977 ± 0.0178 at N = 500 and 0.0907 ± 0.0135 at N = 1000. The N = 1000 row is the tightest nitride fine-tuning configuration we have, both in mean and in seed variance.

**Interpretation.** Two observations matter. First, adaptation has switched on — the optimizer is no longer immediately preferring the initialization. Second, adaptation is partial: even the best genuinely-adapted row (N = 1000) sits 0.0211 eV/atom above the zero-shot baseline. Fine-tuning at N ≥ 500 is strong enough to pull the checkpoint off the pretrained starting point but not strong enough, within the tested range and hyperparameter set, to produce a model below the zero-shot reference on this test split.

**Parity-plot cross-cut.** The two main-text parity figures (`FIG_S1_PARITY_NITRIDE_N10`, `FIG_S1_PARITY_NITRIDE_N1000`) report on-figure MAE/RMSE/R² of 0.0828 / 0.1203 / 0.9841 at N = 10 and 0.0829 / 0.1220 / 0.9837 at N = 1000. These are seed-averaged prediction parity statistics, not the seed-averaged-MAE summaries (0.0874 and 0.0907). The distinction is structural: parity-plot MAE averages predictions first, summary-table MAE averages per-seed errors. Their approximate equality across the two panels means `N` changes the *regime* of fine-tuning (best-epoch, seed variance, adaptation status) far more than it changes broad parity appearance.

**Scope note.** No conclusion is drawn that nitride fine-tuning is incapable of beating zero-shot; only that it does not do so within the tested `N` range and Set 1 hyperparameters.

---

## 4. Step 4 — embedding geometry consistent with the penalty

The embedding section does not produce a new behavioral number. Its role is to give Steps 1–3 a geometric reading in the representation the pretrained model has already learned. Main-text claims use the raw 256-dimensional `last_alignn_pool` layer; `pre_head` and `last_gcn_pool` are appendix-support layers.

### 4.1 Family separation in frozen pretrained space

**Finding.** On the raw 256D `last_alignn_pool` representation, family-separation statistics are: silhouette 0.2392 overall (oxide 0.2546, nitride 0.1453); Davies–Bouldin 1.8290; 15-nearest-neighbor family purity 0.9655 overall (oxide 0.9872, nitride 0.8331); logistic-regression family AUC 0.9994. A linear probe recovers family labels from the frozen representation essentially perfectly, and local neighborhoods are overwhelmingly single-family, especially on the oxide side.

**Interpretation.** The pretrained network has, without being trained to, built a representation in which oxides and nitrides occupy distinguishable regions. This is consistent with it having learned features correlated with chemical family during broad pretraining [CITE: Choudhary2021_ALIGNN]. The nitride region is distinguishable but less cohesive than the oxide control region: lower silhouette, lower 15-NN purity. The nitride side is recognizable but less internally organized.

**Caveat.** PCA, t-SNE, and UMAP projections are descriptive support only; we do not use visual cluster distances as statistical evidence. Both our Week 2 conceptual material and the ALIGNN tutorial warn that such projections preserve local neighborhood structure but not global inter-cluster distance in a physically interpretable way [CITE: vanderMaaten2008_tSNE; McInnes2018_UMAP; Choudhary2021_ALIGNN_tutorial].

### 4.2 Within-nitride error co-varies with distance from the oxide-reference region

**Finding.** Using all 242 test nitrides and the 13,507-structure oxide train+val pool as a reference region (terminology only; see **C1**), we compute the mean distance from each nitride test structure to its five nearest oxide neighbors in raw 256D `last_alignn_pool` space. The 49 hardest nitrides (top 20% by absolute zero-shot error) have mean oxide-neighbor distance 4.5988 vs 3.7821 for the 49 easiest (bottom 20%) — a hard-minus-easy gap of 0.8168 with 95% CI [0.4746, 1.1597] and FDR q = 1.8 × 10⁻⁴. A full-sample Spearman correlation of 0.3428 (95% CI [0.2214, 0.4597], FDR q = 1.3 × 10⁻⁴) shows the same association continuously.

**Interpretation.** Within the nitride test set, structures whose pretrained embeddings sit farther from the oxide-reference region tend to be those on which the zero-shot prediction is worst. This is the geometric counterpart of the Step 1 family gap: the penalty is not only a family-level average but scales with how unlike the oxide region a given nitride is in pretrained feature space.

**Framing.** Under **C4**, this is a correlational / geometric indicator consistent with a representation-space shift, not a mechanism proof. Shared upstream factors — bonding chemistry, coordination, local symmetry — could plausibly drive both a structure's displacement from the oxide region *and* the pretrained head's unreliability on it. Cautious correlational framing of representation-based OOD diagnostics is standard in materials ML [CITE: Omee2024_OOD_Benchmark; Li2025_OOD_AdversarialLearning].

---

## 5. Supporting evidence — pretrained initialization vs training from scratch

This section is deliberately positioned as support for Steps 1–4, not as a parallel main claim. It confirms that pretraining remains operationally valuable on nitrides, but it does not change the headline OOD result.

**Coverage.** Scope rule applies: from-scratch nitride baselines exist only at `N = 50` and `N = 500`.

**Finding.** At N = 50, from-scratch MAE is 0.6914 ± 0.0163 eV/atom vs fine-tuning 0.1173 eV/atom (gap 0.5741). At N = 500, from-scratch MAE is 0.3683 ± 0.0233 eV/atom vs fine-tuning 0.0977 eV/atom (gap 0.2706). Both scratch means sit far above the 0.0695 eV/atom zero-shot baseline, so random initialization on nitride alone cannot match what a broadly pretrained ALIGNN gives at either tested scale.

**Interpretive split.** The two gaps are asymmetric in meaning (**C3**):

- The N = 50 gap measures pretrained-initialization advantage over random initialization, not fine-tuning adaptation. The fine-tuned side is an epoch-1 checkpoint.
- The N = 500 gap is the only clean adapted-vs-scratch comparison we have; the fine-tuned side has `mean_best_epoch = 40.5`.

**Role in the overall reading.** These results confirm that pretraining is worth doing on nitrides — the pretrained route is much lower in error than scratch at both tested scales. But this is a weaker and more expected claim than the main OOD finding. The headline result is that the nitride penalty survives even after Step 3's genuine adaptation: the best adapted row (N = 1000) still sits above zero-shot. "Pretraining helps on nitrides" is consistent with a standard transfer-learning story [CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]; "the domain-shift penalty persists despite adaptation" is the OOD-specific finding.

**Scope note.** No inference is drawn about scratch performance at untested `N`. The two scratch-tested sizes are of different kinds under **C3** and should not be interpolated as a continuous "transfer benefit" curve.

---

## 6. Consolidated reading — the four-step arc

The nitride evidence collapses into a single four-step domain-shift story:

1. **Step 1 — zero-shot gap.** The pretrained model is already about twice as inaccurate on nitrides as on oxides. The penalty exists before any fine-tuning.
2. **Step 2 — low-`N` inertness.** At `N ≤ 200`, fine-tuning is operationally inert: all four rows select the epoch-1 checkpoint. Oxide is already adapting by N = 50; nitride is not.
3. **Step 3 — incomplete high-`N` adaptation.** At N = 500 and N = 1000, fine-tuning becomes genuine (mean best epoch 40.5 and 45.0) and tighter across seeds, but neither row recovers the zero-shot baseline.
4. **Step 4 — embedding-space correlate.** In frozen pretrained space, families are distinguishable but nitride is less cohesive than oxide, and harder nitrides sit farther from the oxide-reference region.

Scratch comparisons (Section 5) confirm that pretraining remains practically valuable on nitrides, but they are secondary to Steps 1–4. The central finding is that the domain-shift penalty survives every behavioral intervention we have at our disposal within the canonical protocol, and it has a consistent geometric correlate in the pretrained representation.

---

## 7. Citation placeholders used

`[CITE: Xie2018_CGCNN]`, `[CITE: Choudhary2021_ALIGNN]`, `[CITE: Choudhary2021_ALIGNN_tutorial]`, `[CITE: Jain2013_MP]`, `[CITE: Choudhary2020_JARVIS]`, `[CITE: Dunn2020_Matbench]`, `[CITE: Lee2021_TransferCGCNN]`, `[CITE: Kim2024_MeltingT_Transfer]`, `[CITE: Hu2024_DomainAdaptation]`, `[CITE: Omee2024_OOD_Benchmark]`, `[CITE: Li2025_OOD_Generalization]`, `[CITE: Li2025_OOD_AdversarialLearning]`, `[CITE: vanderMaaten2008_tSNE]`, `[CITE: McInnes2018_UMAP]`.
