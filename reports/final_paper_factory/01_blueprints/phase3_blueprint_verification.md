# Phase 3 Blueprint Verification

Date: 2026-04-21
Scope: Verification of the patched Phase 3 blueprint pack for scientific structure and drafting safety.

## Passed checks

- Check 1: All three Introduction rows are free of `TAB_ZS_SUMMARY`, `CN_ZS_OXIDE_MAE`, and `CN_ZS_NITRIDE_MAE`. Each Introduction row now has `Table(s) = none`, and no performance MAE values appear in the Introduction evidence columns.
- Check 2: Inaccurate operative phrasing implying an oxide-specialized checkpoint has been removed from the blueprint claims. The active wording is now scientifically safer:
  - `pretrained formation-energy ALIGNN model`
  - `pretrained formation-energy representation`
  - `oxide-reference region` only in embedding-distance contexts
- Check 3: [combined_paper_blueprint_v3.md](/abs/c:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/01_blueprints/combined_paper_blueprint_v3.md) contains an explicit `Results III — compare-not-replay rule` section, and all three Results III rows begin with `Results III rule: compare only.`
- Check 4: Transfer-benefit logic is explicitly constrained to `N=50` and `N=500`:
  - Combined row 12 hard-codes `N=50 and N=500 only`
  - Oxide row 6 includes the same scope note
  - Nitride row 6 includes the same scope note
  - The shared-vs-unique map now carries the same constraint
- Check 5: The oxide standalone blueprint now contains a minimal embedding bridge rather than a full embedding block. Row 7 is short, descriptive, forward-references combined-paper Results IV, and explicitly says not to build a standalone embedding argument there.
- Check 6: [shared_vs_unique_content_map_v3.md](/abs/c:/Users/lenovo/res201-alignn-domain-shift/reports/final_paper_factory/01_blueprints/shared_vs_unique_content_map_v3.md) now reflects the oxide embedding bridge correctly. It no longer says to usually omit oxide embedding content.
- Check 7: A `writing_layer` field was added consistently across all three blueprint tables. The controlled vocabulary is consistent and useful for drafting discipline:
  - `literature_context`
  - `implementation_detail`
  - `experimental_finding`
  - `comparison`
  - `interpretation`
- Check 8: Methods planning now points toward manuscript-facing table concepts rather than raw internal context names. All three Methods rows use:
  - `TAB_METHODS_DATASET_SPLITS`
  - `TAB_METHODS_EXPERIMENT_SCOPE`
  with evidence notes pointing back to the internal files.
- Check 9: Wildcard-heavy canonical-number usage was improved substantially in the drafting-critical blueprint rows. The fine-tuning and transfer-benefit rows now enumerate the relevant `N` values explicitly instead of using `N*` shorthand.
- Check 10: Oxide subsection phrasing is sharper while preserving the control-arm identity. The updated headings are thesis-bearing, but the report still reads as the in-distribution control paper rather than as a second nitride-style failure narrative.

## Failed checks

- None.

## Ambiguous checks

- Introduction rows still reference `CN_ZS_OXIDE_N_TEST` and/or `CN_ZS_NITRIDE_N_TEST` as dataset-characterization counts. I do not count these as study-result evidence because they are explicitly marked as dataset sizes only, not performance results. Still, if you want a maximally strict prose-drafting policy later, you could move even these counts fully into Methods.
- The banned phrase search still matches the `*_v3` files, but only inside revision notes and guardrail text that says not to use the phrase. I found no remaining operative scientific claim that describes the checkpoint as `oxide-pretrained`.
- A small amount of wildcard shorthand remains in the shared-vs-unique map for high-level embedding bundles such as `CN_EA_KNN5_LAST_ALIGNN_POOL_*` and appendix-support groups. I do not consider this a drafting blocker because the subsection-level blueprint rows are explicit, but the shared map is not fully wildcard-free.

## Remaining issues before drafting

- The pack is structurally safe for drafting.
- The only non-blocking caution is workflow-related: later drafting agents should use the subsection blueprint rows as the primary drafting source, not the revision notes or the shared-map shorthand rows.
- Composite figures marked `if created` remain conditional, but this was already acknowledged in the patch changelog and does not create a scientific-structure problem.

## Final verdict

- ready for drafting
