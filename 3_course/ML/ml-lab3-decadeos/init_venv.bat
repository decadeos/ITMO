@echo off
echo Setting up environment...

echo 1. Creating virtual environment...
python -m venv .venv
if not exist ".venv" (
  echo Failed to create .venv
  exit /b 1
)

echo 2. Activating virtual environment...
call .venv\Scripts\activate.bat

echo 3. Installing required packages...
python -m pip install --upgrade pip
pip install pytest pytest-cov pytest-github-actions-annotate-failures ^
 jupyter numpy matplotlib pandas seaborn scikit-learn imbalanced-learn

echo Done.
