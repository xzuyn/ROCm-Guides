# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **August 11th, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).

Afterwards you can continue to installing SD.Next using one of two methods. The first is simply installing with Python Wheels, but if that doesn't work for you, or for any other reason, you can manually compile PyTorch and TorchVision:

1. [(Fastest Setup Time) Python Wheel](#installing-using-python-wheels)
2. [(Slowest Setup Time) Manually Compiling](#installing-by-manually-compiling)

# Installing Using Python Wheels

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

You need to respond to the `Download the default model? (y/N)` input manually. You need to enter `y`, as this will cause a `segmentation fault`, which we want.

Run this command:

`./setup_rocm_venv_whl.sh`

# Installing By Manually Compiling

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

You need to respond to the `Download the default model? (y/N)` input manually. This is personal preference.

You will also need to kill the python script using CTRL + C once its loaded, and displays a URL like `Local URL: http://127.0.0.1:7860/`

Run this command:

`./setup_rocm_venv_build.sh`

## Final:
Your installation is now finished and you can run SD.Next with its included bash script.

Run this command:

`./webui.sh`
