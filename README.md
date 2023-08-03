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
Launch mainline and verify that the `6.1.0-1016-oem` is running.

Run this command:

`mainline`

Look near the top, and check what `Running kernel` says.

You are likely running `6.1.0-1016-oem`, so continue with the guide. If you are already on `5.19.0-46-generic` you can skip to **Step 13**

## Step 5:
Check if `6.1.0-1016.16` is running, and `5.19.0.46.47~22.04.21` & `5.19.0.46.47~22.04.21`(?) are installed.

Run this command:

`mainline --list-installed`

If `5.19.0.46.47~22.04.21` and `5.19.0.46.47~22.04.21`(?) are not installed, idk yet.

Continue with the guide if they are installed.

## Step 6:
Reboot into the grub menu.

For me I had to press `Esc` *once* while Ubuntu boots.

For you it may be different. You may need to *hold* `Shift` while Ubuntu boots, you may not need to press anything at all.

You are trying to get to a screen which has an `Advanced options for Ubuntu` selectable.

## Step 7:
Select `Advanced options for Ubuntu`

## Step 8:
Select `Ubuntu, with Linux 5.19.0-46-generic (recovery mode)`

## Step 9:
Select `resume`.

Note: We boot into recovery mode because if you boot into 5.19 with an RDNA3 card and an IGPU, you may get a `fatal gpu` error.

## Step 10:
You now need to remove the unwanted kernals.

Run this command:

`pkg --list | grep -i -E --color 'linux-image|linux-kernel' | grep '^ii'`

## Step 11:
This will give you a list of kernals. You want to `apt-get remove` all except `linux-image-5.19.0-46-generic`.

In my case I had to remove the following by running these commands:

`apt-remove linux-image-6.1.0-1016-oem`

`apt-remove linux-image-oem-22.04c`

## Step 12:
You now need to restart, but you still need to load into recovery mode so do the same as you did in **step 5**.

## Step 13:
You need to add yourself to render and video.

Run this command:

`sudo usermod -aG video,render $LOGNAME`

## Step 14:
Make sure AMDGPU is uninstalled.

Run these commands:

`amdgpu-uninstall`

`sudo apt-get purge amdgpu-install`

## Step 15:
Download the latest drivers.

Run this command:

`wget http://repo.radeon.com/amdgpu-install/.5.6.1/ubuntu/jammy/amdgpu-install_5.6.50601-1_all.deb`

## Step 16:
Now install AMDGPU.

Run these commands:

`sudo dpkg -i amdgpu-install_5.6.50601-1_all.deb`

`amdgpu-install --usecase=hip,rocm  --no-32`

## Step 17:
You need to reboot now, and you don't need to go into recovery mode anymore so just boot as you normally would.

Run this command:

`reboot`

## Step 18:
Confirm you are using `5.19.0-46-generic`

Run this command:
`uname -r`

## Step 19:
You can try `rocminfo` in the terminal to check if ROCm is installed correctly (you should find your GPU name in there).

## Step 20:
Install the prerequisites.

Run this command:

`sudo apt install git python3-dev python3-venv libjpeg-dev libpng-dev libstdc++-12-dev cmake`

## Step 21:
Enjoy. You can now follow the other guides in this repo. Just open the folder which has the name of the program you are trying to set up, and read its README.

For example, you can set up VLAD's fork of automatic1111 by following [this guide.](https://github.com/xzuyn/ROCm-Guides/tree/main/VLAD_SD.Next)
