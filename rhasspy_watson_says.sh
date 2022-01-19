#!/bin/bash

# Shell script to replace TTS in Rhasspy with IBM's Cloud TTS
# Installation and usage instructions at https://github.com/Rayz224/rhasspy-IBMWatson

apikey=""
url=""

# Voice  (see https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices#listVoices for a complete list)
voice=""

# Folder to cache the files - this also contains the .txt index file with a list of all generated files
cache=""

###### Do not change anything below this

format="wav"

# The text that is passed in
text=$1

# Encode spaces for url
data="${text// /%20}"

# Random file name
name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1)

# Target file to return to rhasspy-tts (wav)
outfile="${cache}/${name}.wav"

# check/create cache if needed
mkdir -pv "$cache"

# Input text and parameters are used to calculate a hash for caching the wav files so only new speech will call watson
md5string="$text""_""$voice""_""$format"
hash="$(echo -n "$md5string" | md5sum | sed 's/ .*$//')"

cachefile="${cache}/cache${hash}.wav"

# do we have a cachefile?
if [ -f "$cachefile" ]
then
    # cachefile found. Sending it to rhasspy
    cat "${cachefile}"
else
    # cachefile not found, running Watson
    curl -X GET -u apikey:$apikey --insecure "$url/v1/synthesize?text=$data&voice=$voice" -H "Accept: audio/$format" -o $cachefile
    # update index
    echo "$hash" "$md5string" >> "$cache"/cacheindex.txt
    cat "${cachefile}"
fi