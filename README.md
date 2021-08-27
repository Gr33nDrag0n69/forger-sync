# Forger-Sync

This project is a collection of bash scripts that allow installation of an automated lisk log monitoring script that will make a forging-info & forger-status backup online every time a new block is forged by a local forging delegate.

If you follow the guide, you'll have full backup of your forger info in the "cloud" in real-time for FREE.

Using GitHub have the advantage of keeping history of all change so you'll be able to see hostname - delegate - time of each change. 

The toolset also contain easy forger.db restore and custom forging enable script.

## Warning(s)

* There is currently no config file in the project and some things are hard coded.
  * The project base path is: `$HOME/forger-sync/`.
  * The git pull/push commands are always active.
* This code require that the target lisk-core node run with `info` log level.

## Prepare New GitHub Project

### Create new GitHub dedicated user

* Register a new account here: [github.com/signup](https://github.com/signup)
* Login into your GitHub account.

### Create GitHub user token

* Create a new Personal Access Token here: [github.com/settings/tokens/new](https://github.com/settings/tokens/new)
  * Note: forger-sync
  * Expiration: No Expiration
  * Scope: repo
* Save your new token safely to a password manager.

### Create your own private project copy

* Create a new private repository here: [github.com/new](https://github.com/new)
  * Repository name: forger-sync
  * Visibility: private

### Copy source code to new private repository

Using any linux server, initialize your new private project with a copy of my public project.
Note 1: Not using a fork of my project allow you to use it with a free private repository on GitHub.
Note 2: The following code will need to be run again every time you want to update codebase of your private project without affecting your data backups.

```bash
# IMPORTANT: EDIT THE FOLLOWING VALUE TO MATCH YOUR GIT PROJECT URL
GIT_URL="https://github.com/GitHubUsername/forger-sync.git"

git clone --bare https://github.com/Gr33nDrag0n69/forger-sync.git
cd forger-sync.git
git push --mirror "$GIT_URL"
cd ..
rm -rf forger-sync.git
```

## Install GitHub Project on Lisk server(s).

```bash
# IMPORTANT: EDIT THE FOLLOWING VALUES TO MATCH YOUR GIT TOKEN & GIT PROJECT URL
GIT_TOKEN='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'
GIT_URL="https://${GIT_TOKEN}@github.com/GitHubUsername/forger-sync.git"

# Clone project & make all bash scripts executable
cd "$HOME"
git clone "$GIT_URL"
chmod 0700 $HOME/forger-sync/*.sh

# Configure server git name & mail that will appear in the git commits made from this given server.
cd "$HOME/forger-sync/"
git config user.name "$HOSTNAME"
git config user.email "forger-sync@$HOSTNAME"
cd "$HOME"
```

## First Start

```bash
# Test Backup is working as expected.
~/forger-sync/backup.sh

# Start Log Monitor
~/forger-sync/start-logmonitor.sh

# Install Keep Alive
~/forger-sync/install-keepalive.sh
```

## Normal Usage

### Check history of backups with file modification

* Login in the GitHub account.
* Click on the "commits" link under the code button.

### Bash Scripts

```bash
# Check internal log file.
~/forger-sync/show-logs.sh

# Preferred Method: Import forging-info backup
# This method will allow to start forging using the normal method.
~/forger-sync/import-backup.sh

# Alternate Method: Start forging using forger:status backup (0.75 LSK Fee on 1st block)
~/forger-sync/enable-forging.sh
```

## Script List

```markdown
# backup.sh

Create a new backup and push it on GitHub.

# enable-forging.sh

Enable forging using forger:status values backup.

# import-backup.sh

Restore local forging-info backup to local database.

# show-log.sh

Show the content of `forger-sync/logs/logmonitor.log`.

# logmonitor.sh

Monitor `$HOME/.lisk/lisk-core/logs/lisk.log` for `Forged new block`.
When a new block is forged, execute `forger-sync/backup.sh`

# start-logmonitor.sh

Start `forger-sync/logmonitor.sh` as a background process.

# stop-logmonitor.sh

Kill all running instance of `forger-sync/logmonitor.sh` background process

# keepalive.sh

If `forger-sync/logmonitor.sh` background process isn't currently running, execute `forger-sync/start-logmonitor.sh`.

# install-keepalive.sh

Add crontab job to execute `keepalive.sh` once each minute.

# uninstall-keepalive.sh

Remove crontab job.
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
