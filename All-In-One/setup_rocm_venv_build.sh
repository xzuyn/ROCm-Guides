#!/bin/bash

# Create a directory named ROCm_AI
mkdir ROCm_AI
echo ""
echo "Step 1/14 Complete."
echo ""

# Create a virtual environment named rocm_venv and activate it
cd ROCm_AI
python3 -m venv rocm_venv
source rocm_venv/bin/activate
echo ""
echo "Step 2/14 Complete."
echo ""

# Clone the LLaMa-LoRA-Tuner and kohya_ss repositories
git clone https://github.com/zetavg/LLaMA-LoRA-Tuner.git LLaMa-LoRA-Tuner
git clone https://github.com/bmaltais/kohya_ss.git kohya_ss
echo ""
echo "Step 3/14 Complete."
echo ""

# Install the dependencies for LLaMa-LoRA-Tuner
cd LLaMa-LoRA-Tuner
pip install -r requirements.lock.txt
echo ""
echo "Step 4/14 Complete."
echo ""

# Uninstall the PyTorch that LLaMa-LoRA-Tuner may have installed
pip uninstall -y torch
echo ""
echo "Step 5/14 Complete."
echo ""

# Clone the PyTorch repository into the rocm_venv directory
cd ..
cd rocm_venv
git clone https://github.com/pytorch/pytorch
echo ""
echo "Step 6/14 Complete."
echo ""

# Sync and update submodules in the PyTorch repository
cd pytorch
git submodule sync
git submodule update --init --recursive
echo ""
echo "Step 6/14 Complete."
echo ""

# Upgrade pip and install the required packages for PyTorch
python -m pip install --upgrade pip wheel
pip install -r requirements.txt
echo ""
echo "Step 7/14 Complete."
echo ""

# Build the AMD-specific parts of pytorch
python tools/amd_build/build_amd.py
echo ""
echo "Step 8/14 Complete."
echo ""

# Set CMAKE_PREFIX_PATH to the site packages directory
cmake_p_p=$(python -c "import site; print(site.getsitepackages()[0])")
export CMAKE_PREFIX_PATH="$cmake_p_p"
echo ""
echo "Step 9/14 Complete."
echo ""

# Configure and build PyTorch+ROCm5.6
BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop
echo ""
echo "Step 10/14 Complete."
echo ""

# Set some variables
export HIP_VISIBLE_DEVICES=0
export HSA_OVERRIDE_GFX_VERSION=11.0.0
echo ""
echo "Step 11/14 Complete."
echo ""

# Install the dependencies for kohya_ss using PEP517
cd ..
cd ..
cd kohya_ss
pip install --use-pep517 -r requirements.txt
echo ""
echo "Step 12/14 Complete."
echo ""

# Uninstall the TorchVision that kohya_ss may have installed
pip uninstall -y torchvision
echo ""
echo "Step 13/14 Complete."
echo ""

# Clone the TorchVision repository into rocm_venv directory and install it
cd rocm_venv
git clone https://github.com/pytorch/vision
cd vision
python3 setup.py install
cd ..
echo ""
echo "Step 14/14 Complete."
echo ""

# Echo a message indicating setup completion
echo "Setup complete."
