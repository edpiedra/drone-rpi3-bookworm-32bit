#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

log "installing requirements in drone virtual environment..."
sudo apt-get install -y python3-opencv python3-numpy 
cd "$PROJECT_DIR"

if [ ! -d .venv ]; then 
log "creating virtual environment..."
    python3 -m venv .venv --system-site-packages
    set +u; source .venv/bin/activate; set -u
    python3 -m pip install "$NAVIO2_WHEEL"
    python3 -m pip install -r requirements.txt
    set +u; deactivate; set -u
else 
    set +u; source .venv/bin/activate; set -u
    python3 -m pip install "$NAVIO2_WHEEL"
    python3 -m pip install -r requirements.txt
    set +u; deactivate; set -u
fi