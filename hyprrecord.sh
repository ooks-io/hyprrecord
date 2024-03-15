#!/usr/bin/env bash

help() {
  echo "Usage: $0 [OPTION]... [ACTION] [SUBJECT]"
  echo ""
  echo "Options:"
  echo "  -a, --audio         Record audio with the video."
  echo "  -h, --help          Display this help and exit."
  echo ""
  echo "Actions:"
  echo "  save                Save the recording to a file."
  echo "  copy                Copy the recording file path to the clipboard."
  echo "  copysave            Save and copy the recording file path to the clipboard."
  echo ""
  echo "Subjects:"
  echo "  screen              Record the entire screen."
  echo "  area                Record a selected area."
  echo "  active              Record the currently active window."
  echo ""
  echo "Examples:"
  echo "  $0 save screen       Save a screen recording."
  echo "  $0 -a copy area      Copy an area recording with audio."
  echo "  $0 copysave active   Save and copy an active window recording."
}

getTargetDirectory() {
  test -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" &&
    . "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
  echo "${XDG_RECORDINGS_DIR:-${XDG_PICTURES_DIR:-$HOME}}"
}

tempFile() {
  echo "/tmp/hyprrecord-$(date -Ins).$FORMAT"
}

AUDIO=""
ACTION="save"
FORMAT=mp4
SUBJECT="screen"

while [ $# -gt 0 ]; do
  key="$1"
  case $key in
  -a | --audio)
    AUDIO="--audio --audio-device $(pactl get-default-sink).monitor"
    shift
    ;;
  copy | save | copysave)
    ACTION="$1"
    shift
    ;;
  -h | --help)
    help
    exit 0
    ;;
  *)
    SUBJECT="$1"
    shift
    ;;
  esac
done

FILE=$(getTargetDirectory)/$(date -Ins).$FORMAT
FILE_TEMP=$(tempFile)

notify() {
  notify-send -t 3000 -a hyprrecord "$1" "$2"
}

copyFile() {
  local file=$1
  URI="file://$file"
  echo -n $URI | wl-copy -t text/uri-list
  notify "Copied" "Recording copied to clipboard."
}

record() {
  local FILE=$1
  local GEOM=""
  if [ "$SUBJECT" == "area" ]; then
    local WORKSPACES
    WORKSPACES="$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')"

    local WINDOWS
    WINDOWS="$(hyprctl clients -j | jq -r --argjson workspaces "$WORKSPACES" 'map(select([.workspace.id] | inside($workspaces)))')"

    local GEOM
    GEOM=$(echo "$WINDOWS" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp $SLURP_ARGS)

  elif [ "$SUBJECT" == "active" ]; then
    local FOCUSED
    FOCUSED=$(hyprctl activewindow -j)
    local GEOM
    GEOM=$(echo "$FOCUSED" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
  fi

  if [ "$SUBJECT" == "screen" ]; then
    wl-screenrec $AUDIO -f $FILE
  else
    wl-screenrec -g "$GEOM" $AUDIO -f $FILE
  fi
}
# Check if already recording
if pgrep -x "wl-screenrec" >/dev/null; then
  pkill -x "wl-screenrec"
  exit 0
fi

# Save file to /tmp if we are only looking to copy
if [ "$ACTION" == "copy" ]; then
  FILE=$FILE_TEMP
fi

# Start recording
record "$FILE"

# Perform action after recording
case "$ACTION" in
save)
  notify "Saved" "Recording saved to $FILE"
  ;;
copy)
  copyFile "$FILE"
  ;;
copysave)
  copyFile "$FILE"
  notify "Saved" "Recording saved to $FILE"
  ;;
esac
