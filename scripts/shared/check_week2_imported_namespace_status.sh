#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
RESULTS_ROOT="${2:-results_prof_advice}"
REPORT_DIR="${3:-reports/week2_prof_advice}"
RUN_SUBDIR="${4:-finetune_last2}"
cd "$REPO_ROOT"

NS=(10 50 100 200 500 1000)
SEEDS=(0 1 2 3 4)
FAMILIES=(oxide nitride)
EXPECTED_RUNS=60

echo "[1/4] Checking imported Week 2 summaries..."
missing=0
for family in "${FAMILIES[@]}"; do
  for n in "${NS[@]}"; do
    for seed in "${SEEDS[@]}"; do
      path="${RESULTS_ROOT}/${family}/N${n}_seed${seed}/${RUN_SUBDIR}/summary.json"
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
echo "[2/4] Checking aggregate imported Week 2 artifacts..."
aggregate_paths=(
  "${REPORT_DIR}/finetune_runs.csv"
  "${REPORT_DIR}/finetune_summary_by_N.csv"
  "${REPORT_DIR}/finetune_summary_wide.csv"
  "${REPORT_DIR}/zero_shot_summary.csv"
  "${REPORT_DIR}/finetune_summary_table.tex"
  "${REPORT_DIR}/progress_manifest.json"
  "${REPORT_DIR}/week2_summary_manifest.json"
  "${REPORT_DIR}/training_curves/training_curve_manifest.csv"
  "${REPORT_DIR}/training_curves/training_curve_manifest.json"
  "${REPORT_DIR}/training_curves/README.md"
  "${REPORT_DIR}/oxide_learning_curve.png"
  "${REPORT_DIR}/oxide_learning_curve.pdf"
  "${REPORT_DIR}/nitride_learning_curve.png"
  "${REPORT_DIR}/nitride_learning_curve.pdf"
  "${REPORT_DIR}/training_curves/oxide_training_curve_grid.png"
  "${REPORT_DIR}/training_curves/oxide_training_curve_grid.pdf"
  "${REPORT_DIR}/training_curves/nitride_training_curve_grid.png"
  "${REPORT_DIR}/training_curves/nitride_training_curve_grid.pdf"
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
echo "[3/4] Validating imported run-row count..."
if ! REPORT_DIR="$REPORT_DIR" EXPECTED_RUNS="$EXPECTED_RUNS" python - <<'PY'
import csv
import os
import sys

path = os.path.join(os.environ["REPORT_DIR"], "finetune_runs.csv")
with open(path, newline="") as f:
    rows = list(csv.DictReader(f))
expected = int(os.environ["EXPECTED_RUNS"])
if len(rows) != expected:
    print(f"Expected {expected} run rows, found {len(rows)}")
    sys.exit(1)
print(f"Row-count check passed ({expected} runs).")
PY
then
  missing=1
fi

echo
echo "[4/4] Imported Week 2 status..."
if [[ "$missing" -ne 0 ]]; then
  echo "Imported Week 2 status: INCOMPLETE"
  exit 1
fi

echo "Imported Week 2 status: COMPLETE"
