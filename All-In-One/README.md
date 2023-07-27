# THIS IS A TUTORIAL/INSTALL GUIDE FOR ROCM 5.6 ON RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

Modified: **July 27th, 2023.**

## Guide Info:
This will let you use ROCm with multiple AI projects with just one venv to keep disk usage down.

A list of added projects:
- LLaMa-LoRA-Tuner
- kohya_ss

A list of projects I intend to add:
- VLAD_SD.Next

A list of projects I intend to add if I can solve issues that prevent it from working right:
- Alpaca-LoRA

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](https://github.com/xzuyn/ROCm-Guides/).

## Step 1:
Get the setup and run bash scripts from this repo.

Run these commands:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/All-In-One/setup_rocm_venv_whl.sh`

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/All-In-One/setup_rocm_venv_build.sh`

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/All-In-One/run_llama-lora-tuner.sh`

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/All-In-One/run_kohya_ss.sh`

## Setup 2:
Give the bash scripts permissions to run.

Run these commands:

`chmod +x setup_rocm_venv_whl.sh`

`chmod +x setup_rocm_venv_build.sh`

`chmod +x run_llama-lora-tuner.sh`

`chmod +x run_kohya_ss.sh`

## Step 3 (Option 1):
Setup the venv with the wheel for PyTorch+ROCm5.6.

Run this command:

`./setup_rocm_venv_whl.sh`

After thats complete, you should now be able to run LLaMa-LoRA-Tuner or kohya_ss with the two run bash script.

Run either of these commands:

`./run_llama-lora-tuner.sh`

`./run_kohya_ss.sh`

## Step 3 (Option 2):
Setup the venv with by building PyTorch+ROCm. This will take longer, but will be a more updated version of PyTorch.

Run this command:

`./setup_rocm_venv_build.sh`

After thats complete, you should now be able to run LLaMa-LoRA-Tuner or kohya_ss with the two run bash script.

Run either of these commands:

`./run_llama-lora-tuner.sh`

`./run_kohya_ss.sh`

## Note:
- You will get an error and complaints about bitsandbytes and CUDA. This will be the last thing you see before the model starts loading, so it will sit there for a while. It's not broken, so just wait.

- If a model complains about not having a padding token, follow this; https://github.com/zetavg/LLaMA-LoRA-Tuner/discussions/29

- Some good small models to start with are; `openlm-research/open_llama_3b_v2` or `meta-llama/Llama-2-7b-hf`
