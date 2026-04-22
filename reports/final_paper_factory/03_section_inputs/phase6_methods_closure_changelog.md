# Phase 6 Methods Closure Changelog

**Date:** 2026-04-22  
**Closure pass purpose:** Convert the Phase 6 methods scaffold into a prose-drafting-ready evidence pack by closing manuscript-blocking TODOs, materializing methods tables, splitting embedding detail into main-text vs. appendix layers, and updating the handoff.

---

## Files Created

| File | Type | Summary |
|---|---|---|
| `shared_methods_skeleton_v2.md` | Revised methods file | Resolved all manuscript-blocking TODOs; frozen decisions table added; guardrails strengthened |
| `oxide_methods_notes_v2.md` | Revised methods file | Oxide TODOs resolved; embedding compressed to bridge note; frozen decisions table added |
| `nitride_methods_notes_v2.md` | Revised methods file | Nitride TODOs resolved; full embedding protocol retained; frozen decisions table added |
| `combined_methods_notes_v2.md` | Revised methods file | Combined TODOs resolved; most complete embedding protocol; frozen decisions table added |
| `TAB_METHODS_DATASET_SPLITS_v1.md` | New manuscript-facing artifact | Dataset split table materialized from oxide and nitride summary JSONs |
| `TAB_METHODS_DATASET_SPLITS_v1.csv` | New manuscript-facing artifact | CSV version of dataset split table |
| `TAB_METHODS_EXPERIMENT_SCOPE_v1.md` | New manuscript-facing artifact | Experiment scope table materialized from finetune_runs.csv, fromscratch_runs.csv, canonical_numbers_v2.md |
| `TAB_METHODS_EXPERIMENT_SCOPE_v1.csv` | New manuscript-facing artifact | CSV version of experiment scope table |
| `embedding_methods_appendix_notes_v1.md` | New appendix-facing support file | Granular embedding details relocated from main-text methods |
| `STAGE6_METHODS_HANDOFF_v2.md` | Updated handoff | Points to all v2 methods files and new table artifacts; declares pack prose-drafting ready |
| `phase6_methods_closure_changelog.md` | Changelog | This file |

---

## Fix A — Manuscript-Blocking TODOs Closed

**Priority: CRITICAL**

### TODOs resolved

**Repeated-run convention (shared skeleton §8 + all report notes):**
- Was: `TODO: confirm whether final tables will report mean +/- SD, mean +/- SEM, or mean-only with per-seed appendix values.`
- Decision frozen: **mean ± SD across five random seeds** for all multi-seed conditions in all three report streams. Zero-shot values are single evaluations (no SD reported).
- Applied to: `shared_methods_skeleton_v2.md`, `oxide_methods_notes_v2.md`, `nitride_methods_notes_v2.md`, `combined_methods_notes_v2.md`.
- Why: Unresolved reporting convention was a hard blocker for any numeric table in prose.

**Seed wording (shared skeleton §8 + all report notes):**
- Was: `TODO: decide whether the Methods section should state the seed set explicitly as {0, 1, 2, 3, 4} or just "five random seeds".`
- Decision frozen: **main-text prose says "five random seeds"**; explicit seed IDs {0, 1, 2, 3, 4} may appear in implementation notes or appendix-facing notes only.
- Why: Both wordings were used inconsistently across the draft; prose requires a single canonical form.

**Model-spec presentation (shared skeleton §6 + all report notes):**
- Was: `TODO: decide whether the final Methods section should state the full shared ALIGNN architecture here or move the architecture table to a compact model-spec table.`
- Decision frozen: **compact paragraph in main Methods; no standalone architecture subsection**. The pretrained model is described in one sentence: four ALIGNN layers, four gated GCN layers, hidden size 256, scalar output.
- Why: A standalone architecture subsection would bloat Methods without adding information not already in the ALIGNN citation.

**JARVIS / ALIGNN citation placeholders (shared skeleton §1 + §4):**
- Was: `TODO: confirm the exact manuscript citation(s) to use for JARVIS dataset provenance...`
- Decision frozen: `[CITE: JARVIS 2020 dataset/repository paper]` for data provenance and split provenance; `[CITE: ALIGNN foundational paper]` for model architecture and fine-tuning context. Consistent with Stage 5 citation hierarchy.
- Why: Placeholder inconsistency (some used "JARVIS dataset/repository paper", others bare "[CITE: JARVIS]") needed standardization before prose polishing.

**Split provenance wording:**
- Was: `TODO: if the paper explicitly credits an official JARVIS benchmark split, add the appropriate citation placeholder near the split sentence.`
- Decision frozen: "original JARVIS benchmark split identities were preserved before family filtering" — factual, repo-grounded, with the JARVIS 2020 citation attached. Do not overclaim benchmark formalism beyond what the repo supports (the manifest is `provided:manifests/...`).
- Why: Needed to prevent the prose from either underclaiming (no split provenance) or overclaiming (formal benchmark status not supported by repo).

**L1Loss / criterion discrepancy:**
- Was: `TODO: in final prose, be explicit that the custom training script optimizes and selects checkpoints with L1Loss, even though inherited config JSONs still contain criterion: "mse".`
- Decision frozen: Implementation details in §5 (fine-tuning) now explicitly state this; the note appears in all three report streams.
- Why: A reviewer reading config files would see `criterion: "mse"` and question the methods claim. The discrepancy needs to be pre-empted.

**Oxynitride term:**
- Was: `TODO: decide whether the final prose should explicitly define "oxynitride" in Methods or leave that term to a brief parenthetical.`
- Decision frozen: **brief parenthetical on first mention** (e.g., "oxynitrides — structures containing both O and N"). No separate definition subsection needed.
- Why: A full subsection would disproportionately emphasize a minor definitional point; a parenthetical is standard for such terms.

**Zero-shot model-name:**
- Was: `TODO: decide whether the manuscript should name the model through its model_name string, through the local checkpoint namespace jv_formation_energy_peratom_alignn, or both.`
- Decision frozen: **prose uses "pretrained formation-energy ALIGNN model"**; implementation notes may name `jv_formation_energy_peratom_alignn`. Both are visible in the same subsection.
- Why: The internal checkpoint name is not publication-suitable for prose; preserving it in implementation notes keeps reproducibility.

**TODOs intentionally NOT resolved (cosmetic / safe for polishing):**
- Citation confirmation for domain-shift literature in nitride framing (no confirmed citation exists yet; placeholder preserved).
- Citation for frozen-representation analysis beyond ALIGNN provenance (no confirmed citation; placeholder preserved).
- Hardware / runtime environment documentation (was noted as out of scope for Phase 6 source-of-truth pack; remains unresolved).

---

## Fix B — Methods Tables Materialized

**Priority: CRITICAL**

### TAB_METHODS_DATASET_SPLITS_v1

- Was: referenced in the handoff as "not a standalone frozen CSV yet"; the skeleton only contained an inline scaffold table.
- What changed: Created `TAB_METHODS_DATASET_SPLITS_v1.md` and `TAB_METHODS_DATASET_SPLITS_v1.csv` as standalone manuscript-facing artifacts.
- Source: verified directly from `data_shared/oxide/summaries/summary.json` and `data_shared/nitride/summaries/summary.json`.
- Contents: family totals, train/val/test/pool counts, oxynitride counts and treatment, split provenance.
- Run-local subset size table included (derived from protocol; not from run CSVs).
- Why: Tables that are only referenced but do not exist as files block the prose writer, who cannot insert a LaTeX table without a concrete source.

### TAB_METHODS_EXPERIMENT_SCOPE_v1

- Was: referenced in the handoff as "not a standalone frozen CSV yet".
- What changed: Created `TAB_METHODS_EXPERIMENT_SCOPE_v1.md` and `TAB_METHODS_EXPERIMENT_SCOPE_v1.csv` as standalone manuscript-facing artifacts.
- Source: verified from `finetune_runs.csv` (60 rows), `fromscratch_runs.csv` (20 rows), `canonical_numbers_v2.md`.
- Contents: protocol, families, N values, seeds per condition, runs per family, total runs, and explicit note that from-scratch exists only at N = 50 and N = 500.
- Why: Same reason as above; the experiment scope table must exist as a concrete file.

---

## Fix C — Embedding-Method Detail Split

**Priority: IMPORTANT**

### What changed

- Created `embedding_methods_appendix_notes_v1.md` as a new appendix-facing support file.
- Relocated or compressed the following into that file:
  - PCA/t-SNE/UMAP parameter sensitivity details (perplexity 15 and 50; UMAP n_neighbors 15 and 50)
  - Overlay-policy details for t-SNE and UMAP hard/easy overlays (different policies; must be in figure notes)
  - Full bootstrap and permutation count operational notes (kept totals in main text; procedural detail in appendix file)
  - Layer-by-layer extraction operational notes
  - Ledoit-Wolf covariance screening procedure
  - Named subset construction details (exact construction of `balanced_pool_set`)

- In main-text methods files:
  - `shared_methods_skeleton_v2.md` §9: retained minimum defensible protocol — extraction source, `last_alignn_pool` preference, named subsets (table), family-separation metric names, distance-versus-error metric names, hard/easy definition, statistical totals, visualization method names with primary settings.
  - `oxide_methods_notes_v2.md`: compressed to a 2-sentence bridge noting extraction protocol and `last_alignn_pool`, with forward reference to combined paper and appendix file.
  - `nitride_methods_notes_v2.md`: fuller protocol retained per differentiation requirement; primary visualization settings in main text; sensitivity/overlay details forward-referenced to appendix file.
  - `combined_methods_notes_v2.md`: most complete; primary visualization settings in main text; full sensitivity details forward-referenced to appendix file.

- Why: Embedding subsections in v1 were at implementation-documentation depth, not manuscript-Methods depth. A prose writer needs to know what to include in the paper, not reproduce the full operational notes.

---

## Fix D — Methods / Results Boundary Protected

**Priority: IMPORTANT**

### What changed

- Added explicit guardrail section in `shared_methods_skeleton_v2.md` §9.
- Added explicit guardrail section in `nitride_methods_notes_v2.md` under "Methods / Results boundary guardrails".
- Added explicit guardrail section in `combined_methods_notes_v2.md` under "Methods / Results boundary guardrails".
- All three sections explicitly state:
  - Methods may define `mean_best_epoch` as a recorded protocol quantity.
  - Methods may explain checkpoint selection as procedure.
  - Methods must NOT interpret low-N nitride runs as inert, effectively zero-shot, or as exhibiting no meaningful adaptation.
  - Methods must NOT describe MAE trends or adaptation behavior.
  - Methods must stay neutral about family outcomes.

- Why: The v1 pack was careful on this boundary, but the closure pass needed to make the guardrails explicit rather than implied, to prevent drift during prose drafting.

---

## Fix E — Report Differentiation Preserved and Sharpened

**Priority: IMPORTANT**

### Oxide standalone (v2)

- Embedding machinery compressed to a 2-sentence bridge in main Methods (confirmed in `oxide_methods_notes_v2.md`).
- Nitride discussion limited to one shared-definitions sentence.
- Explicit frozen-decision entry: "embedding machinery in main text = short bridge sentence".
- Outcome: oxide is lighter on embedding machinery, as required.

### Nitride standalone (v2)

- Full frozen-embedding analysis protocol retained in `nitride_methods_notes_v2.md`.
- Hard/easy nitride definition included as a nitride-only Methods sentence.
- `oxide_reference_pool` rationale: brief definitional sentence in Methods; causal interpretation in Results.
- PCA/t-SNE/UMAP primary settings stated in main text; full sensitivity details forward-referenced to appendix file.
- Outcome: nitride is fuller on embedding machinery, as required.

### Combined paper (v2)

- Most complete embedding protocol in `combined_methods_notes_v2.md`.
- All three embedding sources named and classified.
- All four family-separation metrics listed.
- All three distance-versus-error metrics listed.
- Hard/easy nitride groups included.
- Statistical defaults stated; visualization primary settings stated; sensitivity details forward-referenced.
- Tone explicitly neutral; no family-performance preview.
- Outcome: combined is most complete and still neutral, as required.

---

## Fix F — Handoff Updated

**Priority: CRITICAL**

### What changed

- Created `STAGE6_METHODS_HANDOFF_v2.md`.
- Points to all v2 methods files (shared skeleton, oxide, nitride, combined) as the active prose-drafting pack.
- Points to both new methods tables (TAB_METHODS_DATASET_SPLITS_v1, TAB_METHODS_EXPERIMENT_SCOPE_v1).
- Points to the embedding appendix-notes file.
- States explicitly that the pack is now intended for prose drafting.
- Preserves the latest-only rule: superseded files are listed and flagged.
- Frozen decisions summary table reproduced in handoff for quick reference.
- Updated input bundles for each report stream to include new files.

---

## Decisions Frozen (summary)

| Decision | Frozen value | Fix |
|---|---|---|
| Repeated-run convention | Mean ± SD across five random seeds | A |
| Seed wording in main text | "five random seeds" | A |
| Explicit seed IDs | Implementation/appendix notes only: {0, 1, 2, 3, 4} | A |
| Model-spec presentation | Compact paragraph; no standalone subsection | A |
| JARVIS citation | `[CITE: JARVIS 2020 dataset/repository paper]` | A |
| ALIGNN citation | `[CITE: ALIGNN foundational paper]` | A |
| Split provenance | Factual, repo-grounded; JARVIS 2020 citation | A |
| Oxynitride term | Brief parenthetical; no separate subsection | A |
| Zero-shot model-name in prose | "pretrained formation-energy ALIGNN model" | A |
| L1Loss / criterion discrepancy | Stated in implementation details | A |
| Embedding main-text layer | `last_alignn_pool` | C |
| Embedding appendix layers | `pre_head`, `last_gcn_pool` in appendix file | C |
| PCA/t-SNE/UMAP parameter sensitivity | Appendix file only | C |
| Overlay-policy details | Appendix file only | C |
| Methods / Results boundary | Protected; low-N interpretation in Results only | D |
| oxide_reference_pool rationale | Definitional in Methods; causal in Results | D |
| Report differentiation | Oxide compressed; nitride fuller; combined most complete | E |
| TAB_METHODS_DATASET_SPLITS | Materialized as standalone v1 file | B |
| TAB_METHODS_EXPERIMENT_SCOPE | Materialized as standalone v1 file | B |

---

## Summary Statement

**Manuscript-blocking TODOs were closed:** All TODOs affecting manuscript truth conditions or stable section structure have been resolved. Cosmetic TODOs (domain-shift citation confirmation, hardware documentation) remain intentionally unresolved for later polishing.

**Repeated-run convention frozen to mean ± SD:** Applied consistently to all three report streams.

**Methods tables were materialized:** Both TAB_METHODS_DATASET_SPLITS and TAB_METHODS_EXPERIMENT_SCOPE now exist as standalone manuscript-facing artifacts with provenance notes.

**Embedding-method detail was split into main-text versus appendix-facing layers:** Granular PCA/t-SNE/UMAP parameter sensitivity, overlay-policy details, bootstrap/permutation operational notes, and layer-level extraction notes are now in `embedding_methods_appendix_notes_v1.md`. Main-text methods files hold only the minimum defensible protocol.

**Methods / Results boundary remained protected:** Explicit guardrail sections were added to the shared skeleton, nitride notes, and combined notes. The boundary is now stated rather than implied.

**Oxide / nitride / combined differentiation was preserved:** Oxide has a compressed 2-sentence embedding bridge; nitride retains the full embedding protocol; combined is most complete and neutral. These are explicitly stated in the frozen-decision tables of each file.

**The handoff is now updated for prose drafting:** STAGE6_METHODS_HANDOFF_v2.md points to all new artifacts and declares the pack prose-drafting ready.

---

## Unresolved Items Before Final Prose Polishing

The following items remain open but do not block prose drafting. They should be resolved before submission.

| Item | Status | Where |
|---|---|---|
| Domain-shift literature citation for nitride framing | Placeholder preserved; no confirmed citation yet | `nitride_methods_notes_v2.md`, `combined_methods_notes_v2.md` |
| Frozen-representation analysis citation | Placeholder preserved; ALIGNN citation is sufficient if no additional citation is confirmed | `combined_methods_notes_v2.md` |
| Hardware / runtime environment | Not documented; was noted as out of scope for Phase 6 source-of-truth pack | n/a |
| Results IV cross-reference format | Not decided; combined methods file says "stay purely procedural" | `combined_methods_notes_v2.md` |

---

## Phase 6 Methods Pack Status

**READY FOR PROSE DRAFTING.**

All three report streams (oxide standalone, nitride standalone, combined paper) have a closed, consistent, differentiated methods evidence pack that can be handed directly to a prose-drafting session without further scaffold work.
