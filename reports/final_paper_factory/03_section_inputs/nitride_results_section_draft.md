# Results — Nitride Arm (Standalone Report Draft)

> **Scope of this section.** This is the Results section for the standalone nitride report. It presents behavioral (zero-shot, fine-tuning, from-scratch) and representational (frozen `last_alignn_pool` embedding) evidence evaluated on the fixed 242-structure nitride test set. All fine-tuning and from-scratch numbers use Hyperparameter Set 1 (50 epochs, learning rate 1e-4, batch size 16, five seeds per configuration). Zero-shot uses the shared pretrained formation-energy ALIGNN model evaluated without target-family training. Each subsection follows a fixed template: *what is being compared → what the figure/table shows → consistent pattern → interpretation that is justified → what remains uncertain*.

---

## 4.1 Zero-shot evaluation establishes a nitride family penalty relative to oxides

**What is being compared.** Zero-shot test-set mean absolute error (MAE) of the pretrained formation-energy ALIGNN checkpoint on the fixed nitride test split (n = 242) versus the same checkpoint on the oxide comparator split (n = 1484), with no target-family training for either family. Evidence source: `TAB_ZS_SUMMARY` and `FIG_ZS_COMPARISON`.

**What the figure/table shows.** The nitride zero-shot MAE is 0.0695 eV/atom; the oxide zero-shot MAE is 0.0342 eV/atom (Table `TAB_ZS_SUMMARY`; Figure `FIG_ZS_COMPARISON`). The nitride zero-shot error is approximately twice the oxide zero-shot error on matched evaluation.

**Consistent pattern.** Because both values come from the same pretrained checkpoint under identical evaluation protocol and differ only in the target test family, the two-fold gap isolates a family-level mismatch at the pretrained starting point before any fine-tuning is introduced.

**Justified interpretation.** The pretrained formation-energy ALIGNN model incurs a measurable accuracy penalty on the nitride test set relative to the oxide test set before any target-family adaptation. This zero-shot gap serves as the reference baseline that every subsequent nitride fine-tuning comparison in this report must be judged against.

**What remains uncertain.** We do not attribute this gap to any specific chemical or graph-topological feature in this section; attribution is addressed in Section 4.5 via embedding analysis. The checkpoint is described throughout as the *pretrained formation-energy ALIGNN model*, not as "oxide-pretrained," because the JARVIS-DFT pretraining corpus is broad rather than oxide-exclusive.

---

## 4.2 Low-`N` nitride fine-tuning is operationally inert under the canonical protocol

**What is being compared.** Mean test MAE of the fine-tuned ALIGNN model across five seeds, at target-family budgets `N ∈ {10, 50, 100, 200}`, compared against the nitride zero-shot MAE of 0.0695 eV/atom. Evidence source: `TAB_S1_FT_SUMMARY_BY_N` and the low-`N` portion of `FIG_S1_LC_NITRIDE`.

**What the figure/table shows.** At every one of the four smallest data sizes, mean best epoch equals exactly 1.0: 0.0874 ± 0.0199 eV/atom at N = 10, 0.1173 ± 0.0451 at N = 50, 0.1722 ± 0.0996 at N = 100, and 0.1392 ± 0.0677 at N = 200. All four rows are worse than the zero-shot baseline, with the worst mean and the largest seed-to-seed variance occurring at N = 100. The learning curves in `FIG_S1_LC_NITRIDE` show these rows as a flat, wide-variance band sitting above the zero-shot reference line.

**Consistent pattern.** A `mean_best_epoch = 1.0` at every seed across four different data budgets means that the validation-tracked checkpoint selected by the training loop is the first-epoch checkpoint in every run. Within the resolution of our protocol, the returned model at these budgets is indistinguishable from the pretrained checkpoint with a single optimizer step applied.

**Justified interpretation.** Under Hyperparameter Set 1, nitride fine-tuning at `N ≤ 200` does not constitute adaptation in any operational sense: gradients applied for one epoch do not move the model to a validation-preferred configuration, and the net effect is either neutrality or degradation on the test set. The numerically smallest mean MAE in this band (0.0874 eV/atom at N = 10) should therefore not be read as the "best low-`N` fine-tuning result"; it is an early-checkpoint artifact, and it still sits 0.0179 eV/atom above zero-shot.

**What remains uncertain.** We cannot distinguish between two possible sources of the flat epoch-1 pattern: (i) the validation loss genuinely stops improving after the first step because the pretrained checkpoint is already a better initialization than any nearby point reachable within one epoch's gradient update on the given data budget, and (ii) the validation split at these small `N` is too small to discriminate between checkpoints that differ only slightly. Either explanation is consistent with the observed summary table.

---

## 4.3 Genuine adaptation begins at `N = 500` and stabilizes at `N = 1000` without recovering zero-shot

**What is being compared.** Mean test MAE and mean best epoch at the two largest tested data sizes, `N = 500` and `N = 1000`, compared against the four inert low-`N` rows (Section 4.2) and against the nitride zero-shot baseline. Evidence source: `TAB_S1_FT_SUMMARY_BY_N`, high-`N` portion of `FIG_S1_LC_NITRIDE`, and the parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`.

**What the figure/table shows.** At N = 500, mean best epoch is 40.5 and mean test MAE is 0.0977 ± 0.0178 eV/atom. At N = 1000, mean best epoch is 45.0 and mean test MAE is 0.0907 ± 0.0135 eV/atom. Both rows remain above the zero-shot baseline — by 0.0281 and 0.0211 eV/atom respectively — but seed-to-seed variance tightens substantially between the low-`N` band and the N = 1000 row. The paired parity figures report on-figure MAE 0.0828 / RMSE 0.1203 / R² 0.9841 at N = 10 and MAE 0.0829 / RMSE 0.1220 / R² 0.9837 at N = 1000, computed on seed-averaged predictions.

**Consistent pattern.** The jump in mean best epoch from 1.0 (at N ≤ 200) to 40.5 (at N = 500) to 45.0 (at N = 1000) indicates a discrete transition: only at N ≥ 500 does the training loop traverse a non-trivial fraction of the 50-epoch budget before validation loss stops improving. Both genuinely-adapted rows sit at broadly similar mean test MAE, and the dominant high-`N` improvement is not in the headline parity statistics but in the stability of the result across seeds.

**Justified interpretation.** Under the canonical protocol, nitride fine-tuning transitions from operationally inert to operationally adapted between N = 200 and N = 500. Despite this transition, no tested fine-tuning budget — including N = 1000 — produces a mean test MAE below the zero-shot baseline on this test split. The best genuinely-adapted nitride configuration is thus N = 1000, which pays a smaller but still positive penalty relative to zero-shot. `N` in this regime affects the *regime* of fine-tuning (checkpoint selection, variance across seeds) more than it affects headline parity error.

**What remains uncertain.** We cannot conclude that nitride fine-tuning is incapable of beating zero-shot; we can only conclude that it does not do so within the tested `N` range and hyperparameter set. The aggregation distinction between summary-table MAE (average over per-seed MAEs: 0.0907 at N = 1000) and parity-plot MAE (error of seed-averaged prediction: 0.0829 at N = 1000) should not be interpreted as a contradiction; the two statistics measure different quantities and should be quoted separately.

---

## 4.4 Pretrained initialization outperforms random initialization at both tested data sizes, but the gap carries different meanings

**What is being compared.** Mean test MAE of fine-tuned ALIGNN (pretrained initialization) vs ALIGNN trained from scratch (random initialization), at the two `N` values with matched from-scratch runs: N = 50 and N = 500. Evidence source: `TAB_S1_FS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, and `FIG_S1_COMP_NITRIDE`.

**What the figure/table shows.** At N = 50, from-scratch MAE is 0.6914 ± 0.0163 eV/atom vs fine-tuning 0.1173 eV/atom — a fine-tune-minus-scratch gap of 0.5741 eV/atom. At N = 500, from-scratch MAE is 0.3683 ± 0.0233 eV/atom vs fine-tuning 0.0977 eV/atom — a gap of 0.2706 eV/atom. Both from-scratch means sit well above the zero-shot baseline (0.0695 eV/atom); the scratch-minus-zero-shot gap is 0.6219 at N = 50 and 0.2987 at N = 500.

**Consistent pattern.** At every available scratch comparison, the pretrained route yields a substantially lower mean test MAE than random initialization on the same labeled nitride data.

**Justified interpretation.** Pretraining remains practically valuable on nitrides at both tested scales. However, the two gaps differ in kind and should be reported as such:

- The N = 50 gap of 0.5741 eV/atom is a **pretrained-initialization advantage over scratch, not a fine-tuning adaptation effect.** The corresponding fine-tuning row has `mean_best_epoch = 1.0`, so the "fine-tuned" model is operationally equivalent to the zero-shot checkpoint. This comparison therefore measures zero-shot initialization vs a scratch model trained on 45 structures.
- The N = 500 gap of 0.2706 eV/atom is a **clean adapted-vs-scratch comparison.** The corresponding fine-tuning row has `mean_best_epoch = 40.5`, indicating genuine multi-epoch adaptation, so this gap measures an adapted pretrained-initialized model against a scratch model trained on the same 450 structures.

**What remains uncertain.** From-scratch nitride baselines are available only at N = 50 and N = 500; no scratch comparison exists at N = 10, 100, 200, or 1000. We make no inference about scratch performance at untested `N`, and we do not interpolate a continuous "transfer benefit" curve across `N`.

---

## 4.5 Frozen pretrained embeddings place nitrides in a distinguishable but looser region than oxides

**What is being compared.** Quantitative family-separation statistics computed on the raw 256-dimensional `last_alignn_pool` representation of all fixed-test nitride and oxide structures, with oxide and nitride subsets reported separately. Evidence source: `TAB_EA_FAMILY_SEPARATION` and `FIG_EA_6A_PCA`, with companion views `FIG_EA_6B_TSNE` and `FIG_EA_6C_UMAP`.

**What the figure/table shows.** Overall silhouette is 0.2392 (oxide 0.2546, nitride 0.1453). 15-nearest-neighbor family purity is 0.9655 overall (oxide 0.9872, nitride 0.8331). The Davies–Bouldin index is 1.8290. A logistic-regression probe recovers the family label with AUC 0.9994. The PCA / t-SNE / UMAP panels visually show two distinguishable family regions, with the oxide region appearing more cohesive than the nitride region.

**Consistent pattern.** Every quantitative metric tells the same story: families are clearly separated in the frozen representation (near-perfect linear-probe recoverability, high 15-NN purity), *and* the nitride region is consistently less internally cohesive than the oxide region (lower silhouette and lower local purity on the nitride side).

**Justified interpretation.** The pretrained model has, without being trained to, developed a representation in which oxides and nitrides occupy distinguishable regions, and within that representation, the nitride side is less tightly clustered than the oxide side. This is a representational correlate of the behavioral nitride penalty observed in Sections 4.1–4.3.

**What remains uncertain.** Low-dimensional projections (PCA, t-SNE, UMAP) are used as descriptive support only. Visual inter-cluster distances in these projections are not quoted as statistical evidence, because 2D embeddings of high-dimensional spaces do not preserve global geometry in a physically meaningful way [CITE: vanderMaaten2008_tSNE; McInnes2018_UMAP]. All quantitative claims in this subsection are based on the raw 256D `last_alignn_pool` metrics. `pre_head` and `last_gcn_pool` embeddings are analyzed in the appendix and are not co-equal main-text layers.

---

## 4.6 Nitride zero-shot error co-varies with distance from the oxide-reference region in pretrained embedding space

**What is being compared.** For all 242 test nitrides, the absolute zero-shot prediction error of the pretrained formation-energy ALIGNN model against the mean distance from the structure's raw 256D `last_alignn_pool` embedding to its five nearest neighbors in the oxide train+val reference pool (n = 13,507). Group-level statistics compare the 49 hardest nitrides (top 20% by absolute zero-shot error) against the 49 easiest (bottom 20%). Evidence source: `TAB_EA_DISTANCE_ERROR_STATS`, `FIG_EA_6D_BOXPLOT`, and the continuous companion `FIG_EA_6D_SCATTER`.

**What the figure/table shows.** The hard group has mean 5-nearest-oxide distance 4.5988 vs 3.7821 for the easy group (hard-minus-easy gap 0.8168, 95% CI [0.4746, 1.1597], FDR q = 1.8 × 10⁻⁴). On the full sample, Spearman correlation between mean oxide-reference distance and absolute zero-shot error is 0.3428 (95% CI [0.2214, 0.4597], FDR q = 1.3 × 10⁻⁴); the Pearson correlation is 0.2770.

**Consistent pattern.** The same association appears under two different statistical views: a discrete hard-vs-easy group contrast and a continuous rank correlation across all 242 test structures. Both are positive, both exceed their null at q-values on the order of 10⁻⁴ after FDR correction, and the direction of the association is stable under alternative distance definitions (centroid distance and Mahalanobis distance; see appendix).

**Justified interpretation.** Within the nitride test set, structures whose pretrained embeddings sit farther from the oxide-reference region tend to be the ones on which the pretrained model's zero-shot prediction is least accurate. This is a representational correlate of the zero-shot family penalty documented in Section 4.1: not only is the nitride family harder on average, but the intra-family heterogeneity of zero-shot error aligns with geometric distance from the oxide region in frozen pretrained space.

**What remains uncertain.** This association is correlational. We explicitly do not claim that embedding distance *causes* zero-shot prediction error. Shared upstream factors — bonding chemistry, coordination environment, local symmetry — may jointly drive both (i) displacement from the oxide-dominated region of the representation and (ii) unreliability of the pretrained formation-energy head. The distance–error relationship is therefore reported as a geometric indicator consistent with a representation-space shift, not as mechanistic proof.

---

## 4.7 Results summary for the nitride arm

Taken together, the nitride evidence produces an internally consistent OOD-penalty picture across four layers. Zero-shot evaluation establishes a ~2× family-level MAE gap versus oxides at the pretrained starting point (Section 4.1). Fine-tuning under the canonical Set 1 protocol is operationally inert at `N ≤ 200` by checkpoint-selection criteria, transitions to genuine adaptation at `N = 500`, and stabilizes at `N = 1000` without any tested budget recovering the zero-shot baseline on mean test MAE (Sections 4.2–4.3). Pretrained initialization nonetheless outperforms random initialization by a wide margin at both data sizes with matched from-scratch runs, with the caveat that the N = 50 gap reflects initialization advantage rather than adaptation (Section 4.4). Frozen `last_alignn_pool` embeddings separate the two families, with the nitride side less internally cohesive than the oxide side (Section 4.5), and nitride-specific zero-shot error co-varies with distance from the oxide-reference region in embedding space under multiple statistical tests (Section 4.6). The two main tables (`TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_FAMILY_SEPARATION`, `TAB_EA_DISTANCE_ERROR_STATS`) and the five main figures (`FIG_ZS_COMPARISON`, `FIG_S1_LC_NITRIDE`, `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`, `FIG_S1_COMP_NITRIDE`, the `FIG_EA_6*` panel) anchor these findings for the Discussion.

---

## Drafting guardrails respected in this Results draft

- No nitride fine-tuning row is claimed to outperform the nitride zero-shot baseline.
- `N ≤ 200` is never described as successful adaptation; the epoch-1 checkpoint-selection fact is surfaced explicitly.
- The N = 50 scratch comparison is flagged as pretrained-initialization advantage rather than fine-tuning adaptation.
- No scratch comparison is implied at `N = 10`, `100`, `200`, or `1000`.
- The pretrained checkpoint is referred to as the "pretrained formation-energy ALIGNN model," never as "oxide-pretrained."
- Embedding distance is framed as a correlational / geometric indicator, not as a cause of prediction error.
- Only `last_alignn_pool` is used as a main-text embedding layer.
- Only Hyperparameter Set 1 numbers are used; Set 2 and Set 3 are not invoked in this Results draft.
- Parity-plot MAE/RMSE/R² are kept distinct from summary-table MAE; the aggregation difference is stated where both appear.
- All numeric values trace directly to the nitride analysis and results packets.

## Citation placeholders used

`[CITE: vanderMaaten2008_tSNE]`, `[CITE: McInnes2018_UMAP]`. (Literature-heavier citation is deferred to the Introduction and Discussion of the standalone nitride report, per the Results-section convention of keeping references minimal.)
