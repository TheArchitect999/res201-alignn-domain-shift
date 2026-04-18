#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
RESULTS_ROOT="${2:-results_prof_advice}"
REPORT_DIR="${3:-reports/week3_fromscratch_prof_advice}"
RUN_SUBDIR="${4:-train_alignn_fromscratch}"
cd "$REPO_ROOT"

NS=(50 500)
FAMILIES=(oxide nitride)
SEEDS=(0 1 2 3 4)
EXPECTED_RUNS=20

echo "[1/3] Checking imported from-scratch summaries..."
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
echo "[2/3] Checking imported aggregate artifacts..."
aggregate_paths=(
  "${REPORT_DIR}/fromscratch_runs.csv"
  "${REPORT_DIR}/fromscratch_summary.csv"
  "${REPORT_DIR}/week3_fromscratch_manifest.json"
  "${REPORT_DIR}/run_suite_summary.json"
)
while IFS= read -r path; do
  [[ -n "$path" ]] && aggregate_paths+=("$path")
done < <(REPORT_DIR="$REPORT_DIR" python - <<'PY'
import json
import os
from pathlib import Path

manifest = Path(os.environ["REPORT_DIR"]) / "week3_fromscratch_manifest.json"
data = json.loads(manifest.read_text(encoding="utf-8"))
for family in ("oxide", "nitride"):
    plot = data.get("plots", {}).get(family, {})
    for key in ("png", "pdf"):
        value = plot.get(key)
        if value:
            print(value)
PY
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
echo "[3/3] Validating imported run-row count..."
if ! REPORT_DIR="$REPORT_DIR" EXPECTED_RUNS="$EXPECTED_RUNS" python - <<'PY'
import csv
import os
import sys

path = os.path.join(os.environ["REPORT_DIR"], "fromscratch_runs.csv")
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

if [[ "$missing" -ne 0 ]]; then
  echo "Imported Week 3 from-scratch status: INCOMPLETE"
  exit 1
fi

echo "Imported Week 3 from-scratch status: COMPLETE"
