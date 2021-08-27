#!/bin/bash

# Gr33nDrag0n 2021-08-26

ProcessCount=$( ps -ef | grep 'forger-sync/logmonitor.sh' | grep -v grep | wc -l )
if [ "$ProcessCount" -lt 1 ]
then
    "$HOME/forger-sync/start-logmonitor.sh"
fi
