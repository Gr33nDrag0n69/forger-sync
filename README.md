# Forger-Sync

This project is a collection of bash scripts that allow installation of an automated lisk log monitoring script that will make a forging-info & forger-status backup online every time a new block is forged by a local forging delegate.

## Warning(s)

* There is currently no config file in the project and some things are hard coded. (for now, at least)
  * The project base path is: `$HOME/forger-sync/`.
  * The git pull/push commands are always active.

## Script List

### backup.sh

TODO

### `enable-forging.sh`

TODO

### `import-backup.sh`

TODO

### `keepalive.sh`

TODO

### `logmonitor.sh`

TODO

### `show-log.sh`

TODO

### `start-logmonitor.sh`

TODO

### `stop-logmonitor.sh`

TODO

### `install-keepalive.sh`

Add crontab job to execute `keepalive.sh` once each minute.

### `uninstall-keepalive.sh`

Remove crontab job.

## Install

```bash
# IMPORTANT: EDIT THE FOLLOWING VALUES TO MATCH YOUR GIT TOKEN & GIT PROJECT URL
# The cloning using your token is what will allow git pull & push to be automated.

GIT_TOKEN='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'
GIT_URL="https://${GIT_TOKEN}@github.com/Gr33nDrag0n69/forger-sync.git"

# Clone project & make all bash scripts executable

cd "$HOME"
git clone "$GIT_URL"
chmod 0700 "$HOME/forger-sync/*.sh"

# Configure server git name & mail that will appear in the git commits made from this given server.

cd "$HOME/forger-sync/"
git config user.name "$HOSTNAME"
git config user.email "forger-sync@$HOSTNAME"

# Test Backup is working as expected.

# Start Log Monitor

# Install Keep Alive


```

## Soon TM List

This section will be used to make a misc list of ideas that could be implemented in the toolkit.
Feel free to send me suggestions in lisk discord.

* Support Config File
  * Define base path used by all scripts.
  * Enable/Disable git sync. (pull/push) (forger-info:export & forging:status)
* Add telegram bot option (forging:status only)
* Add send by email (forging:status only)
* Add discord bot option (forging:status only)
