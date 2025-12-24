#!/bin/bash

# Text colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${GREEN}Setting up environment and running tests...${NC}"

# Create and activate virtual environment
echo -e "${CYAN}1. Creating virtual environment...${NC}"
python3 -m venv .venv
source .venv/bin/activate

# Install required packages
echo -e "${CYAN}2. Installing required packages...${NC}"
pip install --upgrade pip
pip install pytest pytest-cov pytest-github-actions-annotate-failures \
            jupyter numpy matplotlib pandas seaborn scikit-learn
