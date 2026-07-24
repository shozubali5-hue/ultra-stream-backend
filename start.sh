#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "⚡ LAUNCHING ULTIMATE QUANTUM AEGIS BACKEND ENGINE"
echo "=========================================================="

# 1. Environment Diagnostics
echo "[1/4] Checking Python Environment..."
python3 --version || { echo "❌ Python is not installed!"; exit 1; }

# 2. Package Installation
echo "[2/4] Syncing High-Performance Dependencies..."
pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet

# 3. Health Diagnostics
echo "[3/4] Validating Core Application Files..."
if [ ! -f "main.py" ]; then
    echo "❌ Error: main.py not found!"
    exit 1
fi

# 4. Engine Launch
echo "[4/4] Starting Async Uvicorn Micro-Engine on Port 8000..."
exec uvicorn main:app \
    --host 0.0.0.0 \
    --port 8000 \
    --workers 2 \
    --loop uvloop \
    --http httptools \
    --reload
    
