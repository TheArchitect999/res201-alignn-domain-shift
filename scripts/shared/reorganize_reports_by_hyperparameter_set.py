from __future__ import annotations

import argparse
import csv
import json
import shutil
import subprocess
import sys
from pathlib import Path


SET_CONFIGS = [
    {
        "number": 1,
        "hyperparameters": {"epochs": 50, "batch_size": 16, "learning_rate": 0.0001},
        "week2_dir": "reports/week2_prof_advice",
        "week3_dir": "reports/week3_fromscratch_prof_advice",
        "results_root": "results_prof_advice",
        "finetune_run_subdir": "finetune_last2",
        "fromscratch_run_subdir": "train_alignn_fromscratch",
        "finetune_ns": [10, 50, 100, 200, 500, 1000],
        "fromscratch_ns": [50, 500],
        "seeds": [0, 1, 2, 3, 4],
        "protocol_note_finetune": "pretrained ALIGNN with partial fine-tuning only",
        "protocol_note_fromscratch": "randomly initialized ALIGNN trained from scratch",
    },
    {
        "number": 2,
        "hyperparameters": {"epochs": 300, "batch_size": 64, "learning_rate": 0.001},
        "week2_dir": "reports/week2_prof_advice_alignn_recommended",
        "week3_dir": "reports/week3_fromscratch_alignn_recommended",
        "results_root": "results_prof_advice_alignn_recommended",
        "finetune_run_subdir": "finetune_last2",
        "fromscratch_run_subdir": "train_alignn_fromscratch",
        "finetune_ns": [10, 50, 100, 200, 500, 1000],
        "fromscratch_ns": [50, 500],
        "seeds": [0, 1, 2, 3, 4],
        "protocol_note_finetune": "pretrained ALIGNN with partial fine-tuning only",
        "protocol_note_fromscratch": "randomly initialized ALIGNN trained from scratch",
    },
    {
        "number": 3,
        "hyperparameters": {"epochs": 100, "batch_size": 32, "learning_rate": 0.00005},
        "week2_dir": "reports/week2_last2_epochs100_bs32_lr5e5",
        "week3_dir": "reports/week3_fromscratch_epochs100_bs32_lr5e5",
        "results_root": "results",
        "finetune_run_subdir": "finetune_last2_epochs100_bs32_lr5e5",
        "fromscratch_run_subdir": "train_alignn_fromscratch_epochs100_bs32_lr5e5",
        "finetune_ns": [10, 50, 100, 200, 500, 1000],
        "fromscratch_ns": [50, 500],
        "seeds": [0, 1, 2, 3, 4],
        "protocol_note_finetune": "pretrained ALIGNN with partial fine-tuning only",
        "protocol_note_fromscratch": "randomly initialized ALIGNN trained from scratch",
    },
]


def repo_relative(repo: Path, path: Path) -> str:
    return str(path.resolve().relative_to(repo.resolve()))


def write_text(path: Path, lines: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def run_command(repo: Path, args: list[str]) -> None:
    subprocess.run(args, cwd=repo, check=True)


def replace_prefix(value: str, old_prefix: str, new_prefix: str) -> str:
    if value.startswith(old_prefix):
        return new_prefix + value[len(old_prefix) :]
    return value


def update_csv_paths(path: Path, fieldnames: list[str], old_prefix: str, new_prefix: str) -> None:
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
        reader_fieldnames = rows[0].keys() if rows else fieldnames
    for row in rows:
        for field in fieldnames:
            row[field] = replace_prefix(row[field], old_prefix, new_prefix)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(reader_fieldnames))
        writer.writeheader()
        writer.writerows(rows)


def update_json_paths(path: Path, old_prefix: str, new_prefix: str) -> None:
    data = json.loads(path.read_text())

    def rewrite(value):
        if isinstance(value, str):
            return replace_prefix(value, old_prefix, new_prefix)
        if isinstance(value, list):
            return [rewrite(item) for item in value]
        if isinstance(value, dict):
            return {key: rewrite(item) for key, item in value.items()}
        return value

    path.write_text(json.dumps(rewrite(data), indent=2) + "\n", encoding="utf-8")


def move_file(source: Path, destination: Path) -> None:
    if not source.exists():
        return
    destination.parent.mkdir(parents=True, exist_ok=True)
    if destination.exists():
        if destination.is_dir():
            shutil.rmtree(destination)
        else:
            destination.unlink()
    shutil.move(str(source), str(destination))


def generate_finetune_training_curves(repo: Path, cfg: dict, out_dir: Path) -> None:
    run_command(
        repo,
        [
            sys.executable,
            "scripts/shared/plot_week2_training_curves.py",
            "--repo-root",
            ".",
            "--results-root",
            cfg["results_root"],
            "--run-subdir",
            cfg["finetune_run_subdir"],
            "--families",
            "oxide",
            "nitride",
            "--Ns",
            *[str(n_value) for n_value in cfg["finetune_ns"]],
            "--seeds",
            *[str(seed) for seed in cfg["seeds"]],
            "--out-dir",
            repo_relative(repo, out_dir),
            "--title-label",
            f"Hyperparameter Set {cfg['number']} Finetuning",
            "--protocol-note",
            (
                f"pretrained ALIGNN with partial fine-tuning only; "
                f"epochs={cfg['hyperparameters']['epochs']}, "
                f"batch_size={cfg['hyperparameters']['batch_size']}, "
                f"learning_rate={cfg['hyperparameters']['learning_rate']}"
            ),
        ],
    )


def generate_fromscratch_training_curves(repo: Path, cfg: dict, out_dir: Path) -> None:
    run_command(
        repo,
        [
            sys.executable,
            "scripts/shared/plot_week3_training_curves.py",
            "--repo-root",
            ".",
            "--results-root",
            cfg["results_root"],
            "--run-subdir",
            cfg["fromscratch_run_subdir"],
            "--families",
            "oxide",
            "nitride",
            "--Ns",
            *[str(n_value) for n_value in cfg["fromscratch_ns"]],
            "--seeds",
            *[str(seed) for seed in cfg["seeds"]],
            "--out-dir",
            repo_relative(repo, out_dir),
            "--title-label",
            f"Hyperparameter Set {cfg['number']} From-Scratch",
            "--protocol-note",
            (
                f"randomly initialized ALIGNN trained from scratch; "
                f"epochs={cfg['hyperparameters']['epochs']}, "
                f"batch_size={cfg['hyperparameters']['batch_size']}, "
                f"learning_rate={cfg['hyperparameters']['learning_rate']}"
            ),
        ],
    )


def rewrite_week2_manifest(path: Path, cfg: dict, set_root: Path, repo: Path) -> None:
    manifest = json.loads(path.read_text())
    finetune_summary_dir = set_root / "Summaries" / "Finetuning"
    learning_dir = set_root / "Learning Curves"
    manifest["runs_csv"] = repo_relative(repo, finetune_summary_dir / "finetune_runs.csv")
    manifest["summary_csv"] = repo_relative(repo, finetune_summary_dir / "finetune_summary_by_N.csv")
    manifest["wide_csv"] = repo_relative(repo, finetune_summary_dir / "finetune_summary_wide.csv")
    manifest["zero_csv"] = repo_relative(repo, finetune_summary_dir / "zero_shot_summary.csv")
    manifest["latex_table"] = repo_relative(repo, finetune_summary_dir / "finetune_summary_table.tex")
    manifest["progress_manifest"] = repo_relative(repo, finetune_summary_dir / "progress_manifest.json")
    manifest["plots"] = {
        "oxide": {
            "png": repo_relative(repo, learning_dir / f"Oxide Learning Curve - Hyperparameter Set {cfg['number']}.png"),
            "pdf": repo_relative(repo, learning_dir / f"Oxide Learning Curve - Hyperparameter Set {cfg['number']}.pdf"),
        },
        "nitride": {
            "png": repo_relative(repo, learning_dir / f"Nitride Learning Curve - Hyperparameter Set {cfg['number']}.png"),
            "pdf": repo_relative(repo, learning_dir / f"Nitride Learning Curve - Hyperparameter Set {cfg['number']}.pdf"),
        },
    }
    path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")


def rewrite_week3_manifest(path: Path, cfg: dict, set_root: Path, repo: Path) -> None:
    manifest = json.loads(path.read_text())
    summary_dir = set_root / "Summaries" / "From Scratch"
    comparison_dir = set_root / "Comparison Plots"
    manifest["runs_csv"] = repo_relative(repo, summary_dir / "fromscratch_runs.csv")
    manifest["summary_csv"] = repo_relative(repo, summary_dir / "fromscratch_summary.csv")
    manifest["plots"] = {
        "oxide": {
            "png": repo_relative(repo, comparison_dir / f"Oxide Comparison Plot - Hyperparameter Set {cfg['number']}.png"),
            "pdf": repo_relative(repo, comparison_dir / f"Oxide Comparison Plot - Hyperparameter Set {cfg['number']}.pdf"),
        },
        "nitride": {
            "png": repo_relative(repo, comparison_dir / f"Nitride Comparison Plot - Hyperparameter Set {cfg['number']}.png"),
            "pdf": repo_relative(repo, comparison_dir / f"Nitride Comparison Plot - Hyperparameter Set {cfg['number']}.pdf"),
        },
    }
    path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")


def rewrite_folder_readmes(set_root: Path, cfg: dict) -> None:
    hp = cfg["hyperparameters"]
    write_text(
        set_root / "README.md",
        [
            f"# Hyperparameter Set {cfg['number']}",
            "",
            f"- epochs: `{hp['epochs']}`",
            f"- batch size: `{hp['batch_size']}`",
            f"- learning rate: `{hp['learning_rate']}`",
            "",
            "This folder groups the fine-tuning and from-scratch report artifacts for one hyperparameter family.",
            "",
            "Subfolders:",
            "- `Learning Curves`: aggregate test-MAE-vs-N plots for fine-tuning",
            "- `Training Curves`: per-run epoch-history plots, split into `Finetuning` and `From Scratch`",
            "- `Comparison Plots`: 5-seed fine-tune mean +/- std versus 5-seed from-scratch mean +/- std, plus zero-shot",
            "- `Parity Plots`: true versus predicted formation-energy scatter plots by domain family and N",
            "- `Summaries`: CSV, JSON, and LaTeX summary artifacts for both fine-tuning and from-scratch runs",
        ],
    )
    write_text(
        set_root / "Learning Curves" / "README.md",
        [
            "# Learning Curves",
            "",
            "These plots summarize fine-tuning performance across all available N sizes for oxide and nitride.",
            "",
            "Files in this folder:",
            "- one PNG and one PDF for oxide",
            "- one PNG and one PDF for nitride",
        ],
    )
    write_text(
        set_root / "Comparison Plots" / "README.md",
        [
            "# Comparison Plots",
            "",
            "These plots compare 5-seed fine-tuning mean +/- std against 5-seed from-scratch mean +/- std at matching N values, with the zero-shot baseline as a reference line.",
            "",
            "Coverage:",
            "- oxide, N=50 and N=500",
            "- nitride, N=50 and N=500",
        ],
    )
    write_text(
        set_root / "Parity Plots" / "README.md",
        [
            "# Parity Plots",
            "",
            "These parity plots compare ground-truth formation energy on the x-axis to predicted formation energy on the y-axis.",
            "",
            "Each plot is built from `prediction_results_test_set.csv` outputs produced from the best validation checkpoint for each seed.",
            "",
            f"For Hyperparameter Set {cfg['number']}, the plotted prediction is the mean test prediction across seeds `0..4` for each `{{family, N}}` combination.",
            "",
            f"- epochs: `{hp['epochs']}`",
            f"- batch size: `{hp['batch_size']}`",
            f"- learning rate: `{hp['learning_rate']}`",
            "",
            "See `parity_plot_manifest.csv` for file paths and summary metrics.",
        ],
    )
    write_text(
        set_root / "Training Curves" / "README.md",
        [
            "# Training Curves",
            "",
            "This folder separates training-history plots by training protocol.",
            "",
            "Subfolders:",
            "- `Finetuning`: partial fine-tuning runs across all N values",
            "- `From Scratch`: randomly initialized ALIGNN runs for N=50 and N=500",
        ],
    )
    write_text(
        set_root / "Summaries" / "README.md",
        [
            "# Summaries",
            "",
            "This folder contains the CSV, JSON, and LaTeX summary artifacts that back the figures in this hyperparameter family.",
            "",
            "Subfolders:",
            "- `Finetuning`: week-2 fine-tuning summaries and manifests",
            "- `From Scratch`: week-3 from-scratch summaries and manifests",
        ],
    )
    write_text(
        set_root / "Summaries" / "Finetuning" / "README.md",
        [
            "# Finetuning Summaries",
            "",
            "These files summarize the week-2 fine-tuning runs for this hyperparameter set, including run-level tables, grouped summaries, and manifest files for the learning curves.",
        ],
    )
    write_text(
        set_root / "Summaries" / "From Scratch" / "README.md",
        [
            "# From-Scratch Summaries",
            "",
            "These files summarize the week-3 from-scratch runs for this hyperparameter set, including run-level tables, grouped summaries, and manifest files for the comparison plots.",
        ],
    )


def reorganize_set(repo: Path, cfg: dict) -> None:
    reports_dir = repo / "reports"
    set_root = reports_dir / f"Hyperparameter Set {cfg['number']}"
    if set_root.exists():
        raise SystemExit(f"Target already exists: {set_root}")

    learning_dir = set_root / "Learning Curves"
    comparison_dir = set_root / "Comparison Plots"
    parity_dir = set_root / "Parity Plots"
    finetune_training_dir = set_root / "Training Curves" / "Finetuning"
    fromscratch_training_dir = set_root / "Training Curves" / "From Scratch"
    finetune_summary_dir = set_root / "Summaries" / "Finetuning"
    fromscratch_summary_dir = set_root / "Summaries" / "From Scratch"

    for path in [
        learning_dir,
        comparison_dir,
        parity_dir,
        finetune_training_dir,
        fromscratch_training_dir,
        finetune_summary_dir,
        fromscratch_summary_dir,
    ]:
        path.mkdir(parents=True, exist_ok=True)

    generate_finetune_training_curves(repo, cfg, finetune_training_dir)
    generate_fromscratch_training_curves(repo, cfg, fromscratch_training_dir)

    week2_dir = repo / cfg["week2_dir"]
    week3_dir = repo / cfg["week3_dir"]

    move_file(
        week2_dir / f"Oxide Learning Curve - Hyperparameter Set {cfg['number']}.png",
        learning_dir / f"Oxide Learning Curve - Hyperparameter Set {cfg['number']}.png",
    )
    move_file(
        week2_dir / f"Oxide Learning Curve - Hyperparameter Set {cfg['number']}.pdf",
        learning_dir / f"Oxide Learning Curve - Hyperparameter Set {cfg['number']}.pdf",
    )
    move_file(
        week2_dir / f"Nitride Learning Curve - Hyperparameter Set {cfg['number']}.png",
        learning_dir / f"Nitride Learning Curve - Hyperparameter Set {cfg['number']}.png",
    )
    move_file(
        week2_dir / f"Nitride Learning Curve - Hyperparameter Set {cfg['number']}.pdf",
        learning_dir / f"Nitride Learning Curve - Hyperparameter Set {cfg['number']}.pdf",
    )

    for filename in [
        "finetune_runs.csv",
        "finetune_summary_by_N.csv",
        "finetune_summary_table.tex",
        "finetune_summary_wide.csv",
        "progress_manifest.json",
        "week2_summary_manifest.json",
        "zero_shot_summary.csv",
        "run_suite_summary.json",
    ]:
        move_file(week2_dir / filename, finetune_summary_dir / filename)

    parity_source_dir = week2_dir / "parity_plots"
    if parity_source_dir.exists():
        for child in sorted(parity_source_dir.iterdir()):
            move_file(child, parity_dir / child.name)

    move_file(
        week3_dir / f"Oxide Comparison Plot - Hyperparameter Set {cfg['number']}.png",
        comparison_dir / f"Oxide Comparison Plot - Hyperparameter Set {cfg['number']}.png",
    )
    move_file(
        week3_dir / f"Oxide Comparison Plot - Hyperparameter Set {cfg['number']}.pdf",
        comparison_dir / f"Oxide Comparison Plot - Hyperparameter Set {cfg['number']}.pdf",
    )
    move_file(
        week3_dir / f"Nitride Comparison Plot - Hyperparameter Set {cfg['number']}.png",
        comparison_dir / f"Nitride Comparison Plot - Hyperparameter Set {cfg['number']}.png",
    )
    move_file(
        week3_dir / f"Nitride Comparison Plot - Hyperparameter Set {cfg['number']}.pdf",
        comparison_dir / f"Nitride Comparison Plot - Hyperparameter Set {cfg['number']}.pdf",
    )

    for filename in [
        "fromscratch_runs.csv",
        "fromscratch_summary.csv",
        "run_suite_summary.json",
        "week3_fromscratch_manifest.json",
    ]:
        move_file(week3_dir / filename, fromscratch_summary_dir / filename)

    rewrite_week2_manifest(finetune_summary_dir / "week2_summary_manifest.json", cfg, set_root, repo)
    rewrite_week3_manifest(fromscratch_summary_dir / "week3_fromscratch_manifest.json", cfg, set_root, repo)

    update_csv_paths(
        parity_dir / "parity_plot_manifest.csv",
        ["png", "pdf"],
        f"{cfg['week2_dir']}/parity_plots/",
        f"reports/Hyperparameter Set {cfg['number']}/Parity Plots/",
    )
    update_json_paths(
        parity_dir / "parity_plot_manifest.json",
        f"{cfg['week2_dir']}/parity_plots/",
        f"reports/Hyperparameter Set {cfg['number']}/Parity Plots/",
    )

    rewrite_folder_readmes(set_root, cfg)

    if week2_dir.exists():
        shutil.rmtree(week2_dir)
    if week3_dir.exists():
        shutil.rmtree(week3_dir)


def write_root_readme(repo: Path) -> None:
    write_text(
        repo / "reports" / "README.md",
        [
            "# Reports",
            "",
            "This folder contains both the preserved historical report artifacts and the reorganized hyperparameter-set bundles.",
            "",
            "Preserved items at the top level:",
            "- `provenance/`",
            "- `week2/`",
            "- `week1_report.tex`",
            "- `week2_report.tex`",
            "",
            "Reorganized bundles:",
            "- `Hyperparameter Set 1/`",
            "- `Hyperparameter Set 2/`",
            "- `Hyperparameter Set 3/`",
        ],
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", default=".")
    args = parser.parse_args()

    repo = Path(args.repo_root).resolve()
    for cfg in SET_CONFIGS:
        reorganize_set(repo, cfg)
    write_root_readme(repo)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
