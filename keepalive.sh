#!/bin/bash

# Gr33nDrag0n 2021-08-02

if [ $( ps -ef | grep 'forger-sync/logmonitor.sh' | grep -v grep | wc -l ) -lt 1 ]
then
    "$HOME/forger-sync/start-logmonitor.sh"
fi
