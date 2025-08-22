#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

log "getting the code..."
if [ -d "$ARDUPILOT_DIR" ]; then 
    rm -rf "$ARDUPILOT_DIR"
fi 

cd "$HOME"

git clone https://github.com/ArduPilot/ardupilot.git
cd $ARDUPILOT_DIR
git submodule update --init --recursive

log "installing build tools..."
sudo apt install -y python3-serial python3-dev libtool libxml2-dev libxslt1-dev \
  gawk python3-pip pkg-config build-essential ccache libffi-dev \
  libjpeg-dev zlib1g-dev
sudo python3 -m pip install --upgrade pymavlink MAVProxy --break-system-packages

log "building ArduCopter for Navio2..."
./waf configure --board=navio2
./waf copter

log "adding ArduPilot as a service..."
sudo bash "$SCRIPTS_DIR/131_ardupilot_service.sh"