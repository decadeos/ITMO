#!/bin/bash

# Text colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${GREEN}Setting up environment with GPU-aware PyTorch...${NC}"

# Decide which PyTorch wheel to use (GPU if available)
choose_torch_index() {
  # Allow manual override e.g. TORCH_CUDA_VERSION=cu118 ./init_venv_gpu.sh
  if [[ -n "$TORCH_CUDA_VERSION" ]]; then
    echo "https://download.pytorch.org/whl/${TORCH_CUDA_VERSION}"
    return
  fi

  if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi >/dev/null 2>&1; then
    echo -e "${CYAN}NVIDIA GPU detected. Installing CUDA-enabled PyTorch (cu126)...${NC}"
    echo "https://download.pytorch.org/whl/cu126"
  else
    echo -e "${CYAN}No NVIDIA GPU detected. Installing CPU-only PyTorch...${NC}"
    echo "https://download.pytorch.org/whl/cpu"
  fi
}

# Create and activate virtual environment
echo -e "${CYAN}1. Creating virtual environment...${NC}"
python3 -m venv .venv
source .venv/bin/activate

# Install required packages
echo -e "${CYAN}2. Installing required packages...${NC}"
TORCH_INDEX_URL=$(choose_torch_index)
pip install --upgrade pip
pip install  pytest pytest-cov pytest-github-actions-annotate-failures \
  jupyter numpy matplotlib pandas seaborn 
pip install --index-url "${TORCH_INDEX_URL}" \
  torch torchvision

echo -e "${GREEN}Environment ready.${NC}"
