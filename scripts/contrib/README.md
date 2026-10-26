# Optional: weekly auto-update (opt-in)

The router's in-console updater is disabled by design — updates arrive from the
official I2P apt repository as dpkg-managed package upgrades. If you don't want
to run `yunohost app upgrade i2p` by hand, install the included watchdog:

```bash
sudo install -m 755 scripts/contrib/i2p-auto-update.sh /usr/local/bin/i2p-auto-update
echo '30 4 * * 1 root /usr/local/bin/i2p-auto-update' | sudo tee /etc/cron.d/i2p-auto-update
```

What it does, weekly at 04:30 Monday:

- `apt-get update`, then compares installed vs candidate `i2p-router`
- **Only when a newer release exists** it runs `yunohost app upgrade java_i2p -b`
  (packaged upgrade path — configs and permissions are re-rendered correctly)
- Logs one line per run to `/var/log/i2p-auto-update.log`, including a warning
  if the apt source for the I2P repo has gone missing (which would otherwise
  turn every run into a silent no-op)
- On a failed upgrade the previously installed version remains in place

Remove `/etc/cron.d/i2p-auto-update` to disable.
