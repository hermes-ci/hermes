#!/usr/bin/env bash
echo "#########################################################"
echo "##        Hermes Automated Deployment"
echo "#########################################################"
echo "Updating Hermes."
#download hermes with wget to tmp directory
wget -O /tmp/hermesupdate/latest.tar.gz http://localhost/hermes/latest.tar.gz 
tar -xvzf /tmp/hermesupdate/latest.tar.gz
cp -R /home/deryk/hermes /tmp/hermesupdate
per=0
while true; do
    read -p "Would you like to update Hermes now? [y/n] " answer
    case $answer in
        [Yy]* ) 
            echo -ne "|"
            while [ $per -lt 7 ]; do
                echo -ne "##\r"
                sleep 1
                ((per++))
            done
            echo -ne '##|(100%)'
            sleep 1

            cp -R /tmp/hermesupdate/app/* "$ROOT"/app
            
            chmod +x "$ROOT"/app/*.sh
            chmod +x "$ROOT"/app/hermes-ci
            echo -ne '\n'
            echo "Hermes update completed";
            #Create symlink to heremes file in the bin path to use everywhere
            ln -sf "$ROOT"/app/hermes-ci /bin/hermes-ci
            rm -R /tmp/hermesupdate
            hermes-ci sshconfig
            exit;;
        [Nn]* ) exit 150;;
        * ) echo "Please answer yes or no.";;
    esac
done