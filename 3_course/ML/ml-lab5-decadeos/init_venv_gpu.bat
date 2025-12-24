@echo off
echo Setting up environment with GPU-aware PyTorch...

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

rem Decide which PyTorch wheel to use (GPU if available)
set "TORCH_PACKAGES=torch torchvision"
set "TORCH_INDEX_URL="

if not "%TORCH_CUDA_VERSION%"=="" (
  set "TORCH_INDEX_URL=https://download.pytorch.org/whl/%TORCH_CUDA_VERSION%"
  echo Using CUDA version from TORCH_CUDA_VERSION=%TORCH_CUDA_VERSION%
) else (
  where nvidia-smi >nul 2>&1
  if %ERRORLEVEL%==0 (
    set "TORCH_INDEX_URL=https://download.pytorch.org/whl/cu126"
    echo NVIDIA GPU detected. Installing CUDA-enabled PyTorch (cu126)...
  ) else (
    set "TORCH_INDEX_URL=https://download.pytorch.org/whl/cpu"
    echo No NVIDIA GPU detected. Installing CPU-only PyTorch...
  )
)

pip install --index-url %TORCH_INDEX_URL% ^
 pytest pytest-cov pytest-github-actions-annotate-failures ^
 jupyter numpy matplotlib pandas seaborn ^
 %TORCH_PACKAGES%

echo Done.
