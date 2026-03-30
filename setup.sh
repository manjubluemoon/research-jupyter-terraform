#!/bin/bash

apt update -y
apt upgrade -y

apt install -y wget git

# Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/ubuntu/miniconda

echo 'export PATH="/home/ubuntu/miniconda/bin:$PATH"' >> /home/ubuntu/.bashrc

# Environment
/home/ubuntu/miniconda/bin/conda create -y -n research_env python=3.10

# Libraries
/home/ubuntu/miniconda/bin/conda run -n research_env pip install \
jupyterlab numpy pandas matplotlib scikit-learn torch torchvision brian2 snntorch

# Start Jupyter
nohup /home/ubuntu/miniconda/bin/conda run -n research_env \
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root \
> /home/ubuntu/jupyter.log 2>&1 &
