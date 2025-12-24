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

# 2. Convert Jupyter notebook to Python script
echo -e "${CYAN}2. Converting Jupyter notebook to Python script...${NC}"
# use "script" instead of "python" because nbconvert >=7 removed that template
python -m jupyter nbconvert --to script --output exercises_dirty exercises.ipynb

# 3. Clean up converted script
echo -e "${CYAN}3. Cleaning up the converted script...${NC}"
# BSD grep (macOS) doesn’t support -P, so use -E instead
grep -Ev '^\s*#|^\s*$|get_ipython\(\)|(^|\s|=)input\(' exercises_dirty.py > exercises.py

# 4. Run tests
echo -e "${CYAN}4. Running tests...${NC}"
pytest -v jupyter_tests.py

# 5. Clean up
echo -e "${CYAN}5. Cleaning up...${NC}"
deactivate
rm -f exercises_dirty.py exercises.py
rm -rf __pycache__ .pytest_cache

echo -e "${GREEN}Done!${NC}"
