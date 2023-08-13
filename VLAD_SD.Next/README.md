# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **August 12th, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).

Afterwards you can continue to installing SD.Next using one of two methods. The first is simply installing with Python Wheels, but if that doesn't work for you, or for any other reason, you can manually compile PyTorch and TorchVision:

1. [(Fastest Setup Time) Python Wheel](#option-1-installing-using-python-wheels)
2. [(Slowest Setup Time) Manually Compiling](#option-2-installing-by-manually-compiling)

# (Option 1) Installing Using Python Wheels

## Step 1:
Clone the SD.Next repo.

Run these commands:

`git clone https://github.com/vladmandic/automatic`

`cd automatic`

## Step 2:
Get the setup script.

Run this command:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/changes/VLAD_SD.Next/setup_rocm_venv_whl.sh`

## Step 3:
Give the bash script permissions to run.

Run this command:

`chmod +x setup_rocm_venv_whl.sh`

## Step 4:
Run the setup script.

Run this command:

`./setup_rocm_venv_whl.sh`

# (Option 2) Installing By Manually Compiling

## Step 1:
Clone the SD.Next repo.

Run these commands:

`git clone https://github.com/vladmandic/automatic`

`cd automatic`

## Step 2:
Get the setup script.

Run this command:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/changes/VLAD_SD.Next/setup_rocm_venv_build.sh`

## Step 3:
Give the bash script permissions to run.

Run this command:

`chmod +x setup_rocm_venv_build.sh`

## Step 4:
Run the setup script.

Run this command:

`./setup_rocm_venv_build.sh`

## Final:
Your installation is now finished and you can run SD.Next with its included bash script.

Run this command:

`./webui.sh`
