hyprrecord(1)

# NAME

hyprrecord - Simple screen recording utility for Hyprland.

# SYNOPSIS

*hyprrecord* [**-a**] [**-w**] [ACTION] [SUBJECT] [TYPE]

# DESCRIPTION

**hyprrecord** is a utility for screen recording in the Hyprland window manager, supporting various options for audio, output type, and target recording area.

# OPTIONS

*-a, --audio*
	Enable audio recording, using the default sink from PulseAudio *$(pactl get-default-sink).*
*-w, --waybar*
	Enables waybar integration by sending a signal(12) to waybar, see https://github.com/ooks-io/hyprrecord for example implementation. 

# ACTIONS

*usage* [**default**]
	Print help information and exit
*check*
	Test if required tools are available and exit
*save*:
	Tries to save the recording to **$XDG_RECORDINGS_DIR** or **$XDG_VIDEOS_DIR** if the
	former doesn't exist.

*copy*
	Copy the recording file to the clipboard.

*copysave*
	Save the recording and copy the file to the clipboard.

# SUBJECTS
	
*screen* [**default**]
	Record the entire screen.

*area*
	Record a selected area using slurp.

*active*
	Record currently focused window.

# Types

*video* [**default**]
	Record as a mp4 video.

*gif*
	Records as mp4 and then converts to GIF with **ffmpeg**.

# Examples

*hyprrecord -a copy area video*
	Record a video with audio of a selected area and copy the file to the clipboard.

*hyprrecord copysave active video*
	Record a video of the currently active window, save it and copy the file to the clipboard.

*hyprrecord save screen gif* 
	Record the entire screen, convert to GIF and save the file.
