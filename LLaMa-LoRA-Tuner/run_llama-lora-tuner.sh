#!/bin/bash

read -p "HF ID or Model Directory (Required): " base_model_input

if [ -z "$base_model_input" ]; then
  echo "Base model input cannot be empty."
  exit 1
fi

read -p "WandB API Key (Optional): " wandb_api_key_input

if [ -z "$wandb_api_key_input" ]; then
  wandb_arg=" "
else
  wandb_arg=" --wandb_api_key=$wandb_api_key_input "
fi

source rocm_venv/bin/activate
export HIP_VISIBLE_DEVICES=0
export HSA_OVERRIDE_GFX_VERSION=11.0.0
export TOKENIZERS_PARALLELISM=false

python app.py --data_dir='./data' --base_model="$base_model_input"$wandb_arg--skip_loading_base_model=True
