#!/bin/bash

   # This program is free software: you can redistribute it and/or modify
   #  it under the terms of the GNU General Public License as published by
   #  the Free Software Foundation, either version 3 of the License, or
   #  (at your option) any later version.

   #  This program is distributed in the hope that it will be useful,
   #  but WITHOUT ANY WARRANTY; without even the implied warranty of
   #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   #  GNU General Public License for more details.

   #  You should have received a copy of the GNU General Public License
   #  along with this program.  If not, see <http://www.gnu.org/licenses/>.
# TODO, make this use the mode, context and custom sed script

#USER_DIR=$HOME/.palaver.d
USER_DIR="/etc/opendomo/speech"

# Try to run a command in ./Recognition/bin with useful errors.
function run_command() {
	while read line           
	do           
		export "$line"           
	done <$USER_DIR/UserInfo
    eval "./Recognition/bin/$1"

    if [ $? != 0 ];then
		logevent error odspeech "There was an error while running $1"
		exit 1
    fi
}

cd $(dirname $0)

read mode < MODE

speech="$1"
echo $speech
# Use sed scripts here.
if [ -z "$speech" ];then
    echo "Speech unable to be transcribed."
    ./Recognition/bin/result "Speech unable to be transcribed"
    exit 1
fi

rm Microphone/result 2>/dev/null


COMMAND=$(./Recognition/dictionary "$speech" "./Recognition/modes/${mode}.dic")

EXIT=$?

if [ "$EXIT" == 0 ];then
    	run_command "$COMMAND"
    	echo  "OK" > RESULTADO
    	exit 0
fi
