#!/bin/bash

# Create a directory named ROCm_AI
mkdir ROCm_AI
echo ""
echo "Step 1/9 Complete."
echo ""

# Create a virtual environment named rocm_venv and activate it
cd ROCm_AI
python3 -m venv rocm_venv
source rocm_venv/bin/activate
echo ""
echo "Step 2/9 Complete."
echo ""

# Clone the LLaMa-LoRA-Tuner and kohya_ss repositories
git clone https://github.com/zetavg/LLaMA-LoRA-Tuner.git LLaMa-LoRA-Tuner
git clone https://github.com/bmaltais/kohya_ss.git kohya_ss
echo ""
echo "Step 3/9 Complete."
echo ""

# Install the dependencies for LLaMa-LoRA-Tuner
cd LLaMa-LoRA-Tuner
pip install -r requirements.lock.txt
pip install wandb
pip install protobuf==3.19.0
echo ""
echo "Step 4/9 Complete."
echo ""

# Uninstall the PyTorch that LLaMa-LoRA-Tuner may have installed
pip uninstall -y torch
echo ""
echo "Step 5/9 Complete."
echo ""

# Install PyTorch+ROCm5.6
pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/rocm5.6
echo ""
echo "Step 6/9 Complete."
echo ""

# Install the dependencies for kohya_ss using PEP517
cd ..
cd kohya_ss
pip install --use-pep517 -r requirements.txt
echo ""
echo "Step 7/9 Complete."
echo ""

# Uninstall the TorchVision that kohya_ss may have installed
pip uninstall -y torchvision
echo ""
echo "Step 8/9 Complete."
echo ""

# Install TorchVision+ROCm5.6
pip install --pre torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.6
pip uninstall -y bitsandbytes

cd ..
cd ..
echo ""
echo "Step 9/9 Complete."
echo ""

echo "Setup complete."
