#!/bin/bash

# Install first dependencies.

sudo apt-get install make gcc sox python-argparse wget espeak xautomation xvkbd 
#For OpenDomo we are going to use /etc/opendomo/speech, instead of $HOME/.palaver.d/
CONFIGDIR="/etc/opendomo/speech"
DIR="$(pwd)"
#Compiling dictionary.c:

#echo Assuming all files are in "'$DIR'"

#touch Recognition/dictionary.c
#cd Recognition
#make
#cd ..
echo "Clean directories from previous installations"
rm Recognition/modes/main.dic
rm Recognition/bin/ -r
rm $CONFIGDIR/plugins.db
rm $CONFIGDIR/UserInfo
rm $CONFIGDIR/configs -r

#mkdir $HOME/.palaver.d/
sudo mkdir -p $CONFIGDIR
sudo chown -R 1000:1000 $CONFIGDIR
#Atentos!!...cambiar el owner...Usamos 1000:1000 para ser compatible : opendomo: admin,,, mi instalación: manu
cp Recognition/config/defaultBin Recognition/bin -r
#touch $HOME/.palaver.d/UserInfo
touch $CONFIGDIR/UserInfo
#cp Recognition/config/BlankInfo $HOME/.palaver.d/UserInfo
cp Recognition/config/BlankInfo $CONFIGDIR/UserInfo
touch Recognition/modes/main.dic
cp Recognition/config/defaultMain.dic Recognition/modes/main.dic
#Solo instalamos lo específico de Opendomo
#./installDefault
./plugins -i /usr/local/opendomo/voiceCommands/OpenDomo_start/OpenDomo_start.sp
./plugins -i /usr/local/opendomo/voiceCommands/OpenDomo_stop/OpenDomo_stop.sp
./plugins -i /usr/local/opendomo/voiceCommands/LucesON/LucesON.sp
./plugins -i /usr/local/opendomo/voiceCommands/LucesOFF/LucesOFF.sp
echo "Install start_opendomoVR.sh to run forever in background" 
sudo update-rc.d start_opendomoVR.sh defaults

echo "Done: Now you can start Voice Recognition with: HOLA OPENDOMO"

