#!/usr/bin/env bash

wget -O /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash /tmp/miniconda.sh -b -p ~/.local/share/miniconda
eval "$(~/.local/share/miniconda/bin/conda shell.zsh hook)"
conda init zsh
conda config --set auto_activate_base false
conda deactivate
