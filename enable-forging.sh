#!/bin/bash

# Gr33nDrag0n 2021-08-02

echo "Sync. Git Repository."
cd "$HOME/forger-sync/"
git pull --rebase --quiet

echo "Select Backup Directory :"
cd "$HOME/forger-sync/backup/"
select Directory in *
do
    test -n "$Directory" && break
    echo ">>> Invalid Selection"
done

JsonFilePath="$HOME/forger-sync/backup/$Directory/ForgingStatus.json"

CurrentForgingStatus=$( lisk-core forging:status )

for Delegate in $(echo "${CurrentForgingStatus}" | jq -rc '.[]')
do
    BinaryAddress=$( echo $Delegate | jq -r '.address' )
    Forging=$( echo $Delegate | jq -r '.forging' )
    DelegateName=$( lisk-core account:get $BinaryAddress | jq -r '.dpos.delegate.username' )
    
    if [ "$Forging" = true ]
    then
        echo "$DelegateName is already forging."
    else
        while true; do
            read -p "Enable Forging on $DelegateName?" yn 
            case $yn in

                [Yy]* )
                    CurrentHeight=$( echo $Delegate | jq -r '.height // 0' )
                    CurrentMaxHeightPreviouslyForged=$( echo $Delegate | jq -r '.maxHeightPreviouslyForged // 0' )
                    CurrentMaxHeightPrevoted=$( echo $Delegate | jq -r '.maxHeightPrevoted // 0' )

                    BackupDelegate=$( cat "$JsonFilePath" | jq -rc --arg address "$BinaryAddress" '.[] | select(.address==$address)' )
                    BackupHeight=$( echo $BackupDelegate | jq -r '.height // 0' )
                    BackupMaxHeightPreviouslyForged=$( echo $BackupDelegate | jq -r '.maxHeightPreviouslyForged // 0' )
                    BackupMaxHeightPrevoted=$( echo $BackupDelegate | jq -r '.maxHeightPrevoted // 0' )

                    echo ""
                    echo "$DelegateName $BinaryAddress"
                    echo ""
                    echo "           Height   MaxHeightPreviouslyForged   MaxHeightPrevoted"
                    echo ""
                    echo "Current : $CurrentHeight           $CurrentMaxHeightPreviouslyForged                $CurrentMaxHeightPrevoted"
                    echo "Backup  : $BackupHeight           $BackupMaxHeightPreviouslyForged                $BackupMaxHeightPrevoted"
                    echo ""

                    echo "Select Configuration:"
                    select Action in Current Backup
                    do
                        case $Action in

                            "Current")
                                echo "lisk-core forging:enable $BinaryAddress $CurrentHeight $CurrentMaxHeightPreviouslyForged $CurrentMaxHeightPrevoted"
                                lisk-core forging:enable $BinaryAddress $CurrentHeight $CurrentMaxHeightPreviouslyForged $CurrentMaxHeightPrevoted
                                break
                                ;;

                            "Backup")
                                echo "lisk-core forging:enable $BinaryAddress $BackupHeight $BackupMaxHeightPreviouslyForged $BackupMaxHeightPrevoted"
                                lisk-core forging:enable $BinaryAddress $BackupHeight $BackupMaxHeightPreviouslyForged $BackupMaxHeightPrevoted
                                break
                                ;;

                            *)
                                echo ">>> Invalid Selection"
                                ;;
                        esac
                    done
                    break
                    ;;

                [Nn]* )
                    break
                    ;;

                * )
                    echo "Please answer yes or no."
                    ;;
            esac
        done
    fi
done
