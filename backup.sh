#!/bin/bash

# Gr33nDrag0n 2021-08-02

Delegate="N/A"
Height="N/A"

while getopts d:h: flag
do
    case "${flag}" in
        d)
            FullDelegate=${OPTARG}
            Delegate="${FullDelegate::5}...${FullDelegate: -5}"
            ;;

        h)
            Height=${OPTARG};;
    esac
done

CommitMessage="Delegate: $Delegate Height: $Height"
BackupPath="$HOME/forger-sync/backup/$HOSTNAME/"
ForgingStatusJsonFile="$HOME/forger-sync/backup/$HOSTNAME/ForgingStatus.json"

cd "$HOME/forger-sync/"
mkdir -p "$BackupPath"

"$HOME/lisk-core/bin/lisk-core" forger-info:export --output "$BackupPath"

echo "Writing 'Forging Status Json File'."
"$HOME/lisk-core/bin/lisk-core" forging:status | jq '.' > "$ForgingStatusJsonFile"

echo "Creating Git Commit '$CommitMessage'."
git add --all
git commit -m "$CommitMessage" --quiet

echo "Sync. Git Repository."
git pull --rebase --quiet && git push --quiet
