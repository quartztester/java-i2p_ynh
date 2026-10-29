# Administering I2P

The router is managed entirely from its own web console. YunoHost's SSO guards the
door — arriving through the portal, the console needs no second login.

## First steps after install

1. Open the console and check the **status page**.
   - **Network: OK** — peers can reach you. You're done.
   - **Firewalled** — the peer port is not reachable from outside; see Ports below.
2. Optionally review *Config → Router manager* for bandwidth limits and relay role.

## Ports

| Purpose | Port | Notes |
|---|---|---|
| Peer transport | `__PORT_EXT__` (TCP **and** UDP) | Must be port-forwarded on your router, or the console reports *Firewalled* and the relay contributes far less. |
| Console | loopback only | Never directly exposed; reachable exclusively through the SSO-gated nginx proxy. |

## Routine settings (inside the console)

- **Bandwidth limits & relay role** — *Config → Router manager*. This package enables
  *floodfill* (a name/database-sharing volunteer role) by default; uncheck it to run
  as a plain relay. Any change here requires a router restart — the console offers a
  reboot button.
- **Log verbosity** — *Logs & log settings* is per-logger. The systemd journal keeps
  the process-side output: `journalctl -u __APP__`.

## Updates

The router's **own software updater is deliberately disabled**: updates arrive from
the I2P apt repository via `yunohost app upgrade i2p`. Do not use the console's
"update now" — it would overwrite dpkg-managed files and break the package.

Want this automated? An opt-in weekly watchdog script ships with the package:
see `scripts/contrib/README.md` (checks the repo, upgrades only when a newer
release exists, logs to `/var/log/i2p-auto-update.log`).

## Data & identity

Router identity (keys, netDB, configuration) lives in the app data dir and is
included in YunoHost app backups. Restoring a backup therefore preserves the same
router identity and its accumulated reputation.

## Troubleshooting

| Symptom | Cause & fix |
|---|---|
| Console shows **Firewalled** | Peer port `__PORT_EXT__` (TCP+UDP) is missing a router port-forward, or the domain's DNS record is Cloudflare-proxied (must be DNS-only for raw ports). |
| I2PSnark (torrent UI) reports *"Configured i2psnark directory ... does not exist"* | Its per-app config holds a stale absolute path. The correct value is relative: `i2psnark.dir=i2psnark` in `i2psnark.config.d/i2psnark.config` inside the data dir. Restart the router after editing. |
| Router slow after boot | Normal on first boot: it performs a large netDB re-check; watch `journalctl -u __APP__`. |
| Router not running | `systemctl status __APP__`; the unit restarts itself on failure (exit 143 on stop is a clean JVM shutdown, not an error). |
| Admin UI "Move the app to a different URL" accepts text after the `/` | The console UI uses absolute URLs, so this app only works at the **root of a domain** — the path field is always empty by design. Moving to another domain (root) works; any path beyond `/` is rejected by the app's change-url script and nothing is moved. |

## Client tunnels (eepsite proxies)

By design this package seeds a minimal relay-only client set: the router console plus the SAM bridge, and nothing else — no HTTP/SOCKS proxies, no eepsite. The **SAM bridge is enabled by default on `127.0.0.1:7656`** so local apps (qBittorrent I2P, other SAM clients) work with no manual step; the distro registers the SAMBridge client with `startOnLoad=false`, and the install/upgrade scripts flip it to `true` in `clients.config.d/01-net.i2p.sam.SAMBridge-clients.config` (edited while the router is stopped). To disable it, set `startOnLoad=false` in that file and restart, or toggle it from the console's client-configuration page. Client tunnels are added through the console's *Hidden Services Manager* (I2P tunnels → Create); they are stored in `i2ptunnel.config.d/` inside the data directory, so they survive upgrades and are included in app backups. Upstream defaults if you recreate proxies by hand: HTTP proxy 4444, HTTPS proxy 4445, SAM 7656, eepsite 7658. When the `i2pd` app runs on the same server, keep its install-time proxy/SAM choices off these numbers — its questions exist for exactly that (both routers default to 7656; whichever installs second automatically falls back to 7666 — read the live value with `yunohost app setting java_i2p port_sam`).
