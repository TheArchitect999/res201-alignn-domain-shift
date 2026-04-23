# Results — Nitride Arm (Edited v3.1)

**Editorial pass:** heavy polish; four-step arc preserved, repeated caveat banners lifted into a single scope note, repetitive subsection templates folded into flowing prose. Numbers, figure references, and citation placeholders unchanged.

---

## 4. Results

### Scope and caveats

This section reports behavioural evidence (zero-shot, fine-tuning, from-scratch) and representational evidence (frozen `last_alignn_pool` embedding) on the fixed 242-structure nitride test split, with matched oxide comparator values where oxide serves as the in-distribution control. All fine-tuning and from-scratch results use Hyperparameter Set 1 (50 epochs, learning rate 1 × 10⁻⁴, batch size 16, five seeds per configuration). Zero-shot uses the pretrained formation-energy ALIGNN model without target-family training.

Four caveats apply throughout and are referenced economically below: **(C1)** we do not describe the pretrained checkpoint as "oxide-pretrained"; **(C2)** nitride `N ≤ 200` is not meaningful adaptation, because `mean_best_epoch = 1.0` at every seed; **(C3)** the `N = 50` scratch gap reflects pretrained-initialization advantage, not fine-tuning adaptation, because under **C2** the fine-tuned side is itself the zero-shot checkpoint; **(C4)** embedding distance is reported as a correlational geometric indicator, not as a cause of prediction error.

The section follows a four-step domain-shift arc. Step 1 (§4.1) is the zero-shot penalty. Step 2 (§4.2) is low-`N` fine-tuning inertness under the canonical protocol. Step 3 (§4.3) is genuine but incomplete adaptation at high `N`. Step 4 (§§4.4–4.5) is embedding-space geometry consistent with the persistence of that penalty. A supporting pretrained-vs-scratch comparison (§4.6) confirms pretraining's operational value on nitrides but is secondary to the Step 1–4 arc; §4.7 summarizes.

### 4.1 Step 1 — zero-shot evaluation establishes a nitride penalty relative to oxides

On matched evaluation, the pretrained formation-energy ALIGNN checkpoint attains a test MAE of **0.0695 eV/atom** on the fixed nitride test set (n = 242) and **0.0342 eV/atom** on the oxide comparator (n = 1 484) — a nitride error roughly twice the oxide error (Table `TAB_ZS_SUMMARY`, Figure `FIG_ZS_COMPARISON`). Because both values come from the same pretrained checkpoint under identical evaluation protocol and differ only in the target family, the ~2× gap isolates a family-level discrepancy at the pretrained starting point, before any fine-tuning is introduced.

The pretrained formation-energy ALIGNN model therefore incurs a measurable accuracy penalty on nitrides relative to the oxide control before any target-family adaptation — the first step of the domain-shift arc and the reference baseline against which every later nitride fine-tuning comparison must be judged. §§4.2–4.3 evaluate whether fine-tuning on target-family data closes this gap; §§4.4–4.5 ask whether the representation shows a geometric correlate of it.

This subsection does not attribute the gap to any specific chemical or graph-topological feature; attribution is examined in §§4.4–4.5 via embedding analysis. Under **C1**, the checkpoint is described as the *pretrained formation-energy ALIGNN model* because the JARVIS-DFT pretraining corpus is broad rather than oxide-exclusive; its composition is consistent with a pretraining regime more aligned with oxides than nitrides.

### 4.2 Step 2 — low-`N` nitride fine-tuning is operationally inert under the canonical protocol

We compare mean test MAE across five seeds at `N ∈ {10, 50, 100, 200}` against the nitride zero-shot MAE of 0.0695 eV/atom and against the analogous oxide fine-tuning rows at matched `N` (Table `TAB_S1_FT_SUMMARY_BY_N`; low-`N` portion of `FIG_S1_LC_NITRIDE`). At every one of the four smallest nitride budgets, `mean_best_epoch = 1.0`: 0.0874 ± 0.0199 eV/atom at `N = 10`, 0.1173 ± 0.0451 at `N = 50`, 0.1722 ± 0.0996 at `N = 100`, and 0.1392 ± 0.0677 at `N = 200`. All four rows are worse than the zero-shot baseline, with the largest mean and largest seed-to-seed variance at `N = 100`. The learning curve shows these rows as a flat, wide-variance band above the zero-shot reference line.

A `mean_best_epoch` of 1.0 at every seed across four different data budgets means the validation-tracked checkpoint selected by the training loop is the first-epoch checkpoint in every run. Within the resolution of this protocol, the returned model is indistinguishable from the pretrained checkpoint with a single optimizer step applied (**C2**). Under Hyperparameter Set 1, nitride fine-tuning at `N ≤ 200` therefore does not constitute adaptation in any operational sense; the numerically smallest mean MAE in this band (0.0874 eV/atom at `N = 10`) is not a "best low-`N` fine-tuning result" but an early-checkpoint artifact, and it still sits 0.0179 eV/atom above zero-shot. This is Step 2 of the domain-shift arc: an inert low-`N` fine-tuning regime in which the loop does not leave the pretrained starting point.

Unlike oxide, which begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5`, rising to 35.5–39.0 at `N ≥ 200`), nitride remains operationally inert across the full low-`N` band up to `N = 200`. The asymmetry is in *when* multi-epoch optimization engages at all, not only in final MAE. Two mechanisms are consistent with the flat epoch-1 pattern within the observed summary: validation loss may genuinely stop improving after the first step because the pretrained checkpoint is a better initialization than any nearby point reachable in one epoch on the given budget, or the small validation splits at low `N` may be too coarse to discriminate between neighbouring checkpoints. Either is compatible with the data; we do not select between them here.

### 4.3 Step 3 — genuine adaptation begins at `N = 500` and stabilizes at `N = 1 000` without recovering zero-shot

At `N = 500`, `mean_best_epoch` jumps to 40.5 and mean test MAE is 0.0977 ± 0.0178 eV/atom; at `N = 1 000`, `mean_best_epoch = 45.0` and mean test MAE is 0.0907 ± 0.0135 eV/atom (Table `TAB_S1_FT_SUMMARY_BY_N`; high-`N` portion of `FIG_S1_LC_NITRIDE`; parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`). Both rows remain above zero-shot — by 0.0281 and 0.0211 eV/atom respectively — but seed-to-seed variance tightens between the low-`N` band and the `N = 1 000` row. The paired parity figures report on-figure MAE / RMSE / R² of 0.0828 / 0.1203 / 0.9841 at `N = 10` and 0.0829 / 0.1220 / 0.9837 at `N = 1 000`, computed on seed-averaged predictions.

The jump in mean best epoch from 1.0 (at `N ≤ 200`) to 40.5 (at `N = 500`) to 45.0 (at `N = 1 000`) indicates a discrete transition: only at `N ≥ 500` does the training loop traverse a non-trivial portion of the 50-epoch budget before validation loss stops improving. Both genuinely-adapted rows sit at broadly similar mean test MAE, and the dominant high-`N` improvement is in across-seed stability, not in headline parity error. Under the canonical protocol, then, nitride fine-tuning transitions from operationally inert to operationally adapted between `N = 200` and `N = 500`. Despite this transition, no tested fine-tuning budget — including `N = 1 000` — produces a mean test MAE below the zero-shot baseline on this split. The best genuinely-adapted nitride configuration is `N = 1 000`, which pays a smaller but still positive domain-shift penalty relative to zero-shot. This is Step 3 of the arc: adaptation is real but partial.

### 4.4 Step 4a — family structure in the frozen pretrained representation

We characterize whether oxides and nitrides occupy distinguishable regions of the frozen `last_alignn_pool` representation and whether the two regions differ in cohesion. All quantitative claims in this subsection are based on raw 256-D metrics; PCA, t-SNE, and UMAP panels (`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`) are descriptive visual support only and carry no numerical claim.

Computed in raw 256-D space across the fixed test set (Table `TAB_EA_FAMILY_SEPARATION`), the overall silhouette score is 0.2392 (95 % CI 0.2332–0.2456); per-family silhouettes are 0.2546 for oxides (CI 0.2476–0.2617) and 0.1453 for nitrides (CI 0.1316–0.1582). The Davies–Bouldin index is 1.8290 (CI 1.7340–1.9071). Local 15-nearest-neighbour family purity is 0.9655 overall (CI 0.9603–0.9708), with oxide neighbourhoods at 0.9872 (CI 0.9832–0.9906) and nitride neighbourhoods at 0.8331 (CI 0.7978–0.8645). A logistic regression trained to recover family labels from the frozen embeddings achieves an AUC of 0.9994 (CI 0.9984–0.9999).

Two raw-space patterns emerge. First, family labels are almost perfectly recoverable from the frozen 256-D embeddings (AUC 0.9994): the pretrained representation encodes chemistry-level information that distinguishes oxides from nitrides even without supervision on that distinction. Second, the two families are not symmetric in raw space — by per-family silhouette (0.2546 vs 0.1453) and by per-family 15-NN purity (0.9872 vs 0.8331), the nitride region is distinguishable from oxides but internally less cohesive than the oxide region. The PCA, t-SNE, and UMAP panels are broadly consistent with this raw-space pattern and are included as descriptive visual support only. The frozen pretrained representation therefore carries family-level structure before any target-family training, and the per-family asymmetry in raw-space cohesion aligns in direction with the behavioural asymmetry established in §§4.1–4.3. Logistic-regression AUC and silhouette are geometric descriptors; they do not quantify how much of the behavioural MAE gap is attributable to representation structure as opposed to label distribution, prediction-head calibration, or other non-geometric factors.

### 4.5 Step 4b — within-family distance–error association

Within the 242 nitride test structures, we ask whether the nitrides the pretrained model predicts poorly lie farther in raw 256-D `last_alignn_pool` space from the oxide-reference pool (n = 13 507 oxide train+val structures) than the nitrides it predicts well. Group-level statistics compare the 49 hardest nitrides (top 20 % by absolute zero-shot error) with the 49 easiest (bottom 20 %); the continuous view uses the full 242 structures.

At the tails (Table `TAB_EA_DISTANCE_ERROR_STATS`, Figure `FIG_EA_6D_BOXPLOT`), the hard group has mean 5-nearest-oxide distance 4.5988 vs 3.7821 for the easy group — a hard-minus-easy gap of 0.8168 (95 % CI 0.4746–1.1597, FDR `q = 1.8 × 10⁻⁴`). Across all 242 structures (Figure `FIG_EA_6D_SCATTER`), Spearman correlation between mean oxide-reference distance and absolute zero-shot error is 0.3428 (95 % CI 0.2214–0.4597, FDR `q = 1.3 × 10⁻⁴`); Pearson correlation is 0.2770. The same association appears under both views, in the same direction, at `q`-values on the order of 10⁻⁴ after FDR correction, and the direction is stable under alternative distance definitions (centroid and Mahalanobis; see appendix).

Within the nitride test set, then, structures whose pretrained embeddings sit farther from the oxide-reference region tend to be those on which the pretrained model's zero-shot prediction is least accurate. This is the within-family complement to §4.4: not only is the nitride family harder on average, but intra-family variation in zero-shot error aligns with geometric distance from the oxide-reference region in frozen pretrained space. Together §§4.4 and 4.5 constitute Step 4 of the arc — the behavioural penalty from §§4.1–4.3 has a consistent representation-space correlate. Under **C4**, the association is correlational; shared upstream factors (bonding chemistry, coordination environment, local symmetry) may jointly drive both displacement from the oxide region and unreliability of the pretrained formation-energy head. The distance–error relationship is reported as a geometric indicator consistent with a representation-space shift, not as mechanistic proof.

### 4.6 Supporting evidence — pretrained initialization versus from-scratch training

This subsection supports the Step 1–4 arc rather than introducing a parallel main claim. It confirms that pretraining remains operationally valuable on nitrides without revising the headline OOD result.

At the two `N` values with matched from-scratch runs (Table `TAB_S1_FS_SUMMARY`, Figure `FIG_S1_COMP_NITRIDE`), nitride from-scratch MAE is 0.6914 ± 0.0163 eV/atom at `N = 50` (vs fine-tuning 0.1173; gap 0.5741) and 0.3683 ± 0.0233 eV/atom at `N = 500` (vs fine-tuning 0.0977; gap 0.2706). Both from-scratch means sit well above the zero-shot baseline (0.0695 eV/atom); the scratch-minus-zero-shot gap is 0.6219 at `N = 50` and 0.2987 at `N = 500`.

At every available scratch comparison the pretrained route yields substantially lower mean test MAE than random initialization on the same labelled nitride data. Pretraining therefore remains practically valuable on nitrides at both tested scales — a standard-form transfer-learning result [CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]. The two gaps differ in kind, however, under **C3**:

- The `N = 50` gap (0.5741 eV/atom) is pretrained-initialization advantage over scratch, not a fine-tuning adaptation effect: the corresponding fine-tuning row has `mean_best_epoch = 1.0` under **C2** and is operationally the zero-shot checkpoint.
- The `N = 500` gap (0.2706 eV/atom) is a clean adapted-vs-scratch comparison: the corresponding fine-tuning row has `mean_best_epoch = 40.5`.

"Pretraining helps on nitrides" is therefore a weaker and more expected finding than the headline result developed in §§4.1–4.5. The central OOD finding of this report is that the domain-shift penalty persists through Step 3's genuine adaptation: the best adapted row (`N = 1 000`) remains above zero-shot. §4.6 confirms pretraining's value; it does not overturn the arc. From-scratch nitride baselines exist only at `N = 50` and `N = 500`, so no continuous transfer-benefit curve is inferred across `N`.

---

## 4.7 Summary — the four-step domain-shift arc

Taken together, the nitride evidence produces a single, internally consistent four-step story.

**Step 1 (§4.1).** Zero-shot evaluation places nitrides at roughly 2× the oxide-comparator MAE at the pretrained starting point (0.0695 vs 0.0342 eV/atom).

**Step 2 (§4.2).** Under Set 1, fine-tuning at `N ≤ 200` is operationally inert (`mean_best_epoch = 1.0` at every seed across all four sizes). Oxide, by contrast, has already begun genuine optimization by `N = 50`.

**Step 3 (§4.3).** At `N = 500` (mean best epoch 40.5) and `N = 1 000` (mean best epoch 45.0), fine-tuning becomes genuine and tighter across seeds, but no tested budget recovers the zero-shot baseline; the `N = 1 000` mean test MAE (0.0907 eV/atom) still sits 0.0211 eV/atom above zero-shot.

**Step 4 (§§4.4–4.5).** In frozen `last_alignn_pool` space, families are distinguishable but the nitride region is less cohesive than the oxide control region, and within nitrides, distance from the oxide-reference region co-varies with absolute zero-shot error (Spearman ρ = 0.3428, FDR `q = 1.3 × 10⁻⁴`; hard-minus-easy gap 0.8168, FDR `q = 1.8 × 10⁻⁴`).

**Supporting layer (§4.6).** Pretrained initialization outperforms random initialization by a wide margin at `N = 50` and `N = 500` (under the `N = 50` initialization-advantage caveat **C3**); this confirms pretraining's operational value but does not revise the headline finding that the domain-shift penalty survives genuine adaptation.

The main tables anchoring these results are `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_FAMILY_SEPARATION`, and `TAB_EA_DISTANCE_ERROR_STATS`. The main figures are `FIG_ZS_COMPARISON`, `FIG_S1_LC_NITRIDE`, the parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`, `FIG_S1_COMP_NITRIDE`, and the `FIG_EA_6A/6B/6C/6D` embedding panels.

**Citation placeholders used in Results:** `[CITE: vanderMaaten2008_tSNE]`, `[CITE: McInnes2018_UMAP]`, `[CITE: Lee2021_TransferCGCNN]`, `[CITE: Hu2024_DomainAdaptation]`. Literature-heavier citation is deferred to the Introduction and Discussion, per the convention of keeping Results references minimal.
