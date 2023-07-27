#!/bin/bash

python3 -m venv rocm_venv
source rocm_venv/bin/activate

pip install -r requirements.lock.txt
pip install wandb
pip install protobuf==3.19.0

pip uninstall -y torch

pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/rocm5.6

echo "Setup complete."
