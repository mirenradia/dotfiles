#!/usr/bin/env bash

APP_NAME="gphotos-sync"
ICON=/usr/share/icons/Papirus/48x48/apps/google-photos.svg
# Set this environment variable for notify-send to send notifications correctly
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

NOTIFICATION_ID=$(notify-send -a $APP_NAME -i $ICON "Syncing Google Photos" -p)
CONFIG=$HOME/.config/gphotos-sync
STORAGE=$HOME/Pictures/Google-Photos

if docker run --rm -v $CONFIG:/config -v $STORAGE:/storage -p 8080:8080 ghcr.io/gilesknap/gphotos-sync --max-threads 2 /storage &>> $STORAGE/gphotos-cron.log; then
	NOTIFICATION_MESSAGE=$(grep "Downloaded" $STORAGE/gphotos-cron.log | tail -n 1 | cut -d " " -f 5-12)
	notify-send -a $APP_NAME -i $ICON -r $NOTIFICATION_ID "Syncing complete" "$NOTIFICATION_MESSAGE"
else
	notify-send -a $APP_NAME -i $ICON -r $NOTIFICATION_ID "Error during syncing" "See log file"
fi

