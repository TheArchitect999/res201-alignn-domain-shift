# Source of Truth Memo v2

This memo records the canonical decisions governing the paper phase. It is a decision record, not an artifact inventory. For the full artifact inventory, see `master_evidence_manifest_v2.md`.

---

## Decision rationale

**Canonical main-results namespace: `Results_Hyperparameter_Set_1/`**

The project brief specifies the main experimental setting directly: `epochs = 50`, `learning_rate = 1e-4`, `batch_size = 16`. This maps to Set 1. Three repo documents confirm the mapping independently: `README.md`, `configs/README.md`, and `Results_Hyperparameter_Set_1/README.md`. The Week 4 embedding analysis uses Set 1 as the error-linked namespace, so embedding and fine-tuning evidence are internally aligned.

Set 2 (`epochs=300, lr=1e-3, batch_size=64`) and Set 3 (`epochs=100, lr=5e-5, batch_size=32`) are complete namespaces and numerically competitive. They are treated as robustness references only — not because they are weaker, but because Set 1 is the brief-specified main setting.

**Zero-shot baseline: `reports/zero_shot/` and `Results_Before_Correction/`**

Zero-shot is treated as a shared pretrained baseline outside the fine-tuning namespace hierarchy. Its authoritative files remain in `reports/zero_shot/` and `Results_Before_Correction/` while Set 1 governs fine-tuning and from-scratch reporting. This split is intentional and must not be collapsed.

**Final paper structure: specified by the project brief**

The project brief specifies three deliverables: a standalone oxide report, a standalone nitride report, and a combined paper. The combined paper structure is also brief-specified: Introduction, Methods, Results I (oxide), Results II (nitride), Results III (direct comparison), Results IV (embedding analysis), Discussion, Conclusion, References. The abstract must be a single paragraph under 250 words.

---

## Empirical caveats

- **Fine-tuning does not beat zero-shot in Set 1.** Under the canonical 50-epoch setting, oxide fine-tuning MAE at N=1000 is 0.04169 eV/atom versus zero-shot 0.03418; nitride fine-tuning at its best is 0.08742 versus zero-shot 0.06955. Neither family reaches zero-shot performance at any N. This is the main reported finding for Set 1 and must be framed as a finding, not avoided.
- **Nitride at N=10 — mean_best_epoch = 1.0.** The lowest nitride fine-tune MAE is at N=10, but early stopping selected epoch 1 on average across all 5 runs. The checkpoint is effectively the pretrained zero-shot state with no meaningful weight updates. Do not frame this as evidence for small-N adaptation.
- **`pre_head` and `last_gcn_pool` are numerically identical** in the current embedding outputs. Do not write any claim that distinguishes these two layers.
- **Set 3 provenance limitation.** `dataset_root/` folders were not duplicated in the Set 3 results tree, making per-structure error linking harder. Set 3 is complete as a summary namespace but is unsuitable for per-structure analysis.

---

## Writing guardrails

- Do not overwrite, regenerate, or clean up any result artifact named in this memo or in the companion inventories.
- Do not invent numbers. All quantitative claims must come from logged experiment outputs.
- Keep zero-shot evidence anchored to `reports/zero_shot/` and `Results_Before_Correction/`. Do not substitute fine-tuning summary statistics as zero-shot proxies.
- Anchor all quantitative embedding claims to the structured tables in `reports/week4_embedding_analysis/tables/`. Use projection plots as descriptive support only.
- Do not claim that representation-space distance proves causality for the domain-shift penalty.
- Keep the oxide and nitride standalone reports distinct in title, abstract, figure ordering, main result emphasis, and discussion framing.
- The JURI template is the formatting shell, not the drafting environment. Move content into it only in Phase 12.
