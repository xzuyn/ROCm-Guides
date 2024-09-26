# Modified: August 4th, 2023.

# Prerequisites:
1. A spare USB stick with at least 12GB, but 16GB or more is best. This will make a USB which you can drop `.iso` files onto and boot them easily.
2. Somewhere you can install Ubuntu. You'll probably want at least 100-200GB at a *minimum* if you plan on using multiple AI tools. Especially if you want space for lots of models. I'd recommend adding as much space as you can.
3. [7-Zip](https://www.7-zip.org/)

## Step 1:
Find the latest release of Ventoy, and download the zip which has `-windows.zip` at the end. (Do Step 1-5 differently depending on if you use Linux as a base already)

https://github.com/ventoy/Ventoy/releases

## Step 2:
Unzip the zip file you just downloaded.

## Step 3:
Go into the the ventoy-`version number` folder.

Run `Ventoy2Disk.exe`

## Step 4:
Select your USB device. Note: This will destory what is on your USB device, so backup anything thats on it.

## Step 5:
Click Install. This will turn your USB device into a `.iso` loader and booter.

## Step 6:
After you've verified that its finished installing you may have to unplug and plug in the USB device.

## Step 7:
There may be 2 new drives in Windows Explorer. If that's the case, one probably won't work. Ignore that and go into the one that works.

## Step 8:
Download `Ubuntu 22.04 LTS` Desktop Image ISO.

https://releases.ubuntu.com/jammy/

## Step 9:
Put that ISO into your Ventoy USB. No folder or anything, just the main part of the USB.

## Step 10:
Reboot into your USB. The steps vary dending on your motherboard, so you'll have to look up what steps to take to get into your `Boot Menu`.

## Step 11:
Select `ubuntu-22.04.3-desktop-amd64`

## Step 12:
Select `Try or Install Ubuntu`

## Step 13:
Select `Install Ubuntu`

## Step 14:
Select your language.

## Step 15:
Have these selected:
- `normal installation`
- `Download updates while installing Ubuntu`
- `Install third-party software for graphics and Wi-Fi hardware and additonal media formats`

## Step 16:
Continue with however you would like to install your Ubuntu. You're able to setup partions manually, or let Ubuntu handle it. This isn't the guide for this specifically yet so you'll need to look this info up yourself for now.

## Step 17:
You can now follow the Main Guide for setting up ROCm [here](..).
