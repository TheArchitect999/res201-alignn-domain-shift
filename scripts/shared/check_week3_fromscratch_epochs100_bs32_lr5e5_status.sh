#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
RUN_SUBDIR="${2:-train_alignn_fromscratch_epochs100_bs32_lr5e5}"
REPORT_DIR="${3:-reports/week3_fromscratch_epochs100_bs32_lr5e5}"

cd "$REPO_ROOT"

NS=(50 500)
SEEDS=(0 1 2 3 4)
FAMILIES=(oxide nitride)

echo "[1/3] Checking per-run from-scratch summaries..."
missing=0
for family in "${FAMILIES[@]}"; do
  for n in "${NS[@]}"; do
    for seed in "${SEEDS[@]}"; do
      path="results/${family}/N${n}_seed${seed}/${RUN_SUBDIR}/summary.json"
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
echo "[3/3] Validating run-row count..."
if ! REPORT_DIR="$REPORT_DIR" python - <<'PY'
import csv
import os
import sys

path = os.path.join(os.environ["REPORT_DIR"], "fromscratch_runs.csv")
with open(path, newline="", encoding="utf-8") as handle:
    rows = list(csv.DictReader(handle))
if len(rows) != 20:
    print(f"Expected 20 run rows, found {len(rows)}")
    sys.exit(1)
print("Row-count check passed (20 runs).")
PY
then
  missing=1
fi

if [[ "$missing" -ne 0 ]]; then
  echo "Week 3 from-scratch status: INCOMPLETE"
  exit 1
fi

echo "Week 3 from-scratch status: COMPLETE"
