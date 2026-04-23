# Results — Nitride Arm (Standalone Report Draft, v3)

> **Scope.** This is the Results section for the standalone nitride report. It presents behavioral evidence (zero-shot, fine-tuning, from-scratch) and representational evidence (frozen `last_alignn_pool` embedding) on the fixed 242-structure nitride test split, with matched oxide comparator values cited where oxide acts as the in-distribution control. All fine-tuning and from-scratch numbers use Hyperparameter Set 1 (50 epochs, learning rate 1e-4, batch size 16, five seeds per configuration). Zero-shot uses the pretrained formation-energy ALIGNN model without target-family training.
>
> **Storyline.** The section follows the four-step domain-shift arc that is the spine of this report: (Step 1, §4.1) the zero-shot domain-shift penalty; (Step 2, §4.2) low-`N` fine-tuning inertness under the canonical protocol; (Step 3, §4.3) genuine but incomplete adaptation at high `N`; (Step 4, §4.4–4.5) embedding-space geometry consistent with the persistence of the domain-shift penalty. A supporting pretrained-vs-from-scratch comparison (§4.6) confirms the operational value of pretraining on nitrides but is secondary to the Step 1–4 arc. A summary is given in §4.7.
>
> **Caveats applied throughout** (stated once, referenced economically later): **C1** the pretrained checkpoint is not described as "oxide-pretrained"; **C2** nitride `N ≤ 200` is not meaningful adaptation because `mean_best_epoch = 1.0` at every seed; **C3** the `N = 50` scratch gap reflects pretrained-initialization advantage, not fine-tuning adaptation, because the fine-tuned side under **C2** is itself the zero-shot checkpoint; **C4** embedding distance is reported as a correlational geometric indicator, not as a cause of prediction error.
>
> **Subsection template.** Each subsection: *what is being compared → what the figure/table shows → consistent pattern → interpretation justified by the evidence → what remains uncertain*.

---

## 4.1 Step 1 — zero-shot evaluation establishes a nitride domain-shift penalty relative to oxides

**What is being compared.** Zero-shot test-set MAE of the pretrained formation-energy ALIGNN checkpoint on the fixed nitride test split (n = 242) vs the same checkpoint on the oxide comparator split (n = 1484), both without target-family training. Evidence source: `TAB_ZS_SUMMARY` and `FIG_ZS_COMPARISON`.

**What the figure/table shows.** Nitride zero-shot MAE is 0.0695 eV/atom; oxide zero-shot MAE is 0.0342 eV/atom. Nitride zero-shot error is approximately twice the oxide zero-shot error on matched evaluation.

**Consistent pattern.** Because both values come from the same pretrained checkpoint under identical evaluation protocol and differ only in the target family, the ~2× gap isolates a family-level discrepancy at the pretrained starting point, before any fine-tuning is introduced.

**Justified interpretation.** The pretrained formation-energy ALIGNN model incurs a measurable accuracy penalty on the nitride test set relative to the oxide control before any target-family adaptation — the first step of the domain-shift arc. This zero-shot gap is the reference baseline against which every later nitride fine-tuning comparison in this report must be judged.

**Oxide-as-control anchor.** Nitride starts at roughly 2× the oxide zero-shot MAE. Sections 4.2–4.3 evaluate whether fine-tuning on target-family data closes this gap; Sections 4.4–4.5 ask whether the representation space shows a geometric correlate of it.

**What remains uncertain.** This subsection does not attribute the gap to any specific chemical or graph-topological feature; attribution is examined in Sections 4.4–4.5 via embedding analysis. Under **C1**, the checkpoint is described as the *pretrained formation-energy ALIGNN model* because the JARVIS-DFT pretraining corpus is broad rather than oxide-exclusive; its composition is consistent with a pretraining regime more aligned with oxides than nitrides.

---

## 4.2 Step 2 — low-`N` nitride fine-tuning is operationally inert under the canonical protocol

**What is being compared.** Mean test MAE across five seeds at `N ∈ {10, 50, 100, 200}` against the nitride zero-shot MAE of 0.0695 eV/atom, and against the analogous oxide fine-tuning regime at matched `N`. Evidence source: `TAB_S1_FT_SUMMARY_BY_N` and the low-`N` portion of `FIG_S1_LC_NITRIDE`.

**What the figure/table shows.** At every one of the four smallest nitride budgets, `mean_best_epoch = 1.0`: 0.0874 ± 0.0199 eV/atom at N = 10, 0.1173 ± 0.0451 at N = 50, 0.1722 ± 0.0996 at N = 100, and 0.1392 ± 0.0677 at N = 200. All four rows are worse than the zero-shot baseline, with the largest mean and largest seed-to-seed variance at N = 100. The learning curve shows these rows as a flat, wide-variance band above the zero-shot reference line.

**Consistent pattern.** `mean_best_epoch = 1.0` at every seed across four different data budgets means the validation-tracked checkpoint selected by the training loop is the first-epoch checkpoint in every run. Within the resolution of this protocol, the returned model is indistinguishable from the pretrained checkpoint with a single optimizer step applied (**C2**).

**Justified interpretation.** Under Hyperparameter Set 1, nitride fine-tuning at `N ≤ 200` does not constitute adaptation in any operational sense. The numerically smallest mean MAE in this band (0.0874 eV/atom at N = 10) is therefore not the "best low-`N` fine-tuning result"; it is an early-checkpoint artifact, and it still sits 0.0179 eV/atom above zero-shot. This is Step 2 of the domain-shift arc: an inert low-`N` fine-tuning regime in which the loop does not leave the pretrained starting point.

**Oxide-as-control anchor.** Unlike oxide, which begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5`, rising to 35.5–39.0 at N ≥ 200), nitride remains operationally inert across the full low-`N` band up to N = 200. The asymmetry is in *when* multi-epoch optimization engages at all, not only in final MAE.

**What remains uncertain.** Within the observed summary table, two mechanisms are consistent with the flat epoch-1 pattern: validation loss genuinely stops improving after the first step because the pretrained checkpoint is a better initialization than any nearby point reachable in one epoch on the given budget, or the small validation splits at low `N` are too coarse to discriminate between neighboring checkpoints. Either is compatible with the data and we do not select between them in this section.

---

## 4.3 Step 3 — genuine adaptation begins at `N = 500` and stabilizes at `N = 1000` without recovering zero-shot

**What is being compared.** Mean test MAE and mean best epoch at `N = 500` and `N = 1000`, against the four inert low-`N` rows (§4.2) and against the nitride zero-shot baseline. Evidence source: `TAB_S1_FT_SUMMARY_BY_N`, the high-`N` portion of `FIG_S1_LC_NITRIDE`, and the parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`.

**What the figure/table shows.** At N = 500, `mean_best_epoch = 40.5` and mean test MAE = 0.0977 ± 0.0178 eV/atom. At N = 1000, `mean_best_epoch = 45.0` and mean test MAE = 0.0907 ± 0.0135 eV/atom. Both rows remain above zero-shot — by 0.0281 and 0.0211 eV/atom respectively — but seed-to-seed variance tightens between the low-`N` band and the N = 1000 row. The paired parity figures report on-figure MAE / RMSE / R² of 0.0828 / 0.1203 / 0.9841 at N = 10 and 0.0829 / 0.1220 / 0.9837 at N = 1000, computed on seed-averaged predictions.

**Consistent pattern.** The jump in mean best epoch from 1.0 (at N ≤ 200) to 40.5 (at N = 500) to 45.0 (at N = 1000) indicates a discrete transition: only at N ≥ 500 does the training loop traverse a non-trivial portion of the 50-epoch budget before validation loss stops improving. Both genuinely-adapted rows sit at broadly similar mean test MAE, and the dominant high-`N` improvement is in across-seed stability, not in headline parity error.

**Justified interpretation.** Under the canonical protocol, nitride fine-tuning transitions from operationally inert to operationally adapted between N = 200 and N = 500. Despite this transition, no tested fine-tuning budget — including N = 1000 — produces a mean test MAE below the zero-shot baseline on this test split. The best genuinely-adapted nitride configuration is N = 1000, which pays a smaller but still positive domain-shift penalty relative to zero-shot. This is Step 3 of the arc: adaptation is real but partial.

**What remains uncertain.** We do not claim nitride fine-tuning is incapable of beating zero-shot; only that it does not do so within the tested `N` range and hyperparameter set. The aggregation difference between summary-table MAE (per-seed-MAE average: 0.0907 at N = 1000) and parity-plot MAE (error of seed-averaged prediction: 0.0829 at N = 1000) is structural, not contradictory; the two quantities measure different things and are quoted separately where both appear.

---

## 4.4 Step 4a — frozen pretrained embeddings place nitrides in a distinguishable but less cohesive region than the oxide control

**What is being compared.** Quantitative family-separation statistics on the raw 256-dimensional `last_alignn_pool` representation of the fixed-test nitride and oxide subsets, reported separately. Evidence source: `TAB_EA_FAMILY_SEPARATION` and `FIG_EA_6A_PCA`, with companion panels `FIG_EA_6B_TSNE` and `FIG_EA_6C_UMAP`.

**What the figure/table shows.** Overall silhouette is 0.2392 (oxide 0.2546, nitride 0.1453). 15-nearest-neighbor family purity is 0.9655 overall (oxide 0.9872, nitride 0.8331). Davies–Bouldin index is 1.8290. Logistic-regression family AUC is 0.9994. Projection panels (PCA, t-SNE, UMAP) show two distinguishable family regions.

**Consistent pattern.** Every quantitative metric tells the same story: families are clearly separated in the frozen representation (near-perfect linear-probe recoverability, high 15-NN purity), and the nitride side is consistently less internally cohesive than the oxide side (lower silhouette and lower local purity on the nitride side).

**Justified interpretation.** The pretrained network, without being explicitly supervised on family labels, has built a representation in which oxides and nitrides occupy distinguishable regions. Within that representation, the nitride region is distinguishable but less cohesive than the oxide control region. This is a representational correlate of the behavioral domain-shift penalty observed in §§4.1–4.3.

**What remains uncertain.** Low-dimensional projections (PCA, t-SNE, UMAP) are descriptive support only. Visual inter-cluster distances are not quoted as statistical evidence, because 2D embeddings of high-dimensional spaces do not preserve global geometry in a physically meaningful way [CITE: vanderMaaten2008_tSNE; McInnes2018_UMAP]. All quantitative claims here come from raw 256D `last_alignn_pool` metrics. `pre_head` and `last_gcn_pool` layers are appendix-support and are not co-equal main-text evidence.

---

## 4.5 Step 4b — within-nitride zero-shot error co-varies with distance from the oxide-reference region

**What is being compared.** For all 242 test nitrides, absolute zero-shot prediction error vs the mean distance from the structure's raw 256D `last_alignn_pool` embedding to its five nearest neighbors in the oxide train+val reference pool (n = 13,507). Group-level statistics compare the 49 hardest nitrides (top 20% by absolute zero-shot error) against the 49 easiest (bottom 20%). Evidence source: `TAB_EA_DISTANCE_ERROR_STATS`, `FIG_EA_6D_BOXPLOT`, and the continuous companion `FIG_EA_6D_SCATTER`.

**What the figure/table shows.** The hard group has mean 5-nearest-oxide distance 4.5988 vs 3.7821 for the easy group (hard-minus-easy gap 0.8168, 95% CI [0.4746, 1.1597], FDR q = 1.8 × 10⁻⁴). On the full sample, Spearman correlation between mean oxide-reference distance and absolute zero-shot error is 0.3428 (95% CI [0.2214, 0.4597], FDR q = 1.3 × 10⁻⁴); Pearson correlation is 0.2770.

**Consistent pattern.** The same association appears under two statistical views: a discrete hard-vs-easy tail contrast and a continuous rank correlation across all 242 structures. Both are positive, both exceed their null at q-values on the order of 10⁻⁴ after FDR correction, and the direction is stable under alternative distance definitions (centroid and Mahalanobis; see appendix).

**Justified interpretation.** Within the nitride test set, structures whose pretrained embeddings sit farther from the oxide-reference region tend to be those on which the pretrained model's zero-shot prediction is least accurate. This is the within-family complement to §4.4: not only is the nitride family harder on average, but intra-family variation in zero-shot error aligns with geometric distance from the oxide region in frozen pretrained space. Together, §4.4 and §4.5 make Step 4 of the arc: the behavioral domain-shift penalty from §§4.1–4.3 has a consistent representation-space correlate.

**What remains uncertain.** Under **C4**, this association is correlational. Shared upstream factors — bonding chemistry, coordination environment, local symmetry — may jointly drive both displacement from the oxide region and unreliability of the pretrained formation-energy head. The distance–error relationship is reported as a geometric indicator consistent with a representation-space shift, not as mechanistic proof.

---

## 4.6 Supporting evidence — pretrained initialization vs from-scratch training

This subsection supports the Step 1–4 arc rather than introducing a parallel main claim. It confirms that pretraining remains operationally valuable on nitrides but does not change the headline OOD result.

**What is being compared.** Mean test MAE of fine-tuned ALIGNN (pretrained initialization) vs ALIGNN trained from scratch (random initialization) at the two `N` values with matched from-scratch runs: N = 50 and N = 500. Evidence source: `TAB_S1_FS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, and `FIG_S1_COMP_NITRIDE`.

**What the figure/table shows.** At N = 50, from-scratch MAE is 0.6914 ± 0.0163 eV/atom vs fine-tuning 0.1173 eV/atom (gap 0.5741). At N = 500, from-scratch MAE is 0.3683 ± 0.0233 eV/atom vs fine-tuning 0.0977 eV/atom (gap 0.2706). Both from-scratch means sit well above the zero-shot baseline (0.0695 eV/atom); the scratch-minus-zero-shot gap is 0.6219 at N = 50 and 0.2987 at N = 500.

**Consistent pattern.** At every available scratch comparison, the pretrained route yields substantially lower mean test MAE than random initialization on the same labeled nitride data.

**Justified interpretation.** Pretraining remains practically valuable on nitrides at both tested scales, a standard-form transfer-learning result [CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]. The two gaps differ in kind, however, under **C3**:

- The N = 50 gap (0.5741 eV/atom) is pretrained-initialization advantage over scratch, not a fine-tuning adaptation effect. The corresponding fine-tuning row has `mean_best_epoch = 1.0` under **C2**, so it is operationally the zero-shot checkpoint.
- The N = 500 gap (0.2706 eV/atom) is a clean adapted-vs-scratch comparison. The corresponding fine-tuning row has `mean_best_epoch = 40.5`.

**Relationship to the main arc.** "Pretraining helps on nitrides" is a weaker and more expected finding than the headline result developed in §§4.1–4.5. The central OOD finding of this report is that the domain-shift penalty persists through Step 3's genuine adaptation: the best adapted row (N = 1000) remains above zero-shot. §4.6 confirms pretraining's value; it does not overturn the arc.

**What remains uncertain.** From-scratch nitride baselines exist only at N = 50 and N = 500; scratch performance at N = 10, 100, 200, or 1000 is not measured here, so no continuous "transfer benefit" curve is inferred across `N`.

---

## 4.7 Nitride Results summary — the four-step domain-shift arc

Taken together, the nitride evidence produces a single, internally consistent four-step domain-shift story.

**Step 1 (§4.1).** Zero-shot evaluation places nitrides at roughly 2× the oxide-comparator MAE at the pretrained starting point (0.0695 vs 0.0342 eV/atom).

**Step 2 (§4.2).** Under Set 1 hyperparameters, fine-tuning at `N ≤ 200` is operationally inert (`mean_best_epoch = 1.0` at every seed across all four sizes). Oxide, by contrast, has already begun genuine optimization by N = 50.

**Step 3 (§4.3).** At N = 500 (mean best epoch 40.5) and N = 1000 (mean best epoch 45.0), fine-tuning becomes genuine and tighter across seeds, but no tested budget recovers the zero-shot baseline; the N = 1000 mean test MAE (0.0907 eV/atom) still sits 0.0211 eV/atom above zero-shot.

**Step 4 (§§4.4–4.5).** In frozen `last_alignn_pool` space, families are distinguishable but the nitride region is less cohesive than the oxide control region, and within the nitride family, distance from the oxide-reference region co-varies with absolute zero-shot error (Spearman ρ = 0.3428, FDR q = 1.3 × 10⁻⁴; hard-minus-easy gap 0.8168, FDR q = 1.8 × 10⁻⁴).

**Supporting layer (§4.6).** Pretrained initialization outperforms random initialization by a wide margin at N = 50 and N = 500, under the N = 50 initialization-advantage caveat (**C3**); this confirms pretraining's operational value but does not revise the headline finding that the domain-shift penalty survives genuine adaptation.

The main tables anchoring these results are `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_FAMILY_SEPARATION`, and `TAB_EA_DISTANCE_ERROR_STATS`. The main figures are `FIG_ZS_COMPARISON`, `FIG_S1_LC_NITRIDE`, the parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`, `FIG_S1_COMP_NITRIDE`, and the `FIG_EA_6A/6B/6C/6D` embedding panels.

---

## Citation placeholders used

`[CITE: vanderMaaten2008_tSNE]`, `[CITE: McInnes2018_UMAP]`, `[CITE: Lee2021_TransferCGCNN]`, `[CITE: Hu2024_DomainAdaptation]`. (Literature-heavier citation is deferred to the Introduction and Discussion of the standalone nitride report, per the Results-section convention of keeping references minimal.)
