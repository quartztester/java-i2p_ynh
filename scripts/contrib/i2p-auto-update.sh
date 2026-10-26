#!/bin/bash
# i2p auto-update — weekly freshness check for the i2p router (i2p_ynh).
#
# The router's own self-updater is disabled by design (it would overwrite
# dpkg-managed files). This script is the automated substitute: it checks the
# official I2P apt repo and, only when a newer release exists, performs a
# proper packaged upgrade via `yunohost app upgrade` so configs/permissions
# are re-rendered correctly.
#
# Opt-in install: copy this file to /usr/local/bin/ and install the cron.d
# entry shipped next to it (or per README). Log: /var/log/i2p-auto-update.log
set -u
PKG=i2p-router
LOG=/var/log/i2p-auto-update.log
log() { echo "$(date -Is) $*" >> "$LOG"; }

apt-get update -qq >> "$LOG" 2>&1

# Self-check: a vanished apt source would make every run a silent no-op.
if ! apt-cache policy "$PKG" 2>/dev/null | grep -q 'deb.i2p.net\| Candidate: [0-9]'; then
    log "WARNING: apt source for $PKG seems missing (no candidate); update channel broken?"
    exit 1
fi

installed=$(dpkg-query -W -f='${Version}' "$PKG" 2>/dev/null)
candidate=$(apt-cache policy "$PKG" 2>/dev/null | awk '/Candidate:/{print $2}')

if [ -z "$candidate" ] || [ "$candidate" = "(none)" ]; then
    log "WARNING: no candidate version for $PKG"
    exit 1
fi

if [ "$installed" = "$candidate" ]; then
    log "up to date ($installed)"
    exit 0
fi

log "new release available: $installed -> $candidate; running packaged upgrade"
if yunohost app upgrade java_i2p -b >> "$LOG" 2>&1; then
    log "upgrade to $candidate completed successfully"
else
    rc=$?
    log "ERROR: yunohost app upgrade failed (rc=$rc); previous version $installed remains installed"
    exit "$rc"
fi
