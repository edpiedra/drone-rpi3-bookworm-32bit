#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

log "getting the code..."
cd ~
git clone https://github.com/ArduPilot/ardupilot.git
cd ardupilot
git submodule update --init --recursive

log "installing build tools..."
sudo apt install -y python3-pyserial python3-dev libtool libxml2-dev libxslt1-dev \
  gawk python3-pip pkg-config build-essential ccache libffi-dev \
  libjpeg-dev zlib1g-dev
pip3 install pymavlink MAVProxy

log "building ArduCopter for Navio2..."
./waf configure --board=navio2
./waf copter

