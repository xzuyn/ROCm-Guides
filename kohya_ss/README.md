# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **July 27th, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](https://github.com/xzuyn/ROCm-Guides/).

After you've completed that, this guide will have two options that fork out on step 5.

The first you simply download PyTorch with ROCm 5.5 and use it.

The second will guide you through manually building PyTorch with ROCm 5.6 yourself and using it.

## Step 1:
Clone kohya_ss GUI, and enter it.

Run these commands:

`git clone https://github.com/bmaltais/kohya_ss.git`

`cd kohya_ss`

## Step 2:
Make a venv and activate it.

Run these commands:

`python3 -m venv venv`

`source venv/bin/activate`

## Step 3:
Install requirements.

Run this command:

`pip install --use-pep517 -r requirements.txt`

## Step 4:
Uninstall the PyTorch & TorchVision that step 3 may have installed.

Run this command:

`pip uninstall torch torchvision`

## Step 5 (Option 1):
Install precompiled PyTorch & TorchVision for ROCm 5.5.

Run this command:

`pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.5`

You can now use kohya_ss GUI. You just need to run these commands:

`export HSA_OVERRIDE_GFX_VERSION=11.0.0`

`python kohya_gui.py "$@"`

## Step 5 (Option 2):
*MANUALLY BUILD PYTORCH & TORCHVISION*

If you want the faster version you have to ***build PyTorch & TorchVision*** yourself.

## Step 6 (Option 2):
Clone pytorch.

Run this command:

`git clone https://github.com/pytorch/pytorch`

## Step 7 (Option 2):
Go into the PyTorch folder.

Run this command:
`cd pytorch`

## Step 8 (Option 2):
Run these commands:

`git submodule sync`

`git submodule update --init --recursive`

`python -m pip install --upgrade pip wheel`

`pip install -r requirements.txt`

`python tools/amd_build/build_amd.py`

## Step 9 (Option 2):
Run this command:

`python -c "import site; print(site.getsitepackages()[0])"`

Copy the directory that gave you for use in the next step.

## Step 10 (Option 2):
Use the path the previous command gave you in this command.

Run this command replacing `REPLACEME` with your directory. Keep the quotes:

`export CMAKE_PREFIX_PATH="REPLACEME"`

## Step 11 (Option 2):
Build PyTorch. This will take a while.

Run this command:

`BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop`

## Step 12 (Option 2):
Run these commands:

`export HIP_VISIBLE_DEVICES=0`

`export HSA_OVERRIDE_GFX_VERSION=11.0.0`

## Step 13 (Option 2):
Now we test Torch.

Run this command:

`python`

## Step 14 (Option 2):
In the python enviroment that appears, put all of this. You can copy line by line, or copy it all at once. I personally did it one line at a time to see how it outputs.

```
import torch
torch.cuda.is_available()
torch.cuda.device_count()
torch.cuda.current_device()
torch.cuda.get_device_name(torch.cuda.current_device())

tensor = torch.randn(2, 2)
res = tensor.to(0)
print(res)
```

## Step 15 (Option 2):
If everything works you get a device count and a name (your gpu).

The last like should include a 2x2 grid of numbers.

If you get and segmentation error you closed your terminal after putting "export HSA_OVERRIDE_GFX_VERSION=11.0.0" so put that again and redo the test

## Step 16 (Option 2):
Exit out of the python environment.

Add this, then press enter:
`exit()`

## Step 17 (Option 2):
Go back into the main koyhya_ss directory.

Run this command:
`cd ../`

## Step 18 (Option 2):
Clone and install TorchVision. This can take a while as well.

Run these commands:

`git clone https://github.com/pytorch/vision`

`cd vision`

`python setup.py install`

## Step 19 (Option 2):
To make sure you dont have to run `export HSA_OVERRIDE_GFX_VERSION=11.0.0` everytime you open the terminal, we are going to edit a systemfile. You can ignore Step 19 to 22 if you've already added `HSA_OVERRIDE_GFX_VERSION=11.0.0`.

Run these commands:

`cd ~`

`nano .bashrc`

## Step 20 (Option 2):
Add the `export HSA_OVERRIDE_GFX_VERSION=11.0.0` at the last line

## Step 21 (Option 2):
Save and exit.

You do so by pressing `CTRL` and `X` to exit.

Then pressing `Enter` to write the changes.

## Step 22 (Option 2):
Now you can go back into kohya_ss.

Run this command:

`cd kohya_ss`

## Step 23 (Option 2):
You can now use kohya_ss GUI. You just need to run this command:

`python kohya_gui.py "$@"`

## Notes:
Some features don't work.

Disable `xformers`, and change the optimizer to something other than `AdamW8bit`. I chose `AdamW`.

I've included a [known working config](https://github.com/xzuyn/ROCm-Guides/blob/main/kohya_ss/known_working_lora.json) for a LoRA. It runs on my 7900 XTX using ROCm 5.6.5.
