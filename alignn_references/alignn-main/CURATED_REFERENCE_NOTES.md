# Curated ALIGNN Reference Bundle

This folder was trimmed down for the RES201 project so future debugging and code inspection stay focused on the parts of ALIGNN that matter most for pretrained property prediction and fine-tuning.

## Kept

- top-level packaging and docs:
  - `README.md`
  - `LICENSE.rst`
  - `pyproject.toml`
  - `setup.py`
  - `environment.yml`
- core library files used by our project:
  - `alignn/config.py`
  - `alignn/data.py`
  - `alignn/dataset.py`
  - `alignn/graphs.py`
  - `alignn/lmdb_dataset.py`
  - `alignn/pretrained.py`
  - `alignn/train.py`
  - `alignn/train_alignn.py`
  - `alignn/train_props.py`
  - `alignn/utils.py`
  - `alignn/cli.py`
- model definitions:
  - `alignn/models/`
- one upstream regression/property example:
  - `alignn/examples/sample_data/`
- one useful upstream regression-oriented test:
  - `alignn/tests/test_prop.py`

## Removed

- CI and repo-maintenance files that are not useful for local RES201 debugging
- force-field specific code and examples
- multi-property and atomwise example packs
- paper assets, figures, and TeX files
- bulk helper scripts unrelated to our current property-prediction workflow
- extra tests that do not help with the pretrained formation-energy path

## Why

Our current RES201 work depends mainly on:

- pretrained ALIGNN prediction
- user-data dataset loading
- LMDB-backed training/evaluation
- model definitions and config handling
- property-prediction training flow

That is the slice preserved here.
