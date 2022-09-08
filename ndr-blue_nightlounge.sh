#!/usr/bin/env bash

# Guide:
# https://wiki.videolan.org/Documentation:Streaming_HowTo_New/#Example_commandline:_Converting_an_audio_file_to_a_MP3_file

NAME="ndr-blue_nightlounge";
DURATION='55m';

EXTENSION="mp3";
LIVESTREAM_URL='http://icecast.ndr.de/ndr/ndrblue/live/mp3/128/stream.mp3';

#EXTENSION="aac";
#LIVESTREAM_URL='http://icecast.ndr.de/ndr/ndrblue/live/aac/low';

SOUT_TRANSCODE='acodec=mp3,ab=128,channels=2,samplerate=48000';
SOUT_STD='access=file,mux=raw';

TEMP_FILEPATH="/tmp/${NAME}_temp.$EXTENSION";

timeout $DURATION \
  cvlc $LIVESTREAM_URL \
  :sout="#transcode{$SOUT_TRANSCODE}:std{$SOUT_STD,dst=$TEMP_FILEPATH}";

bash ./utils/sync-to-nextcloud.sh "$NAME" "$EXTENSION" "$TEMP_FILEPATH";
