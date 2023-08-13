#!/bin/bash

# Step 1/5: Creating and activating a Python virtual environment
echo ""
echo "Step 1/5: Creating and activating a Python virtual environment"
echo ""
python3 -m venv venv
source venv/bin/activate

# Step 2/5: Installing requirements
echo ""
echo "Step 2/5: Installing requirements"
echo ""
pip install --use-pep517 -r requirements.txt

# Step 3/5: Removing unwanted PyTorch and TorchVision installations
echo ""
echo "Step 3/5: Removing unwanted PyTorch and TorchVision installations"
echo ""
pip uninstall -y torch torchvision

# Step 4/5: Installing the PyTorch and TorchVision we actually want
echo ""
echo "Step 4/5: Installing the PyTorch and TorchVision we actually want"
echo ""
pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.6

# Step 5/5: Configuring environment variables
echo ""
echo "Step 5/5: Configuring environment variables"
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

echo ""
echo 'You can now follow the rest of the guide to configure accelerate'
