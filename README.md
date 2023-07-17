# THIS IS A TUTORIAL/INSTALL GUIDE FOR ROCM 5.6 ON RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Main Guide
This is the main README guide. This will get you set up to be able to follow the other guides.

It will get you the correct kernals, drivers, and **ROCm 5.6**.

If you don't already have this stuff done, the other guides will be of ***no use to you*** as they ***won't work***.

## Credits:
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
Reboot into the grub menu.

For me I had to press my Esc key *once* while Ubuntu boots.

For you it may be different. You may not need to press anything at all.

You are trying to get to a screen which has an `Advanced options for Ubuntu` selectable.

## Step 4:
Select `Advanced options for Ubuntu`

## Step 5:
Select `Ubuntu, with Linux 5.19.0-46-generic (recovery mode)`

## Step 6:
Select `resume`.

## Step 7:
You now need to remove the unwanted kernals.

Run this command:

`pkg --list | grep -i -E --color 'linux-image|linux-kernel' | grep '^ii'`

## Step 8:
This will give you a list of kernals. You want to `apt-get remove` all except `linux-image-5.19.0-46-generic`.

In my case I had to remove the following;

`apt-remove linux-image-6.1.0-1016-oem`

`apt-remove linux-image-oem-22.04c`

## Step 9:
You now need to restart, but you still need to load into recovery mode so do the same as you did in **step 3**.

## Step 10:
You need to add yourself to render and video.

Run this command:

`sudo usermod -aG video,render $LOGNAME`

## Step 11:
Make sure amdgpu is uninstalled.

Run these commands:

`amdgpu-uninstall`

`sudo apt-get purge amdgpu-install`

## Step 12:
Download the latest drivers.

Run this command:

`wget http://repo.radeon.com/amdgpu-install/5.6/ubuntu/jammy/amdgpu-install_5.6.50600-1_all.deb`

## Step 13:
Now install amdgpu.

Run these commands:

`sudo dpkg -i amdgpu-install_5.6.50600-1_all.deb`

`amdgpu-install --usecase=hip,rocm  --no-32`

## Step 14:
You need to reboot now. You don't need to go into recovery mode anymore, so just boot as you normally would.

Just reboot normally or use run this command:

`reboot`

## Step 15:
Confirm you are using `5.19.0-46-generic`

Run this command:
`uname -r`

## Step 16:
You can try `rocminfo` in the terminal to check if ROCm is installed correctly (you should find your gpu name in there).

## Step 17:
Install the prerq.

Run this command:

`sudo apt install git python3-dev python3-venv libjpeg-dev libpng-dev libstdc++-12-dev cmake`

## Step 18:
Enjoy. You can now follow the other guides in this repo. Just open the folder which has the name of the program you are trying to set up, and read its README.

For example, you can set up VLAD's fork of automatic1111 by following [this guide.](https://github.com/xzuyn/ROCm-Guides/tree/main/VLAD_SD.Next)
