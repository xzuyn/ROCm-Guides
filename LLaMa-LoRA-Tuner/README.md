# THIS IS A TUTORIAL/INSTALL GUIDE FOR ROCM 5.6 ON RDNA3 GPUS. IT WILL NOT WORK WITH OLDER MODELS.
## Credits:
- https://github.com/m68k-fr/Compiling-Pytorch-for-ROCm
- ODIN the GOAT
- https://github.com/Kademo15

This is not the original guide. It has been modified to add more steps that *I* had to run. Some steps may not be required, but shouldn't cause any issues.

Modified: **August 3rd, 2023.**

## Step 0:
If you don't already have your system setup with the correct drivers, kernels, etc, please follow the Main Guide [README.md](..).

## Step 1:
Clone LLaMa-LoRA-Tuner.

Run these commands:

`git clone https://github.com/zetavg/LLaMA-LoRA-Tuner.git`

`cd LLaMA-LoRA-Tuner`

## Step 2:
Get the setup and run bash scripts from this repo.

Run these commands:

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/LLaMa-LoRA-Tuner/setup_rocm_venv_whl.sh`

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/LLaMa-LoRA-Tuner/setup_rocm_venv_build.sh`

`wget https://raw.githubusercontent.com/xzuyn/ROCm-Guides/main/LLaMa-LoRA-Tuner/run_llama-lora-tuner.sh`

## Setup 3:
Give the bash scripts permissions to run.

Run these commands:

`chmod +x setup_rocm_venv_whl.sh`

`chmod +x setup_rocm_venv_build.sh`

`chmod +x run_llama-lora-tuner.sh`

## Step 4 (Option 1):
Setup the venv with the wheel for PyTorch+ROCm5.6.

Run this command:

`./setup_rocm_venv_whl.sh`

After thats complete, you should now be able to run LLaMa-LoRA-Tuner with the run bash script.

Run this command:

`./run_llama-lora-tuner.sh`

## Step 4 (Option 2):
Setup the venv with by building PyTorch+ROCm. This will take longer, but will be a more updated version of PyTorch.

Run this command:

`./setup_rocm_venv_build.sh`

After thats complete, you should now be able to run LLaMa-LoRA-Tuner with the run bash script.

Run this command:

`./run_llama-lora-tuner.sh`

## Note:
- You will get errors and complaints about bitsandbytes and CUDA. You can ignore these.

- If a model complains about not having a padding token, follow this; https://github.com/zetavg/LLaMA-LoRA-Tuner/discussions/29

- Some good small models to start with are; `openlm-research/open_llama_3b_v2` or `meta-llama/Llama-2-7b-hf`
