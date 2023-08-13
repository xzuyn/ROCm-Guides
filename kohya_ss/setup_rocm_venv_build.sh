#!/bin/bash

# Step 1/11: Creating and activating a Python virtual environment
echo ""
echo "Step 1/11: Creating and activating a Python virtual environment"
echo ""
python3 -m venv venv
source venv/bin/activate

# Step 2/11: Installing requirements
echo ""
echo "Step 2/11: Installing requirements"
echo ""
pip install --use-pep517 -r requirements.txt

# Step 3/11: Removing unwanted PyTorch and TorchVision installations
echo ""
echo "Step 3/11: Removing unwanted PyTorch and TorchVision installations"
echo ""
pip uninstall -y torch torchvision

# Step 4/11: Cloning the PyTorch repo
echo ""
echo "Step 4/11: Cloning PyTorch"
echo ""
cd venv
git clone https://github.com/pytorch/pytorch

# Step 5/11: Updating submodules
echo ""
echo "Step 5/11: Updating submodules"
echo ""
cd pytorch
git submodule sync
git submodule update --init --recursive

# Step 6/11: Installing requirements
echo ""
echo "Step 6/11: Installing requirements"
echo ""
python -m pip install --upgrade pip wheel
pip install -r requirements.txt

# Step 7/11: Building the AMD-specific parts of PyTorch
echo ""
echo "Step 7/11: Building the AMD-specific parts of PyTorch"
echo ""
python tools/amd_build/build_amd.py

# Step 8/11: Compiling PyTorch
echo ""
echo "Step 8/11: Building the AMD-specific parts of PyTorch"
echo ""
cmake_p_p=$(python -c "import site; print(site.getsitepackages()[0])")
export CMAKE_PREFIX_PATH="$cmake_p_p"
BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop
export HIP_VISIBLE_DEVICES=0

# Step 9/11: Cloning the TorchVision repo
echo ""
echo "Step 9/11: Cloning TorchVision"
echo ""
cd ..
git clone https://github.com/pytorch/vision

# Step 10/11: Compiling TorchVision
echo ""
echo "Step 9/11: Compiling TorchVision"
echo ""
cd vision
python setup.py install
cd ..
cd ..

# Step 11: Configuring environment variables
echo ""
echo "Step 11/11: Configuring environment variables"
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
echo 'You can now run SD.Next any time by running the "./webui.sh" bash script'
