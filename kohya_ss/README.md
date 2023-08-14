# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **August 13th, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).

Afterwards you can continue to installing kohya_ss using one of two methods. The first is simply installing with Python Wheels, but if that doesn't work for you, or for any other reason, you can manually compile PyTorch and TorchVision:

1. [(Fastest Setup Time) Python Wheel](#option-1-installing-using-python-wheels)
2. [(Slowest Setup Time) Manually Compiling](#option-2-installing-by-manually-compiling)

# (Option 1) Installing Using Python Wheels

## (Option 1) Step 1:
Clone kohya_ss GUI, and enter it.

Run these commands:

`git clone https://github.com/bmaltais/kohya_ss.git`

`cd kohya_ss`

## (Option 1) Step 2:
Get the setup script.

Run this command:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/kohya_ss/setup_rocm_venv_whl.sh`

## (Option 1) Step 3:
Give the bash script permissions to run.

Run this command:

`chmod +x setup_rocm_venv_whl.sh`

## (Option 1) Step 4:
Run the setup script.

Run this command:

`./setup_rocm_venv_whl.sh`

## (Option 1) Step 5:
You now need configurate accelerate.

Run these commands:

`source venv/bin/activate`

`accelerate config`

## (Option 1) Step 6:
Now answer like this:

`This machine`

`No distributed training`

`Do you want to run your training on CPU only (even if a GPU / Apple Silicon device is available)? [yes/NO]: NO`

`Do you wish to optimize your script with torch dynamo?[yes/NO]: NO`

`Do you want to use DeepSpeed? [yes/NO]: NO`

`What GPU(s) (by id) should be used for training on this machine as a comma-seperated list? [all]: all`

`Do you wish to use FP16 or BF16 (mixed precision)? fp16`

## (Option 1) Step 7:
Now you can run kohya_ss.

Run these commands:

`source venv/bin/activate`

`python kohya_gui.py "$@"`

# (Option 2) Installing By Manually Compiling

## (Option 2) Step 1:
Clone kohya_ss GUI, and enter it.

Run these commands:

`git clone https://github.com/bmaltais/kohya_ss.git`

`cd kohya_ss`

## (Option 2) Step 2:
Get the setup script.

Run this command:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/kohya_ss/setup_rocm_venv_build.sh`

## (Option 2) Step 3:
Give the bash script permissions to run.

Run this command:

`chmod +x setup_rocm_venv_build.sh`

## (Option 2) Step 4:
Run the setup script.

Run this command:

`./setup_rocm_venv_build.sh`

## (Option 2) Step 5:
You now need configurate accelerate.

Run these commands:

`source venv/bin/activate`

`accelerate config`

## (Option 1) Step 6:
Now answer like this:

`This machine`

`No distributed training`

`Do you want to run your training on CPU only (even if a GPU / Apple Silicon device is available)? [yes/NO]: NO`

`Do you wish to optimize your script with torch dynamo?[yes/NO]: NO`

`Do you want to use DeepSpeed? [yes/NO]: NO`

`What GPU(s) (by id) should be used for training on this machine as a comma-seperated list? [all]: all`

`Do you wish to use FP16 or BF16 (mixed precision)? fp16`

## (Option 2) Step 7:
Now you can run kohya_ss.

Run these commands:

`source venv/bin/activate`

`python kohya_gui.py "$@"`

## Notes:
Some features don't work.

Disable `xformers` as it doesn't work.

I've included a [known working config](https://github.com/xzuyn/ROCm-Guides/blob/main/kohya_ss/known_working_lora.json) for a LoRA. It runs on my 7900 XTX using ROCm 5.6.5.
