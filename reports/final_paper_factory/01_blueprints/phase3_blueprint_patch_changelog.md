# Phase 3 Blueprint Patch Changelog

**Date applied:** 2026-04-21
**Applied by:** Claude Code (blueprint audit/patch pass)
**Purpose:** Correct structural and scientific problems in the Phase 3 blueprints before any prose drafting begins. No canonical evidence choices changed except where required by the issues below.

---

## Files created

| file | replaces |
|---|---|
| `oxide_report_blueprint_v3.md` | `oxide_report_blueprint.md` (v2 preserved, not overwritten) |
| `nitride_report_blueprint_v3.md` | `nitride_report_blueprint.md` (v2 preserved, not overwritten) |
| `combined_paper_blueprint_v3.md` | `combined_paper_blueprint.md` (v2 preserved, not overwritten) |
| `shared_vs_unique_content_map_v3.md` | `shared_vs_unique_content_map.md` (v2 preserved, not overwritten) |
| `phase3_blueprint_patch_changelog.md` | new file |

---

## FIX A — CRITICAL: Introductions made result-free

**What changed:**

All three Introduction rows were carrying result tables and MAE values. Specifically removed from Introduction rows:
- `TAB_ZS_SUMMARY` — removed from Introduction in all three blueprints
- `CN_ZS_OXIDE_MAE` — removed from Introduction in oxide and combined blueprints
- `CN_ZS_NITRIDE_MAE` — removed from Introduction in nitride and combined blueprints

Dataset size counts (`CN_ZS_OXIDE_N_TEST`, `CN_ZS_NITRIDE_N_TEST`) were retained in Introduction where used, as these characterize the dataset scope rather than performance results.

Main claims for all three Introduction rows were rewritten as objective-driven framing:
- Oxide: "This report examines how a pretrained formation-energy ALIGNN model adapts to an in-distribution oxide regime, establishing a control baseline for understanding pretraining value and data efficiency in materials property prediction."
- Nitride: "This report examines how a pretrained formation-energy ALIGNN model behaves when evaluated on nitrides — a family that lies outside the chemistry of the pretraining distribution — and asks whether fine-tuning can overcome the resulting domain-shift penalty."
- Combined: "The paper asks how a pretrained formation-energy ALIGNN model behaves on an in-distribution oxide control task versus an out-of-distribution nitride test task, and whether embedding-space distances can explain the difference in adaptation difficulty."

Purpose fields updated to specify: "No result tables. No MAE values."

The report-level guardrails in all three blueprints now include: "The Introduction must contain only background, motivation, and objective framing. Do not place result tables or MAE values in the Introduction."

**Why needed:** Placing your own result numbers in the Introduction inverts the paper structure. The Introduction must motivate the question, not answer it. Readers will encounter zero-shot MAEs in the Results sections where they are properly framed.

**Severity resolved:** CRITICAL

---

## FIX B — CRITICAL: "Oxide-pretrained" wording removed

**What changed:**

Two instances of scientifically inaccurate phrasing were found and replaced:

1. Combined blueprint row 1 (Introduction) main claim: "The paper asks how an **oxide-pretrained model** behaves..." → "The paper asks how a **pretrained formation-energy ALIGNN model** behaves..."

2. Nitride blueprint row 9 (Discussion) main claim: "The nitride difficulty is best explained as domain shift acting on an **oxide-pretrained representation**..." → "The nitride difficulty is best explained as domain shift acting on a **pretrained formation-energy representation**..."

The phrase "oxide-reference region" is preserved wherever it appears in embedding-distance contexts (e.g., combined blueprint rows 13–14, nitride blueprint rows 7–8), as this is a correct description of the kNN5 distance metric's reference set and is not a claim about what the model was trained on.

The report-level guardrails in all three blueprints now include: "Do not describe the pretrained checkpoint as 'oxide-pretrained'. Use 'pretrained formation-energy ALIGNN model' or 'pretrained ALIGNN model'. 'Oxide-reference region' is acceptable only in embedding-distance contexts."

The shared map reuse rules section also carries this guardrail.

**Why needed:** The pretrained ALIGNN checkpoint was trained on a broad formation-energy dataset, not specifically on oxides. Calling it "oxide-pretrained" falsely implies it was specialized or fine-tuned for oxide chemistry. The correct framing is that oxide structures happen to be well-represented in the pretraining distribution, making them the in-distribution control — not that the model was pretrained exclusively or intentionally on oxides.

**Severity resolved:** CRITICAL

---

## FIX C — IMPORTANT: Results III compare-not-replay rule added

**What changed:**

A new section was added to the combined blueprint immediately before the subsection plan: **"Results III — compare-not-replay rule"**. This section specifies:

1. Results III must synthesize and directly contrast evidence from Results I and II — not re-explain it.
2. The preferred structure for each Results III subsection: opening synthesis sentence → one comparison paragraph → one direct comparison figure/table anchor → one closing interpretation sentence.
3. Long restatement of either family's standalone story is not permitted inside Results III.
4. Results III is a cross-examination layer, not a replay layer.

Each of the three Results III subsection Purpose fields (rows 10, 11, 12) was updated to begin with: **"Results III rule: compare only."**

Row 10 (Zero-shot family gap): "Synthesize the oxide and nitride ZS benchmarks into a direct family-gap statement. Do not re-describe either family's ZS evidence at full length."

Row 11 (Differential fine-tuning response): "Synthesize already-presented FT trajectories into a direct contrast of adaptation smoothness and inertness. Do not re-explain either family's FT story at standalone length."

Row 12 (Transfer-benefit contrast): "Synthesize the transfer-benefit gap for both families into a direct cross-family comparison." (Also includes FIX D scope constraint — see below.)

**Why needed:** Without an explicit rule, Claude/Codex drafting agents will tend to repeat Results I and Results II content in Results III, making the section feel like a second pass over the same material instead of a genuine synthesis. The combined paper's value comes from the cross-family comparison layer; that value disappears if Results III becomes a replay.

**Severity resolved:** IMPORTANT

---

## FIX D — IMPORTANT: Transfer-benefit figure scoped to N=50 and N=500

**What changed:**

Combined blueprint row 12 (Transfer-benefit contrast across families) updated:
- Subsection heading changed to: "Transfer-benefit contrast across families (N=50 and N=500 only)"
- Purpose field now contains explicit scope constraint: "FIG_TRANSFER_BENEFIT and all transfer-benefit claims in this subsection must be limited to N=50 and N=500 because from-scratch baselines do not exist at other N values."
- Nitride N=50 caveat explicitly required in this subsection.

Shared content map updated:
- "From-scratch baselines" row guardrail strengthened: now reads "Do not imply from-scratch comparisons exist outside N=50 and N=500 in any report stream."
- "Direct comparison block" row updated: FIG_TRANSFER_BENEFIT explicitly marked "(N=50 and N=500 only)" in both the shared evidence core and the combined paper use column.
- "Direct comparison block" guardrail now reads: "FIG_TRANSFER_BENEFIT must be scoped to N=50 and N=500 in all three streams."

The oxide blueprint row 6 already contained the scope note ("Scope note: comparison limited to N=50 and N=500") and was preserved.
The nitride blueprint row 6 already contained the scope note and was preserved.

**Why needed:** From-scratch baselines were only run at N=50 and N=500 under Set 1 (confirmed by row count in fromscratch_summary.csv). If the transfer-benefit figure implies wider coverage, it will be factually wrong. The Phase 2 canonical numbers already document this limitation; it must now be enforced at blueprint level.

**Severity resolved:** IMPORTANT

---

## FIX E — IMPORTANT: Oxide embedding bridge added

**What changed:**

Oxide blueprint: New row 7 added — "Oxide embedding context: family separation confirmed".

This is a brief Results subsection (1–2 paragraphs maximum) with the following specification:
- Purpose: Acknowledge that oxide embeddings were extracted and analyzed as part of the project brief (Week 4). State that the pretrained representation separates oxide and nitride families in raw space. Forward-reference the combined paper's Results IV for the full embedding analysis. Explicitly marked: "Do NOT build a standalone embedding argument here."
- Figure(s): appendix reference only (optional thumbnail)
- Table(s): none in main text
- Canonical Numbers: none in main text (appendix_support embedding rows available for appendix reference if needed)
- Main claim: "Oxide embedding analysis confirms family separation in pretrained space; the detailed distance-error mechanism is examined in the combined paper."
- Mode: descriptive
- writing_layer: experimental_finding

The original Discussion (row 7) and Conclusion (row 8) in v2 are now renumbered to rows 8 and 9 respectively.

Shared content map updated:
- "Embedding family separation" row, Oxide Standalone Use column: changed from "Usually omit or mention only as forward link" to "Brief Results bridge (row 7 of oxide blueprint): 1–2 paragraphs acknowledging that analysis was conducted, confirming family separation, and forward-referencing combined paper Results IV. Do not build a standalone embedding argument."
- "Embedding distance-error link" row, Oxide Standalone Use column: changed from "Omit." to "Omit from oxide standalone main text. Oxide embedding bridge (row 7) may reference that distance analysis was performed, but forward-reference the combined paper for the mechanism test."

**Why needed:** The project brief's Week 4 oxide deliverable explicitly includes oxide embeddings extracted and visualized. A standalone oxide report that makes no mention of the embedding analysis would be incomplete relative to the project requirements. The bridge keeps the report compliant while avoiding duplication of the combined paper's full embedding block.

**Severity resolved:** IMPORTANT

---

## FIX F — IMPORTANT: writing_layer column added to all blueprints

**What changed:**

A new `writing_layer` column was added as the final column in all three blueprint subsection tables.

Controlled vocabulary used:
- `literature_context` — background, motivation, framing (Introduction rows)
- `implementation_detail` — setup, protocol, run counts, namespace decisions (Methods rows)
- `experimental_finding` — what the data shows, error values, epoch counts, learning curves, parity (most Results rows)
- `comparison` — direct cross-family or cross-condition comparisons, transfer-benefit rows
- `interpretation` — Discussion and Conclusion rows, embedding mechanism rows

Values assigned:

**Oxide blueprint:**
| Row | writing_layer |
|-----|--------------|
| 1 Introduction | literature_context |
| 2 Methods | implementation_detail |
| 3 Results ZS | experimental_finding |
| 4 Results FT | experimental_finding |
| 5 Results Parity | experimental_finding |
| 6 Results FS contrast | comparison |
| 7 Results Embedding bridge | experimental_finding |
| 8 Discussion | interpretation |
| 9 Conclusion | interpretation |

**Nitride blueprint:**
| Row | writing_layer |
|-----|--------------|
| 1 Introduction | literature_context |
| 2 Methods | implementation_detail |
| 3 Results ZS | experimental_finding |
| 4 Results FT inertness | experimental_finding |
| 5 Results Adaptation onset | experimental_finding |
| 6 Results FS caveat | comparison |
| 7 Results Embedding sep | experimental_finding |
| 8 Results Embedding distance | interpretation |
| 9 Discussion | interpretation |
| 10 Conclusion | interpretation |

**Combined blueprint:**
| Row | writing_layer |
|-----|--------------|
| 1 Introduction | literature_context |
| 2 Methods | implementation_detail |
| 3–5 Results I | experimental_finding / experimental_finding / comparison |
| 6–9 Results II | experimental_finding / experimental_finding / experimental_finding / comparison |
| 10–12 Results III | comparison / comparison / comparison |
| 13–14 Results IV | experimental_finding / interpretation |
| 15 Discussion | interpretation |
| 16 Conclusion | interpretation |

**Why needed:** Without explicit writing-layer markers, drafting agents mix literature context (what the field knows), implementation details (what we set up), and experimental findings (what we observed) within the same paragraph. The three layers must remain separable for scientific clarity and for later review using Prompt T3.

**Severity resolved:** IMPORTANT

---

## FIX G — IMPORTANT: Manuscript-facing Methods table labels

**What changed:**

Internal context table labels replaced with cleaner manuscript-facing names in all three blueprints:

- `TAB_CTX_OXIDE_SUMMARY_JSON` → `TAB_METHODS_DATASET_SPLITS` (with evidence note: family_summary.json)
- `TAB_CTX_NITRIDE_SUMMARY_JSON` → `TAB_METHODS_DATASET_SPLITS` (with evidence note: family_summary.json)
- `TAB_S1_FT_RUNS` (where used in Methods) → absorbed into `TAB_METHODS_EXPERIMENT_SCOPE`
- `TAB_S1_FS_RUNS` (where used in Methods) → absorbed into `TAB_METHODS_EXPERIMENT_SCOPE`

Both `TAB_METHODS_DATASET_SPLITS` and `TAB_METHODS_EXPERIMENT_SCOPE` carry parenthetical evidence notes so the internal file references are not lost.

Downstream table references in Results and Discussion rows (e.g., `TAB_S1_FT_RUNS` in Results) were not changed, as those are internal evidence anchors used for lookup and were never intended as visible paper table names.

**Why needed:** If a drafting agent inherits `TAB_CTX_OXIDE_SUMMARY_JSON` as a paper table label, the final manuscript will either carry an awkward internal name or require a confusing find-and-replace pass. Clean manuscript-facing labels from the blueprint layer prevent this downstream cleanup.

**Severity resolved:** IMPORTANT

---

## FIX H — POLISH: Wildcard canonical number references replaced

**What changed:**

Wildcard references of the form `CN_FT_S1_FAMILY_N*_METRIC` were replaced throughout all three blueprints with fully explicit N-enumerated lists. Key replacements:

**Oxide blueprint row 4 (FT trajectory):**
`CN_FT_S1_OXIDE_N*_TRANSFER_GAIN_VS_ZERO_SHOT` →
`CN_FT_S1_OXIDE_N10_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N50_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N100_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N200_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N500_TRANSFER_GAIN_VS_ZERO_SHOT`, `CN_FT_S1_OXIDE_N1000_TRANSFER_GAIN_VS_ZERO_SHOT`

**Nitride blueprint row 4 (FT inertness) and combined blueprint row 7:**
`CN_FT_S1_NITRIDE_N*_TRANSFER_GAIN_VS_ZERO_SHOT` split into inert-regime group (N=10,50,100,200) with `(effective_zero_shot)` annotation, and adaptation-regime rows (N=500, 1000) in row 5.

**Combined blueprint row 4 (Results I FT trajectory):**
`CN_FT_S1_OXIDE_N*_TRANSFER_GAIN_VS_ZERO_SHOT` → fully enumerated (N=10,50,100,200,500,1000).

**Why needed:** Multi-agent drafting systems treat wildcards literally and may select incorrect or incomplete subsets. Explicit enumeration forces the correct scope and makes the effective_zero_shot caveat distinction visible at the reference level.

**Severity resolved:** POLISH

---

## FIX I — POLISH: Oxide subsection headings sharpened

**What changed:**

Oxide blueprint subsection headings updated to be thesis-bearing rather than generic:

| v2 heading | v3 heading |
|---|---|
| Zero-shot control baseline | Zero-shot performance establishes a strong control benchmark |
| Fine-tuning trajectory across N | Fine-tuning adapts smoothly once data exceeds the low-N checkpoint threshold |
| Parity snapshots at low and high N | Error structure shifts with data scale: low-N ceiling versus high-N improvement |
| From-scratch contrast and pretraining value | Pretraining dominates from-scratch training at both available data sizes |
| What the oxide control establishes | Oxide as the stable control: what the in-distribution result confirms |

The logic and evidence assignments of each row are unchanged.

**Why needed:** Thesis-bearing headings tell the drafter what the subsection should conclude, not just what it should describe. This reduces the risk of subsections that list evidence without stating a claim.

**Severity resolved:** POLISH

---

## Summary of upgraded blueprint logic

The v3 blueprint pack represents a structurally complete and scientifically safe foundation for full prose drafting. Six key upgrades:

1. **Introductions are now result-free.** All three Introduction rows have been stripped of result tables (`TAB_ZS_SUMMARY`) and MAE values (`CN_ZS_OXIDE_MAE`, `CN_ZS_NITRIDE_MAE`). Introductions now carry only background, motivation, and objective framing.

2. **"Oxide-pretrained" wording has been removed.** The phrase "oxide-pretrained model" (combined blueprint introduction) and "oxide-pretrained representation" (nitride discussion) have been replaced with "pretrained formation-energy ALIGNN model" and "pretrained formation-energy representation". The term "oxide-reference region" is retained only in embedding-distance contexts where it is geometrically correct.

3. **Results III is now explicitly compare-not-replay.** A section-level rule was added to the combined blueprint specifying that Results III must synthesize and contrast, not re-explain. Each of the three Results III subsection Purpose fields carries the enforcement note "Results III rule: compare only."

4. **Transfer-benefit is explicitly limited to N=50 and N=500.** The combined blueprint row 12 heading and purpose both specify the scope constraint. The shared map's direct comparison and from-scratch blocks also carry the constraint. This closes the risk of FIG_TRANSFER_BENEFIT being drawn with false coverage.

5. **Oxide now has a minimal embedding bridge.** A new row 7 was added to the oxide blueprint: a 1–2 paragraph Results subsection acknowledging oxide embedding analysis, confirming family separation, and forward-referencing the combined paper's Results IV. This satisfies the project brief's Week 4 oxide deliverable requirement without duplicating the full embedding block.

6. **Writing-layer classification was added.** All three blueprint tables now carry a `writing_layer` column with a controlled vocabulary (`literature_context`, `implementation_detail`, `experimental_finding`, `comparison`, `interpretation`). This enforces the three-layer separation (literature context / implementation details / findings) that the REPORT_PLAN.txt requires.

---

## Unresolved ambiguities before drafting

None of the above fixes leave open issues that would block Phase 4 (figure memos) or full prose drafting. The following items are noted for completeness but are not blockers:

- `FIG_ZS_COMPARISON` and `FIG_TRANSFER_BENEFIT` are marked "(if created)" in several rows, reflecting that these composite figures have not yet been confirmed to exist. If they are absent, the blueprint rows will fall back to the component figures (`FIG_S1_COMP_OXIDE`, `FIG_S1_COMP_NITRIDE`).
- `FIG_SCHEMATIC` is marked "(optional)" throughout. Its absence does not affect the evidence base.
- The `TAB_METHODS_DATASET_SPLITS` and `TAB_METHODS_EXPERIMENT_SCOPE` labels are manuscript-facing concepts that will need to be built as actual tables during drafting; the evidence sources are documented in the parenthetical notes.

---

## Blueprint pack readiness verdict

**The v3 blueprint pack is safe for full prose drafting.**

All critical structural problems (result-heavy introductions, inaccurate pretraining label) are resolved. All important issues (Results III replay risk, transfer-benefit scope, oxide embedding gap, writing-layer discipline, methods table naming) are addressed. Polish fixes (wildcard reduction, heading sharpening) have been applied. No open ambiguity remains that would create overclaiming risk during drafting.
