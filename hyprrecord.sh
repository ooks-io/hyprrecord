#!/usr/bin/env bash

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

    local GEOM_FLAG
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

# Decide on the file to use based on the action
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
