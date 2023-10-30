#!/bin/bash

# Step 1/6: Updating submodules
echo ""
echo "Step 1/6: Updating submodules."
echo ""
git submodule sync
git submodule update --init --recursive

# Step 2/6: Creating and activating a Python virtual environment
echo ""
echo "Step 2/6: Creating and activating a Python virtual environment"
echo ""
python3 -m venv venv
source venv/bin/activate

# Step 3/6: Launching the Python script (this will likely segfault, which is fine)
echo ""
echo "Step 3/6: Launching the Python script (this will likely segfault, which is fine)"
echo ""
python launch.py

# Step 4/6: Removing unwanted PyTorch and TorchVision installations
echo ""
echo "Step 4/6: Removing unwanted PyTorch and TorchVision installations"
echo ""
pip uninstall -y torch torchvision

# Step 5/6: Installing the PyTorch and TorchVision we actually want
echo ""
echo "Step 5/6: Installing the PyTorch and TorchVision we actually want"
echo ""
pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.7

# Step 6/6: Configuring environment variables
echo ""
echo "Step 6/6: Configuring environment variables"
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

echo 'You can now run SD.Next any time by running the "./webui.sh" bash script'
