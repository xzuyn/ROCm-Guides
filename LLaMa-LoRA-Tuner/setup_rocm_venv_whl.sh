#!/bin/bash

python3 -m venv rocm_venv
source rocm_venv/bin/activate

pip install -r requirements.lock.txt
pip install wandb
pip install protobuf==3.19.0

pip uninstall -y torch

pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/rocm5.6

pip uninstall bitsandbytes
cd rocm_venv
git clone https://github.com/arlo-phoenix/bitsandbytes-rocm-5.6.git bitsandbytes
cd bitsandbytes
export ROCM_HOME=/opt/rocm-5.6.0
make hip ROCM_TARGET=gfx1100
pip install .
cd ..
cd ..

echo "Setup complete."
