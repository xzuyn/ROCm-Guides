#!/bin/bash

# Step 1/12: Creating and activating a Python virtual environment
echo ""
echo "Step 1/12: Creating and activating a Python virtual environment"
echo ""
python3 -m venv rocm_venv
source rocm_venv/bin/activate

# Step 2/12: Installing requirements
echo ""
echo "Step 2/12: Installing requirements"
echo ""
pip install -r requirements.lock.txt
pip install wandb
pip install protobuf==3.19.0

# Step 3/12: Removing unwanted PyTorch installation
echo ""
echo "Step 3/12: Removing unwanted PyTorch installation"
echo ""
pip uninstall -y torch

# Step 4/12: Cloning the PyTorch repo
echo ""
echo "Step 4/12: Cloning PyTorch"
echo ""
cd ..
cd rocm_venv
git clone https://github.com/pytorch/pytorch

# Step 5/12: Updating submodules
echo ""
echo "Step 5/12: Updating submodules"
echo ""
cd pytorch
git submodule sync
git submodule update --init --recursive

# Step 6/12: Installing requirements
echo ""
echo "Step 6/12: Installing requirements"
echo ""
python -m pip install --upgrade pip wheel
pip install -r requirements.txt

# Step 7/12: Building the AMD-specific parts of PyTorch
echo ""
echo "Step 7/12: Building the AMD-specific parts of PyTorch"
echo ""
python tools/amd_build/build_amd.py

# Step 8/12: Compiling PyTorch
echo ""
echo "Step 8/12: Building the AMD-specific parts of PyTorch"
echo ""
cmake_p_p=$(python -c "import site; print(site.getsitepackages()[0])")
export CMAKE_PREFIX_PATH="$cmake_p_p"
BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop
export HIP_VISIBLE_DEVICES=0

# Step 9/12: Removing unwanted bitsandbytes installation
echo ""
echo "Step 9/12: Removing unwanted bitsandbytes installation"
echo ""
cd ..
pip uninstall bitsandbytes

# Step 10/12: Cloning the bitsandbytes-rocm fork repo
echo ""
echo "Step 10/12: Cloning the bitsandbytes-rocm fork repo"
echo ""
git clone https://github.com/arlo-phoenix/bitsandbytes-rocm-5.6.git bitsandbytes
cd bitsandbytes

# Step 11/12: Installing bitsandbytes-rocm
echo ""
echo "Step 11/12: Installing bitsandbytes-rocm"
echo ""
export ROCM_HOME=/opt/rocm-5.6.0
make hip ROCM_TARGET=gfx1100
pip install .
cd ..

# Step 12/12: Configuring environment variables
echo ""
echo "Step 12/12: Configuring environment variables"
echo ""

# Check if .bashrc exists, if not, create one
if [ ! -e ~/.bashrc ]; then
    touch ~/.bashrc
fi

# Check if HSA_OVERRIDE_GFX_VERSION is already set
if grep -q "HSA_OVERRIDE_GFX_VERSION=11.0.0" ~/.bashrc; then
    echo "HSA_OVERRIDE_GFX_VERSION is already set in .bashrc"
else
    echo "Adding HSA_OVERRIDE_GFX_VERSION to .bashrc..."
    echo "export HSA_OVERRIDE_GFX_VERSION=11.0.0" >> ~/.bashrc
    echo "HSA_OVERRIDE_GFX_VERSION added to .bashrc"
fi

echo "Setup complete."
