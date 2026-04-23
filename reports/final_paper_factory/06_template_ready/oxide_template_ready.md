# Pretrained ALIGNN on Oxide Formation Energies: An In-Distribution Control for Data-Efficient Transfer Learning

First Author Name*, Second Author Name

[Affiliation placeholder]

[Corresponding author email placeholder]

## Abstract

Pretrained crystal-graph neural networks have become a routine starting point for materials-property prediction in low-data regimes, but the data-efficiency value of such checkpoints depends on how related the target chemistry is to the distribution that supported pretraining. This report evaluates a single pretrained formation-energy ALIGNN model on an in-distribution oxide control task, providing a reference condition against which the companion chemistry-shifted evaluation can be read. Using the JARVIS `dft_3d` benchmark splits, we compare zero-shot evaluation of the pretrained checkpoint, fine-tuning across six labelled-data sizes from ten to one thousand structures at five random seeds per size, and matched from-scratch baselines at the two sizes where both protocols are available. We further extract frozen `last_alignn_pool` embeddings to characterize how oxides are organized in the pretrained representation. Under the canonical Hyperparameter Set 1 protocol, the pretrained zero-shot checkpoint is already the strongest observed oxide configuration, canonical fine-tuning converges monotonically toward but does not cross that benchmark across the tested range, and pretrained initialization outperforms random initialization by a wide margin at both scratch-tested sizes. In the frozen representation, oxides occupy a cohesive, locally pure region. Scoped to the tested regime, these findings identify that, within the tested range and protocol, the choice of initialization is the dominant data-efficiency lever, position pretrained zero-shot as a defensible first-pass estimator on chemistry-aligned formation-energy targets, and fix the in-distribution reference condition needed to interpret the chemistry-shifted nitride arm as domain shift.

## Keywords

crystal graph neural networks, ALIGNN, pretrained models, transfer learning, fine-tuning, data efficiency, formation energy, oxides, JARVIS DFT-3D, in-distribution evaluation, from-scratch baseline, frozen embeddings

## 1. Introduction

Crystal-property prediction from atomic structure is a central workload in materials informatics. Structure-based crystal graph neural networks perform this task by learning directly from atomic coordinates, bonding topology, and element identities rather than relying solely on handcrafted descriptors, and they have become a routine starting point for high-throughput and low-data property modelling alike [CITE: crystal graph baseline for materials property prediction]. The early canonical exemplar of this family, CGCNN, established that a graph representation of the crystal structure can be mapped to scalar properties with competitive accuracy without hand-engineered features [CITE: CGCNN foundational paper].

ALIGNN sharpens this family by alternating message passing on the bond graph and its line graph, making bond-angle information explicit in the learned representation and improving accuracy on structure-dependent targets [CITE: ALIGNN foundational paper]. The specific ALIGNN checkpoint and training corpus used in this work — a formation-energy regressor trained on the JARVIS DFT-3D database — are distributed through the JARVIS infrastructure, which provides the dataset, the pretrained-model checkpoints, and the benchmark splits used throughout this report [CITE: JARVIS dataset/repository paper].

Transfer learning from pretrained crystal-graph models has been shown to reduce labelled-data requirements for downstream property tasks [CITE: transfer learning in materials informatics]. Whether and how much of this benefit survives on a new target, however, depends on how related the target is to the distribution that supported pretraining; when the target chemistry or structure lies outside that distribution, both accuracy and apparent scaling behaviour can degrade, and recent out-of-distribution evaluations make this failure mode concrete [CITE: domain shift or OOD benchmark in materials property prediction]. What remains harder to read off the existing literature is how a single, widely used pretrained checkpoint behaves across a clean chemical-family split when evaluated as a data-efficiency curve — zero-shot, fine-tuning across labelled-data sizes, and matched from-scratch baselines — rather than as a single test-MAE number.

This report addresses the in-distribution half of that evaluation. Using the same pretrained formation-energy ALIGNN model [CITE: ALIGNN foundational paper] on the JARVIS `dft_3d` benchmark splits [CITE: JARVIS dataset/repository paper], we study a chemistry-aligned oxide target — the regime in which a broadly JARVIS-trained representation is most likely to operate as transfer learning predicts. We evaluate the checkpoint zero-shot, fine-tune it across a range of labelled-data sizes at multiple random seeds, and compare fine-tuned runs against matched from-scratch baselines at the sample sizes where both protocols are available. To describe how oxides are organized in the pretrained representation before any fine-tuning, we also extract frozen intermediate embeddings from the same checkpoint. The companion nitride report treats the chemistry-shifted case on the same infrastructure; the two together form the control-versus-shift design for the combined manuscript.

The oxide report asks three linked questions scoped to the in-distribution control task: how strong the pretrained zero-shot checkpoint already is on a chemistry-aligned oxide target; how the fine-tuning response scales with labelled-data size across the tested range; and what pretraining contributes at the sample sizes where matched from-scratch baselines are available. A fourth, subsidiary question — whether the pretrained representation organizes oxides into a coherent region in embedding space — is addressed briefly as a bridge to the companion work. Section 2 describes the dataset, splits, protocols, and hyperparameter settings. Section 3 reports the zero-shot, fine-tuning, and from-scratch results, together with a short embedding bridge. Sections 4 and 5 discuss the control-arm interpretation and conclude with the reference condition carried forward to the domain-shift arm.

[INSERT FIGURE FIG_SCHEMATIC HERE]

## 2. Methodology

### 2.1 Dataset and prediction target

Crystal structures and formation-energy labels were obtained from the JARVIS materials repository, specifically the `dft_3d_2021` release [CITE: JARVIS 2020 dataset/repository paper]. The supervised target throughout the oxide arm is per-atom formation energy `formation_energy_peratom`, reported in eV/atom. A machine-readable summary of the filtered oxide composition is stored at `data_shared/oxide/summaries/summary.json`; the underlying filter is `scripts/dataset/build_res201_family_datasets.py`.

### 2.2 Oxide family definition

We define an oxide as any structure whose composition contains oxygen. Oxynitrides — structures containing both oxygen and nitrogen — are retained in the oxide arm (499 structures after filtering). Family assignment is performed by `scripts/dataset/res201_stage2_lib.py` through `classify_family(...)` with `keep_oxynitrides_in_oxide=True`. For reference, the complementary nitride family used in related work is defined as structures containing nitrogen but no oxygen; that arm is not analysed in this report.

### 2.3 Split protocol and run-local subset construction

[INSERT TABLE TAB_METHODS_DATASET_SPLITS HERE]

We preserve the original JARVIS benchmark split identities (`provided:manifests/dft_3d_formation_energy_peratom_splits.csv`) before applying family filtering, so each oxide structure retains the train, validation, or test assignment it carries in the underlying release [CITE: JARVIS 2020 dataset/repository paper]. After filtering, the oxide family contains 14 991 structures (11 960 train / 1 547 validation / 1 484 test); the pool — training plus validation — holds 13 507 structures. Full counts and their source appear in Table 1 (`TAB_METHODS_DATASET_SPLITS`).

Run-local training subsets are constructed by `scripts/shared/Prepare_Week1_Finetuning_Dataset.py`. For each sample size `N` and seed, `N` structures are drawn from the oxide pool using `np.random.default_rng(seed).permutation(...)[:N]`. Within each subset, validation allocation is `n_val = max(5, round(0.1 × N))`, with training taking the remainder; if that rule would produce `n_val ≥ N`, the allocation falls back to `max(1, N // 5)`. The fixed oxide test set (n = 1 484) is appended unchanged to every run-local dataset. Row ordering inside each `id_prop.csv` is enforced with `keep_data_order=True` together with explicit `n_train`, `n_val`, and `n_test` arguments, ensuring the loader sees a deterministic training, validation, and test sequence.

### 2.4 Zero-shot evaluation

The pretrained formation-energy ALIGNN model is evaluated on the fixed oxide test set without task-specific training [CITE: ALIGNN foundational paper]. The evaluation, implemented in `scripts/shared/Evaluate_ALIGNN_Zero_Shot.py`, loads the POSCAR files listed in `data_shared/oxide/manifests/test.csv` and obtains per-structure predictions via `alignn.pretrained.get_prediction(model_name="jv_formation_energy_peratom_alignn", atoms=atoms)`; test MAE is computed with `sklearn.metrics.mean_absolute_error`. Per-structure outputs are written to `Results_Before_Correction/oxide/zero_shot/predictions.csv`, and the summary value is recorded in `reports/zero_shot/zero_shot_summary.csv`. Zero-shot evaluation is performed once per family and is not seed-varied.

### 2.5 Fine-tuning and from-scratch training protocols

Fine-tuning (`scripts/shared/Fine_Tune_Last_Two_ALIGNN_Layers.py`) begins from the pretrained checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt` and its accompanying configuration. All parameters are frozen, after which training is selectively re-enabled for the final gated GCN block (`gcn_layers.3`) and the scalar output head (`fc`). The overall model remains in `eval()` mode; only the two unfrozen modules are switched to training mode, and runtime invariant checks confirm that no additional parameters become trainable. Optimization uses `AdamW` with a `OneCycleLR` schedule and an L1 training objective (`torch.nn.L1Loss`); for transparency, the inherited config JSON retains a `criterion: "mse"` entry from the original pretraining configuration that the custom training script overrides, training with L1 throughout. The best checkpoint per run is selected by minimum validation L1, and each run writes a `summary.json` recording `best_epoch` and `test_mae_eV_per_atom`. Oxide fine-tuning was conducted at `N ∈ {10, 50, 100, 200, 500, 1 000}` with five random seeds per condition (30 oxide fine-tuning runs in total).

From-scratch training (`scripts/shared/Train_ALIGNN_From_Scratch.py`) reuses the identical run-local dataset roots and model configuration but instantiates a fresh ALIGNN model (`ALIGNN(ALIGNNConfig(**cfg.model.model_dump()))`) with no pretrained weights and all parameters trainable. The optimizer, learning-rate schedule, L1 objective, and best-checkpoint rule match the fine-tuning setup. From-scratch baselines exist only at `N = 50` and `N = 500`, with five seeds at each (10 oxide from-scratch runs in total). Because no from-scratch baseline exists at `N = 10, 100, 200`, or `1 000`, Results and Discussion restrict all transfer-benefit comparisons to the two sizes where both protocols are available.

### 2.6 Hyperparameter setting, model specification, and evaluation metric

[INSERT TABLE TAB_METHODS_EXPERIMENT_SCOPE HERE]

All trained oxide runs use Hyperparameter Set 1, the canonical namespace fixed by the project brief: `epochs = 50`, `batch_size = 16`, `learning_rate = 1 × 10⁻⁴`. The shared graph-construction settings are `neighbor_strategy = "k-nearest"`, `cutoff = 8.0` Å, `cutoff_extra = 3.0` Å, and `max_neighbors = 12`, with `use_canonize`, `compute_line_graph`, and `use_lmdb` enabled. The architecture is the ALIGNN formation-energy model: four ALIGNN convolutional layers, four gated GCN layers, hidden size 256, and a scalar output head [CITE: ALIGNN foundational paper]. No separate architecture subsection is introduced.

The primary reported metric is test-set mean absolute error (MAE) in eV/atom. Checkpoint selection for all trained protocols uses the lowest validation L1. Multi-seed results are summarized as mean ± standard deviation across the five random seeds; the zero-shot value is a single evaluation on the fixed oxide test set and is reported without a dispersion estimate. The oxide arm's full experimental scope — one zero-shot evaluation, 30 fine-tuning runs, and 10 from-scratch runs — appears in Table 2 (`TAB_METHODS_EXPERIMENT_SCOPE`).

### 2.7 Embedding-analysis bridge

To complement the error-based evaluation, we extract structure embeddings from the frozen pretrained ALIGNN model (checkpoint `jv_formation_energy_peratom_alignn/checkpoint_300.pt`) without retraining and without modifying any fine-tuning or from-scratch outputs. The main-text embedding layer throughout this report is `last_alignn_pool`, the pooled node tensor returned by the last ALIGNN convolutional block. Two additional layers (`pre_head` and `last_gcn_pool`) are extracted as robustness controls; in the current outputs they are numerical near-duplicates of each other, are treated as a matched pair of appendix-facing layers, and are not presented as independent probes of the representation. Full visualization parameters, the complete family-separation metric set, and the nitride distance-versus-error protocol are documented in the combined paper and in `embedding_methods_appendix_notes_v1.md`; the oxide report uses this extraction only to confirm that the same pretrained representation space supports the family-separation bridge figure discussed in Results. Throughout, the embedding workflow is treated as an interpretive protocol rather than a mechanism-proving instrument.

---

## 3. Results

The oxide arm is reported in five parts. Section 3.1 establishes the Set 1 zero-shot benchmark of the pretrained ALIGNN checkpoint [CITE: Choudhary & DeCost 2021 — ALIGNN] on the fixed oxide test set. Section 3.2 characterizes Set 1 fine-tuning across `N ∈ {10, 50, 100, 200, 500, 1 000}`. Section 3.3 summarizes the parity view at the two canonical endpoints. Section 3.4 — the central on-oxide transfer-value result — contrasts fine-tuning against training from scratch at the two data sizes where scratch baselines were run. Section 3.5 reports the oxide-side of the pretrained-embedding analysis as a self-contained representation-level finding.

### 3.1 The pretrained zero-shot MAE is the best observed oxide configuration under Set 1

[INSERT TABLE TAB_ZS_SUMMARY HERE]

We evaluated the unmodified pretrained formation-energy ALIGNN checkpoint (`jv_formation_energy_peratom_alignn`) on the 1 484-structure oxide test set without any target-family fine-tuning, establishing the control benchmark against which every fine-tuning, parity, and from-scratch result reported below is compared. The checkpoint attains a test mean absolute error of **0.0342 eV/atom** on the oxide test set (Table `TAB_ZS_SUMMARY`). This is the best observed oxide MAE under Set 1 anywhere in this study: no fine-tuning row at any `N` sits below it (§3.2), and every from-scratch row sits far above it (§3.4). Oxides serve as the in-distribution control arm by project design; the pretrained model and training data used here derive from the JARVIS materials infrastructure [CITE: Choudhary et al. 2020 — JARVIS; Choudhary et al. 2024 — JARVIS-Leaderboard]. We make no separate claim about the exact chemical composition of the pretraining corpus, and we do not claim that no alternative fine-tuning protocol could improve on this baseline — such claims are out of scope for the Set 1 main narrative.

### 3.2 Set 1 fine-tuning converges toward, but does not surpass, the zero-shot benchmark

[INSERT TABLE TAB_S1_FT_SUMMARY_BY_N HERE]
[INSERT FIGURE FIG_S1_LC_OXIDE HERE]

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

[INSERT FIGURE FIG_S1_PARITY_OXIDE_N10 HERE]
[INSERT FIGURE FIG_S1_PARITY_OXIDE_N1000 HERE]

We report the oxide parity plots at the two canonical endpoints: `N = 10` (`FIG_S1_PARITY_OXIDE_N10`) and `N = 1 000` (`FIG_S1_PARITY_OXIDE_N1000`). Each panel shows seed-averaged predictions against ground-truth formation energies on the 1 484-structure test set, with on-figure MAE, RMSE, and R² computed on those seed-averaged predictions. Intermediate panels at `N = 50, 100, 200, 500` are provided in the Appendix.

The two endpoints look visually similar (on-figure MAE 0.0391 and 0.0383 eV/atom; R² 0.9944 and 0.9943) because the pretrained model already performs well on the oxide test set. The substantive difference is not the scatter structure but the optimization depth and reproducibility behind each panel: `mean_best_epoch` rises from 1.0 to 35.5, and per-seed standard deviation narrows from 0.0111 to 0.0053 eV/atom. The `N = 10` panel is best read as a near-pretrained-checkpoint snapshot; the `N = 1 000` panel, as a genuinely optimized and substantially more reproducible fine-tuned model. A technical note: on-figure MAEs are computed on seed-averaged predictions, whereas summary-table MAEs average per-seed MAEs, so the two values are not interchangeable. Parity panels describe prediction quality, not mechanism; they are bounded by the same Set 1 protocol as the underlying fine-tuning results.

### 3.4 Pretrained initialization dominates random initialization at both scratch-tested sizes

[INSERT TABLE TAB_S1_FS_SUMMARY HERE]
[INSERT FIGURE FIG_S1_COMP_OXIDE HERE]

Sections 3.1–3.3 established that the pretrained checkpoint is already strong on oxides under Set 1 and that Set 1 fine-tuning does not surpass it. That alone would not demonstrate transfer value. The oxide arm's transfer-value evidence lives in this subsection: if pretrained initialization were not itself responsible for the strong oxide performance, it should be possible to reach similar error by training the same architecture from scratch on the same oxide data under the same protocol. It is not — by a very large margin.

At `N = 50` and `N = 500` — the two oxide training sizes for which from-scratch baselines were run — we compare the Set 1 fine-tuning MAE against the MAE of randomly-initialized ALIGNN models trained on the same oxide splits with the same hyperparameters, protocol, and test set (Table `TAB_S1_FS_SUMMARY`, Figure `FIG_S1_COMP_OXIDE`):

| `N` | Fine-tune mean MAE ± SD (eV/atom) | From-scratch mean MAE ± SD (eV/atom) | Scratch − fine-tune (eV/atom) | Scratch − zero-shot (eV/atom) |
|----:|----------------------------------:|-------------------------------------:|------------------------------:|------------------------------:|
| 50  | 0.0523 ± 0.0148                   | 0.5561 ± 0.0523                      | +0.5038                       | +0.5219                       |
| 500 | 0.0430 ± 0.0062                   | 0.2643 ± 0.0228                      | +0.2214                       | +0.2301                       |

At `N = 50`, from-scratch MAE is roughly an order of magnitude higher than fine-tune MAE; at `N = 500`, roughly six times higher. Between these two points, from-scratch MAE drops substantially (0.5561 → 0.2643 eV/atom) while fine-tune MAE changes only modestly (0.0523 → 0.0430 eV/atom), narrowing the transfer-benefit gap from 0.5038 to 0.2214 eV/atom. Both from-scratch points sit far above the zero-shot benchmark as well (scratch − zero-shot of 0.5219 and 0.2301 eV/atom).

The pattern is consistent with pretrained initialization providing a large labelled-data saving relative to random initialization in the oxide regime studied, and with randomly-initialized ALIGNN improving at a faster rate with more data than fine-tuning does, because fine-tuning is already bounded near the zero-shot benchmark. This gap is the oxide arm's clearest on-family signature of transfer value: fine-tuning does not need to surpass zero-shot for the pretrained representation to be delivering a substantial benefit. At `N = 500` under Set 1, fine-tuning sits 0.2214 eV/atom below scratch while sitting only 0.0088 eV/atom above zero-shot, so the transfer gain relative to a no-pretraining world is roughly 25× the residual gap to the zero-shot benchmark. The gap is measured at only two data sizes; we do not extrapolate a continuous scratch learning curve or claim where, if anywhere, scratch would intersect fine-tune or zero-shot at much larger `N`.

### 3.5 Oxide embeddings form a cohesive, locally pure region in pretrained representation space

[INSERT TABLE TAB_EA_FAMILY_SEPARATION HERE]
[INSERT FIGURE FIG_EA_6A_PCA HERE]
[INSERT FIGURE FIG_EA_6B_TSNE HERE]
[INSERT FIGURE FIG_EA_6C_UMAP HERE]

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

## 4. Discussion

### 4.1 What the oxide control establishes

The oxide arm answers a single question for the broader study: when the target chemistry sits inside the regime a broadly JARVIS-trained ALIGNN already handles, what does pretraining actually deliver, and what role does fine-tuning then play? Three pieces of evidence fix the answer. Pretrained initialization beats random initialization by a wide margin at both data sizes where scratch was measured. The pretrained zero-shot checkpoint is already the strongest oxide configuration observed under the canonical protocol, and canonical fine-tuning converges toward — but does not cross — that benchmark across the tested range. And in the frozen pretrained representation, oxides occupy a cohesive, locally pure region. Read together, these establish the in-distribution reference condition for the project: under the canonical protocol on a chemistry-aligned target, pretraining is the dominant accuracy lever and fine-tuning's operational role is reproducibility rather than headline accuracy. The remainder of this Discussion explains each of those three pieces, keeps literature claims separate from our findings, and makes explicit which features of the result are tied to the tested protocol rather than to oxide chemistry per se.

### 4.2 What pretraining delivers on the in-distribution task

Prior work on transfer learning for crystal graph neural networks reports that reusing pretrained representations is most effective when the target lies close to the data regime that supported pretraining, with the largest per-sample benefit typically observed in the low-data regime [CITE: Lee & Asahi 2021; Kim et al. 2024]. Pretrained graph neural networks in materials informatics are conventionally used either as zero-shot baselines or as initialization for supervised fine-tuning [CITE: Xie & Grossman 2018 — CGCNN; Choudhary & DeCost 2021 — ALIGNN; Choudhary et al. 2020 — JARVIS; Choudhary et al. 2024 — JARVIS-Leaderboard].

Our oxide evidence speaks to a specific shape of that benefit. Under Hyperparameter Set 1 on the fixed 1 484-structure oxide test set, pretrained initialization delivers a large, consistent advantage over random initialization at the two scratch-tested sizes — gaps of 0.5038 eV/atom at `N = 50` and 0.2214 eV/atom at `N = 500`. At `N = 500`, that pretrained-vs-scratch gap is roughly 25× the residual gap between fine-tuning and the zero-shot benchmark. The asymmetry is the operative point: in this regime, the labelled-data value of starting from the pretrained checkpoint dwarfs anything the fine-tuning loop adds downstream of it, and fine-tuning's residual contribution is small and positive in the seed-variance dimension rather than in the mean.

We deliberately do not describe the oxide arm's headline as "fine-tuning improves on zero-shot." Under Hyperparameter Set 1, every fine-tuning row sits above the zero-shot benchmark; the residual gap is small at the largest tested budgets but never negative. This protocol-bounded outcome is consistent with prior reports that when a pretrained backbone is already strong on a chemistry-aligned target, additional supervised fine-tuning produces only modest improvements in the mean [CITE: Choudhary et al. 2024 — JARVIS-Leaderboard]. Within the tested `N` range, schedule, and target property, the most defensible operational reading is that the representation the model can already deploy zero-shot is most of what pretraining is delivering for this family.

### 4.3 Why oxide is easier — and why that makes the nitride contrast interpretable

Oxides sit within the operating regime of a broadly JARVIS-trained representation by study design [CITE: Choudhary et al. 2020 — JARVIS; Choudhary & DeCost 2021 — ALIGNN]. Three empirical features of the oxide trajectory are consistent with that positioning without requiring any stronger claim about the chemical composition of the pretraining corpus. The fine-tuning loop willingly leaves the pretrained initialization at small `N` — `mean_best_epoch` rises to 18.5 at `N = 50` and stabilizes at 35–39 from `N = 200` onward — so the optimizer is not pinned to an epoch-1 checkpoint as it is on nitrides. Mean test MAE recovers monotonically from the small-data penalty at `N = 50` back toward the zero-shot benchmark, and cross-seed standard deviation tightens by roughly 2× across the tested range. The parity views at the two endpoints look qualitatively similar because the pretrained model is already competent on the test population; what changes with `N` is optimization depth and reproducibility, not the gross shape of the scatter.

The scientific weight of this "easier" status is not that oxide is uninteresting — it is that the oxide arm establishes the best-case transfer regime, the regime in which the canonical protocol behaves the way the transfer-learning literature predicts it should. Without this reference, the nitride arm's behaviour cannot be diagnosed: a slow learning curve on a single family in isolation could be read as small-data noise, optimizer pathology, or chemistry-specific difficulty in roughly equal measure. Anchoring the broader study in a control case where the pretrained representation works as advertised is what allows the companion nitride report to read its own evidence as domain shift rather than as one of those alternatives. The oxide arm earns its scientific role precisely because it is the case the pretrained model was, in practice, prepared for.

### 4.4 What the embedding view adds on the oxide side

Embedding-level analyses of pretrained crystal GNNs have been used to describe how representations organize along chemical family, composition space, or structural motif [CITE: Choudhary & DeCost 2021; Choudhary 2025]; subsequent out-of-distribution work has argued that pretrained-representation structure correlates with generalization while framing such analyses as *consistent-with* rather than causal evidence [CITE: Omee et al. 2024; Li et al. 2025 — OOD; Hu et al. 2024]. We follow that convention here.

On the oxide side, the `last_alignn_pool` representation places oxides in a cohesive, locally pure region. The 15-nearest-neighbour family purity on oxide test points is 0.9872 — oxide local neighbourhoods in this layer are almost entirely oxide-only — and the family label is recoverable from the raw 256-D embeddings with near-perfect separability (logistic-regression family AUC 0.9994). Three concrete oxide-side observations follow: oxide neighbourhoods carry negligible cross-family contamination; the oxide region is internally more coherent than the nitride region in raw space; and the pretrained representation has organized the test set along the oxide/non-oxide axis without supervision on that axis.

Because the oxide arm's scientific weight rests on the behavioural pretrained-vs-scratch comparison, the embedding view is read here as a representation-space description consistent with the behavioural picture, not as a separate causal account of it. PCA, t-SNE, and UMAP panels are descriptive support only; visual inter-cluster distances are not quoted as statistical evidence, because such projections preserve local structure but not global geometry in a physically interpretable way [CITE: van der Maaten & Hinton 2008; McInnes et al. 2018]. The quantitative distance–error analyses that link representation geometry to prediction error are nitride-facing and live in the combined manuscript; the oxide report forward-references them rather than reproducing them.

### 4.5 Practical implications for small-data oxide prediction

Two implications follow conservatively from the oxide evidence, each scoped explicitly to the regime tested.

The first is a budget-allocation observation. For formation energy per atom on JARVIS `dft_3d` oxide splits under Hyperparameter Set 1 at `N ∈ {50, 500}`, the choice of initialization is the dominant data-efficiency lever: at `N = 500` the pretrained route reaches a mean test MAE of about 0.043 eV/atom against about 0.264 eV/atom from scratch, while the fine-tuning mean changes by only 0.0013 eV/atom between `N = 500` and `N = 1 000`. If a project must allocate computation between obtaining a stronger pretrained starting point and collecting more labelled oxide data, the present evidence supports spending it on the starting point — within the tested scratch sizes, fine-tuning `N` range, and target property.

The second is an operational claim about zero-shot. Because the pretrained zero-shot MAE is the best observed oxide configuration under Set 1 in this study, pretrained zero-shot is a defensible first-pass estimator on chemistry-aligned formation-energy targets in a comparable regime, with fine-tuning useful primarily for tightening cross-seed reproducibility (per-seed standard deviation roughly halves across the tested `N` range) rather than for producing the headline accuracy. We avoid stronger versions of this claim because the regime is specific in four ways: the target is formation energy per atom; the splits are JARVIS `dft_3d` oxide splits; the protocol is Hyperparameter Set 1; and the fine-tuning `N` range tops out at 1 000. We do not infer behaviour at larger `N`, on other target properties, or under alternative schedules.

### 4.6 Limitations

Five limitations bound the oxide claim. *(i) Scratch coverage.* From-scratch baselines exist only at `N = 50` and `N = 500`. We do not infer a continuous scratch learning curve at intermediate or larger `N`, and we do not claim where, if anywhere, scratch would intersect fine-tune or zero-shot at much larger `N`. *(ii) Fine-tuning range.* Six `N` values were tested up to `N = 1 000`; the flattening of the oxide learning curve at high `N` is consistent with convergence toward the zero-shot benchmark from above, but we describe this as flattening, not as demonstrated saturation. *(iii) Protocol scope.* The "zero-shot is best observed" statement is bounded by Hyperparameter Set 1; whether a different schedule — a lower learning rate, a longer budget, a discriminative fine-tuning policy — could produce a configuration below zero-shot is not resolved here. *(iv) Target and corpus.* The target is formation energy per atom on JARVIS `dft_3d` oxide splits; we do not claim the oxide pattern generalizes to other properties or to other oxide-containing distributions. *(v) Embedding scope.* Raw-space `last_alignn_pool` metrics describe the organization of the pretrained representation but do not quantify how much of the behavioural picture is attributable to representation geometry, and projection panels are descriptive only.

### 4.7 Future work

Three directions follow naturally from this control arm. Extending fine-tuning beyond `N = 1 000` under Set 1 would clarify whether the oxide learning curve eventually crosses the zero-shot benchmark or continues to flatten against it. A more granular scratch sweep at `N ∈ {10, 100, 200, 1 000}` would turn the present two-point pretrained-vs-scratch comparison into a continuous transfer-benefit curve and pin the data-efficiency advantage as a function of `N` rather than at two sizes. A within-oxide version of the distance–error analysis reported in the nitride arm would test whether the correlational geometric indicator developed there generalizes to the in-distribution setting, extending the embedding view from a control-arm description to an analytical tool.

---

## 5. Conclusion

This report asked what a pretrained formation-energy ALIGNN model contributes when the target chemistry is aligned with the regime the model was prepared for, and how fine-tuning behaves in that setting. Under the canonical protocol on the oxide test split, pretrained initialization dominates random initialization at both scratch-tested sizes (gaps of 0.5038 eV/atom at `N = 50` and 0.2214 eV/atom at `N = 500`), the pretrained zero-shot MAE of 0.0342 eV/atom is the best observed oxide configuration in this study, and the frozen `last_alignn_pool` representation places oxides in a cohesive, locally pure region (family AUC 0.9994; oxide silhouette 0.2546) consistent with that behaviour.

Scoped to formation energy per atom on JARVIS `dft_3d` oxide splits under Hyperparameter Set 1 and the tested `N` range, the practical reading is that the choice of initialization is the dominant data-efficiency lever, that fine-tuning is most useful for tightening cross-seed reproducibility rather than for improving the mean, and that pretrained zero-shot is a defensible first-pass estimator on chemistry-aligned targets.

The broader role of these findings is to fix the reference condition for the project. The oxide arm is the case in which the pretrained representation is known to operate in the regime it was prepared for; it is the control without which the companion nitride report's evidence cannot be diagnosed as domain shift rather than as small-data noise or optimizer pathology. By establishing what transfer working as advertised looks like under the canonical protocol, this report makes the chemical-family domain shift documented in the companion work an interpretable and quantifiable phenomenon rather than an isolated observation.

## Acknowledgements

[ACKNOWLEDGEMENTS PLACEHOLDER — insert funding, institutional support, and contributor thanks here.]

## References

[REFERENCES PLACEHOLDER — insert JURI/Nature-formatted references here.]
