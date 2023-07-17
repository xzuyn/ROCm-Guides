## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](https://github.com/xzuyn/ROCm-Guides/)

## Step 1:
Clone Vlad's fork of automtic1111.

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

## Step 4:
After it gives you an error run the following commands.

Run these commands:

`uninstall torch torchvision`

`pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.5`

## Step 5:
You should now be able to run Vlad's fork with ROCm 5.5 using the following command.

Run this command:
`python launch.py`

# EXTRA: MANUALLY BUILD PYTORCH & PYVISION
## If you want the faster version you have to build PyTorch & PyVision yourself.

## Step 6:
Run this command:
`pip uninstall torch torchvision`

## Step 7:
Go into your repositories folder that can be found in your automatic folder, and clone PyTorch.

Run these commands:

`cd repositories/`

`git clone https://github.com/pytorch/pytorch`

## Step 8:
Go into the PyTorch folder.

Run this command:
`cd pytorch`

## Step 9:
Run these commands:

`git submodule sync`

`git submodule update --init --recursive`

`python -m pip install --upgrade pip wheel`

`pip install -r requirements.txt`

`python tools/amd_build/build_amd.py`

## Step 10:
Run this command:

`python -c "import site; print(site.getsitepackages()[0])"`

Copy the directory that gave you for use in the next step.

## Step 11:
Use the path the previous command gave you in this command.

Run this command replacing `REPLACEME` with your directory. Keep the quotes:

`export CMAKE_PREFIX_PATH="REPLACEME"`

## Step 12:
Build PyTorch. This will take a while.

Run this command:

`BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop`

## Step 13:
Run these commands:

`export HIP_VISIBLE_DEVICES=0`

`export HSA_OVERRIDE_GFX_VERSION=11.0.0`

## Step 14:
Now we test Torch.

Run this command:

`python`

## Step 15:
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

## Step 16:
If everything works you get a device count and a name (your gpu).

The last like should include a 2x2 grid of numbers.

If you get and segmentation error you closed your terminal after putting "export HSA_OVERRIDE_GFX_VERSION=11.0.0" so put that again and redo the test

## Step 17:
Exit out of the python environment.

Add this, then press enter:
`exit()`

## Step 18:
Go back into the repositories folder.

Run this command:
`cd ../`

## Step 19:
Clone and install PyVision.

Run these commands:

`git clone https://github.com/pytorch/vision`

`cd vision`

`python setup.py install`

## Step 20:
To make sure you dont have to run `export HSA_OVERRIDE_GFX_VERSION=11.0.0` everytime you open the terminal, we are going to edit a systemfile.

Run these commands:

`cd ~`

`nano .bashrc`

## Step 21:
Add the `export HSA_OVERRIDE_GFX_VERSION=11.0.0` at the last line

## Step 22:
Save and exit.

You do so by pressing `CTRL` and `X` to exit.

Then pressing `Enter` to write the changes.

## Step 23:
Run these commands:

`cd automatic`

## Step 24:
You can now use Vlad's fork. You can run `webui.sh` and it will automatically activate the venv for you.

Run this command:
`./webui.sh`

## Step 25:
Enjoy.

# Note:
The original automatic1111 fill mess up your torch install with the launch.py, thats why I chose Vlad's fork.
