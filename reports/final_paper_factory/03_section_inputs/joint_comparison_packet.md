# Joint Comparison Packet

Status: combined-paper source packet for Results III direct comparison, with a short Results IV handoff.

Canonical namespace: Hyperparameter Set 1 for fine-tuning and from-scratch; shared zero-shot from `reports/zero_shot/`; embedding interpretation from Week 4 `last_alignn_pool` outputs.

## Source Priority

| Evidence type | Primary source |
|---|---|
| Blueprint structure | `reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md` |
| Canonical numbers | `reports/final_paper_factory/00_source_of_truth/canonical_numbers_v2.md` and `.csv` |
| Oxide results | `reports/final_paper_factory/03_section_inputs/oxide_results_packet.md` |
| Nitride results | `reports/final_paper_factory/03_section_inputs/nitride_results_section_draft_v3.md` and `nitride_results_packet.md` |
| Figure memos | `reports/final_paper_factory/02_figure_memos/` |
| Embedding companion packet | `reports/final_paper_factory/03_section_inputs/embedding_interpretation_packet.md` |

## Results III Job

Results III should compare, not replay. The section should place the already-established oxide and nitride stories side by side on three axes: zero-shot starting point, fine-tuning response, and transfer benefit over scratch. Each subsection should use one direct figure/table anchor and one short interpretation sentence.

## Direct Oxide vs Nitride Zero-Shot Comparison

| Family | Test set | Zero-shot MAE | Rounded prose value |
|---|---:|---:|---:|
| Oxide | `1484` | `0.03418360680813096` | `0.0342 eV/atom` |
| Nitride | `242` | `0.06954201496284854` | `0.0695 eV/atom` |

Direct comparison:

- Nitride zero-shot MAE exceeds oxide zero-shot MAE by `0.0353584082 eV/atom`.
- Nitride zero-shot MAE is `2.034x` the oxide zero-shot MAE.
- Best Results III figure anchor: `FIG_ZS_COMPARISON`.

Draftable comparison sentence: The same pretrained formation-energy ALIGNN checkpoint starts from `0.0342 eV/atom` MAE on oxides and `0.0695 eV/atom` on nitrides, a `2.03x` gap that establishes the domain-shift penalty before any target-family training.

Guardrail: This is a behavioral starting-point comparison, not a mechanism claim. Do not infer the cause of the gap from zero-shot MAE alone.

## Direct Oxide vs Nitride Fine-Tuning Comparison

Primary comparison table: `TAB_S1_FT_SUMMARY_BY_N`.

| N | Oxide mean MAE | Oxide best epoch | Nitride mean MAE | Nitride best epoch | Nitride minus oxide MAE | Main comparison |
|---:|---:|---:|---:|---:|---:|---|
| 10 | `0.0417` | `1.0` | `0.0874` | `1.0` | `0.0457` | Both are near-pretrained/early-checkpoint rows; nitride error is about `2.09x` oxide. |
| 50 | `0.0523` | `18.5` | `0.1173` | `1.0` | `0.0650` | Oxide has begun multi-epoch optimization; nitride remains inert. |
| 100 | `0.0465` | `20.0` | `0.1722` | `1.0` | `0.1257` | Largest family gap in mean fine-tuned MAE; nitride still inert. |
| 200 | `0.0457` | `39.0` | `0.1392` | `1.0` | `0.0935` | Oxide is genuinely adapting; nitride remains pinned to epoch 1. |
| 500 | `0.0430` | `39.0` | `0.0977` | `40.5` | `0.0547` | Nitride adaptation finally switches on, but error remains much higher. |
| 1000 | `0.0417` | `35.5` | `0.0907` | `45.0` | `0.0490` | Both are genuinely optimized; nitride remains above oxide and above nitride zero-shot. |

Direct comparison pattern:

- Oxide begins genuine optimization by `N=50` (`mean_best_epoch = 18.5`).
- Nitride remains operationally inert through `N=200` (`mean_best_epoch = 1.0` at `N=10`, `50`, `100`, and `200`).
- Nitride adaptation begins at `N=500` (`mean_best_epoch = 40.5`) and continues at `N=1000` (`45.0`), but no nitride fine-tuning row beats nitride zero-shot.
- Best Results III figure anchors: `FIG_S1_LC_OXIDE` and `FIG_S1_LC_NITRIDE` as a side-by-side learning-curve pair.

Draftable comparison sentence: The family contrast is not only that nitride MAE is higher; it is that oxide begins multi-epoch adaptation by `N=50`, while nitride remains an epoch-1, effectively inert fine-tuning regime through `N=200`.

Guardrail: Do not describe nitride `N<=200` as successful low-data fine-tuning. Those rows are early-checkpoint outputs and all remain worse than nitride zero-shot.

## Transfer-Benefit Comparison Across Families

Definition: `transfer benefit = from-scratch MAE - fine-tuned MAE`.

Scope: from-scratch baselines exist only at `N=50` and `N=500` for both families. No transfer-benefit claim should be made at `N=10`, `100`, `200`, or `1000`.

| Family | N | Scratch MAE | Fine-tuned MAE | Transfer benefit | Required caveat |
|---|---:|---:|---:|---:|---|
| Oxide | 50 | `0.5561` | `0.0523` | `0.5038` | Genuine oxide optimization has begun (`mean_best_epoch = 18.5`). |
| Nitride | 50 | `0.6914` | `0.1173` | `0.5741` | Pretrained-initialization advantage over scratch, not fine-tuning adaptation (`mean_best_epoch = 1.0`). |
| Oxide | 500 | `0.2643` | `0.0430` | `0.2214` | Clean adapted fine-tune vs scratch comparison. |
| Nitride | 500 | `0.3683` | `0.0977` | `0.2706` | First clean nitride adapted fine-tune vs scratch comparison. |

Direct comparison pattern:

- Both families benefit strongly from pretrained initialization relative to random initialization at both tested scratch sizes.
- Benefits are larger at `N=50` than at `N=500` for both families.
- Nitride bars are numerically taller, but this should not be framed as better nitride transfer. Nitride also has the weaker scratch anchor and worse final MAE.
- Best Results III figure anchor: `FIG_TRANSFER_BENEFIT`; optional companions are `FIG_S1_COMP_OXIDE` and `FIG_S1_COMP_NITRIDE`.

Draftable comparison sentence: Pretraining is valuable in both families at the two scratch-tested sizes, but the nitride `N=50` value must be read as pretrained-initialization advantage over scratch, not fine-tuning adaptation; the clean adapted cross-family comparison begins at `N=500`.

## Most Informative Parity Comparisons

Use parity plots as visual diagnostics, not as the primary performance table. On-figure MAE is computed after seed-averaging predictions; summary-table MAE averages per-seed MAEs.

| Pair | Figures | What it shows | Why it matters |
|---|---|---|---|
| Low-N family pair | `FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_NITRIDE_N10` | Oxide on-figure MAE `0.0391`; nitride on-figure MAE `0.0828`. Both have `mean_best_epoch = 1.0`. | Shows the same near-pretrained checkpoint condition looks much cleaner on oxide than nitride. |
| High-N family pair | `FIG_S1_PARITY_OXIDE_N1000`, `FIG_S1_PARITY_NITRIDE_N1000` | Oxide on-figure MAE `0.0383`; nitride on-figure MAE `0.0829`. Both are genuinely optimized (`35.5` and `45.0` mean best epoch). | Shows the nitride parity gap persists even after high-N adaptation begins. |
| Within-nitride pair | `FIG_S1_PARITY_NITRIDE_N10`, `FIG_S1_PARITY_NITRIDE_N1000` | On-figure MAE is nearly unchanged (`0.0828` vs `0.0829`), while best epoch shifts from `1.0` to `45.0`. | Shows high-N nitride fine-tuning changes adaptation status and variance more than broad parity appearance. |
| Within-oxide pair | `FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_OXIDE_N1000` | On-figure MAE remains close (`0.0391` vs `0.0383`), while best epoch shifts from `1.0` to `35.5`. | Shows oxide high-N fine-tuning stabilizes a model that was already visually close to parity. |

Recommended Results III use: if space is tight, include the high-N family pair only, because it compares two genuinely optimized endpoints. If space allows a four-panel parity supplement, use both low-N and high-N family pairs.

## Embedding Figure Memo Set

Primary embedding packet: `embedding_interpretation_packet.md`.

| Figure | Memo | Main role |
|---|---|---|
| `FIG_EA_6A_PCA` | `fig10_embedding_pca_memo.md` | Conservative family-separation opener for Results IV. |
| `FIG_EA_6B_TSNE` | `fig11_embedding_tsne_memo.md` | Local-neighborhood family-separation companion. |
| `FIG_EA_6C_UMAP` | `fig12_embedding_umap_memo.md` | Third projection view; useful if Results IV has space for a projection triptych. |
| `FIG_EA_6D_BOXPLOT` | `fig13_nitride_distance_error_memo.md` | Strongest tail-contrast evidence linking nitride difficulty to oxide-reference distance. |
| `FIG_EA_6D_SCATTER` | `fig13b_nitride_distance_error_scatter_memo.md` | Strongest continuous-association view across all `242` nitrides. |

## Raw Embedding Summary Metrics

Main-text layer: `last_alignn_pool`, raw 256D embeddings.

Family separation on fixed test set (`1484` oxides + `242` nitrides):

- Overall silhouette: `0.2392` (95% CI `0.2332` to `0.2456`).
- Oxide silhouette: `0.2546`; nitride silhouette: `0.1453`.
- Davies-Bouldin index: `1.8290`.
- 15-NN family purity: `0.9655` overall, `0.9872` oxide, `0.8331` nitride.
- Logistic-regression family AUC: `0.9994`.

Nitride distance-error association, mean 5NN oxide distance:

- Nitride test size: `242`; oxide reference pool size: `13507`.
- Hard/easy groups: `49` hardest and `49` easiest nitrides by absolute zero-shot error.
- Hard mean distance: `4.5988`; easy mean distance: `3.7821`.
- Hard-minus-easy mean gap: `0.8168` (95% CI `0.4746` to `1.1597`; FDR q `0.0001800`).
- Spearman rho: `0.3428` (95% CI `0.2214` to `0.4597`; FDR q `0.0001286`).
- Pearson r: `0.2770` (95% CI `0.1741` to `0.3890`; FDR q `0.0001286`).

## Strongest Evidence For The Domain-Shift Interpretation

1. Zero-shot gap: the same pretrained checkpoint has `2.03x` higher MAE on nitrides than oxides before target-family training.
2. Fine-tuning response: oxide begins multi-epoch optimization at `N=50`, while nitride remains epoch-1/inert through `N=200`.
3. High-N persistence: nitride adaptation begins at `N=500` and `N=1000`, but even the best genuinely adapted nitride row (`0.0907 eV/atom` at `N=1000`) remains above nitride zero-shot (`0.0695 eV/atom`).
4. Scratch comparison: pretraining helps both families relative to scratch, so the nitride result is not "pretraining fails"; it is "pretraining helps, but the domain-shift penalty persists."
5. Embedding geometry: raw `last_alignn_pool` embeddings separate families strongly, nitrides are less cohesive than oxides, and harder nitrides lie farther from the oxide-reference region.

## Strongest Caveats Against Overclaiming

- Do not call the checkpoint "oxide-pretrained"; it is the pretrained formation-energy ALIGNN checkpoint.
- Do not claim oxide fine-tuning beats oxide zero-shot; it does not under Set 1.
- Do not claim nitride fine-tuning beats nitride zero-shot; it does not under Set 1.
- Do not describe nitride `N<=200` as adaptation; all four rows have `mean_best_epoch = 1.0`.
- Do not treat nitride `N=50` transfer benefit as adaptation benefit; it is pretrained-initialization advantage over scratch.
- Do not imply scratch baselines exist outside `N=50` and `N=500`.
- Do not claim embedding distance causes prediction error. It is a correlational geometric indicator.
- Do not treat 2D PCA/t-SNE/UMAP visual distances as raw-space statistics.
- Do not overread taller nitride transfer-benefit bars as "better transfer"; nitride final errors and scratch anchors are both worse.

## Recommended Figures For Results III

Minimum Results III set:

| Subsection | Figure(s) | Why |
|---|---|---|
| Zero-shot family gap | `FIG_ZS_COMPARISON` | Direct same-checkpoint oxide vs nitride starting point. |
| Differential fine-tuning response | `FIG_S1_LC_OXIDE` + `FIG_S1_LC_NITRIDE` | Side-by-side adaptation timing and low-N inertness contrast. |
| Transfer-benefit contrast | `FIG_TRANSFER_BENEFIT` | Direct cross-family scratch-minus-fine-tune comparison at `N=50` and `N=500` only. |

Optional Results III additions:

| Figure(s) | Use |
|---|---|
| `FIG_S1_PARITY_OXIDE_N1000` + `FIG_S1_PARITY_NITRIDE_N1000` | Endpoint parity comparison where both families have genuine multi-epoch optimization. |
| `FIG_S1_COMP_OXIDE` + `FIG_S1_COMP_NITRIDE` | Use only if `FIG_TRANSFER_BENEFIT` needs source-panel companions. |
| Low-N parity pair (`FIG_S1_PARITY_OXIDE_N10`, `FIG_S1_PARITY_NITRIDE_N10`) | Appendix or short visual bridge; both are epoch-1 checkpoint views. |

## Recommended Figures For Results IV

Primary Results IV set belongs in `embedding_interpretation_packet.md`. If this joint packet is used alone, use:

| Subsection | Figure(s) | Why |
|---|---|---|
| Family separation in raw pretrained space | `FIG_EA_6A_PCA` plus either `FIG_EA_6B_TSNE` or `FIG_EA_6C_UMAP` | Opens the embedding section with family-level structure while keeping raw metrics as the statistical anchor. |
| Nitride error vs oxide-reference distance | `FIG_EA_6D_BOXPLOT` and, if space allows, `FIG_EA_6D_SCATTER` | Boxplot gives hard/easy effect size; scatter gives full-sample continuity. |

Best compact Results IV package: `FIG_EA_6A_PCA`, `FIG_EA_6D_BOXPLOT`, and `FIG_EA_6D_SCATTER`.
