# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **February 23, 2024**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).

# Installing Using Python Wheels

## Step 1:
Go the the location on your device where you want your ComfyUI folder to be created.

Get the setup script.

Run this command:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/ComfyUi/setup_rocm_venv_whl.sh`

## Step 2:
Give the bash script permissions to run.

Run this command:

`chmod +x setup_rocm_venv_whl.sh`

## Step 3:
Run the setup script.

Run this command:

`./setup_rocm_venv_whl.sh`

## Step 4:
Your setup is complete to easily start comfyUI I included the `comfyUI.sh` file. 
It will activate the venv and launch ComfyUI. 
If you want to set command line args open the file and read the code comments. 
