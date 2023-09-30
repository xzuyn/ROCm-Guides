#!/bin/bash

# Step 1/7: Creating and activating a Python virtual environment
echo ""
echo "Step 1/7: Creating and activating a Python virtual environment"
echo ""
python3 -m venv rocm_venv
source rocm_venv/bin/activate

# Step 2/7: Installing requirements
echo ""
echo "Step 2/7: Installing requirements"
echo ""
pip install -r requirements.lock.txt
pip install wandb
pip install protobuf==3.19.0

# Step 3/7: Removing unwanted PyTorch installation
echo ""
echo "Step 3/7: Removing unwanted PyTorch installation"
echo ""
pip uninstall -y torch

# Step 4/7: Installing the PyTorch we actually want
echo ""
echo "Step 4/7: Installing the PyTorch we actually want"
echo ""
pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/rocm5.6

# Step 5/7: Removing unwanted bitsandbytes installation
echo ""
echo "Step 5/7: Removing unwanted bitsandbytes installation"
echo ""
pip uninstall bitsandbytes

# Step 6/7: Cloning the bitsandbytes-rocm fork repo
echo ""
echo "Step 6/7: Cloning the bitsandbytes-rocm fork repo"
echo ""
cd rocm_venv
git clone https://github.com/arlo-phoenix/bitsandbytes-rocm-5.6.git bitsandbytes
cd bitsandbytes

# Step 7/7: Installing bitsandbytes-rocm
echo ""
echo "Step 7/7: Installing bitsandbytes-rocm"
echo ""
export ROCM_HOME=/opt/rocm-5.6.0
make hip ROCM_TARGET=gfx1100
pip install .
cd ..
cd ..

echo "Setup complete."
