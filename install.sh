#!/usr/bin/env bash
# Redacted — Plymouth Boot Splash — install.  ./install.sh
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DST=/usr/share/plymouth/themes/redacted
[[ $EUID -eq 0 ]] || { echo "run with sudo: sudo ./install.sh" >&2; exit 1; }
rm -rf "$DST"; mkdir -p "$DST"
cp "$HERE"/*.png "$HERE"/redacted.plymouth "$HERE"/redacted.script "$DST"/
chmod -R a+rX "$DST"
if command -v dracut >/dev/null && ! command -v mkinitcpio >/dev/null; then
    plymouth-set-default-theme redacted
    if command -v dracut-rebuild >/dev/null; then dracut-rebuild; else dracut -f; fi
else
    plymouth-set-default-theme -R redacted
fi
echo "Installed; you will see it at next boot."
