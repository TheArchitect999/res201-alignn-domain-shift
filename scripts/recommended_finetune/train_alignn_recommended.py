#!/usr/bin/env python3
"""Standalone training wrapper with recommended ALIGNN hyperparameters.

Keeps original training scripts untouched by producing a separate config file
and then invoking ALIGNN's training entry point.
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--base-config", required=True, help="Path to an existing training config JSON")
    ap.add_argument("--out-config", required=True, help="Path to write the recommended training config")
    ap.add_argument("--python", default=sys.executable)
    ap.add_argument("--epochs", type=int, default=300)
    ap.add_argument("--batch-size", type=int, default=64)
    ap.add_argument("--learning-rate", type=float, default=1e-3)
    ap.add_argument("--cutoff", type=float, default=8.0)
    ap.add_argument("--alignn-layers", type=int, default=4)
    ap.add_argument("--gcn-layers", type=int, default=4)
    ap.add_argument("--atom-input-features", type=int, default=92)
    ap.add_argument("--run", action="store_true", help="If set, launch ALIGNN training after writing config")
    args, unknown = ap.parse_known_args()

    base_path = Path(args.base_config)
    out_path = Path(args.out_config)
    cfg = json.loads(base_path.read_text(encoding="utf-8"))

    cfg["epochs"] = args.epochs
    cfg["batch_size"] = args.batch_size
    cfg["learning_rate"] = args.learning_rate
    cfg["cutoff"] = args.cutoff
    cfg.setdefault("model", {})
    cfg["model"]["alignn_layers"] = args.alignn_layers
    cfg["model"]["gcn_layers"] = args.gcn_layers
    cfg["model"]["atom_input_features"] = args.atom_input_features

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(cfg, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote recommended training config: {out_path}")

    if args.run:
        cmd = [args.python, "alignn_references/alignn-main/alignn/train_alignn.py", "--config", str(out_path), *unknown]
        print("$", " ".join(cmd))
        raise SystemExit(subprocess.call(cmd))


if __name__ == "__main__":
    main()
