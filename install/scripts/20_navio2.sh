#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

log "cloning Emlid's Navio2 repo..."
git clone https://github.com/emlid/Navio2.git
cd Navio2

log "installing rcio firmware..."
cd C++
sudo ./install_tools.sh

log "adding Navio2 overlays..."
sudo bash "$SCRIPTS_DIR/121_navio2_overlays.sh"