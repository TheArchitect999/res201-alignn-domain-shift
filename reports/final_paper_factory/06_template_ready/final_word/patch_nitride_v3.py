"""
patch_nitride_v3.py
Patches nitride_final_v2.docx → nitride_final_v3.docx:
  1. Deletes duplicate Figure 4 block (same image as Figure 3)
  2. Renumbers Figure captions 5→4, 6→5, ..., 12→11
  3. Replaces all TAB_* and FIG_* tokens in prose
  4. Replaces the summary paragraph with a clean version
  5. Writes QC report
"""

import re
import copy
from pathlib import Path
from docx import Document
from docx.oxml.ns import qn
from lxml import etree

INPUT  = Path(__file__).parent / "nitride_final_v2.docx"
OUTPUT = Path(__file__).parent / "nitride_final_v3.docx"
QC_OUT = Path(__file__).parent / "nitride_final_v3_qc.md"

# ── token replacement maps ────────────────────────────────────────────────────

TABLE_MAP = {
    "TAB_METHODS_DATASET_SPLITS":   "Table 1",
    "TAB_METHODS_EXPERIMENT_SCOPE": "Table 2",
    "TAB_ZS_SUMMARY":               "Table 3",
    "TAB_S1_FT_SUMMARY_BY_N":       "Table 4",
    "TAB_EA_FAMILY_SEPARATION":     "Table 5",
    "TAB_EA_DISTANCE_ERROR_STATS":  "Table 6",
    "TAB_S1_FS_SUMMARY":            "Table 7",
}

FIG_MAP = {
    "FIG_SCHEMATIC":                 "Figure 1",
    "FIG_ZS_COMPARISON":             "Figure 2",
    "FIG_S1_LC_NITRIDE":             "Figure 3",
    "FIG_S1_PARITY_NITRIDE_N10":     "Figure 4",
    "FIG_S1_PARITY_NITRIDE_N1000":   "Figure 5",
    "FIG_EA_6A_PCA":                 "Figure 6",
    "FIG_EA_6B_TSNE":                "Figure 7",
    "FIG_EA_6C_UMAP":                "Figure 8",
    "FIG_EA_6D_BOXPLOT":             "Figure 9",
    "FIG_EA_6D_SCATTER":             "Figure 10",
    "FIG_S1_COMP_NITRIDE":           "Figure 11",
}

SUMMARY_REPLACEMENT = (
    "The main numerical evidence is summarized in Tables 3–7, "
    "with the corresponding visual evidence shown in Figures 2–11."
)

# ── helpers ───────────────────────────────────────────────────────────────────

def para_style(p_elem):
    pPr = p_elem.find(qn("w:pPr"))
    if pPr is None:
        return ""
    pStyle = pPr.find(qn("w:pStyle"))
    return pStyle.get(qn("w:val"), "") if pStyle is not None else ""

def para_text(p_elem):
    return "".join(t.text or "" for t in p_elem.iter(qn("w:t")))

def has_image(p_elem):
    return p_elem.find(".//" + qn("w:drawing")) is not None

def set_para_text_inplace(p_elem, new_text):
    """
    Replace the text content of a paragraph by clearing all runs and
    writing a single run with new_text, preserving paragraph-level formatting.
    """
    # collect all existing runs and delete them
    for r in p_elem.findall(qn("w:r")):
        p_elem.remove(r)
    # also remove hyperlinks etc
    for child in list(p_elem):
        tag = child.tag.split("}")[-1] if "}" in child.tag else child.tag
        if tag not in ("pPr",):
            p_elem.remove(child)
    # create a fresh run
    r_elem = etree.SubElement(p_elem, qn("w:r"))
    t_elem = etree.SubElement(r_elem, qn("w:t"))
    t_elem.text = new_text
    t_elem.set("{http://www.w3.org/XML/1998/namespace}space", "preserve")

def replace_tokens_in_para(p_elem, table_map, fig_map):
    """Apply TAB_* and FIG_* substitutions on all w:t elements in a paragraph.
    Handles tokens that are in a separate run from a preceding 'Table '/'Figure ' word."""
    t_elems = list(p_elem.iter(qn("w:t")))
    changed = False
    for idx, t in enumerate(t_elems):
        orig = t.text or ""
        new = orig
        raw = orig.strip("`").strip()

        # Table tokens
        for tok, label in table_map.items():
            if raw == tok:
                # token is isolated in its own run
                new = label
                # strip trailing "Table " from previous run if present
                if idx > 0:
                    prev = t_elems[idx - 1]
                    if prev.text and re.search(r"Table\s+$", prev.text):
                        prev.text = re.sub(r"Table\s+$", "", prev.text)
                break
            elif tok in new:
                new = re.sub(r"(?:Table\s+)?`?" + re.escape(tok) + r"`?", label, new)
                break

        if new == orig:
            # Figure tokens
            for tok, label in fig_map.items():
                raw2 = (new or orig).strip("`").strip()
                if raw2 == tok:
                    new = label
                    if idx > 0:
                        prev = t_elems[idx - 1]
                        if prev.text and re.search(r"Figure\s+$", prev.text):
                            prev.text = re.sub(r"Figure\s+$", "", prev.text)
                    break
                elif tok in new:
                    new = re.sub(r"(?:Figure\s+)?`?" + re.escape(tok) + r"`?", label, new)
                    break

        if new != orig:
            t.text = new
            changed = True
    return changed

def is_summary_paragraph(p_elem):
    text = para_text(p_elem)
    # The summary paragraph contains multiple TAB_* and FIG_* tokens
    return ("TAB_ZS_SUMMARY" in text and "TAB_S1_FT_SUMMARY_BY_N" in text
            and "FIG_ZS_COMPARISON" in text and "FIG_EA_6A_PCA" in text)

# ── main ─────────────────────────────────────────────────────────────────────

def main():
    doc = Document(INPUT)
    body = doc.element.body

    log = []

    # ── Step 1: Find and delete duplicate Figure 4 block ─────────────────────
    # The duplicate is: image paragraph, then caption "Figure 4. Nitride Set 1 fine-tuning..."
    # followed by a spacer paragraph. We need to find the SECOND occurrence of
    # a Normal+image paragraph immediately followed by a Caption containing "Figure 4"
    # and delete: image para + caption para + spacer para.

    children = list(body)
    duplicate_found = False
    duplicate_indices = []

    for i, elem in enumerate(children):
        tag = elem.tag.split("}")[-1] if "}" in elem.tag else elem.tag
        if tag != "p":
            continue
        if not has_image(elem):
            continue
        # check if next sibling is a Caption with "Figure 4."
        if i + 1 < len(children):
            nxt = children[i + 1]
            nxt_tag = nxt.tag.split("}")[-1] if "}" in nxt.tag else nxt.tag
            if nxt_tag == "p" and para_style(nxt) == "Caption":
                cap_text = para_text(nxt)
                if re.match(r"Figure 4\.", cap_text.strip()):
                    duplicate_indices = [i, i + 1]
                    # also check for spacer at i+2
                    if i + 2 < len(children):
                        possible_spacer = children[i + 2]
                        sp_tag = possible_spacer.tag.split("}")[-1] if "}" in possible_spacer.tag else possible_spacer.tag
                        if sp_tag == "p" and not has_image(possible_spacer):
                            sp_text = para_text(possible_spacer).strip()
                            if sp_text == "":
                                duplicate_indices.append(i + 2)
                    break

    if duplicate_indices:
        # Remove in reverse order to preserve indices
        for idx in sorted(duplicate_indices, reverse=True):
            elem_to_remove = children[idx]
            body.remove(elem_to_remove)
        duplicate_found = True
        log.append(f"DELETED duplicate Figure 4 block: body indices {duplicate_indices} (image + caption + spacer)")
    else:
        log.append("WARNING: Duplicate Figure 4 block NOT found — check manually")

    # ── Step 2: Renumber Figure captions 5→4, ..., 12→11 ───────────────────
    renumber_count = 0
    # refresh children after deletion
    children = list(body)
    for elem in children:
        tag = elem.tag.split("}")[-1] if "}" in elem.tag else elem.tag
        if tag != "p":
            continue
        if para_style(elem) != "Caption":
            continue
        # look for "Figure N." at start of caption text (across runs)
        full_text = para_text(elem)
        m = re.match(r"^(Figure )(\d+)(\..*)", full_text, re.DOTALL)
        if not m:
            continue
        old_n = int(m.group(2))
        if old_n >= 5:
            new_n = old_n - 1
            # Replace in the w:t elements
            # Strategy: find the run that contains the digit and replace it
            target_str = f"Figure {old_n}."
            replacement_str = f"Figure {new_n}."
            for t in elem.iter(qn("w:t")):
                if t.text and target_str in t.text:
                    t.text = t.text.replace(target_str, replacement_str, 1)
                    renumber_count += 1
                    log.append(f"  Caption renumbered: Figure {old_n} -> Figure {new_n} | '{full_text[:60].strip()}'")
                    break

    log.append(f"Total figure captions renumbered: {renumber_count}")

    # ── Step 3 & 4: Replace TAB_*/FIG_* tokens in prose ────────────────────
    token_paras_changed = 0
    summary_replaced = False
    children = list(body)

    for elem in children:
        tag = elem.tag.split("}")[-1] if "}" in elem.tag else elem.tag
        if tag != "p":
            continue

        # Check for summary paragraph first
        if is_summary_paragraph(elem):
            set_para_text_inplace(elem, SUMMARY_REPLACEMENT)
            summary_replaced = True
            log.append(f"Summary paragraph replaced with clean version.")
            continue

        # General token replacement
        if replace_tokens_in_para(elem, TABLE_MAP, FIG_MAP):
            token_paras_changed += 1
            log.append(f"  Token replacement in para: '{para_text(elem)[:80].strip()}'")

    log.append(f"Prose paragraphs with token replacements: {token_paras_changed}")
    log.append(f"Summary paragraph replaced: {summary_replaced}")

    # ── Step 5: Save ─────────────────────────────────────────────────────────
    doc.save(OUTPUT)
    log.append(f"Saved: {OUTPUT}")

    # ── Step 6: QC pass ──────────────────────────────────────────────────────
    doc2 = Document(OUTPUT)
    body2 = doc2.element.body

    remaining_tab = []
    remaining_fig = []
    remaining_insert = []
    figure_captions = []

    for elem in body2:
        tag = elem.tag.split("}")[-1] if "}" in elem.tag else elem.tag
        if tag == "p":
            txt = para_text(elem)
            # check for leftover tokens
            for tok in TABLE_MAP:
                if tok in txt:
                    remaining_tab.append(f"  TAB token '{tok}' in: {txt[:80].strip()}")
            for tok in FIG_MAP:
                if tok in txt:
                    remaining_fig.append(f"  FIG token '{tok}' in: {txt[:80].strip()}")
            if "[INSERT" in txt:
                remaining_insert.append(f"  INSERT placeholder: {txt[:80].strip()}")
            # collect captions
            if para_style(elem) == "Caption":
                m = re.match(r"^Figure (\d+)\.", txt.strip())
                if m:
                    figure_captions.append((int(m.group(1)), txt.strip()[:80]))
        elif tag == "tbl":
            # check table cells
            for t in elem.iter(qn("w:t")):
                txt = t.text or ""
                for tok in TABLE_MAP:
                    if tok in txt:
                        remaining_tab.append(f"  TAB in table cell: {txt[:80]}")
                for tok in FIG_MAP:
                    if tok in txt:
                        remaining_fig.append(f"  FIG in table cell: {txt[:80]}")

    # check sequential numbering
    fig_nums = [n for n, _ in figure_captions]
    expected = list(range(1, len(fig_nums) + 1))
    sequential_ok = (fig_nums == expected)

    # write QC report
    qc_lines = [
        "# nitride_final_v3.docx — QC Report",
        f"**Date:** 2026-04-24",
        f"**Input:** nitride_final_v2.docx",
        f"**Output:** nitride_final_v3.docx",
        "",
        "## Patch operations",
        "",
        *[f"- {line}" for line in log],
        "",
        "## QC results",
        "",
        f"| Check | Result |",
        f"|-------|--------|",
        f"| Duplicate Figure 4 removed | {'YES ✓' if duplicate_found else 'NO ⚠'} |",
        f"| Figure captions renumbered | {renumber_count} captions updated |",
        f"| Sequential figure numbering (1–{len(fig_nums)}) | {'YES ✓' if sequential_ok else 'NO ⚠ — ' + str(fig_nums)} |",
        f"| Summary paragraph replaced | {'YES ✓' if summary_replaced else 'NO ⚠'} |",
        f"| Remaining TAB_* tokens | {len(remaining_tab)} {'✓' if not remaining_tab else '⚠'} |",
        f"| Remaining FIG_* tokens | {len(remaining_fig)} {'✓' if not remaining_fig else '⚠'} |",
        f"| Remaining [INSERT...] placeholders | {len(remaining_insert)} {'✓' if not remaining_insert else '⚠'} |",
        "",
    ]

    if remaining_tab:
        qc_lines += ["### Remaining TAB_* tokens", *remaining_tab, ""]
    if remaining_fig:
        qc_lines += ["### Remaining FIG_* tokens", *remaining_fig, ""]
    if remaining_insert:
        qc_lines += ["### Remaining INSERT placeholders", *remaining_insert, ""]

    qc_lines += [
        "## Figure caption index",
        "",
        "| # | Caption (truncated) |",
        "|---|---------------------|",
        *[f"| {n} | {cap} |" for n, cap in figure_captions],
        "",
        "## Verdict",
        "",
    ]

    all_ok = (duplicate_found and sequential_ok and summary_replaced
              and not remaining_tab and not remaining_fig and not remaining_insert)
    if all_ok:
        qc_lines.append("**PASS — nitride_final_v3.docx is ready for human Word QA pass.**")
    else:
        qc_lines.append("**FAIL — see ⚠ items above before submission.**")

    QC_OUT.write_text("\n".join(qc_lines), encoding="utf-8")
    print("\n".join(log).encode("ascii", errors="replace").decode("ascii"))
    print(f"\nQC report written: {QC_OUT}")
    print(f"Verdict: {'PASS' if all_ok else 'FAIL'}")

if __name__ == "__main__":
    main()
