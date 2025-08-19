#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

log "updating system packages..."
sudo apt-get update && sudo apt-get -y dist-upgrade

log "installing system dependencies..."
sudo apt install git cmake g++ python3 python3-pip screen -y