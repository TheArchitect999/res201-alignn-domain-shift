#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
RUN_SUBDIR="${2:-train_alignn_fromscratch}"
REPORT_DIR="${3:-reports/week3_fromscratch_baseline}"
cd "$REPO_ROOT"

NS=(50 500)
FAMILIES=(oxide nitride)

echo "[1/3] Checking per-run from-scratch summaries..."
missing=0
for family in "${FAMILIES[@]}"; do
  for n in "${NS[@]}"; do
    path="results/${family}/N${n}_seed0/${RUN_SUBDIR}/summary.json"
    if [[ -f "$path" ]]; then
      echo "OK  $path"
    else
      echo "MISS $path"
      missing=1
    fi
  done
done

echo
echo "[2/3] Checking aggregate artifacts..."
aggregate_paths=(
  "${REPORT_DIR}/fromscratch_runs.csv"
  "${REPORT_DIR}/fromscratch_summary.csv"
  "${REPORT_DIR}/week3_fromscratch_manifest.json"
  "${REPORT_DIR}/oxide_fromscratch_comparison.png"
  "${REPORT_DIR}/oxide_fromscratch_comparison.pdf"
  "${REPORT_DIR}/nitride_fromscratch_comparison.png"
  "${REPORT_DIR}/nitride_fromscratch_comparison.pdf"
  "${REPORT_DIR}/run_suite_summary.json"
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
echo "[3/3] Validating run-row count..."
if ! REPORT_DIR="$REPORT_DIR" python - <<'PY'
import csv
import os
import sys

path = os.path.join(os.environ["REPORT_DIR"], "fromscratch_runs.csv")
with open(path, newline="") as f:
    rows = list(csv.DictReader(f))
if len(rows) != 4:
    print(f"Expected 4 run rows, found {len(rows)}")
    sys.exit(1)
print("Row-count check passed (4 runs).")
PY
then
  missing=1
fi

if [[ "$missing" -ne 0 ]]; then
  echo "Week 3 from-scratch status: INCOMPLETE"
  exit 1
fi

echo "Week 3 from-scratch status: COMPLETE"
