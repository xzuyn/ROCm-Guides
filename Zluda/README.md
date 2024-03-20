# [AMD] Experimental Guide: Install Zluda on AMD Windows with Auto1111 Directml Fork

## Prerequisites
- Install AMD HIP SDK 5.7 from here: https://www.amd.com/en/developer/resources/rocm-hub/hip-sdk.html
- Add the C:\ZLUDA folder and %HIP_PATH%bin to your PATH in the System Variables. Like shown here: https://www.wikihow.com/Change-the-PATH-Environment-Variable-on-Windows
- If your GPU is below a RX 6800, you need to to the following steps mentioned here: (Without installing SD.next) https://github.com/vladmandic/automatic/wiki/ZLUDA#replace-hip-sdk-library-files-for-gpu-architectures-gfx1031-and-gfx1032

### Step 1
Go to the foldere you want your Zluda install to be, right click empty space inside the folder and select **Open in Terminal**

### Step 2
Get the setup script.

Run this command:

`Invoke-WebRequest -Uri https://raw.githubusercontent.com/xzuyn/ROCm-Guides/develop/Zluda/zluda_setup.bat -OutFile zluda_setup.bat`

### Step 3:
Run the setup script.

Run this command:

`.\zluda_setup.bat`

### Step4:
The install is complete and you can start the webui as normal with the webui-user.bat file.

Modified: **March 20, 2024**
