# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **December 15th, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).

# Installing Using Python Wheels

## Step 1:
Clone the SD.Next repo.

Run these commands:

`git clone https://github.com/comfyanonymous/ComfyUI`

`cd ComfyUI`

## Step 2:
Get the setup script.

Run this command:

`wget https://raw.githubusercontent.com/Kademo15/ROCm-Guides/main/ComfyUi/setup_rocm_venv_whl.sh`

## Step 3:
Give the bash script permissions to run.

Run this command:

`chmod +x setup_rocm_venv_whl.sh`

## Step 4:
Run the setup script.

Run this command:

`./setup_rocm_venv_whl.sh`

## Step 5:
Your installation is now finished and you can run ComfyUi.

Run this command to activate the venv (if you installed it just now it may still be activated):

`source venv/bin/activate`

Run this command to launch ComfyUi:

`python main.py --use-pytorch-cross-attention`
