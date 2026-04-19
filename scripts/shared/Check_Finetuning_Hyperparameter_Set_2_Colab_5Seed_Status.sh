#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
TAG="${2:-week2_alignn_defaults_colab_5seed}"
RUN_SUBDIR="finetune_last2_${TAG}"
REPORT_DIR="reports/${TAG}"
TRAINING_CURVE_DIR="${REPORT_DIR}/training_curves"

cd "$REPO_ROOT"

NS=(10 50 100 200 500 1000)
SEEDS=(0 1 2 3 4)
FAMILIES=(oxide nitride)

echo "[1/4] Checking per-run tagged Week 2 summaries..."
missing=0
for family in "${FAMILIES[@]}"; do
  for n in "${NS[@]}"; do
    for seed in "${SEEDS[@]}"; do
      path="Results_Hyperparameter_Set_2/${family}/N${n}_seed${seed}/${RUN_SUBDIR}/summary.json"
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
echo "[2/4] Checking aggregate tagged Week 2 artifacts..."
aggregate_paths=(
  "${REPORT_DIR}/finetune_runs.csv"
  "${REPORT_DIR}/finetune_summary_by_N.csv"
  "${REPORT_DIR}/finetune_summary_wide.csv"
  "${REPORT_DIR}/finetune_summary_table.tex"
  "${REPORT_DIR}/oxide_learning_curve.png"
  "${REPORT_DIR}/oxide_learning_curve.pdf"
  "${REPORT_DIR}/nitride_learning_curve.png"
  "${REPORT_DIR}/nitride_learning_curve.pdf"
  "${REPORT_DIR}/run_suite_summary.json"
  "${REPORT_DIR}/week2_summary_manifest.json"
  "${REPORT_DIR}/progress_manifest.json"
  "${TRAINING_CURVE_DIR}/training_curve_manifest.csv"
  "${TRAINING_CURVE_DIR}/training_curve_manifest.json"
  "${TRAINING_CURVE_DIR}/README.md"
  "${TRAINING_CURVE_DIR}/oxide_training_curve_grid.png"
  "${TRAINING_CURVE_DIR}/oxide_training_curve_grid.pdf"
  "${TRAINING_CURVE_DIR}/nitride_training_curve_grid.png"
  "${TRAINING_CURVE_DIR}/nitride_training_curve_grid.pdf"
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
if ! TAG_ENV="$TAG" python - <<'PY'
import csv
import os
import sys
from pathlib import Path

tag = os.environ["TAG_ENV"]
report_dir = Path("reports") / tag
training_curve_dir = report_dir / "training_curves"
families = ["oxide", "nitride"]
ns = [10, 50, 100, 200, 500, 1000]
expected_runs = 5
bad = False

summary_rows = {}
with open(report_dir / "finetune_summary_by_N.csv", newline="", encoding="utf-8") as handle:
    for row in csv.DictReader(handle):
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
        std_mae = float(row["std_test_mae_eV_per_atom"]) if row["std_test_mae_eV_per_atom"] else float("nan")
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

with open(report_dir / "finetune_runs.csv", newline="", encoding="utf-8") as handle:
    run_rows = list(csv.DictReader(handle))
expected_total = len(families) * len(ns) * expected_runs
if len(run_rows) != expected_total:
    print(f"Run-count mismatch: expected {expected_total}, found {len(run_rows)}")
    bad = True

with open(training_curve_dir / "training_curve_manifest.csv", newline="", encoding="utf-8") as handle:
    training_rows = list(csv.DictReader(handle))
if len(training_rows) != expected_total:
    print(f"Training-curve manifest mismatch: expected {expected_total}, found {len(training_rows)}")
    bad = True

if bad:
    sys.exit(1)
PY
then
  missing=1
fi

echo
echo "[4/4] Tagged Week 2 status..."
if [[ "$missing" -ne 0 ]]; then
  echo "Tagged Week 2 status: INCOMPLETE"
  exit 1
fi

echo "Tagged Week 2 status: COMPLETE"
