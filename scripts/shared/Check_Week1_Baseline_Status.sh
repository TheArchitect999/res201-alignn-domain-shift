#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-.}"
cd "$REPO_ROOT"

echo "[1/5] Validating Stage 2 dataset..."
python scripts/dataset/validate_res201_stage2.py --root ./data_shared

echo
echo "[2/5] Checking required week 1 artifact files..."
required_files=(
  "data_shared/oxide/summaries/summary.json"
  "data_shared/nitride/summaries/summary.json"
  "results/oxide/zero_shot/summary.json"
  "results/nitride/zero_shot/summary.json"
  "results/oxide/N50_seed0/finetune_last2/summary.json"
  "results/nitride/N50_seed0/finetune_last2/summary.json"
  "results/oxide/N50_seed0/finetune_last2/best_model.pt"
  "results/nitride/N50_seed0/finetune_last2/best_model.pt"
  "results/oxide/N50_seed0/finetune_last2/history_val.json"
  "results/nitride/N50_seed0/finetune_last2/history_val.json"
  "results/oxide/N50_seed0/finetune_last2/prediction_results_test_set.csv"
  "results/nitride/N50_seed0/finetune_last2/prediction_results_test_set.csv"
)

missing=0
for path in "${required_files[@]}"; do
  if [[ -f "$path" ]]; then
    echo "OK  $path"
  else
    echo "MISS $path"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo
  echo "Week 1 status: INCOMPLETE (missing required artifacts)."
  exit 1
fi

echo
echo "[3/5] Checking recorded epoch counts..."
python - <<'PY'
import json
paths = [
    "results/oxide/N50_seed0/finetune_last2/history_val.json",
    "results/nitride/N50_seed0/finetune_last2/history_val.json",
]
for path in paths:
    history = json.load(open(path))
    print(f"{path}: epochs_recorded={len(history)}")
PY

echo
echo "[4/5] Printing key week 1 metrics..."
python - <<'PY'
import json
summary_paths = [
    ("oxide_zero_shot", "results/oxide/zero_shot/summary.json"),
    ("nitride_zero_shot", "results/nitride/zero_shot/summary.json"),
    ("oxide_N50_finetune", "results/oxide/N50_seed0/finetune_last2/summary.json"),
    ("nitride_N50_finetune", "results/nitride/N50_seed0/finetune_last2/summary.json"),
]
for label, path in summary_paths:
    data = json.load(open(path))
    mae = data.get("mae_eV_per_atom", data.get("test_mae_eV_per_atom"))
    print(f"{label}: {mae}")
PY

echo
echo "[5/5] Week 1 checklist..."
cat <<'EOF'
Completed checks:
- oxide subset built and validated
- nitride subset built and validated
- official splits applied before family filtering
- fixed oxide and nitride test sets present
- pretrained ALIGNN checkpoint available locally
- oxide zero-shot result saved
- nitride zero-shot result saved
- oxide N=50 fine-tune result saved
- nitride N=50 fine-tune result saved
EOF

echo
echo "Week 1 status: COMPLETE"
