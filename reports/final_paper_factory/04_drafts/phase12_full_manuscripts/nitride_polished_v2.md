# The Domain-Shift Penalty of Pretrained ALIGNN on Nitride Formation-Energy Prediction: Behavioural and Representational Evidence

First Author Name*, Second Author Name

[Affiliation placeholder]

[Corresponding author email placeholder]

## Abstract

Pretrained crystal-graph neural networks are widely used to reduce labelled-data requirements in materials-property prediction, but their benefit depends on how closely the target chemistry matches the regime that supported pretraining. We evaluate a single pretrained formation-energy ALIGNN model on a chemistry-distant nitride target drawn from the JARVIS `dft_3d` benchmark, matched to a companion in-distribution oxide control on the same pipeline. Three measurement surfaces are reported: zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes from ten to one thousand structures with five random seeds per size, and matched from-scratch baselines at two of those sizes. We then probe the frozen 256-dimensional `last_alignn_pool` representation for family structure and for a within-family correlate between zero-shot error and distance from an oxide-reference region. Under the canonical Hyperparameter Set 1 protocol, nitride zero-shot error is approximately twice the oxide comparator; fine-tuning at labelled-data sizes of two hundred or fewer is operationally inert — the selected checkpoint is the pretrained zero-shot state at every seed — and meaningful adaptation begins only at five hundred and one thousand labelled structures, where the best adapted configuration still sits above the nitride zero-shot baseline. Pretrained initialization nonetheless outperforms random initialization by a wide margin at both scratch-tested sizes. In the frozen representation, family labels are near-perfectly recoverable, and nitride prediction error co-varies with distance from the oxide-reference region (Spearman ρ ≈ 0.34, FDR-controlled). Scoped to the tested regime, the evidence supports a domain-shift reading with a consistent geometric correlate, not a causal mechanism proof.

## Keywords

crystal graph neural networks, ALIGNN, transfer learning, domain shift, out-of-distribution generalization, fine-tuning, formation energy, nitrides, JARVIS DFT-3D, frozen embeddings, representation geometry, data efficiency

## 1. Introduction

Crystal-property prediction from atomic structure is a central workload in materials informatics. Structure-based crystal graph neural networks perform this task by learning directly from atomic coordinates, bonding topology, and element identities rather than relying on handcrafted descriptors, and they have become a routine starting point for high-throughput and low-data property modelling alike [CITE: crystal graph baseline for materials property prediction]. CGCNN is the canonical early exemplar of this family and established that a crystal graph can be mapped directly to scalar properties without hand-engineered features [CITE: CGCNN foundational paper].

ALIGNN refines this approach by alternating message passing on the bond graph and its line graph, making bond-angle information explicit in the learned representation and improving accuracy on structure-dependent targets [CITE: ALIGNN foundational paper]. The specific ALIGNN checkpoint and training corpus used in this work — a formation-energy regressor trained on the JARVIS DFT-3D database — are distributed through the JARVIS infrastructure, which also supplies the benchmark splits used throughout this report [CITE: JARVIS dataset/repository paper].

Transfer learning from pretrained crystal-graph models has been shown to reduce labelled-data requirements on downstream property tasks, with the largest per-sample benefit typically observed in the low-data regime [CITE: transfer learning in materials informatics]. How much of that benefit survives on a new target depends on how closely the target matches the distribution that supported pretraining. When the target chemistry or structure lies outside that distribution, both accuracy and apparent scaling behaviour can degrade, and a growing body of out-of-distribution evaluations in materials ML makes this failure mode concrete [CITE: domain shift or OOD benchmark in materials property prediction]. What is harder to read off the existing literature is how a single, widely used pretrained checkpoint behaves across a clean chemical-family split when evaluated as a data-efficiency curve — zero-shot, fine-tuning across labelled-data sizes, and matched from-scratch baselines — together with a representation-space view of the pretrained model, rather than as a single test-MAE number.

This report addresses the out-of-distribution half of that evaluation. Using the same pretrained formation-energy ALIGNN model [CITE: ALIGNN foundational paper] on the JARVIS `dft_3d` benchmark splits [CITE: JARVIS dataset/repository paper], we study a chemistry-distant nitride target: the regime in which source–target mismatch is most likely to surface and most likely to be misattributed to small-data noise if read in isolation. We evaluate the checkpoint zero-shot, fine-tune it across a range of labelled-data sizes at multiple random seeds, and compare fine-tuned runs against matched from-scratch baselines at the sample sizes where both protocols are available. Because the behavioural evidence alone cannot distinguish a representational mismatch from an optimization artefact, we additionally extract frozen intermediate embeddings from the same checkpoint and ask whether the pretrained representation already carries a family-level signature — and whether, within nitrides, prediction difficulty co-varies with distance from the region occupied by the chemistry-aligned oxide comparator. The companion oxide report establishes the in-distribution control condition against which the present evidence is read.

The nitride report asks four linked questions scoped to the out-of-distribution test task: the size of the zero-shot penalty relative to a chemistry-aligned comparator; the rate and onset of adaptation with labelled-data scale; what pretraining still contributes over matched from-scratch training in the presence of chemical mismatch; and whether the pretrained representation shows geometric structure consistent with the behavioural penalty, treated as an interpretive probe rather than a causal proof. The first three questions form the behavioural spine of the report; the fourth is co-primary rather than subsidiary, because the representation-space view strengthens the domain-shift reading by providing a correlational probe consistent with it. Section 2 describes the dataset, splits, protocols, and hyperparameter settings. Section 3 reports the behavioural evidence — zero-shot, fine-tuning across sizes, and from-scratch comparisons — together with the representational evidence extracted from the frozen pretrained model. Sections 4 and 5 discuss the domain-shift interpretation and its limitations, and conclude with the out-of-distribution takeaways that feed the combined manuscript.

[INSERT FIGURE FIG_SCHEMATIC HERE]

## 2. Methodology

### 2.1 Dataset and prediction target

Crystal structures and formation-energy labels were obtained from the JARVIS materials repository, specifically the `dft_3d_2021` release [CITE: JARVIS 2020 dataset/repository paper]. The supervised target is per-atom formation energy `formation_energy_peratom`, in eV/atom. The nitride family composition used throughout this report is summarized at `data_shared/nitride/summaries/summary.json`; the filter that builds both family datasets is `scripts/dataset/build_res201_family_datasets.py`.

### 2.2 Nitride family definition

We define a nitride as any structure whose composition contains nitrogen and does not contain oxygen. All oxygen-containing structures — including oxynitrides (both N and O) — are excluded from the nitride arm by construction; the nitride family summary records zero retained oxynitrides. Family assignment is performed by `scripts/dataset/res201_stage2_lib.py` through `classify_family(...)` with `keep_oxynitrides_in_oxide=True`, which is consistent with the complementary oxide arm in related work: an oxide is defined as any structure containing oxygen, and oxynitrides are retained on that side.

### 2.3 Split protocol and run-local subset construction

[INSERT TABLE TAB_METHODS_DATASET_SPLITS HERE]

We preserve the original JARVIS benchmark split identities (`provided:manifests/dft_3d_formation_energy_peratom_splits.csv`) before applying family filtering, so each nitride structure retains the train, validation, or test assignment it carries in the underlying release [CITE: JARVIS 2020 dataset/repository paper]. After filtering, the nitride family contains 2 288 structures (1 837 train / 209 validation / 242 test); the pool holds 2 046 structures. Full counts appear in Table 1 (`TAB_METHODS_DATASET_SPLITS`).

Run-local subset construction follows the same protocol used in the oxide arm. For each `N` and seed, `N` structures are drawn from the nitride pool using `np.random.default_rng(seed).permutation(...)[:N]`; validation allocation is `n_val = max(5, round(0.1 × N))`, with training taking the remainder and a fallback of `max(1, N // 5)` when that rule would produce `n_val ≥ N`. The fixed nitride test set (n = 242) is appended unchanged to every run-local dataset, and row ordering inside each `id_prop.csv` is enforced with `keep_data_order=True` together with explicit `n_train`, `n_val`, and `n_test` arguments.

### 2.4 Zero-shot evaluation

The pretrained formation-energy ALIGNN model is evaluated on the fixed nitride test set without task-specific training [CITE: ALIGNN foundational paper]. The evaluation, implemented in `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py`, reads `data_shared/nitride/manifests/test.csv`, loads the corresponding POSCAR files, and obtains predictions via `alignn.pretrained.get_prediction(model_name="jv_formation_energy_peratom_alignn", atoms=atoms)`; test MAE is computed with `sklearn.metrics.mean_absolute_error`. Per-structure outputs are written to `Results_Before_Correction/nitride/zero_shot/predictions.csv`, and the summary value is recorded in `reports/zero_shot/zero_shot_summary.csv`. Zero-shot evaluation is performed once on the fixed nitride test set and is not seed-varied.

### 2.5 Fine-tuning and from-scratch training protocols

Fine-tuning follows the identical partial-update protocol used in the oxide arm: the pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt` is loaded with its accompanying configuration, all parameters are frozen, and training is selectively re-enabled for the final gated GCN block (`gcn_layers.3`) and the scalar output head (`fc`). The overall model remains in `eval()` mode; only the two unfrozen modules are switched to training mode, and runtime invariant checks confirm that no additional parameters become trainable. Optimization uses `AdamW` with a `OneCycleLR` schedule and L1Loss; the inherited config JSON retains a `criterion: "mse"` entry from the original pretraining configuration that the custom training script overrides, training with L1 throughout. The best checkpoint per run is selected by minimum validation L1, and each run writes a `summary.json` recording `best_epoch` and `test_mae_eV_per_atom`. The per-`N` mean of `best_epoch` over the five seeds is referred to in subsequent tables as `mean_best_epoch`; this quantity is defined here as a recorded protocol-level summary, with interpretation reserved for Results and Discussion. Nitride fine-tuning was conducted at `N ∈ {10, 50, 100, 200, 500, 1 000}` with five seeds per condition (30 nitride fine-tuning runs in total).

From-scratch training reuses the identical run-local dataset roots and model configuration but instantiates a fresh ALIGNN model (`ALIGNN(ALIGNNConfig(**cfg.model.model_dump()))`) with no pretrained weights and all parameters trainable. The optimizer, learning-rate schedule, L1 objective, and best-checkpoint rule match the fine-tuning setup. From-scratch baselines exist only at `N = 50` and `N = 500`, with five seeds at each (10 nitride from-scratch runs in total). Transfer-benefit analyses in this report are scoped accordingly; no from-scratch comparison is made at `N = 10, 100, 200`, or `1 000`.

### 2.6 Hyperparameter setting, model specification, and evaluation metric

[INSERT TABLE TAB_METHODS_EXPERIMENT_SCOPE HERE]

All trained nitride runs use Hyperparameter Set 1: `epochs = 50`, `batch_size = 16`, `learning_rate = 1 × 10⁻⁴`. The shared graph-construction settings are `neighbor_strategy = "k-nearest"`, `cutoff = 8.0` Å, `cutoff_extra = 3.0` Å, and `max_neighbors = 12`, with `use_canonize`, `compute_line_graph`, and `use_lmdb` enabled. The architecture is the ALIGNN formation-energy model: four ALIGNN convolutional layers, four gated GCN layers, hidden size 256, and a scalar output head [CITE: ALIGNN foundational paper].

The primary reported metric is test-set MAE in eV/atom; checkpoint selection uses the lowest validation L1. Multi-seed results are summarized as mean ± standard deviation across the five random seeds. The zero-shot value is a single evaluation on the fixed nitride test set and is reported without a dispersion estimate. The nitride arm's full experimental scope — one zero-shot evaluation, 30 fine-tuning runs, and 10 from-scratch runs — appears in Table 2 (`TAB_METHODS_EXPERIMENT_SCOPE`).

### 2.7 Frozen-embedding analysis protocol

Structure embeddings were extracted from the frozen pretrained ALIGNN model (checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`) without retraining and without modifying any fine-tuning or from-scratch outputs. Extraction touches only inference code and therefore does not alter any previously reported training artefact.

The primary embedding layer for all main-text analysis is `last_alignn_pool`, the pooled node tensor returned by the last ALIGNN convolutional block. Two additional layers were extracted as robustness controls: `pre_head`, the pooled output of `model.readout` immediately before `model.fc`, and `last_gcn_pool`, the pooled node tensor from the last gated GCN block (`gcn_layers[3]`). In the current outputs, `pre_head` and `last_gcn_pool` are numerical near-duplicates of each other; we therefore treat them as a matched pair of appendix-facing supporting layers rather than independent probes.

Three fixed evaluation subsets support the embedding analyses. The `fixed_test_set` is the union of all oxide test structures and all nitride test structures; it is used for family-separation scoring and for nitride-side error metadata. The `balanced_pool_set` pairs every nitride pool structure with an equal-size random oxide pool sample (seed 42) and is used for balanced visualization and for bootstrap-resampled family-separation estimates. The `oxide_reference_pool` comprises all oxide pool structures and provides the reference manifold against which nitride embedding distances are measured. Throughout this report, "oxide-reference region" denotes positions within this manifold.

Family separation is quantified directly in the raw 256-dimensional embedding space. For each fixed subset we compute the silhouette score, the Davies–Bouldin index, the family purity of the 15-nearest-neighbor graph, and the AUC of a logistic-regression family classifier evaluated under five-fold cross-validation with `StandardScaler` preprocessing. These raw-space statistics are the inferential layer of the embedding analysis; PCA, t-SNE, and UMAP projections are used only as descriptive visual support, with primary settings `perplexity = 30` (t-SNE) and `n_neighbors = 30`, `min_dist = 0.1` (UMAP), both fitted on standardized inputs without PCA pre-reduction. PCA is fitted on the standardized `balanced_pool_set` and used to project the other subsets into that basis. Parameter sensitivity runs and overlay-fit policies are documented in `embedding_methods_appendix_notes_v1.md`.

For the distance-versus-error analysis, each nitride test structure is characterized by three embedding-space distances to the oxide-reference manifold: the Euclidean distance to the oxide centroid, the mean Euclidean distance to its five nearest oxide-reference neighbours, and a supplemental Ledoit–Wolf-regularized Mahalanobis distance evaluated only when covariance-screening diagnostics pass. These distances are paired with per-structure absolute zero-shot error. To characterize the distribution of prediction difficulty relative to the embedding geometry, we define hard nitrides as the top 20 % of fixed-test nitrides by absolute zero-shot error and easy nitrides as the bottom 20 %. The hard/easy assignment is a protocol-level partition; interpretation of what the resulting distance differences imply for adaptation belongs to Results and Discussion.

Statistical defaults for the embedding analyses are 1 000 bootstrap resamples for family-separation estimates, 5 000 bootstrap resamples and 10 000 permutations for distance–error tests, and within-statistic Benjamini–Hochberg false-discovery-rate adjustment. Throughout, the embedding workflow is treated as an interpretive protocol rather than a mechanism-proving instrument.

---

## 3. Results

### Scope and caveats

This section reports behavioural evidence (zero-shot, fine-tuning, from-scratch) and representational evidence (frozen `last_alignn_pool` embedding) on the fixed 242-structure nitride test split, with matched oxide comparator values where oxide serves as the in-distribution control. All fine-tuning and from-scratch results use Hyperparameter Set 1 (50 epochs, learning rate 1 × 10⁻⁴, batch size 16, five seeds per configuration). Zero-shot uses the pretrained formation-energy ALIGNN model without target-family training.

Four caveats apply throughout and are referenced economically below: **(C1)** we do not describe the pretrained checkpoint as "oxide-pretrained"; **(C2)** nitride `N ≤ 200` is not meaningful adaptation, because `mean_best_epoch = 1.0` at every seed; **(C3)** the `N = 50` scratch gap reflects pretrained-initialization advantage, not fine-tuning adaptation, because under **C2** the fine-tuned side is itself the zero-shot checkpoint; **(C4)** embedding distance is reported as a correlational geometric indicator, not as a cause of prediction error.

The section follows a four-step domain-shift arc. Step 1 (§3.1) is the zero-shot penalty. Step 2 (§3.2) is low-`N` fine-tuning inertness under the canonical protocol. Step 3 (§3.3) is genuine but incomplete adaptation at high `N`. Step 4 (§§3.4–3.5) is embedding-space geometry consistent with the persistence of that penalty. A supporting pretrained-vs-scratch comparison (§3.6) confirms pretraining's operational value on nitrides but is secondary to the Step 1–4 arc; §3.7 summarizes.

### 3.1 Step 1 — zero-shot evaluation establishes a nitride penalty relative to oxides

[INSERT TABLE TAB_ZS_SUMMARY HERE]
[INSERT FIGURE FIG_ZS_COMPARISON HERE]

On matched evaluation, the pretrained formation-energy ALIGNN checkpoint attains a test MAE of **0.0695 eV/atom** on the fixed nitride test set (n = 242) and **0.0342 eV/atom** on the oxide comparator (n = 1 484) — a nitride error roughly twice the oxide error (Table `TAB_ZS_SUMMARY`, Figure `FIG_ZS_COMPARISON`). Because both values come from the same pretrained checkpoint under identical evaluation protocol and differ only in the target family, the ~2× gap isolates a family-level discrepancy at the pretrained starting point, before any fine-tuning is introduced.

The pretrained formation-energy ALIGNN model therefore incurs a measurable accuracy penalty on nitrides relative to the oxide control before any target-family adaptation — the first step of the domain-shift arc and the reference baseline against which every later nitride fine-tuning comparison must be judged. §§3.2–3.3 examine whether fine-tuning on target-family data closes this gap; §§3.4–3.5 ask whether the representation shows a geometric correlate of it.

This subsection does not attribute the gap to any specific chemical or graph-topological feature; attribution is examined in §§3.4–3.5 via embedding analysis. Under **C1**, the checkpoint is described as the *pretrained formation-energy ALIGNN model* because the JARVIS-DFT pretraining corpus is broad rather than oxide-exclusive; its composition is consistent with a pretraining regime more aligned with oxides than nitrides.

### 3.2 Step 2 — low-`N` nitride fine-tuning is operationally inert under the canonical protocol

[INSERT TABLE TAB_S1_FT_SUMMARY_BY_N HERE]
[INSERT FIGURE FIG_S1_LC_NITRIDE HERE]

We compare mean test MAE across five seeds at `N ∈ {10, 50, 100, 200}` against the nitride zero-shot MAE of 0.0695 eV/atom and against the analogous oxide fine-tuning rows at matched `N` (Table `TAB_S1_FT_SUMMARY_BY_N`; low-`N` portion of `FIG_S1_LC_NITRIDE`). At every one of the four smallest nitride budgets, `mean_best_epoch = 1.0`: 0.0874 ± 0.0199 eV/atom at `N = 10`, 0.1173 ± 0.0451 at `N = 50`, 0.1722 ± 0.0996 at `N = 100`, and 0.1392 ± 0.0677 at `N = 200`. All four rows are worse than the zero-shot baseline, with the largest mean and largest seed-to-seed variance at `N = 100`. The learning curve shows these rows as a flat, wide-variance band above the zero-shot reference line.

A `mean_best_epoch` of 1.0 at every seed across four different data budgets means the validation-tracked checkpoint selected by the training loop is the first-epoch checkpoint in every run. Within the resolution of this protocol, the returned model is indistinguishable from the pretrained checkpoint with a single optimizer step applied (**C2**). Under Hyperparameter Set 1, nitride fine-tuning at `N ≤ 200` therefore does not constitute adaptation in any operational sense; the numerically smallest mean MAE in this band (0.0874 eV/atom at `N = 10`) is not a "best low-`N` fine-tuning result" but an early-checkpoint artifact, and it still sits 0.0179 eV/atom above zero-shot. This is Step 2 of the domain-shift arc: an inert low-`N` fine-tuning regime in which the loop does not leave the pretrained starting point.

Unlike oxide, which begins genuine optimization by `N = 50` (`mean_best_epoch = 18.5`, rising to 35.5–39.0 at `N ≥ 200`), nitride remains operationally inert across the full low-`N` band up to `N = 200`. The asymmetry is in *when* multi-epoch optimization engages at all, not only in final MAE. Two mechanisms are consistent with the flat epoch-1 pattern within the observed summary: validation loss may genuinely stop improving after the first step because the pretrained checkpoint is a better initialization than any nearby point reachable in one epoch on the given budget, or the small validation splits at low `N` may be too coarse to discriminate between neighbouring checkpoints. Either is compatible with the data; we do not select between them here.

### 3.3 Step 3 — genuine adaptation begins at `N = 500` and stabilizes at `N = 1 000` without recovering zero-shot

[INSERT FIGURE FIG_S1_LC_NITRIDE HERE]
[INSERT FIGURE FIG_S1_PARITY_NITRIDE_N10 HERE]
[INSERT FIGURE FIG_S1_PARITY_NITRIDE_N1000 HERE]

At `N = 500`, `mean_best_epoch` jumps to 40.5 and mean test MAE is 0.0977 ± 0.0178 eV/atom; at `N = 1 000`, `mean_best_epoch = 45.0` and mean test MAE is 0.0907 ± 0.0135 eV/atom (Table `TAB_S1_FT_SUMMARY_BY_N`; high-`N` portion of `FIG_S1_LC_NITRIDE`; parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`). Both rows remain above zero-shot — by 0.0281 and 0.0211 eV/atom respectively — but seed-to-seed variance tightens between the low-`N` band and the `N = 1 000` row. The paired parity figures report on-figure MAE / RMSE / R² of 0.0828 / 0.1203 / 0.9841 at `N = 10` and 0.0829 / 0.1220 / 0.9837 at `N = 1 000`, computed on seed-averaged predictions.

The jump in mean best epoch from 1.0 (at `N ≤ 200`) to 40.5 (at `N = 500`) to 45.0 (at `N = 1 000`) indicates a sharp transition: only at `N ≥ 500` does the training loop traverse a non-trivial portion of the 50-epoch budget before validation loss stops improving. Both genuinely-adapted rows sit at broadly similar mean test MAE, and the dominant high-`N` improvement is in across-seed stability, not in headline parity error. Under the canonical protocol, then, nitride fine-tuning transitions from operationally inert to operationally adapted between `N = 200` and `N = 500`. Despite this transition, no tested fine-tuning budget — including `N = 1 000` — produces a mean test MAE below the zero-shot baseline on this split. The best genuinely-adapted nitride configuration is `N = 1 000`, which pays a smaller but still positive domain-shift penalty relative to zero-shot. This is Step 3 of the arc: adaptation is real but partial.

### 3.4 Step 4a — family structure in the frozen pretrained representation

[INSERT TABLE TAB_EA_FAMILY_SEPARATION HERE]
[INSERT FIGURE FIG_EA_6A_PCA HERE]
[INSERT FIGURE FIG_EA_6B_TSNE HERE]
[INSERT FIGURE FIG_EA_6C_UMAP HERE]

We characterize whether oxides and nitrides occupy distinguishable regions of the frozen `last_alignn_pool` representation and whether the two regions differ in cohesion. All quantitative claims in this subsection are based on raw 256-D metrics; PCA, t-SNE, and UMAP panels (`FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`) are descriptive visual support only and carry no numerical claim.

Computed in raw 256-D space across the fixed test set (Table `TAB_EA_FAMILY_SEPARATION`), the overall silhouette score is 0.2392 (95 % CI 0.2332–0.2456); per-family silhouettes are 0.2546 for oxides (CI 0.2476–0.2617) and 0.1453 for nitrides (CI 0.1316–0.1582). The Davies–Bouldin index is 1.8290 (CI 1.7340–1.9071). Local 15-nearest-neighbour family purity is 0.9655 overall (CI 0.9603–0.9708), with oxide neighbourhoods at 0.9872 (CI 0.9832–0.9906) and nitride neighbourhoods at 0.8331 (CI 0.7978–0.8645). A logistic regression trained to recover family labels from the frozen embeddings achieves an AUC of 0.9994 (CI 0.9984–0.9999).

Two raw-space patterns emerge. First, family labels are almost perfectly recoverable from the frozen 256-D embeddings (AUC 0.9994): the pretrained representation encodes chemistry-level information that distinguishes oxides from nitrides even without supervision on that distinction. Second, the two families are not symmetric in raw space — by per-family silhouette (0.2546 vs 0.1453) and by per-family 15-NN purity (0.9872 vs 0.8331), the nitride region is distinguishable from oxides but internally less cohesive than the oxide region. The PCA, t-SNE, and UMAP panels are broadly consistent with this raw-space pattern and are included as descriptive visual support only. The frozen pretrained representation therefore carries family-level structure before any target-family training, and the per-family asymmetry in raw-space cohesion aligns in direction with the behavioural asymmetry established in §§3.1–3.3. Logistic-regression AUC and silhouette are geometric descriptors; they do not quantify how much of the behavioural MAE gap is attributable to representation structure as opposed to label distribution, prediction-head calibration, or other non-geometric factors.

### 3.5 Step 4b — within-family distance–error association

[INSERT TABLE TAB_EA_DISTANCE_ERROR_STATS HERE]
[INSERT FIGURE FIG_EA_6D_BOXPLOT HERE]
[INSERT FIGURE FIG_EA_6D_SCATTER HERE]

Within the 242 nitride test structures, we ask whether the nitrides the pretrained model predicts poorly lie farther in raw 256-D `last_alignn_pool` space from the oxide-reference pool (n = 13 507 oxide train+val structures) than the nitrides it predicts well. Group-level statistics compare the 49 hardest nitrides (top 20 % by absolute zero-shot error) with the 49 easiest (bottom 20 %); the continuous view uses the full 242 structures.

At the tails (Table `TAB_EA_DISTANCE_ERROR_STATS`, Figure `FIG_EA_6D_BOXPLOT`), the hard group has mean 5-nearest-oxide distance 4.5988 vs 3.7821 for the easy group — a hard-minus-easy gap of 0.8168 (95 % CI 0.4746–1.1597, FDR `q = 1.8 × 10⁻⁴`). Across all 242 structures (Figure `FIG_EA_6D_SCATTER`), Spearman correlation between mean oxide-reference distance and absolute zero-shot error is 0.3428 (95 % CI 0.2214–0.4597, FDR `q = 1.3 × 10⁻⁴`); Pearson correlation is 0.2770. The same association appears under both views, in the same direction, at `q`-values on the order of 10⁻⁴ after FDR correction, and the direction is stable under alternative distance definitions (centroid and Mahalanobis; see appendix).

Within the nitride test set, then, structures whose pretrained embeddings sit farther from the oxide-reference region tend to be those on which the pretrained model's zero-shot prediction is least accurate. This is the within-family complement to §3.4: not only is the nitride family harder on average, but intra-family variation in zero-shot error aligns with geometric distance from the oxide-reference region in frozen pretrained space. Together §§3.4 and 3.5 constitute Step 4 of the arc — the behavioural penalty from §§3.1–3.3 has a consistent representation-space correlate. Under **C4**, the association is correlational; shared upstream factors (bonding chemistry, coordination environment, local symmetry) may jointly drive both displacement from the oxide region and unreliability of the pretrained formation-energy head. The distance–error relationship is reported as a geometric indicator consistent with a representation-space shift, not as mechanistic proof.

### 3.6 Supporting evidence — pretrained initialization versus from-scratch training

[INSERT TABLE TAB_S1_FS_SUMMARY HERE]
[INSERT FIGURE FIG_S1_COMP_NITRIDE HERE]

This subsection supports the Step 1–4 arc rather than introducing a parallel main claim. It confirms that pretraining remains operationally valuable on nitrides without revising the headline OOD result.

At the two `N` values with matched from-scratch runs (Table `TAB_S1_FS_SUMMARY`, Figure `FIG_S1_COMP_NITRIDE`), nitride from-scratch MAE is 0.6914 ± 0.0163 eV/atom at `N = 50` (vs fine-tuning 0.1173; gap 0.5741) and 0.3683 ± 0.0233 eV/atom at `N = 500` (vs fine-tuning 0.0977; gap 0.2706). Both from-scratch means sit well above the zero-shot baseline (0.0695 eV/atom); the scratch-minus-zero-shot gap is 0.6219 at `N = 50` and 0.2987 at `N = 500`.

At every available scratch comparison the pretrained route yields substantially lower mean test MAE than random initialization on the same labelled nitride data. Pretraining therefore remains practically valuable on nitrides at both tested scales — a standard-form transfer-learning result [CITE: Lee2021_TransferCGCNN; Hu2024_DomainAdaptation]. The two gaps differ in kind, however, under **C3**:

- The `N = 50` gap (0.5741 eV/atom) is pretrained-initialization advantage over scratch, not a fine-tuning adaptation effect: the corresponding fine-tuning row has `mean_best_epoch = 1.0` under **C2** and is operationally the zero-shot checkpoint.
- The `N = 500` gap (0.2706 eV/atom) is a clean adapted-vs-scratch comparison: the corresponding fine-tuning row has `mean_best_epoch = 40.5`.

"Pretraining helps on nitrides" is therefore a weaker and more expected finding than the headline result developed in §§3.1–3.5. The central OOD finding of this report is that the domain-shift penalty persists through Step 3's genuine adaptation: the best adapted row (`N = 1 000`) remains above zero-shot. §3.6 confirms pretraining's value; it does not overturn the arc. From-scratch nitride baselines exist only at `N = 50` and `N = 500`, so no continuous transfer-benefit curve is inferred across `N`.

---

## 3.7 Summary — the four-step domain-shift arc

Taken together, the nitride evidence produces a single, internally consistent four-step story.

**Step 1 (§3.1).** Zero-shot evaluation places nitrides at roughly 2× the oxide-comparator MAE at the pretrained starting point (0.0695 vs 0.0342 eV/atom).

**Step 2 (§3.2).** Under Set 1, fine-tuning at `N ≤ 200` is operationally inert (`mean_best_epoch = 1.0` at every seed across all four sizes). Oxide, by contrast, has already begun genuine optimization by `N = 50`.

**Step 3 (§3.3).** At `N = 500` (mean best epoch 40.5) and `N = 1 000` (mean best epoch 45.0), fine-tuning becomes genuine and tighter across seeds, but no tested budget recovers the zero-shot baseline; the `N = 1 000` mean test MAE (0.0907 eV/atom) still sits 0.0211 eV/atom above zero-shot.

**Step 4 (§§3.4–3.5).** In frozen `last_alignn_pool` space, families are distinguishable but the nitride region is less cohesive than the oxide control region, and within nitrides, distance from the oxide-reference region co-varies with absolute zero-shot error (Spearman ρ = 0.3428, FDR `q = 1.3 × 10⁻⁴`; hard-minus-easy gap 0.8168, FDR `q = 1.8 × 10⁻⁴`).

**Supporting layer (§3.6).** Pretrained initialization outperforms random initialization by a wide margin at `N = 50` and `N = 500` (under the `N = 50` initialization-advantage caveat **C3**); this confirms pretraining's operational value but does not revise the headline finding that the domain-shift penalty survives genuine adaptation.

The main tables anchoring these results are `TAB_ZS_SUMMARY`, `TAB_S1_FT_SUMMARY_BY_N`, `TAB_S1_FS_SUMMARY`, `TAB_EA_FAMILY_SEPARATION`, and `TAB_EA_DISTANCE_ERROR_STATS`. The main figures are `FIG_ZS_COMPARISON`, `FIG_S1_LC_NITRIDE`, the parity pair `FIG_S1_PARITY_NITRIDE_N10` / `FIG_S1_PARITY_NITRIDE_N1000`, `FIG_S1_COMP_NITRIDE`, and the `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`, `FIG_EA_6D_BOXPLOT`, and `FIG_EA_6D_SCATTER` embedding panels.

## 4. Discussion

### 4.1 The domain-shift answer in one paragraph

Under the canonical protocol on a chemically distinct target family, the cost of pretraining–target mismatch is not concentrated in any one measurement but reappears at every measurement surface examined: at the pretrained starting point, in the optimizer's behaviour during fine-tuning, in the residual error of the genuinely-adapted models, and in the geometry of the frozen representation. The 2× zero-shot family gap (Results §3.1) is the cleanest quantitative signature, because it removes every confound introduced by fine-tuning. The `mean_best_epoch = 1.0` signature from `N = 10` through `N = 200` (Results §3.2) is the strongest behavioural one, showing an optimizer that does not move off the pretrained checkpoint at all under the canonical protocol. The persistence of the penalty at `N = 500` and `N = 1 000` (Results §3.3) shows that the cost survives genuine adaptation within the tested `N` range. And the frozen-representation evidence (Results §§3.4–3.5) shows that all of this coexists with a pretrained-space geometry that already encodes the family distinction before any nitride-specific training. The remainder of this Discussion argues for that reading; it is not a replay of the four steps.

### 4.2 What pretraining helps with on nitrides — and where the help runs out

Transfer learning in materials informatics is conventionally defended as a two-part claim: pretrained representations outperform random initialization, and that value is most pronounced when target-family data are scarce [CITE: Lee & Asahi 2021; Kim et al. 2024]. The nitride evidence confirms the first part and places a sharp boundary on the second.

Pretraining beats random initialization on nitrides at both scratch-tested sizes by a wide margin: gaps of 0.5741 eV/atom at `N = 50` and 0.2706 eV/atom at `N = 500`, with both from-scratch means sitting well above the nitride zero-shot baseline of 0.0695 eV/atom. Random initialization on nitride alone cannot match what a broadly pretrained ALIGNN gives at either tested scale; this is the standard-form transfer-learning result [CITE: Lee & Asahi 2021; Hu et al. 2024], and it holds on nitrides.

The two scratch gaps are asymmetric in meaning, however, and must not be averaged into a single claim. The `N = 50` gap measures pretrained-initialization advantage over scratch, not fine-tuning adaptation, because the corresponding fine-tuning row has `mean_best_epoch = 1.0` and is operationally still the pretrained zero-shot checkpoint with a single optimizer step applied. The `N = 500` gap is the only clean adapted-vs-scratch comparison available on nitrides; its fine-tuning row has `mean_best_epoch = 40.5`. Read together, the two rows say something narrow and useful: on nitrides, the step that delivers value is starting from a pretrained representation in the first place; the additional step of fine-tuning that representation on more labelled nitride data reduces error further at `N = 500`, but from a baseline still above the zero-shot line.

The boundary the nitride evidence draws is operational rather than theoretical and is bounded by the protocol tested. Under Hyperparameter Set 1 and within the six `N` values tested up to 1 000, no fine-tuning configuration achieves a mean test MAE below the nitride zero-shot baseline. We do not claim the nitride penalty is independent of optimization schedule; whether a different schedule could push some configuration below zero-shot is a question the present protocol cannot answer either way. What we do claim — within the tested schedule and `N` range — is that the standard expectation that a few hundred labelled target-family structures will beat the pretrained checkpoint is not met here.

### 4.3 Why nitride is harder: this is not just a small-data problem

The clearest discriminator in the nitride evidence is also the one most easily missed if oxide is not held side-by-side. **Nitride low-`N` inertness cannot be read as ordinary small-data noise, because oxide under the same canonical protocol does not behave this way.** In the matched low-`N` rows (`N = 50, 100, 200`), the oxide arm has already entered genuine multi-epoch optimization — `mean_best_epoch` rises from 18.5 at `N = 50` to 39.0 at `N = 200`. If the nitride `mean_best_epoch = 1.0` pattern were only a noisy-gradient story driven by small budgets, it should appear on oxides too, and it does not. The asymmetry is in *when* multi-epoch optimization engages at all — a behaviour that final-MAE-only tables do not surface.

The candidate that survives this control is a domain-shift reading: the pretrained initialization sits in a region of parameter space that, for the nitride distribution, is not a basin the canonical optimizer can productively descend from at the tested low-`N` budgets, so the loop returns the initialization itself. The `mean_best_epoch = 1.0` signature at nitride `N ≤ 200` reads as convergence to initialization, not failure to converge. This reading is bounded by the canonical protocol: a different schedule might move `mean_best_epoch` off 1.0, and we do not claim otherwise. The behavioural finding supported by the evidence is that, under the canonical protocol, the optimizer is unable to leave the pretrained initialization on nitride splits up to `N = 200` and only begins to do so meaningfully at `N = 500`. That is a domain-shift signature in the operational sense — the same protocol that adapts on oxide does not adapt on nitride at the same data sizes — without requiring a stronger architectural or theoretical claim.

This is consistent with the cautious form of OOD-generalization findings in materials ML, where family- or composition-held-out splits produce larger errors than random splits and transfer-learning gains shrink as chemical distance grows [CITE: Omee et al. 2024; Li et al. 2025 — OOD; Hu et al. 2024]. Our result adds a sharper operational claim within that picture: on a chemically distinct target family under a standard fine-tuning protocol, the canonical low-`N` failure mode is not noisy gradients on small budgets but an optimizer that stays pinned at the pretrained checkpoint.

### 4.4 What the embedding analysis adds beyond the performance curves

The embedding analysis adds two things the behavioural section cannot: a representation-space correlate of the family-level penalty, and a within-family geometric correlate of intra-family difficulty. Each is reported as a geometric indicator consistent with the behavioural picture, not as a causal mechanism.

The first addition comes from the family-separation evidence (Results §3.4). In the frozen 256-D `last_alignn_pool` representation, family labels are recoverable almost perfectly from raw embeddings (logistic-regression family AUC 0.9994), and the two family regions are not symmetric in raw space — the nitride region is internally less cohesive than the oxide region by per-family silhouette and per-family 15-NN purity. The pretrained network has organized the test set along the oxide/nitride axis without supervision on that axis, and the per-family asymmetry in raw-space cohesion aligns in direction with the behavioural asymmetry. This is what we mean by a representation-space correlate: a property of the representation, measured before any nitride-specific training, that points the same way the behavioural penalty does.

The second addition comes from the distance–error evidence (Results §3.5). Within the nitride family, zero-shot error co-varies with mean 5-nearest-oxide distance in raw `last_alignn_pool` space (Spearman ρ = 0.3428, FDR `q = 1.3 × 10⁻⁴`; hard-minus-easy distance gap 0.8168, FDR `q = 1.8 × 10⁻⁴`), with the association stable under alternative distance definitions reported in the appendix. Where a given nitride sits in the pretrained space tracks with how hard the pretrained head finds it to predict, providing a within-family geometric indicator of relative difficulty that aggregate MAE cannot resolve.

We frame both findings as consistent with a representation-space shift, not as causal proof of one. The family AUC is a recoverability statistic, not a mechanism statistic; near-perfect family separation in raw space is compatible with many downstream error patterns. The distance–error association is correlational; shared upstream factors — bonding chemistry, coordination environment, local symmetry — may plausibly drive both displacement from the oxide-reference region and the pretrained head's unreliability on a given structure [CITE: Omee et al. 2024; Li et al. 2025 — OOD; Li et al. 2025 — adversarial]. Two-dimensional projections (PCA, t-SNE, UMAP) are descriptive visual support only; visual inter-cluster distances are not quoted as statistical evidence, because such projections preserve local structure but not global geometry in a physically interpretable way [CITE: van der Maaten & Hinton 2008; McInnes et al. 2018]. Every quantitative claim in the embedding section is computed in the raw 256-D `last_alignn_pool` space.

### 4.5 Practical implications for small-data materials discovery on chemically distant targets

Three implications follow from the nitride evidence, each scoped explicitly to the regime tested: formation energy per atom on JARVIS `dft_3d` nitride splits, the pretrained formation-energy ALIGNN checkpoint, Hyperparameter Set 1, and the six `N` values up to 1 000.

*Labelled-data planning.* On chemically distant target families in a comparable regime, a few hundred labelled target-family structures should not be counted on to beat the pretrained zero-shot baseline under a standard fine-tuning protocol. Our tested range up to `N = 1 000` does not produce such a configuration on nitrides; under the canonical protocol, the threshold at which the optimizer engages at all sits between `N = 200` and `N = 500`. This is a useful reference point for project planning on comparable targets, though we do not claim it transfers to other families, properties, or schedules without testing.

*Communicating transfer value on shifted targets.* When fine-tuning under the canonical protocol does not push below zero-shot, the pretrained-vs-scratch gap is the more defensible measure of transfer value than the fine-tune-vs-zero-shot residual. On nitrides at `N = 500`, the pretrained route sits 0.2706 eV/atom below scratch while remaining above the zero-shot baseline; the order-of-magnitude transfer claim is the robust one, and the residual adaptation improvement over zero-shot is — in this regime — negative.

*Within-family triage.* The distance–error correlate (Spearman ρ = 0.3428, FDR `q = 1.3 × 10⁻⁴`) suggests that pretrained-space geometry can serve as a within-family hardness indicator on chemically distant tasks: structures whose pretrained embeddings sit far from a reference region (here, the oxide train+val pool as the heavier-represented family in the training data) tend to be those on which the pretrained head is least reliable zero-shot. This is consistent with emerging OOD-diagnosis practice in materials ML [CITE: Omee et al. 2024; Li et al. 2025 — OOD]. We stop short of deployment claims: the correlation is moderate, hard and easy distance distributions overlap substantially, and the association is reported for absolute zero-shot error only.

### 4.6 Limitations

Five limitations bound the nitride claim. *(i) Protocol scope.* All results are reported under Hyperparameter Set 1; we do not claim that nitride fine-tuning is incapable of beating zero-shot under alternative schedules, only that it does not within the tested protocol and `N` range. Whether a lower learning rate, a longer budget, or a discriminative fine-tuning policy would move `mean_best_epoch` off 1.0 at `N ≤ 200` is not resolved here. *(ii) Scratch coverage.* From-scratch baselines exist only at `N = 50` and `N = 500`; under the `N = 50` initialization-advantage caveat, the only clean adapted-vs-scratch cross-section is `N = 500`, and no continuous transfer-benefit curve is inferred. *(iii) Test-set size.* The nitride test set contains 242 structures; sampling uncertainty on the nitride zero-shot MAE is larger than on the 1 484-structure oxide comparator, so the 2× family-gap statement is directional rather than tightly pinned. *(iv) Checkpoint scope.* The pretrained checkpoint is the formation-energy ALIGNN model distributed through the JARVIS infrastructure; we do not characterize its training corpus chemically and deliberately do not describe it as "oxide-pretrained." "Oxide-reference region" is used only in the distance-context language of §§3.5 and 4.4. *(v) Embedding causality.* The distance–error association is correlational. It is consistent with a representation-space shift and is reported as a geometric indicator; it does not constitute mechanism proof, and shared upstream factors may drive both geometry and error.

### 4.7 Future work

Four directions extend the nitride analysis without revising its conclusion. Per-family hyperparameter tuning would quantify how much of the low-`N` inertness is protocol-contingent under the canonical evaluation conditions; this would sharpen — without overturning — the split between domain shift and canonical-protocol stall. Scratch baselines at `N ∈ {10, 100, 200, 1 000}` would convert the present two-point pretrained-vs-scratch comparison into a continuous transfer-benefit curve and allow the `N = 50` initialization-advantage caveat to be benchmarked against neighbouring sizes. A compositional, coordination-environment, or structural-prototype decomposition of the nitride residual would test which subpopulations drive the high-`N` parity dispersion and the tail of the distance–error distribution. Extending the distance–error analysis from zero-shot error to fine-tuned error at `N = 500` and `N = 1 000` would test whether the geometric correlate of difficulty survives adaptation or relaxes with it.

---

## 5. Conclusion

This report asked how a pretrained formation-energy ALIGNN model behaves when the target family lies outside the chemistry most aligned with the pretraining distribution, and whether fine-tuning on labelled target-family data can overcome the resulting penalty under the canonical protocol.

The evidence supports a single, four-faceted domain-shift answer. The pretrained checkpoint incurs a 2× nitride zero-shot penalty relative to oxides before any target-family training. Under Hyperparameter Set 1, fine-tuning at `N ≤ 200` is operationally inert — `mean_best_epoch = 1.0` at every seed across all four sizes — so the selected checkpoint at each of those budgets is effectively the pretrained zero-shot state with a single optimizer step applied. At `N = 500` and `N = 1 000` the optimizer engages, but the best genuinely-adapted configuration still sits above the nitride zero-shot baseline. In the frozen `last_alignn_pool` representation, the nitride region is distinguishable from the oxide region but internally less cohesive, and within nitrides, zero-shot error co-varies with distance from the oxide-reference region (Spearman ρ = 0.3428, FDR `q = 1.3 × 10⁻⁴`) — a correlational geometric indicator consistent with a representation-space shift, not a causal mechanism proof.

The practical implication is sharp and bounded by the regime tested: on chemically distant targets in a comparable regime, the labelled-data cost of moving a pretrained baseline below its own zero-shot line under a standard fine-tuning protocol is substantially higher than chemistry-aligned task experience would predict, and project planning should treat that cost as the default rather than the exception. Chemically distant targets require substantially more labelled data to beat a pretrained baseline under this protocol than chemistry-aligned targets do.

## Acknowledgements

[ACKNOWLEDGEMENTS PLACEHOLDER — insert funding, institutional support, and contributor thanks here.]

## References

[REFERENCES PLACEHOLDER — insert JURI/Nature-formatted references here.]
