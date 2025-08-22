#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$BOOT_CONF.bak-${STAMP}"

require_root(){
  if [[ $EUID -ne 0 ]]; then
    echo "please run $SCRIPT_NAME with sudo." >&2
    exit 1
  fi
}

ensure_line(){
  local key="$1" value="$2"
  if ! grep -q -E "^${key}=${value}$" "$BOOT_CONF"; then
    echo "${key}=${value}" >> "$BOOT_CONF"
    log "added: ${key}=${value}"
  else
    log "already present: ${key}=${value}"
  fi
}

require_root

log "copying Navio2 overlays..."
sudo cp $OVERLAYS_DIR/navio-rgb.dtbo /boot/overlays/

log "adding Navio2 overlays to $BOOT_CONF..."
if [[ ! -f "$BOOT_CONF" ]]; then
  echo "cannot find $BOOT_CONF" >&2
  exit 1
fi

cp -a "$BOOT_CONF" "$BACKUP"
log "backed up $BOOT_CONF -> $BACKUP"

ensure_line "dtoverlay" "navio-rgb"
ensure_line "enable_uart" "1"
ensure_line "dtparam" "spi=on"
