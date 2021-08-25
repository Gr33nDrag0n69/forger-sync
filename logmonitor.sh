#!/bin/bash

# Gr33nDrag0n 2021-08-02

LiskLogFile="$HOME/.lisk/lisk-core/logs/lisk.log"

tail -Fn0 "$LiskLogFile" | \
while read Line ; do
    #echo "$Line" | jq '.'
    if [[ $Line == *"Forged new block"* ]]; then
        sleep 9
        Delegate=$( echo "$Line" | jq -r '.meta.generatorAddress' )
        Height=$( echo "$Line" | jq '.meta.height' )

        echo '--------------------------------------------------------------------------------'
        echo "$Height $Delegate Forged New Block"
        echo '--------------------------------------------------------------------------------'

        "$HOME/forger-sync/backup.sh" -d "$Delegate" -h "$Height"
    fi
done
