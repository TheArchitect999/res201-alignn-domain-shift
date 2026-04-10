# Stage 3 (Week 1): zero-shot + one N=50 fine-tune

Order:
1. Create `res201_train` environment.
2. Run zero-shot on oxide and nitride fixed test sets.
3. Prepare one `N=50` dataset root per family.
4. Write one ALIGNN config per family.
5. Run one fine-tune per family.

Outputs to save:
- zero-shot predictions.csv and summary.json
- N50 dataset_root/id_prop.csv and split_manifest.json
- fine-tune output directory with config.json, history_val.json, pred_data_test_set.csv, best_model.pt
