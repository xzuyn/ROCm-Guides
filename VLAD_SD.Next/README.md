# THIS IS A TUTORIAL/INSTALL GUIDE FOR RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
Credit:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **July 17th, 2023.**

## Step 1:
Install `Ubuntu 22.04.2 LTS`

## Step 2:
Open a terminal and run these commands:

`sudo add-apt-repository ppa:cappelikan/ppa`

`sudo apt update`

`sudo apt install mainline`

## Step 3:
Run this command:

`sudo grub-mkconfig | grep -iE "menuentry 'Ubuntu, with Linux" | awk '{print i++ " : "$1, $2, $3, $4, $5, $6, $7}'`

## Step 4:
Find which number is assigned to `menuentry 'Ubuntu, with Linux 5.19.0-46-generic (recovery mode)'`

You will need this for **step 6**.

## Step 5:
Run this command:

`sudo gedit /etc/default/grub`

## Step 6:
Edit the `GRUB_DEFAULT=` to the number you got from step 4.

## Step 7:
Run this command:

`sudo update-grub`

## Step 8:
Reboot into the grub menu.

For me I had to press my Esc key *once* while Ubuntu boots.

For you it may be different. You may not need to press anything at all.

You are trying to get to a screen which has an `Advanced options for Ubuntu` selectable.

## Step 9:
Select `Advanced options for Ubuntu`

## Step 10:
Select `Ubuntu, with Linux 5.19.0-46-generic (recovery mode)`

## Step 11:
Select `resume`.

## Step 12:
You now need to remove the unwanted kernals.

Run this command:

`pkg --list | grep -i -E --color 'linux-image|linux-kernel' | grep '^ii'`

## Step 13:
This will give you a list of kernals. You want to `apt-get remove` all except `linux-image-5.19.0-46-generic`.

In my case I had to remove the following;

`apt-remove linux-image-6.1.0-1016-oem`

`apt-remove linux-image-oem-22.04c`

## Step 14:
Run this command:

`sudo gedit /etc/default/grub`

## Step 15:
Set `GRUB_DEFAULT=` to the default value again, which in my case was 0.

## Step 16:
Run this command:

`sudo update-grub`

## Step 17:
You now need to restart, but you still need to load into recovery mode so do the same as you did in **step 8**.

## Step 18:
You need to add yourself to render and video.

Run this command:

`sudo usermod -aG video,render $LOGNAME`

## Step 19:
Make sure amdgpu is uninstalled.

Run these commands:

`amdgpu-uninstall`

`sudo apt-get purge amdgpu-install`

## Step 20:
Download the latest drivers.

Run this command:

`wget http://repo.radeon.com/amdgpu-install/5.6/ubuntu/jammy/amdgpu-install_5.6.50600-1_all.deb`

## Step 21:
Now install amdgpu.

Run these commands:

`sudo dpkg -i amdgpu-install_5.6.50600-1_all.deb`

`amdgpu-install --usecase=hip,rocm  --no-32`

## Step 22:
You need to reboot now. You don't need to go into recovery mode anymore, so just boot as you normally would.

Just reboot normally or use run this command:

`reboot`

## Step 23:
Confirm you are using `5.19.0-46-generic`

Run this command:
`uname -r`

## Step 24:
You can try `rocminfo` in the terminal to check if ROCm is installed correctly (you should find your gpu name in there).

## Step 25:
Install the prerq.

Run this command:

`sudo apt install git python3-dev python3-venv libjpeg-dev libpng-dev libstdc++-12-dev cmake`

## Step 26:
Clone Vlad's fork of automatic1111.

Run these commands:

`git clone https://github.com/vladmandic/automatic`

`cd automatic`

`git submodule sync`

`git submodule update --init --recursive`

## Step 27:
Make a venv and activate it.

Run these commands:

`python3 -m venv venv`

`source venv/bin/activate`

## Step 28:
Run `launch.py` just to install requirements it will fail by running the following command.

Run this command:

`python launch.py`

## Step 29:
After it gives you an error run the following commands.

Run these commands:

`uninstall torch torchvision`

`pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.5`

## Step 30:
You should now be able to run Vlad's fork with ROCm 5.5 using the following command.

Run this command:
`python launch.py`

# EXTRA: MANUALLY BUILD PYTORCH & PYVISION
## If you want the faster version you have to build PyTorch & PyVision yourself.

## Step 31:
Run this command:
`pip uninstall torch torchvision`

## Step 32:
Go into your repositories folder that can be found in your automatic folder, and clone PyTorch.

Run these commands:

`cd repositories/`

`git clone https://github.com/pytorch/pytorch`

## Step 33:
Go into the PyTorch folder.

Run this command:
`cd pytorch`

## Step 34:
Run these commands:

`git submodule sync`

`git submodule update --init --recursive`

`python -m pip install --upgrade pip wheel`

`pip install -r requirements.txt`

`python tools/amd_build/build_amd.py`

## Step 35:
Run this command:

`python -c "import site; print(site.getsitepackages()[0])"`

Copy the directory that gave you for use in the next step.

## Step 36:
Use the path the previous command gave you in this command.

Run this command replacing `REPLACEME` with your directory. Keep the quotes:

`export CMAKE_PREFIX_PATH="REPLACEME"`

## Step 37:
Build PyTorch. This will take a while.

Run this command:

`BUILD_TEST=0 USE_CUDA=0 USE_CUDNN=0 USE_ROCM=1 PYTORCH_ROCM_ARCH=gfx1100 USE_MKLDNN=0 python setup.py develop`

## Step 38:
Run these commands:

`export HIP_VISIBLE_DEVICES=0`

`export HSA_OVERRIDE_GFX_VERSION=11.0.0`

## Step 39:
Now we test Torch.

Run this command:

`python`

## Step 40:
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

## Step 41:
If everything works you get a device count and a name (your gpu).

The last like should include a 2x2 grid of numbers.

If you get and segmentation error you closed your terminal after putting "export HSA_OVERRIDE_GFX_VERSION=11.0.0" so put that again and redo the test

## Step 42:
Exit out of the python environment.

Add this, then press enter:
`exit()`

## Step 43:
Go back into the repositories folder.

Run this command:
`cd ../`

## Step 44:
Clone and install PyVision.

Run these commands:

`git clone https://github.com/pytorch/vision`

`cd vision`

`python setup.py install`

## Step 45:
To make sure you dont have to run `export HSA_OVERRIDE_GFX_VERSION=11.0.0` everytime you open the terminal, we are going to edit a systemfile.

Run these commands:

`cd ~`

`nano .bashrc`

## Step 46:
Add the `export HSA_OVERRIDE_GFX_VERSION=11.0.0` at the last line

## Step 47:
Save and exit.

You do so by pressing `CTRL` and `X` to exit.

Then pressing `Enter` to write the changes.

## Step 48:
Run these commands:

`cd automatic`

## Step 49:
You can now use Vlad's fork. You can run `webui.sh` and it will automatically activate the venv for you.

Run this command:
`./webui.sh`

## Step 50:
Enjoy.

# Note:
The original automatic1111 fill mess up your torch install with the launch.py, thats why I chose Vlad's fork.
