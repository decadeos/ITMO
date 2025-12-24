#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${GREEN}Setting up environment and running tests...${NC}"

# 1. Init or activate venv
echo -e "${CYAN}1. Checking virtual environment...${NC}"
if [ -d ".venv" ]; then
    echo -e "${CYAN}→ Virtual environment already exists. Activating...${NC}"
    source .venv/bin/activate
else
    echo -e "${CYAN}→ Virtual environment not found. Initializing...${NC}"
    bash init_venv.sh
    source .venv/bin/activate
fi

# 2. Run tests
echo -e "${CYAN}4. Running tests...${NC}"
pytest -v auto_tests.py

# 3. Clean up
echo -e "${CYAN}5. Cleaning up...${NC}"
deactivate
rm -rf __pycache__ .pytest_cache

echo -e "${GREEN}Done!${NC}"
