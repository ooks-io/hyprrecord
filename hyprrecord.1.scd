hyprrecord(1)

# NAME

hyprrecord - Simple screen recording utility for Hyprland.

# Usage

*hyprrecord* [OPTIONS]... [ACTION] [SUBJECT] [TYPE]

# Options

*-a, --audio*
	enable audio for recording, uses $(pact get-default-sink).

*-h, --help*
	prints help screen

# Actions

*save* [default]
	Saves the recording to $XDG_RECORDINGS_DIR ($HOME/Videos/Recordings) if exists
	otherwise it saves to $XDG_VIDEOS_DIR.

*copy*
	Copy recording to clipboard.

*copysave*
	Combine the previous two options.

# Subjects
	
*screen* [default]
	Record the entire screen.

*area*
	Record a selected area using slurp.

*active*
	Record currently focused window.

# Types

*video* [default]
	Record as a mp4 video.

*gif*
	Records as mp4 then converts to gif with ffmpeg.

# Examples

*hyprrecord -a copy area video*
	Record a video with audio of a selected area and copy it into clipboard.

*hyprrecord copysave active video*
	Record a video of the currently active window, copy it into the clipboard and save to Recording Directory.

*hyprrecord area gif* 
	Record a gif of a selected area and copy it into the clipboard.
