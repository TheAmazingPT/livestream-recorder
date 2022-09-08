#/usr/bin/env bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  echo "MISSING ARGUMENTS! Use this script as follows:";
  echo -e "\tbash sync-to-nextcloud.sh NAME EXTENSION FILEPATH";
  echo
  echo "Example:"
  echo -e "\tbash sync-to-nextcloud.sh bbc-essential-mix aac /tmp/audio.aac";
  echo
  echo "Arguments given:"
  echo -e "\tArg 1\tNAME\t\t$1";
  echo -e "\tArg 2\tEXTENSION\t$2";
  echo -e "\tArg 3\tFILEPATH\t$3";
  exit 1;
fi

NAME=$1
EXTENSION=$2
TEMP_FILEPATH=$3

TWO_WEEKS_IN_SECONDS=604800;
DATE_NEW_IN_SECONDS=$(date '+%s');
DATE_OLD_IN_SECONDS=$((DATE_NEW_IN_SECONDS - TWO_WEEKS_IN_SECONDS));
FILE_DATE_NEW=$(date --date="@$DATE_NEW_IN_SECONDS" '+%Y-%m-%d_hour-%H');
FILE_DATE_OLD=$(date --date="@$DATE_OLD_IN_SECONDS" '+%Y-%m-%d_hour-%H');

FILENAME_NEW="${NAME}_$FILE_DATE_NEW.$EXTENSION";
FILENAME_OLD="${NAME}_$FILE_DATE_OLD.$EXTENSION";

# Clean up files, which are older than two weeks to save storage
rclone deletefile \
  nextcloud:/music/livestreams/$NAME/$FILENAME_OLD;

# Save resulting audio file to nextcloud
rclone copyto \
  $TEMP_FILEPATH \
  nextcloud:/music/livestreams/$NAME/$FILENAME_NEW;

rm "$TEMP_FILEPATH";
