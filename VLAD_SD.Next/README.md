# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **August 4rd, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).


## Step 1:
Clone VLAD's fork of automatic1111.

Run these commands:

`git clone https://github.com/vladmandic/automatic`

`cd automatic`

`git submodule sync`

`git submodule update --init --recursive`

## Step 2:
Make a venv and activate it.

Run these commands:

`python3 -m venv venv`

`source venv/bin/activate`

## Step 3:
Run `launch.py` just to install requirements it will fail by running the following command.

Run this command:

`python launch.py`

This should result in an error.
## Step 4:
Uninstall the PyTorch & TorchVision that step 3 may have installed.

Run this command:

`pip uninstall torch torchvision`

## Step 5 (Option 1):
Install precompiled PyTorch & TorchVision for ROCm 5.5.

Run this command:

`pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.6`




## Step 5 (Option 2):
*MANUALLY BUILD PYTORCH & TORCHVISION*

If the guide above is not up-to-date anymore you can always ***build PyTorch & TorchVision*** yourself.

## Step 5.1 (Option 2):
Go into your repositories folder that can be found in your automatic folder.

Run this command:

`cd repositories`

## Step 5.2 (Option 2):
Clone pytorch.

Run this command:

`git clone https://github.com/pytorch/pytorch`

## Step 5.3 (Option 2):
Go into the PyTorch folder.

Run this command:
`cd pytorch`

## Step 5.4 (Option 2):
Run these commands:

`git submodule sync`

`git submodule update --init --recursive`

`python -m pip install --upgrade pip wheel`

`pip install -r requirements.txt`

`python tools/amd_build/build_amd.py`

## Step 5.5 (Option 2):
Run this command:

`python -c "import site; print(site.getsitepackages()[0])"`

Copy the directory that gave you for use in the next step.

## Step 5.6 (Option 2):
Use the path the previous command gave you in this command.

Run this command replacing `REPLACEME` with your directory. Keep the quotes:

`export CMAKE_PREFIX_PATH="REPLACEME"`

It should look something like this; `export CMAKE_PREFIX_PATH="/home/username/pytorch/venv/lib/python3.10/site-packages"`

## Step 5.7 (Option 2):
Build PyTorch. This will take a while.

Run this command:

`BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop`

## Step 5.8 (Option 2):
Run these commands:

`export HIP_VISIBLE_DEVICES=0`

`export HSA_OVERRIDE_GFX_VERSION=11.0.0`

## Step 5.9 (Option 2):
Now we test Torch.

Run this command:

`python`

## Step 5.10 (Option 2):
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

## Step 5.11 (Option 2):
If everything works you get a device count and a name (your gpu).

The last like should include a 2x2 grid of numbers.

If you get and segmentation error you closed your terminal after putting "export HSA_OVERRIDE_GFX_VERSION=11.0.0" so put that again and redo the test

## Step 5.12 (Option 2):
Exit out of the python environment.

Add this, then press enter:
`exit()`

## Step 5.13 (Option 2):
Go back into the repositories folder.

Run this command:
`cd ../`

## Step 5.14 (Option 2):
Clone and install TorchVision. This can take a while as well.

Run these commands:

`git clone https://github.com/pytorch/vision`

`cd vision`

`python setup.py install`



## Step 6:
To make sure you dont have to run `export HSA_OVERRIDE_GFX_VERSION=11.0.0` everytime you open the terminal, we are going to edit a systemfile.

Run these commands:

`cd ~`

`nano .bashrc`

## Step 7:
Add the `export HSA_OVERRIDE_GFX_VERSION=11.0.0` at the last line

## Step 8:
Save and exit.

You do so by pressing `CTRL` and `X` to exit.

Then pressing `Enter` to write the changes.

## Step 9:
You can now go back into automatic.

Run this commands:

`cd automatic`

## Step 10:
You can now use VLAD's fork. You can run `webui.sh` and it will automatically activate the venv for you.

Run this command:

`./webui.sh`

# Note:
The original automatic1111 fill mess up your torch install with the launch.py, thats why I chose VLAD's fork.
