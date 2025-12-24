@echo off
setlocal enableextensions enabledelayedexpansion
pushd "%~dp0"

echo [92mSetting up environment and running tests...[0m

:: 0) Предварительная зачистка от прошлых запусков (не трогаем .venv)
if defined VIRTUAL_ENV call deactivate 2>nul
del /f /q exercises_dirty.py exercises.py 2>nul
for /r %%F in (*.pyc *.pyo) do del /f /q "%%F" 2>nul
for /d /r %%D in (__pycache__) do rmdir /s /q "%%D" 2>nul
rmdir /s /q .pytest_cache 2>nul
rmdir /s /q htmlcov 2>nul
for /d /r %%D in (.ipynb_checkpoints) do rmdir /s /q "%%D" 2>nul
del /f /q .coverage coverage.xml junit.xml 2>nul

:: 1) Проверить/инициализировать и активировать виртуальное окружение
echo [96m1. Checking virtual environment...[0m
if exist ".\.venv\Scripts\activate.bat" (
    echo [96m→ .venv exists. Activating...[0m
) else (
    echo [96m→ .venv not found. Running init_venv.bat...[0m
    if exist "init_venv.bat" (
        call init_venv.bat
        if errorlevel 1 (
            echo [91minit_venv.bat failed[0m
            popd & endlocal & exit /b 1
        )
    ) else (
        echo [91minit_venv.bat not found in %~dp0[0m
        popd & endlocal & exit /b 1
    )
)
call ".venv\Scripts\activate.bat"
if errorlevel 1 (
    echo [91mFailed to activate .venv[0m
    popd & endlocal & exit /b 1
)

:: 2) Установить зависимости (если нужно)
echo [96m2. Installing required packages...[0m
python -m pip install --upgrade pip
python -m pip install pytest pytest-cov pytest-github-actions-annotate-failures jupyter numpy matplotlib pandas seaborn scikit-learn imbalanced-learn
if errorlevel 1 (
    echo [91mPip install failed[0m
    if defined VIRTUAL_ENV call deactivate 2>nul
    popd & endlocal & exit /b 1
)

:: 4) Запустить тесты
echo [96m5. Running tests...[0m
pytest -v auto_tests.py
set testsExit=%errorlevel%

:: 5) Деактивировать окружение
if defined VIRTUAL_ENV call deactivate 2>nul

:: 6) Финальная зачистка мусора (кроме .venv)
echo [96m6. Cleaning up...[0m
for /r %%F in (*.pyc *.pyo) do del /f /q "%%F" 2>nul
for /d /r %%D in (__pycache__) do rmdir /s /q "%%D" 2>nul
rmdir /s /q .pytest_cache 2>nul
rmdir /s /q htmlcov 2>nul
for /d /r %%D in (.ipynb_checkpoints) do rmdir /s /q "%%D" 2>nul
del /f /q .coverage coverage.xml junit.xml 2>nul

echo [92mDone![0m
popd
endlocal
exit /b %testsExit%
