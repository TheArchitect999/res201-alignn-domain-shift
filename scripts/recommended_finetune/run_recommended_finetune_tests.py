#!/usr/bin/env python3
"""Run recommended-parameter ALIGNN fine-tuning tests without touching shared scripts.

This script:
1) Creates run-specific config files in configs/recommended_finetune/
2) Launches fine-tuning with the local recommended finetune script copy
3) Writes artifacts to a separate output tree (default: results_recommended_v2)
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

RECOMMENDED = {
    "batch_size": 64,
    "epochs": 300,
    "learning_rate": 1e-3,
    "cutoff": 8.0,
    "model": {
        "alignn_layers": 4,
        "gcn_layers": 4,
        "atom_input_features": 92,
    },
}


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def dump_json(path: Path, payload: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")


def build_config(base_cfg: Path, out_cfg: Path, epochs_override: int | None) -> None:
    cfg = load_json(base_cfg)
    cfg["batch_size"] = RECOMMENDED["batch_size"]
    cfg["epochs"] = RECOMMENDED["epochs"] if epochs_override is None else int(epochs_override)
    cfg["learning_rate"] = RECOMMENDED["learning_rate"]
    cfg["cutoff"] = RECOMMENDED["cutoff"]
    cfg.setdefault("model", {})
    cfg["model"].update(RECOMMENDED["model"])
    dump_json(out_cfg, cfg)


def run_cmd(cmd: list[str], cwd: Path) -> None:
    print("$", " ".join(cmd))
    proc = subprocess.run(cmd, cwd=str(cwd))
    if proc.returncode != 0:
        raise SystemExit(proc.returncode)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", default=".")
    parser.add_argument("--families", nargs="+", default=["oxide", "nitride"])
    parser.add_argument("--Ns", nargs="+", type=int, default=[500, 1000])
    parser.add_argument("--seeds", nargs="+", type=int, default=[0])
    parser.add_argument("--epochs-override", type=int, default=None, help="Override epochs for quick tests (e.g., 1 or 100).")
    parser.add_argument("--output-root", default="results_recommended_v2")
    parser.add_argument("--config-root", default="configs/recommended_finetune")
    parser.add_argument("--python", default=sys.executable)
    parser.add_argument("--device", default="cpu")
    parser.add_argument("--pretrained-checkpoint", default="jv_formation_energy_peratom_alignn/checkpoint_300.pt")
    parser.add_argument("--pretrained-config", default="jv_formation_energy_peratom_alignn/config.json")
    args = parser.parse_args()

    repo = Path(args.repo_root).resolve()
    finetune_script = repo / "scripts/recommended_finetune/finetune_last2_alignn_recommended.py"

    for family in args.families:
        for n in args.Ns:
            for seed in args.seeds:
                base_cfg = repo / "configs" / f"{family}_week2_N{n}_seed{seed}.finetune_last2.json"
                out_cfg = repo / args.config_root / f"{family}_week2_N{n}_seed{seed}.recommended.json"
                build_config(base_cfg, out_cfg, args.epochs_override)

                dataset_root = repo / "results" / family / f"N{n}_seed{seed}" / "dataset_root"
                output_dir = repo / args.output_root / family / f"N{n}_seed{seed}" / "finetune_last2"
                output_dir.mkdir(parents=True, exist_ok=True)

                cmd = [
                    args.python,
                    str(finetune_script),
                    "--config",
                    str(out_cfg),
                    "--output-dir",
                    str(output_dir),
                    "--dataset-root",
                    str(dataset_root),
                    "--pretrained-checkpoint",
                    str(repo / args.pretrained_checkpoint),
                    "--pretrained-config",
                    str(repo / args.pretrained_config),
                    "--device",
                    args.device,
                ]
                run_cmd(cmd, repo)


if __name__ == "__main__":
    main()
