#!/bin/bash
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

echo "------------------------------------"
echo rhasspy-IBMWatson script installation
echo Make sure you are running Rhasspy version 2.5.11 or more
echo "------------------------------------"

read -p "Enter the path of your rhasspy profile folder [/home/${SUDO_USER}/.config/rhasspy/profiles/en]: " path
path=${path:-/home/${SUDO_USER}/.config/rhasspy/profiles/en}

wget -P $path https://raw.githubusercontent.com/Rayz224/rhasspy-IBMWatson/main/rhasspy_watson_says.sh

read -p "Copy you IBM apikey: " apikey
if [ -z "$apikey" ]; then echo [ERROR] apikey null, please try again && exit 1; fi
sed -i '0,/apikey=""/s//apikey="'$apikey'"/' $path/rhasspy_watson_says.sh

read -p "Copy you IBM url: " url
if [ -z "$url" ]; then echo [ERROR] url null, please try again && exit 1; fi
sed -i '0,/url=""/s@@url="'$url'"@' $path/rhasspy_watson_says.sh

read -p "Which voice do you want to use? [en-GB_JamesV3Voice]: " voice
voice=${voice:-en-GB_JamesV3Voice}
sed -i '0,/voice=""/s//voice="'$voice'"/' $path/rhasspy_watson_says.sh

read -p "Are you using docker? (y/n) [y]: " docker
docker=${docker:-y}
if [ "$docker" = "y" ]
then
  cache="/profiles/en/tts/cache/"
  scriptPath="/profiles/en"
else
  cache="$path/tts/cache/"
  scriptPath="$path"
fi
sed -i '0,/cache=""/s@@cache="'$cache'"@' $path/rhasspy_watson_says.sh

chmod a+x $path/rhasspy_watson_says.sh

echo "------------------------------------"
echo Script installed
echo "Do not forget to set Rhasspy TTS settings to Local Command and set Say Program to: $scriptPath/rhasspy_watson_says.sh"
echo "------------------------------------"
