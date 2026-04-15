from __future__ import annotations

import argparse
import json
import os
import tempfile
from pathlib import Path

DEFAULT_FAMILIES = ["oxide", "nitride"]
DEFAULT_NS = [50, 500]
REPORTING_DEPENDENCY_HINT = (
    "Week 3 summarization requires pandas and matplotlib. "
    "Install the pinned environment from `requirements/res201_train_frozen.txt` "
    "or bootstrap it with `env/bootstrap_res201_stage3_train.sh`."
)


def configure_plot_env() -> None:
    temp_root = Path(tempfile.gettempdir())
    os.environ.setdefault("MPLCONFIGDIR", str(temp_root / "matplotlib"))
    os.environ.setdefault("XDG_CACHE_HOME", str(temp_root / "xdg-cache"))
    os.environ.setdefault("FC_CACHEDIR", str(temp_root / "fontconfig"))
    Path(os.environ["MPLCONFIGDIR"]).mkdir(parents=True, exist_ok=True)
    Path(os.environ["XDG_CACHE_HOME"]).mkdir(parents=True, exist_ok=True)
    Path(os.environ["FC_CACHEDIR"]).mkdir(parents=True, exist_ok=True)


def load_reporting_dependencies():
    missing: list[str] = []
    try:
        import pandas as pd  # pylint: disable=import-error
    except Exception:  # noqa: BLE001
        missing.append("pandas")
        pd = None

    configure_plot_env()
    try:
        import matplotlib.pyplot as plt  # pylint: disable=import-error
    except Exception:  # noqa: BLE001
        missing.append("matplotlib")
        plt = None

    if missing:
        missing_text = ", ".join(missing)
        raise SystemExit(f"Missing reporting dependencies: {missing_text}. {REPORTING_DEPENDENCY_HINT}")
    return pd, plt


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def collect_fromscratch_rows(repo: Path, families: list[str], ns: list[int], run_subdir: str) -> list[dict]:
    rows: list[dict] = []
    for family in families:
        for n_value in ns:
            summary_path = repo / "results" / family / f"N{n_value}_seed0" / run_subdir / "summary.json"
            if not summary_path.exists():
                continue
            summary = load_json(summary_path)
            rows.append(
                {
                    "family": family,
                    "N": n_value,
                    "seed": 0,
                    "n_train": summary["n_train"],
                    "n_val": summary["n_val"],
                    "n_test": summary["n_test"],
                    "epochs": summary["epochs"],
                    "batch_size": summary["batch_size"],
                    "learning_rate": summary["learning_rate"],
                    "test_mae_eV_per_atom": summary["test_mae_eV_per_atom"],
                    "train_mae_eV_per_atom": summary["train_mae_eV_per_atom"],
                    "val_best_l1": summary["val_best_l1"],
                    "summary_path": str(summary_path.resolve()),
                }
            )
    return rows


def collect_finetune_seed0(repo: Path, families: list[str], ns: list[int], pd) -> "pd.DataFrame":
    rows: list[dict] = []
    for family in families:
        for n_value in ns:
            summary_path = repo / "results" / family / f"N{n_value}_seed0" / "finetune_last2" / "summary.json"
            if not summary_path.exists():
                continue
            summary = load_json(summary_path)
            rows.append(
                {
                    "family": family,
                    "N": n_value,
                    "finetune_seed0_test_mae_eV_per_atom": summary["test_mae_eV_per_atom"],
                }
            )
    return pd.DataFrame(rows)


def collect_zero_shot(repo: Path, families: list[str], pd) -> "pd.DataFrame":
    rows: list[dict] = []
    for family in families:
        summary_path = repo / "results" / family / "zero_shot" / "summary.json"
        if not summary_path.exists():
            continue
        summary = load_json(summary_path)
        rows.append(
            {
                "family": family,
                "zero_shot_mae_eV_per_atom": summary["mae_eV_per_atom"],
            }
        )
    return pd.DataFrame(rows)


def plot_family_comparison(df: "pd.DataFrame", family: str, out_png: Path, out_pdf: Path, plt) -> None:
    family_df = df[df["family"] == family].sort_values("N")
    if family_df.empty:
        return

    plt.figure(figsize=(7, 4.5))
    plt.plot(family_df["N"], family_df["test_mae_eV_per_atom"], marker="o", linewidth=2, label="From scratch")
    if "finetune_seed0_test_mae_eV_per_atom" in family_df:
        plt.plot(
            family_df["N"],
            family_df["finetune_seed0_test_mae_eV_per_atom"],
            marker="s",
            linewidth=2,
            label="Fine-tune (seed0)",
        )
    if family_df["zero_shot_mae_eV_per_atom"].notna().any():
        zero = float(family_df["zero_shot_mae_eV_per_atom"].dropna().iloc[0])
        plt.axhline(zero, linestyle="--", color="tab:red", label=f"Zero-shot ({zero:.4f})")

    plt.xscale("log")
    plt.xticks(family_df["N"], [str(v) for v in family_df["N"]])
    plt.xlabel("Training size N")
    plt.ylabel("Test MAE (eV/atom)")
    plt.title(f"{family.capitalize()} Week 3 Baseline Comparison")
    plt.grid(alpha=0.3)
    plt.legend()
    plt.tight_layout()
    out_png.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(out_png, dpi=200)
    plt.savefig(out_pdf)
    plt.close()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", default=".")
    parser.add_argument("--families", nargs="+", default=DEFAULT_FAMILIES)
    parser.add_argument("--Ns", nargs="+", type=int, default=DEFAULT_NS)
    parser.add_argument("--run-subdir", default="train_alignn_fromscratch")
    parser.add_argument("--out-dir", default="reports/week3_fromscratch_baseline")
    args = parser.parse_args()
    pd, plt = load_reporting_dependencies()

    repo = Path(args.repo_root).resolve()
    out_dir = (repo / args.out_dir).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    rows = collect_fromscratch_rows(repo, args.families, args.Ns, args.run_subdir)
    if not rows:
        raise SystemExit("No from-scratch summaries found.")

    runs_df = pd.DataFrame(rows).sort_values(["family", "N"]).reset_index(drop=True)
    finetune_df = collect_finetune_seed0(repo, args.families, args.Ns, pd)
    zero_df = collect_zero_shot(repo, args.families, pd)

    merged = runs_df.merge(finetune_df, on=["family", "N"], how="left").merge(zero_df, on="family", how="left")
    merged["gain_vs_zero_shot"] = merged["zero_shot_mae_eV_per_atom"] - merged["test_mae_eV_per_atom"]
    merged["gain_vs_finetune_seed0"] = (
        merged["finetune_seed0_test_mae_eV_per_atom"] - merged["test_mae_eV_per_atom"]
    )

    runs_csv = out_dir / "fromscratch_runs.csv"
    summary_csv = out_dir / "fromscratch_summary.csv"
    manifest_json = out_dir / "week3_fromscratch_manifest.json"

    runs_df.to_csv(runs_csv, index=False)
    merged.to_csv(summary_csv, index=False)

    for family in args.families:
        plot_family_comparison(
            merged,
            family,
            out_dir / f"{family}_fromscratch_comparison.png",
            out_dir / f"{family}_fromscratch_comparison.pdf",
            plt,
        )

    manifest = {
        "run_subdir": args.run_subdir,
        "runs_csv": str(runs_csv),
        "summary_csv": str(summary_csv),
        "plots": {
            family: {
                "png": str((out_dir / f"{family}_fromscratch_comparison.png").resolve()),
                "pdf": str((out_dir / f"{family}_fromscratch_comparison.pdf").resolve()),
            }
            for family in args.families
        },
    }
    manifest_json.write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    print(json.dumps(manifest, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
