# THIS IS A TUTORIAL/INSTALL GUIDE FOR ROCM 5.7 ON RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Main Guide
This is the main README guide. This will get you set up to be able to follow the other guides.

It will get you the correct graphics drivers and **ROCm 5.7**.

If you don't already have this stuff done, the other guides will be of ***no use to you*** as they ***won't work***.

## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

Modified: **October 23rd, 2023.**

## Step 1:
Install `Ubuntu® 22.04.3 LTS`

https://releases.ubuntu.com/jammy/

A more in-depth guide can be found [here](/Ubuntu-From-Windows-10/)

## Step 2:
Run the Software Updater

## Step 3:
Install any pending updates.
`sudo apt-get update`

`sudo apt-get dist-upgrade`

## Step 4:
Reboot if it asks.

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

`wget https://repo.radeon.com/amdgpu-install/23.20.00.48/ubuntu/jammy/amdgpu-install_5.7.00.48.50700-1_all.deb`

## Step 8:
Now install AMDGPU.

Run these commands:

`sudo apt install ./amdgpu-install_5.7.00.48.50700-1_all.deb`

`amdgpu-install -y --usecase=graphics,rocm`

## Step 9:
You need to reboot now. 

Run this command:

`reboot`

## Step 10:
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

## Step 11:
Install the prerequisites.

Run this command:

`sudo apt install git python3-dev python3-venv libjpeg-dev libpng-dev libstdc++-12-dev cmake`

## Step 12:
Enjoy. You can now follow the other guides in this repo. Just open the folder which has the name of the program you are trying to set up, and read its README.

For example, you can set up VLAD's fork of automatic1111 by following [this guide.](https://github.com/xzuyn/ROCm-Guides/tree/main/VLAD_SD.Next)
