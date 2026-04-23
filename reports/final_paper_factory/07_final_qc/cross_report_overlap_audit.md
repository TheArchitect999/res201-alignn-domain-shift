# Cross-Report Overlap Audit

Date: 2026-04-24

Scope:
- `04_drafts/phase12_full_manuscripts/oxide_polished_v2.md`
- `04_drafts/phase12_full_manuscripts/nitride_polished_v2.md`

The combined paper was not treated as an overlap target here because it is expected to reuse and integrate the standalone scientific content by design.

## Method

- Paragraph-level similarity check after whitespace normalization
- Full-document pass for oxide vs nitride
- Separate pass restricted to Results onward
- Thresholds used:
  - `>= 0.78` similarity for full-document duplicate screening
  - `>= 0.75` similarity for Results/Discussion/Conclusion duplicate screening

## Findings

### 1. Full-document overlap exists, but it is concentrated where it should be

The high-similarity paragraph pairs are mostly:
- front matter placeholders
- the shared CGCNN / ALIGNN background paragraph
- shared dataset/split protocol description
- shared zero-shot / fine-tuning / from-scratch method descriptions
- the identical embedding figure insertion block

This is expected because the two standalones share:
- the same pretrained checkpoint
- the same JARVIS split logic
- the same Set 1 training protocol
- the same embedding-analysis machinery

### 2. Results-plus overlap is low

After restricting the comparison to Results onward:
- only **one** paragraph pair met the `>= 0.75` threshold
- that pair was the shared insertion-marker block for the embedding figure triptych

In other words:
- the Results, Discussion, and Conclusion prose is not being duplicated across the oxide and nitride standalones in a way that threatens manuscript identity

### 3. Distinct manuscript identity is preserved

The two standalones remain distinct where it matters most:
- oxide centers the control-arm interpretation, pretraining-vs-scratch value, and the reference-condition role
- nitride centers the domain-shift arc, low-`N` inertness, persistent residual penalty, and distance-error correlation

The Discussions are not mirror copies of each other, and the Conclusions answer different scientific questions.

## Areas of legitimate shared wording

The following overlap is real but acceptable:
- Introduction background on crystal GNNs
- JARVIS dataset and split-inheritance explanation
- fine-tuning and from-scratch protocol description
- shared embedding-method description

These are methodologically shared paragraphs, not evidence that the scientific argument has collapsed into one template.

## Remaining overlap risk

Low.

If a later venue-specific edit wants stronger stylistic separation, the best places to trim shared wording are:
- the first two Introduction paragraphs
- the shared Methods protocol paragraphs

That is an editorial refinement, not a scientific-identity problem.

## Verdict

Pass.

There is no evidence of excessive oxide-nitride standalone overlap in the Results/Discussion/Conclusion material. The remaining high-overlap text is concentrated in legitimate shared background and methods prose.
