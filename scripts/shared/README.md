# Shared Script Guide

This folder contains reusable training, evaluation, reporting, plotting, and validation scripts for the ALIGNN domain-shift experiments.

The filenames are intentionally descriptive. Most scripts follow this pattern:

- `Run_*`: launch a training workflow or experiment suite
- `Preflight_*`: check that the runtime has the expected packages, CUDA support, and input files before training
- `Check_*`: verify that expected outputs, summaries, plots, and manifests exist after a run
- `Generate_*`: build report bundles or derived artifacts
- `Summarize_*`: aggregate run-level results into CSV/JSON/LaTeX report files
- `Plot_*`: create figures from existing logs, summaries, or predictions

## Hyperparameter Sets

The report and experiment scripts use these set numbers:

| Set | Meaning | Epochs | Batch size | Learning rate |
| --- | --- | ---: | ---: | ---: |
| `Hyperparameter Set 1` | Professor-advice setting | `50` | `16` | `0.0001` |
| `Hyperparameter Set 2` | ALIGNN-recommended setting | `300` | `64` | `0.001` |
| `Hyperparameter Set 3` | Additional low-learning-rate setting | `100` | `32` | `0.00005` |

## Main Training Engines

These are the core model-running scripts. Other pipeline/suite scripts call into these.

| Script | Purpose |
| --- | --- |
| `Fine_Tune_Last_Two_ALIGNN_Layers.py` | Fine-tunes only the last ALIGNN GCN block and the final fully connected layer while keeping the rest of the pretrained model frozen. This is the main fine-tuning engine. |
| `Train_ALIGNN_From_Scratch.py` | Trains an ALIGNN model from random initialization using the configured architecture and data split. |
| `Evaluate_ALIGNN_Zero_Shot.py` | Evaluates the pretrained ALIGNN model without additional training. |
| `Fine_Tune_Last_Two_ALIGNN_Layers_Draft_ALIGNN_Hyperparameters.py` | Draft/legacy fine-tuning variant kept for provenance around early ALIGNN-hyperparameter experiments. |

## Fine-Tuning Pipelines And Suites

Use these when running fine-tuning experiments.

| Script | Purpose |
| --- | --- |
| `Run_Finetuning_Original_Baseline_Suite.py` | Original baseline fine-tuning suite for the `Results_Before_Correction/` namespace. |
| `Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Pipeline.sh` | Colab pipeline wrapper for 5-seed fine-tuning with Hyperparameter Set 2. |
| `Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Suite.py` | Python suite for the 5-seed Hyperparameter Set 2 fine-tuning runs. |
| `Run_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Smoke_Test.sh` | Smoke-test wrapper for the Hyperparameter Set 2 Colab fine-tuning workflow. |
| `Run_Finetuning_Hyperparameter_Set_3_Pipeline.sh` | Pipeline wrapper for Hyperparameter Set 3 fine-tuning. |
| `Run_Finetuning_Hyperparameter_Set_3_Suite.py` | Python suite for Hyperparameter Set 3 fine-tuning runs. |
| `Run_Finetuning_Draft_ALIGNN_Hyperparameters_Pipeline.sh` | Draft/legacy ALIGNN-hyperparameter fine-tuning pipeline. |
| `Run_Finetuning_Draft_ALIGNN_Hyperparameters_Suite.py` | Draft/legacy Python suite for the same experimental path. |
| `Run_Finetuning_Draft_ALIGNN_Hyperparameters_Smoke_Test.sh` | Smoke-test wrapper for the draft ALIGNN-hyperparameter path. |

## From-Scratch Pipelines And Suites

Use these when running random-initialization from-scratch experiments.

| Script | Purpose |
| --- | --- |
| `Run_From_Scratch_Suite.py` | Generic from-scratch run orchestrator used by hyperparameter-specific wrappers. |
| `Run_From_Scratch_Hyperparameter_Set_2_Pipeline.sh` | Pipeline wrapper for from-scratch training with Hyperparameter Set 2. |
| `Run_From_Scratch_Hyperparameter_Set_2_Smoke_Test.sh` | Smoke-test wrapper for the Hyperparameter Set 2 from-scratch workflow. |
| `Run_From_Scratch_Hyperparameter_Set_3_Pipeline.sh` | Pipeline wrapper for from-scratch training with Hyperparameter Set 3. |
| `Run_From_Scratch_Hyperparameter_Set_3_Suite.py` | Python suite wrapper for Hyperparameter Set 3 from-scratch runs. |

## Preflight Checks

Preflight scripts are intended to be run before expensive Colab/A100 training jobs. They check environment and input readiness.

| Script | Purpose |
| --- | --- |
| `Preflight_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py` | Preflight for the Hyperparameter Set 2 Colab fine-tuning workflow. |
| `Preflight_Finetuning_Hyperparameter_Set_3.py` | Preflight for Hyperparameter Set 3 fine-tuning. |
| `Preflight_From_Scratch_Hyperparameter_Set_2.py` | Preflight for Hyperparameter Set 2 from-scratch training. |
| `Preflight_From_Scratch_Hyperparameter_Set_3.py` | Preflight for Hyperparameter Set 3 from-scratch training. |
| `Preflight_Finetuning_Draft_ALIGNN_Hyperparameters.py` | Preflight for the draft/legacy ALIGNN-hyperparameter fine-tuning workflow. |

## Status Checks

Status scripts verify that completed runs produced the expected summaries, plots, and manifests.

| Script | Purpose |
| --- | --- |
| `Check_Week1_Baseline_Status.sh` | Checks the older Week 1 baseline outputs. |
| `Check_Finetuning_Original_Baseline_Status.sh` | Checks the original Week 2 baseline fine-tuning outputs. |
| `Check_Finetuning_Imported_Namespace_Status.sh` | Generic checker for imported fine-tuning namespaces such as Hyperparameter Sets 1 and 2. |
| `Check_Finetuning_Hyperparameter_Set_2_Colab_5Seed_Status.sh` | Checks the Colab 5-seed Hyperparameter Set 2 fine-tuning outputs. |
| `Check_Finetuning_Hyperparameter_Set_3_Status.sh` | Checks Hyperparameter Set 3 fine-tuning outputs. |
| `Check_From_Scratch_Imported_Namespace_Status.sh` | Generic checker for imported from-scratch namespaces such as Hyperparameter Sets 1 and 2. |
| `Check_From_Scratch_Hyperparameter_Set_2_Status.sh` | Checks Hyperparameter Set 2 from-scratch outputs. |
| `Check_From_Scratch_Hyperparameter_Set_3_Status.sh` | Checks Hyperparameter Set 3 from-scratch outputs. |
| `Check_Finetuning_Draft_ALIGNN_Hyperparameters_Status.sh` | Checks the draft/legacy ALIGNN-hyperparameter fine-tuning outputs. |

## Report Generation And Summaries

These scripts produce aggregate report artifacts under `reports/`.

| Script | Purpose |
| --- | --- |
| `Generate_Finetuning_Report_Hyperparameter_Set_1.sh` | Builds fine-tuning report artifacts for Hyperparameter Set 1. |
| `Generate_Finetuning_Report_Hyperparameter_Set_2.sh` | Builds fine-tuning report artifacts for Hyperparameter Set 2. |
| `Generate_From_Scratch_Report_Hyperparameter_Set_1.sh` | Builds from-scratch report artifacts for Hyperparameter Set 1. |
| `Generate_From_Scratch_Report_Hyperparameter_Set_2.sh` | Builds from-scratch report artifacts for Hyperparameter Set 2. |
| `Generate_Finetuning_Parity_Plots.py` | Creates true-vs-predicted parity plots from best-checkpoint test predictions. |
| `Summarize_Finetuning_Reports.py` | Aggregates fine-tuning run summaries into report CSV/JSON/LaTeX files and learning curves. |
| `Summarize_Finetuning_Hyperparameter_Set_2_Colab_5Seed.py` | Historical summarizer for the Colab 5-seed Hyperparameter Set 2 fine-tuning bundle. |
| `Summarize_Finetuning_Draft_ALIGNN_Hyperparameters.py` | Draft/legacy fine-tuning summarizer. |
| `Summarize_From_Scratch_Reports.py` | Aggregates from-scratch run summaries and creates comparison plots. |
| `Summarize_From_Scratch_Zero_Shot_Only.py` | Variant from-scratch summarizer that compares only against zero-shot rather than fine-tuning. |

## Plotting Utilities

These create figures from existing results and summaries. They do not train models.

| Script | Purpose |
| --- | --- |
| `Plot_Finetuning_Learning_Curves_By_Hyperparameter_Set.py` | Regenerates named fine-tuning learning curves for hyperparameter-set report folders. |
| `Plot_Finetuning_Training_Curves.py` | Creates per-run fine-tuning training curves and family-level grids. |
| `Plot_Finetuning_Training_Curves_Hyperparameter_Set_2_Colab_5Seed.py` | Historical plotting helper for the Colab 5-seed Hyperparameter Set 2 fine-tuning bundle. |
| `Plot_Finetuning_Training_Curves_Draft_ALIGNN_Hyperparameters.py` | Draft/legacy fine-tuning training-curve plotter. |
| `Plot_From_Scratch_Training_Curves.py` | Creates per-run from-scratch training curves and family-level grids. |
| `Plot_Finetuning_Vs_From_Scratch_Comparison.py` | Creates 5-seed fine-tuning mean/std vs 5-seed from-scratch mean/std comparison plots. |

## Dataset, Config, And Utility Scripts

These support setup, diagnostics, and reproducibility.

| Script | Purpose |
| --- | --- |
| `Prepare_Week1_Finetuning_Dataset.py` | Prepares the Week 1 fine-tuning dataset layout. |
| `Write_Week1_ALIGNN_Config.py` | Writes ALIGNN config files for early Week 1 experiments. |
| `Inspect_ALIGNN_Model.py` | Inspects the pretrained ALIGNN model structure. |
| `Save_Pretrained_ALIGNN_State_Dict.py` | Extracts/saves pretrained ALIGNN state-dict information. |
| `Generate_Workspace_Inventory.py` | Creates an inventory of workspace artifacts. |
| `Reorganize_Reports_By_Hyperparameter_Set.py` | One-time helper that reorganized report outputs into `Hyperparameter Set 1/2/3` folders. |

## Recommended Usage Pattern

For new training on Colab, the safest order is:

1. Run the matching `Preflight_*` script.
2. Run the matching `Run_*_Pipeline.sh` wrapper.
3. Run the matching `Check_*_Status.sh` script.
4. Regenerate reports only if new results were added.

For local report work, prefer the `Generate_*`, `Summarize_*`, and `Plot_*` scripts rather than rerunning model training.
