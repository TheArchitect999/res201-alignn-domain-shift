#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
RUN_SUBDIR="${2:-train_alignn_fromscratch}"
REPORT_DIR="${3:-reports/Hyperparameter Set 2/Summaries/From Scratch}"
RESULTS_ROOT="${4:-Results_Hyperparameter_Set_2}"
PLOT_DIR="${5:-reports/Hyperparameter Set 2/Comparison Plots}"
cd "$REPO_ROOT"

NS=(50 500)
FAMILIES=(oxide nitride)
SEEDS=(0 1 2 3 4)

echo "[1/3] Checking per-run from-scratch summaries..."
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
echo "[2/3] Checking aggregate artifacts..."
aggregate_paths=(
  "${REPORT_DIR}/fromscratch_runs.csv"
  "${REPORT_DIR}/fromscratch_summary.csv"
  "${REPORT_DIR}/week3_fromscratch_manifest.json"
  "${REPORT_DIR}/run_suite_summary.json"
  "${PLOT_DIR}/Oxide Comparison Plot - Hyperparameter Set 2.png"
  "${PLOT_DIR}/Oxide Comparison Plot - Hyperparameter Set 2.pdf"
  "${PLOT_DIR}/Nitride Comparison Plot - Hyperparameter Set 2.png"
  "${PLOT_DIR}/Nitride Comparison Plot - Hyperparameter Set 2.pdf"
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
if len(rows) != 20:
    print(f"Expected 20 run rows, found {len(rows)}")
    sys.exit(1)
print("Row-count check passed (20 runs).")
PY
then
  missing=1
fi

if [[ "$missing" -ne 0 ]]; then
  echo "Hyperparameter Set 2 from-scratch status: INCOMPLETE"
  exit 1
fi

echo "Hyperparameter Set 2 from-scratch status: COMPLETE"
