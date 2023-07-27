#!/bin/bash

source ROCm_AI/rocm_venv/bin/activate
export HIP_VISIBLE_DEVICES=0
export HSA_OVERRIDE_GFX_VERSION=11.0.0

cd ROCm_AI/kohya_ss
export HF_HOME=./HF_HOME/

python kohya_gui.py "$@"
