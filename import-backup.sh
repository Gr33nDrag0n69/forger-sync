#!/bin/bash

# Gr33nDrag0n 2021-08-26

if [ $( ps -ef | grep "lisk-core start" | grep -v grep | wc -l ) -ge 1 ]
then
    echo "The lisk-core process is running. Stop it and retry."
    exit 1
fi

echo "Sync. Git Repository."
cd "$HOME/forger-sync/"
git pull --rebase --quiet

echo "Select Backup to Import."
cd "$HOME/forger-sync/backup/"
select Directory in *
do
    test -n "$Directory" && break
    echo ">>> Invalid Selection"
done

BackupFilePath="$HOME/forger-sync/backup/$Directory/forger.db.tar.gz"

echo "Importing: $BackupFilePath"
"$HOME/lisk-core/bin/lisk-core" forger-info:import "$BackupFilePath"
