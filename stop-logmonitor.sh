#!/bin/bash

# Gr33nDrag0n 2021-08-02

ps -ef | grep "$HOME/forger-sync/logmonitor.sh" | grep -v grep | awk '{print $2}' | xargs -r kill -9 &>/dev/null
