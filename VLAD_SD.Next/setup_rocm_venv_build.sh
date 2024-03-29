#!/bin/bash

# Step 1/12: Updating submodules
echo ""
echo "Step 1/12: Updating submodules."
echo ""
git submodule sync
git submodule update --init --recursive

# Step 2/12: Creating and activating a Python virtual environment
echo ""
echo "Step 2/12: Creating and activating a Python virtual environment"
echo ""
python3 -m venv venv
source venv/bin/activate

# Step 3/12: Launching the Python script (this will likely segfault, which is fine)
echo ""
echo "Step 3/12: Launching the Python script (this will likely segfault, which is fine)"
echo ""
python launch.py

# Step 4/12: Removing unwanted PyTorch and TorchVision installations
echo ""
echo "Step 4/12: Removing unwanted PyTorch and TorchVision installations"
echo ""
pip uninstall -y torch torchvision

# Step 5/12: Cloning the PyTorch repo
echo ""
echo "Step 5/12: Cloning PyTorch"
echo ""
cd repositories
git clone https://github.com/pytorch/pytorch

# Step 6/12: Updating submodules
echo ""
echo "Step 6/12: Updating submodules"
echo ""
cd pytorch
git submodule sync
git submodule update --init --recursive

# Step 7/12: Installing requirements
echo ""
echo "Step 7/12: Installing requirements"
echo ""
python -m pip install --upgrade pip wheel
pip install -r requirements.txt

# Step 8/12: Building the AMD-specific parts of PyTorch
echo ""
echo "Step 8/12: Building the AMD-specific parts of PyTorch"
echo ""
python tools/amd_build/build_amd.py

# Step 9/12: Compiling PyTorch
echo ""
echo "Step 9/12: Building the AMD-specific parts of PyTorch"
echo ""
cmake_p_p=$(python3 -c "import site; print(site.getsitepackages()[0])")
export CMAKE_PREFIX_PATH="$cmake_p_p"
BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop
export HIP_VISIBLE_DEVICES=0

# Step 10/12: Configuring environment variables
echo ""
echo "Step 10/12: Configuring environment variables"
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

# Step 11/12: Cloning the TorchVision repo
echo ""
echo "Step 11/12: Cloning the TorchVision repo"
echo ""
cd ..
git clone https://github.com/pytorch/vision

# Step 12/12: Compiling TorchVision
echo ""
echo "Step 12/12: Compiling TorchVision"
echo ""
cd vision
python setup.py install
cd ..
cd ..

echo ""
echo 'You can now run SD.Next any time by running the "./webui.sh" bash script'
