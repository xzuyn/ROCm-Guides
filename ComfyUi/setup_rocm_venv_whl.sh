#!/bin/bash

# Step 1/6: Configuring environment variables
echo ""
echo "Step 1/6: Configuring environment variables"
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

# Step 2/6: Cloning the repository
echo ""
echo "Step 2/6: Cloning the repository"
echo ""
git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI

# Step 3/6: Updating submodules
echo ""
echo "Step 3/6: Updating submodules"
echo ""
git submodule sync
git submodule update --init --recursive

# Step 4/6: Creating and activating a Python virtual environment
echo ""
echo "Step 4/6: Creating and activating a Python virtual environment"
echo ""
python3 -m venv venv
source venv/bin/activate

#Step 5/6: Installing the right PyTorch and TorchVision versions and other requirements
echo ""
echo "Step 5/6: Installing the right PyTorch and TorchVision versions and other requirements"
echo ""
pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm6.0
pip install -r requirements.txt

# Step 6/6: Launching the Python script and installing a one click launcher
echo ""
echo "Step 6/6: Launching the Python script"
echo 'You can now run ComfyUI any time by following step 4 in the README file'
echo ""
wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/ComfyUi/comfyUI.sh
python main.py
