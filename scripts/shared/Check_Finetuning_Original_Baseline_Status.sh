#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

NS=(10 50 100 200 500 1000)
SEEDS=(0 1 2)
FAMILIES=(oxide nitride)

echo "[1/4] Checking per-run Week 2 summaries..."
missing=0
for family in "${FAMILIES[@]}"; do
  for n in "${NS[@]}"; do
    for seed in "${SEEDS[@]}"; do
      path="Results_Before_Correction/${family}/N${n}_seed${seed}/finetune_last2/summary.json"
      if [[ -f "$path" ]]; then
        echo "OK  $path"
      else
        echo "MISS $path"
        missing=1
      fi
    done
  done
done

echo
echo "[2/4] Checking aggregate Week 2 artifacts..."
aggregate_paths=(
  "reports/week2/finetune_runs.csv"
  "reports/week2/finetune_summary_by_N.csv"
  "reports/week2/finetune_summary_wide.csv"
  "reports/week2/finetune_summary_table.tex"
  "reports/week2/oxide_learning_curve.png"
  "reports/week2/oxide_learning_curve.pdf"
  "reports/week2/nitride_learning_curve.png"
  "reports/week2/nitride_learning_curve.pdf"
  "reports/week2/run_suite_summary.json"
  "reports/week2/week2_summary_manifest.json"
  "reports/week2_report.tex"
)
for path in "${aggregate_paths[@]}"; do
  if [[ -f "$path" ]]; then
    echo "OK  $path"
  else
    echo "MISS $path"
    missing=1
  fi
done

echo
echo "[3/4] Validating aggregate CSV contents..."
if ! python - <<'PY'
import csv
import json
import math
import os
import sys

families = ["oxide", "nitride"]
ns = [10, 50, 100, 200, 500, 1000]
expected_runs = 3
bad = False

summary_rows = {}
with open("reports/week2/finetune_summary_by_N.csv", newline="") as f:
    for row in csv.DictReader(f):
        summary_rows[(row["family"], int(row["N"]))] = row

for family in families:
    print(f"[{family}]")
    for n in ns:
        row = summary_rows.get((family, n))
        if row is None:
            print(f"  N={n}: MISSING aggregate row")
            bad = True
            continue
        runs = int(row["runs"])
        mean_mae = float(row["mean_test_mae_eV_per_atom"])
        std_mae = float(row["std_test_mae_eV_per_atom"])
        zero = float(row["zero_shot_mae_eV_per_atom"])
        gain = float(row["transfer_gain_vs_zero_shot"])
        status = "OK"
        if runs != expected_runs:
            status = f"BAD runs={runs}"
            bad = True
        print(
            f"  N={n}: runs={runs}, mean_test_mae={mean_mae:.6f}, "
            f"std={std_mae:.6f}, zero_shot={zero:.6f}, gain={gain:.6f} [{status}]"
        )

with open("reports/week2/finetune_runs.csv", newline="") as f:
    run_rows = list(csv.DictReader(f))

if len(run_rows) != len(families) * len(ns) * expected_runs:
    print(
        f"Run-count mismatch: expected {len(families) * len(ns) * expected_runs}, "
        f"found {len(run_rows)}"
    )
    bad = True

if bad:
    sys.exit(1)
PY
then
  missing=1
fi

echo
echo "[4/4] Week 2 status..."
if [[ "$missing" -ne 0 ]]; then
  echo "Week 2 status: INCOMPLETE"
  exit 1
fi

echo "Week 2 status: COMPLETE"
