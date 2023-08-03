# THIS IS A TUTORIAL/INSTALL GUIDE FOR ROCM 5.6 ON RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Main Guide
This is the main README guide. This will get you set up to be able to follow the other guides.

It will get you the correct kernals, drivers, and **ROCm 5.6**.

If you don't already have this stuff done, the other guides will be of ***no use to you*** as they ***won't work***.

## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

Modified: **August 2nd, 2023.**

## Step 1:
Install `Ubuntu 22.04.2 LTS`

https://releases.ubuntu.com/jammy/

## Step 2:
Open a terminal.

Press these keys:

`Ctrl` + `Alt` + `T`

## Step 3:
Run these commands:

`sudo add-apt-repository ppa:cappelikan/ppa`

`sudo apt update`

`sudo apt install mainline`

## Step 4:
Launch mainline and verify that the `5.19.0-50-generic` is running.

Run this command:

`mainline`

Look near the top on the 4th line, and check what `Running kernel:` says.

You are likely running `5.19.0-50-generic`. If so, continue with the guide. If you aren't {I need to add this to the guide}

## Step 5:
You need to add yourself to render and video.

Run this command:

`sudo usermod -aG video,render $LOGNAME`

## Step 6:
Make sure AMDGPU is uninstalled.

Run these commands:

`amdgpu-uninstall`

`sudo apt-get purge amdgpu-install`

## Step 7:
Download the latest drivers.

Run this command:

`wget http://repo.radeon.com/amdgpu-install/5.6/ubuntu/jammy/amdgpu-install_5.6.50600-1_all.deb`

## Step 8:
Now install AMDGPU.

Run these commands:

`sudo dpkg -i amdgpu-install_5.6.50600-1_all.deb`

`amdgpu-install --usecase=hip,rocm  --no-32`

## Step 9:
You need to reboot now, and you don't need to go into recovery mode anymore so just boot as you normally would.

Run this command:

`reboot`

## Step 10:
Check if ROCm is installed correctly. You should find your GPU name.

Open the terminal and run this command:

`rocminfo`

## Step 11:
Install the prerequisites.

Run this command:

`sudo apt install git python3-dev python3-venv libjpeg-dev libpng-dev libstdc++-12-dev cmake`

## Step 12:
Enjoy. You can now follow the other guides in this repo. Just open the folder which has the name of the program you are trying to set up, and read its README.

For example, you can set up VLAD's fork of automatic1111 by following [this guide.](https://github.com/xzuyn/ROCm-Guides/tree/main/VLAD_SD.Next)
