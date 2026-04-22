# Stage 5 Literature + Introduction Consistency Patch — Changelog

**Date:** 2026-04-22
**Patch scope:** Cross-file consistency repair following confirmation that JARVIS 2020 is physically present in `paper_sources/`. Stale "to be obtained" language removed; `citation_needed_list.md` synchronized with the repaired citation hierarchy. No citation hierarchies changed; no claims added or broadened.

**Builds on:** `stage5_lit_intro_patch_changelog.md` (the prior Stage 5 pass that established the three-tier JARVIS hierarchy, the transfer-learning ordering, and the gap-sentence protections).

---

## Files created

| New file | Supersedes |
|---|---|
| `literature_claim_map_v3.md` | `literature_claim_map_v2.md` |
| `introduction_paragraph_plan_v4.md` | `introduction_paragraph_plan_v3.md` |
| `citation_needed_list_v2.md` | `citation_needed_list.md` |

Originals are preserved and not overwritten.

---

## Fix-by-fix record

---

### FIX A — Remove False "JARVIS 2020 Is Missing" Statements

**Severity:** Critical issue

**What changed.**

*Repository fact verified:* `paper_sources/Choudhary et al. - 2020 - The joint automated repository for various integrated simulations (JARVIS) for data-driven materials.pdf` is present on disk.

*In `literature_claim_map_v3.md` (from v2):*
- Scholarly Anchors JARVIS row: Replaced `[JARVIS 2020 — to be obtained; see note below]` with the actual local filename.
- Removed the standalone "JARVIS 2020 file status" note block that appeared below the Scholarly Anchors table.
- L4 local source candidates: Replaced "JARVIS 2020 (to be obtained)" with the actual filename.
- Version note updated to describe the consistency patch accurately.

*In `introduction_paragraph_plan_v4.md` (from v3):*
- JARVIS citation note for P2: Replaced "cite JARVIS 2020 (to be obtained)" with the actual filename.
- §6 local-source table `[CITE: JARVIS dataset/repository paper]` row: Replaced the "(to be obtained)" entry and the full acquisition notice with the actual filename and a clean description of its role.
- §8 checklist item 5: Removed "(Note: JARVIS 2020 still needs to be obtained.)".
- §9 "What this blueprint deliberately does not fix": Removed the JARVIS 2020 acquisition item entirely (it is resolved). The three remaining open items (dataset counts, Chen et al. vs CGCNN in P1, optional Matbench sentence) are preserved.
- Version note updated to describe the consistency patch accurately.

*Stale language that is now removed from both files:*
- "to be obtained"
- "missing from paper_sources/"
- "flagged for acquisition"
- "must be obtained before manuscript submission" (in the context of JARVIS 2020)

**Why it changed.**
The prior pass correctly established JARVIS 2020 as the primary provenance anchor but wrote it as a paper not yet in hand. The paper is now confirmed present. Leaving "to be obtained" language in planning files that are about to be used for prose drafting would (a) create a false impression of a gap, (b) risk a drafter defaulting to JARVIS 2025 or JARVIS-Leaderboard 2024 to "avoid the missing citation," which would silently reintroduce the provenance error the prior pass fixed.

---

### FIX B — Synchronize citation_needed_list with the Repaired Hierarchy

**Severity:** Important issue

**What changed.**

*In `citation_needed_list_v2.md` (from `citation_needed_list.md`):*

1. **M1 — Dataset and benchmark provenance.**
   - Prior version listed only JARVIS 2025 and JARVIS-Leaderboard 2024 as local source candidates with no hierarchy.
   - Updated to show the full three-tier hierarchy: JARVIS 2020 as primary (dataset/repository provenance), JARVIS 2025 as secondary (broader ecosystem context), JARVIS-Leaderboard 2024 as contextual (benchmark/leaderboard framing only).
   - Added explicit instruction: "Use JARVIS 2020 as the primary anchor when the sentence concerns where the dataset and repository come from."

2. **M5 — Split protocol.**
   - Prior version listed JARVIS-Leaderboard 2024 first, JARVIS 2025 second, with no mention of JARVIS 2020.
   - Updated to list JARVIS 2020 as primary and JARVIS 2025 as secondary, matching M1 and the claim map.
   - Added explicit instruction: "Cite JARVIS 2020 when invoking the original JARVIS split provenance."

3. **§5 Citation family summary.**
   - Prior version had a single "JARVIS / dataset" row that did not distinguish the three papers.
   - Expanded to three rows: JARVIS 2020 (primary, dataset/repository), JARVIS 2025 (secondary, ecosystem/infrastructure), JARVIS-Leaderboard 2024 (contextual, benchmark/leaderboard).
   - This makes the hierarchy visible at a glance and prevents the undifferentiated usage pattern that the prior pass was designed to fix.

4. **Section 1 — Introduction.**
   - Updated the "Superseded" pointer from `introduction_blueprint_v2.md` to `introduction_paragraph_plan_v4.md`, the current authoritative intro blueprint.

5. **§6 Guardrails.**
   - Added "JARVIS hierarchy guardrail" as an explicit named guardrail matching the §5 expansion.
   - Added "Transfer-learning hierarchy guardrail" naming the Lee & Asahi / Kim / Hu ordering, since this file was the one document in the pack that did not yet name it as a guardrail.

6. **Authority note and What changed table.**
   - Added at the top to make the three-file authority structure explicit and to record what was updated.

**Why it changed.**
`citation_needed_list.md` was the one document in the Stage 5 pack that had not yet been updated to reflect the JARVIS provenance hierarchy established in the prior patch. Because it directly guides Methods and Discussion drafting, leaving it with the old hierarchy created a vector for re-introducing the error: a Methods drafter reading M1 and seeing only JARVIS 2025 and JARVIS-Leaderboard 2024 would naturally cite those and omit JARVIS 2020. The file also still pointed to `introduction_blueprint_v2.md` as the authority for the introduction, which is now two versions stale.

---

### FIX C — Authoritative File Relationship Made Explicit

**Severity:** Polish issue

**What changed.**

*In `literature_claim_map_v3.md`:*
- Added an "Authority note" paragraph at the top of the file naming the three-file hierarchy: this file (source-tier and claim-boundary authority), `introduction_paragraph_plan_v4.md` (authoritative intro blueprint), `citation_needed_list_v2.md` (practical citation helper that must not contradict the first two).

*In `introduction_paragraph_plan_v4.md`:*
- Added an "Authority note" paragraph at the top naming its role and directing users to `citation_needed_list_v2.md` for Methods/Discussion/Abstract.

*In `citation_needed_list_v2.md`:*
- Added an "Authority note" paragraph at the top making the precedence explicit: if this file conflicts with the claim map or intro blueprint, those take precedence.

**Why it changed.**
With three interconnected planning files, a drafter who reads only one may make decisions that contradict the others. The authority notes are short (two sentences each) and close the coordination gap without bloating the files.

### FIX D — Preserve Existing Good Logic

**Severity:** No change required

All of the following were verified unchanged in every new version:

1. Narrow evaluation-design gap only (Link E, P3 sentence 4, gap protection note).
2. Introduction stays result-free (M5, P1–P5 "must not contain" clauses).
3. No oxide-pretrained wording (anti-pattern preserved in §7 of intro blueprint and §6 of citation list).
4. No embedding-as-proof wording (anti-pattern preserved; L7 claim preserved in claim map).
5. Matbench remains optional (P2 optional sentence, §5 table, §6 guardrail, anti-pattern).
6. Literature / project-design / our-question boundary remains explicit (§2 of claim map, P4 sentence classification reminder, §8 checklist item 4).

---

## Changelog summary (required items)

| Item | Status |
|---|---|
| Stale "JARVIS 2020 missing" notes removed | Removed from `literature_claim_map_v3.md` and `introduction_paragraph_plan_v4.md`. "To be obtained," "flagged for acquisition," and "missing from paper_sources/" language eliminated. |
| JARVIS 2020 now treated as present and primary | All three new files treat `Choudhary et al. - 2020 - ...` as a fully available local source candidate in its primary provenance role. |
| `citation_needed_list` is now synchronized with the repaired hierarchy | M1 and M5 updated; §5 summary expanded to three JARVIS rows; JARVIS and transfer-learning hierarchy guardrails added to §6. |
| Obsolete intro-file references were removed or updated | Section 1 superseded-by pointer updated to `introduction_paragraph_plan_v4.md`; `introduction_blueprint_v2.md` reference removed. |
| Stage 5 pack is now internally consistent for intro drafting | All four Stage 5 planning files (`literature_claim_map_v3.md`, `introduction_paragraph_plan_v4.md`, `citation_needed_list_v2.md`, this changelog) share the same JARVIS hierarchy, the same transfer-learning ordering, and the same gap-claim framing. |

---

## Prior changelog status corrections

The prior changelog (`stage5_lit_intro_patch_changelog.md`) contained two entries that are now superseded:

1. "JARVIS 2020 not in `paper_sources/`" in Unresolved items → **Resolved.** File confirmed present.
2. "File not yet in `paper_sources/` — must be obtained before submission" in Changelog summary → **Resolved.**

The prior changelog is preserved as a historical record. This file is the current state-of-record.

---

## Unresolved items before intro drafting

The following remain open and are intentionally deferred (unchanged from prior pass):

1. **Whether to mention dataset counts in the introduction or defer them to methods.** The stricter choice (defer all) is still recommended.
2. **Chen et al. 2019 vs CGCNN-only in P1.** Pick one approach and apply consistently at drafting time.
3. **Optional Matbench sentence in P2.** Decide after Methods is written; depends on how heavily Methods uses Matbench or JARVIS-Leaderboard framing.

No acquisition items remain outstanding.

---

## Pack readiness verdict

**Stage 5 pack is safe for intro drafting.** All four planning files are now internally consistent. JARVIS 2020 is physically present and correctly designated as the primary provenance anchor. The citation hierarchy (JARVIS, transfer learning), the gap-claim protection, and the three-column boundary are in agreement across all files. No missing files, no stale acquisition notes, no contradictions between files.
