# Oxide Fix List

Target file: `04_drafts/phase12_full_manuscripts/oxide_polished_v2.md`

Overall status:
- Scientifically the cleanest of the three.
- No incorrect measured values found.
- No robustness-result leakage found.

## Important

1. Remove remaining draft-stage placeholders before any submission-facing export.
   - `oxide_polished_v2.md:5`
   - `oxide_polished_v2.md:7`
   - `oxide_polished_v2.md:9`
   - `oxide_polished_v2.md:214`
   - `oxide_polished_v2.md:218`
   - Includes the assembly note, front-matter placeholders, and end-matter placeholders.

2. Harmonize embedding figure namespace with the repo's final assembly namespace.
   - `oxide_polished_v2.md:135-137`
   - Manuscript text uses `FIG_EA_6A_PCA`, `FIG_EA_6B_TSNE`, `FIG_EA_6C_UMAP`
   - `figure_queue.csv` supports those labels, but `figure_inventory_v2.csv` still uses `FIG_EA_6A`, `FIG_EA_6B`, `FIG_EA_6C`

## Minor

1. Appendix reference is still generic rather than anchored.
   - `oxide_polished_v2.md:110`
   - Current wording says intermediate parity panels are "provided in the Appendix" without naming the appendix figure IDs.

2. A few phrases are slightly stronger than they need to be for final scientific prose.
   - `oxide_polished_v2.md:119` - `very large margin`
   - `oxide_polished_v2.md:176`
   - `oxide_polished_v2.md:206`
   - `oxide_polished_v2.md:210`
   - Suggested direction: prefer direct behavioural wording over "works as advertised" / "prepared for" style phrasing.

## No-fix / passed items

- Core oxide numbers match canonical sources.
- Protocol-bounded language is generally disciplined.
- Embedding interpretation remains descriptive/correlational.
- No contradiction was found between the oxide standalone and the combined paper on the core oxide results.
