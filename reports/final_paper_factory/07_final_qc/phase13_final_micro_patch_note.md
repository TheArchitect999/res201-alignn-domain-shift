# Phase 13 Micro-Patch Note

Date: 2026-04-24

Source: `combined_paper_polished_v3.md`
Output: `combined_paper_polished_v4.md`

---

## Change applied

**Location:** §VIII. Conclusion, final paragraph, last sentence.

**Old text:**
> Under the canonical protocol, that cost separates the chemistry-aligned regime in which transfer works as advertised from the chemistry-shifted regime in which the labelled-data cost of moving below a pretrained baseline is substantially higher than chemistry-aligned task experience would predict — a cost that should be planned for rather than discovered after the fact.

**New text:**
> Under the canonical protocol, that cost is visible in the divergence between the two arms: oxide fine-tuning begins earlier and converges within 0.0075 eV/atom of its own zero-shot baseline at `N = 1 000`, while nitride fine-tuning begins later, remains farther above its own zero-shot baseline at every tested budget, and does not recover that baseline even at the largest tested size — a cost that should be planned for rather than discovered after the fact on chemistry-distant targets.

---

## Why this fix was required

The original sentence made an implicit cross-family claim: that the chemistry-aligned (oxide) arm can move below its pretrained zero-shot baseline and that the chemistry-shifted (nitride) arm requires substantially more labelled data to do the same. Neither half of that comparison is supported by the experimental evidence.

- Oxide fine-tuning never drops below the oxide zero-shot MAE of 0.0342 eV/atom at any tested N. The closest it gets is 0.0417 eV/atom at N = 1 000, a gap of 0.0075 eV/atom above zero-shot.
- Nitride fine-tuning likewise never drops below the nitride zero-shot MAE of 0.0695 eV/atom at any tested N.

The original sentence therefore compared a threshold (beating a pretrained baseline) that neither arm crosses within the tested regime.

---

## What the replacement claims — and why each claim is supported

| Claim | Evidence anchor |
|---|---|
| Oxide fine-tuning begins earlier | Oxide mean_best_epoch = 18.5 at N = 50; nitride mean_best_epoch = 1.0 at N = 50, 100, 200 |
| Oxide converges within 0.0075 eV/atom of its own zero-shot baseline at N = 1 000 | Canonical numbers: oxide gap vs zero-shot at N = 1 000 is +0.0075 eV/atom |
| Nitride fine-tuning begins later | Nitride mean_best_epoch = 1.0 through N = 200; 40.5 at N = 500 |
| Nitride remains farther above its own zero-shot baseline at every tested budget | Nitride fine-tuning MAE at every N sits above 0.0695 eV/atom; smallest gap is 0.0211 eV/atom at N = 1 000 vs oxide's 0.0075 eV/atom at N = 1 000 |
| Best genuinely adapted nitride configuration remains above its own zero-shot baseline | N = 1 000 nitride mean test MAE = 0.0907 eV/atom > nitride zero-shot 0.0695 eV/atom |

---

## Scope of change

- One sentence in §VIII. Conclusion only.
- No numbers, figure markers, table markers, or `[CITE: ...]` placeholders were altered.
- No other section was touched.
- v3 → v4 is a single-sentence diff.
