# Figure Memo: Fig. 01 Study Design Schematic

## Metadata

- Figure label: `FIG_SCHEMATIC`
- Source figure: `reports/final_paper_factory/02_figure_memos/core_figures/FIG_SCHEMATIC.png`
- Canonical source path: repo-created study schematic (`figure_queue.csv` lists source as `to_be_created`)
- Linked table: `none`
- Report membership: `all`
- Placement: `main_text`
- External analysis inputs:
  - `c:\Users\lenovo\Desktop\Claude Figure Memo.txt`

## What The Figure Shows

This figure is a study-design schematic for the full project. It defines the two dataset families, the shared pretrained starting point, the three protocol arms, and the main downstream outputs.

The left side of the panel identifies the two dataset families and their split counts:

- Oxide family (`in-distribution control`): All `14991`, Pool `13507`, Train `11960`, Val `1547`, Test `1484`
- Nitride family (`out-of-distribution test`): All `2288`, Pool `2046`, Train `1837`, Val `209`, Test `242`

The center and right side of the panel show the three experimental arms branching from the same pretrained formation-energy ALIGNN model:

- `1) Zero-shot evaluation`: direct evaluation on the oxide and nitride test sets with no fine-tuning
- `2) Fine-tuning (Set 1)`: transfer learning on both families with `N_train in {10, 50, 100, 200, 500, 1000}`
- `3) From-scratch training`: no pretraining, with `N_train in {50, 500}`

The bottom strip lists the planned outputs and analyses:

- Error metrics (`MAE`)
- Parity plots (`selected N`)
- Learning curves (`vs. N_train`)
- Transfer benefit (`vs. scratch`, `N = 50, 500 only`)
- Embedding analysis (`representation geometry`)

The schematic also states the main narrative framing directly in the legend:

- Oxide = in-distribution control, chemically close to the pretraining distribution
- Nitride = out-of-distribution test, chemically distant from the pretraining distribution
- Goal: quantify domain-shift penalty, data-efficiency under fine-tuning, and the role of representation geometry
- Hyperparameter Set 1: `epochs = 50`, `batch_size = 16`, `learning_rate = 0.0001`

## Justified Interpretation

The safest interpretation is that this figure defines the project as a controlled domain-shift comparison rather than as two unrelated experiments. Oxides and nitrides are routed through the same overall workflow, using the same pretrained starting point for zero-shot and fine-tuning and the same Hyperparameter Set 1 for the main narrative. That makes later oxide-versus-nitride comparisons interpretable as family-level contrasts under a matched protocol.

The schematic also justifies an important scope guard for later report writing: from-scratch baselines are part of the design, but they are explicitly limited to `N = 50` and `N = 500`. Likewise, embedding analysis is presented as a planned output of the workflow rather than as a post-hoc appendix add-on. Those are design-level commitments the later report can rely on.

This is therefore a framing figure, not an evidence figure. Its value is that it makes the logic of the paper visible early: zero-shot establishes baseline transferability, fine-tuning tests data efficiency and adaptation, from-scratch isolates pretraining value at matched budgets, and embedding analysis provides the mechanism-oriented interpretation layer.

## Non-Claims / Cautions

- This figure does not show any empirical performance outcome by itself.
- This figure does not establish that oxide performs better than nitride; later results figures must do that.
- The small learning-curve and parity-style drawings inside the workflow boxes are schematic illustrations, not data.
- This figure does not justify transfer-benefit claims outside `N = 50` and `N = 500`, because from-scratch is only shown at those two budgets.
- This figure does not prove that domain shift exists in measured outcomes; it only defines the control-versus-shift study design.
- This figure does not compare hyperparameter settings; it only states that the main narrative uses Hyperparameter Set 1.
- This figure should not be used to describe the checkpoint as "oxide-pretrained"; the correct wording is the pretrained formation-energy ALIGNN model.

## Caption Draft

Figure 1. Study design for evaluating chemical-family domain shift in a pretrained formation-energy ALIGNN model. Oxides are treated as the in-distribution control family and nitrides as the out-of-distribution test family. A shared pretrained model is used for zero-shot evaluation and Set 1 fine-tuning, while from-scratch training is run without pretraining. Fine-tuning is performed at `N_train in {10, 50, 100, 200, 500, 1000}` for both families, whereas from-scratch baselines are limited to `N_train in {50, 500}`. The planned outputs are MAE error metrics, parity plots, learning curves, transfer-benefit comparisons, and embedding analysis. Dataset split counts shown in the figure are `14991/13507/11960/1547/1484` for oxides and `2288/2046/1837/209/242` for nitrides (All/Pool/Train/Val/Test). All main-text runs use Hyperparameter Set 1: `epochs = 50`, `batch_size = 16`, `learning_rate = 0.0001`.

## Results Paragraph Draft

Figure 1 summarizes the study design used throughout the paper. Both oxide and nitride subsets are evaluated from the same pretrained formation-energy ALIGNN starting point for zero-shot and fine-tuning, while a matched from-scratch arm is used at `N = 50` and `N = 500` to isolate pretraining value. This structure makes it possible to compare baseline transferability, data efficiency under fine-tuning, transfer benefit relative to random initialization, and the role of representation geometry under a single controlled workflow. The figure is descriptive of the experimental design rather than evidence of empirical outcomes.

## Discussion Paragraph Draft

The schematic matters because it isolates chemical-family identity as the central comparison axis while holding the main workflow fixed across both families. That makes later oxide-versus-nitride contrasts easier to interpret: differences in zero-shot behavior, fine-tuning response, transfer benefit, and embedding-distance evidence can be read as part of a control-versus-shift design rather than as artifacts of mismatched protocol. The figure also makes the scope limitations explicit, especially the restricted from-scratch coverage at `N = 50` and `N = 500`, which later discussion text should continue to respect.

## Role In Report

- Main-text opening schematic for the combined paper, ideally in the Introduction-to-Methods transition.
- Optional but useful framing figure for the oxide and nitride standalone reports.
- Reader-orientation figure that defines the control-versus-shift logic before any outcome-bearing results are shown.
- Scope-setting figure that states the three protocol arms, the restricted from-scratch coverage, and the role of embedding analysis in the project.
