# THIS IS A TUTORIAL/INSTALL GUIDE FOR ROCM 6.2 ON RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Main Guide
This is the main README guide. This will get you set up to be able to follow the other guides.

It will get you the correct graphics drivers and **ROCm 6.2**.

If you don't already have this stuff done, the other guides will be of ***no use to you*** as they ***won't work***.

In this guide we will use the 22.04 version of Ubuntu. 

## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

Modified: **December 18th, 2023.**

## Step 1:
Install `Ubuntu® 22.04 LTS`

[https://releases.ubuntu.com/jammy/](https://releases.ubuntu.com/jammy/)

A more in-depth guide can be found [here](/Ubuntu-From-Windows-10/)

## Step 2:
Install any pending updates.

`sudo apt-get update`

`sudo apt-get dist-upgrade`

## Step 3:
Reboot if it asks.

## Step 4:
You need to add yourself to render and video.

Run this command:

`sudo usermod -aG video,render $LOGNAME`

## Step 5:
Make sure AMDGPU is uninstalled.

Run these commands:

`amdgpu-uninstall`

`sudo apt-get purge amdgpu-install`

If this is a new system this step can be skipped.

## Step 6:
Download the latest drivers.

Run this command:

`wget https://repo.radeon.com/amdgpu-install/6.0.2/ubuntu/jammy/amdgpu-install_6.0.60002-1_all.deb`

## Step 7:
Now install the rocm software stack.

Run these commands:

`wget https://repo.radeon.com/amdgpu-install/6.2.1/ubuntu/jammy/amdgpu-install_6.2.60201-1_all.deb
sudo apt install ./amdgpu-install_6.2.60201-1_all.deb
sudo apt update
sudo apt install amdgpu-dkms rocm`

`amdgpu-install -y --usecase=graphics,rocm,hip`

## Step 8:
You need to reboot now. 

Run this command:

`reboot`

## Step 9:
Check if ROCm is installed correctly.

Open the terminal and run this command:

`dkms status`

you should get something along the lines of: 

`amdgpu/x.x.x-xxxxxxx.xx.xx, x.x.x-xx-generic, x86_64: installed`

After that succeeded run this command: 

`rocminfo`

you should be seeing your gpu in the list:

```
*******
Agent 2
*******
  Name:                    gfx1100
  Uuid:                    GPU-5ecee39292e80c37
  Marketing Name:          Radeon RX 7900 XTX
  Vendor Name:             AMD
```

## Step 10:
Install the prerequisites.

Run this command:

`sudo apt install git python3-dev python3-venv libjpeg-dev libpng-dev libstdc++-12-dev cmake`

## Step 11:
Enjoy. You can now follow the other guides in this repo. Just open the folder which has the name of the program you are trying to set up, and read its README.

For example, you can set up VLAD's fork of automatic1111 by following [this guide.](https://github.com/xzuyn/ROCm-Guides/tree/main/VLAD_SD.Next)
