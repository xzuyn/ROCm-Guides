#!/bin/bash

python3 -m venv rocm_venv
source rocm_venv/bin/activate

# Install the dependencies for LLaMa-LoRA-Tuner
pip install -r requirements.lock.txt
pip install wandb

# Uninstall the torch that LLaMa-LoRA-Tuner may have installed
pip uninstall -y torch

# Clone the pytorch repository into rocm_venv directory
cd ..
cd rocm_venv
git clone https://github.com/pytorch/pytorch

# Sync and update submodules in the pytorch repository
cd pytorch
git submodule sync
git submodule update --init --recursive

# Upgrade pip and install the required packages for pytorch
python -m pip install --upgrade pip wheel
pip install -r requirements.txt

# Build the AMD-specific parts of pytorch
python tools/amd_build/build_amd.py

# Set CMAKE_PREFIX_PATH to the site packages directory
cmake_p_p=$(python -c "import site; print(site.getsitepackages()[0])")
export CMAKE_PREFIX_PATH="$cmake_p_p"

# Configure and build pytorch for ROCm 5.6
BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop

export HIP_VISIBLE_DEVICES=0
export HSA_OVERRIDE_GFX_VERSION=11.0.0

# Install the dependencies for kohya_ss using PEP517
cd ..
cd ..

# Echo a message indicating setup completion
echo "Setup complete."
