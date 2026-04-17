This report bundle contains the consolidated `100 / 32 / 5e-5` week-3 from-scratch runs that were completed on the branch-safe Colab workflow and then promoted to `main`.

- Results live under `results/<family>/N<N>_seed<seed>/train_alignn_fromscratch_epochs100_bs32_lr5e5/`.
- Configs live under `configs/week3_fromscratch_epochs100_bs32_lr5e5/`.
- The summary tables and plots here were generated against zero-shot references only, using `scripts/shared/summarize_week3_fromscratch_zero_shot_only.py`.
- Coverage is `oxide` and `nitride`, `N=50` and `N=500`, seeds `0..4`.
