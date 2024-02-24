#!/bin/bash

# User can set their arguments here
# Remove the "#" from the line below and add your arguments

#USER_ARGS=""

# Activate the virtual environment
echo "Activating virtual environment"
source venv/bin/activate

# Run the main.py script with user arguments
echo "Running ComfyUI"
python main.py $USER_ARGS