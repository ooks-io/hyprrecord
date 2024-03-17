> [!WARNING]\
> This script is still in a prototype/proof-of-concept stage. Needs a lot of
> cleaning up.

# Hyprrecord

A simple screen recording script for
[hyprland](https://github.com/hyprwm/hyprland), based on
[grimblast](https://github.com/hyprwm/contrib/tree/main/grimblast).

## Tools used

- [wl-screenrec](https://github.com/russelltg/wl-screenrec): Wayland screen
  recording utility
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard): Wayland clipboard.
- [slurp](https://github.com/emersion/slurp): For selecting a region in wayland.
- [ffmpeg](https://ffmpeg.org/): Tool used to convert, stream and manipulate
  media.
- [pactl](https://manpages.ubuntu.com/manpages/jammy/en/man1/pactl.1.html):
  Command-line utility for controlling a PulseAudio server.
- [jq](https://github.com/jqlang/jq): Json processor

## Features I would like to add

- Microphone option (_requires pipewire creating a virtual output with multiple
  audio streams_)
- Convert to WebP (_will require building ffmpeg with libwebp_)
- Waybar/AGS support (_function that prints json recording status?_)
