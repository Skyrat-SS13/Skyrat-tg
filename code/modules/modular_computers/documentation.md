# Modular computer programs

How module computer programs work

Ok. so a quick rundown on how to make a program. This is kind of a shitty documentation, but oh well I was asked to.

## Base setup

This is how the base program is setup. the rest is mostly tgui stuff. I'll use the ntnetmonitor as a base

```DM
/datum/computer_file/program/ntnetmonitor
	/// This is obviously the name of the file itself. not much to be said
	filename = "ntmonitor"

	/// This is sort of the official name. it's what shows up on the main menu
	filedesc = "NTNet Diagnostics and Monitoring"

	/// This is what the screen will look like when the program is active
	program_icon_state = "comm_monitor"

	/// This is a sort of a description, visible when looking on the ntnet
	extended_desc = "This program is a dummy."

	/// size of the program. Big programs need more hard drive space. Don't
	/// make it too big though.
	size = 12

	/// If this is set, the program will not run without an ntnet connection,
	/// and will close if the connection is lost. Mainly for primarily online
	/// programs.
	requires_ntnet = 1

	/// This is access required to run the program itself.
	run_access = access_network

	/// This is the access needed to download from ntnet or host on the ptp
	/// program. This is what you want to use most of the time.
	download_access = access_change_ids

	/// If it's available to download on ntnet. pretty self explanatory.
	available_on_ntnet = 1

	/// ditto but on emagged syndie net. Use this for antag programs
	available_on_syndinet = 0

	/// Bitflags (PROGRAM_CONSOLE, PROGRAM_LAPTOP, PROGRAM_PDA combination)
	/// or PROGRAM_ALL. Use this to limit what kind of machines can run the
	/// program. For example, comms program should be limited to consoles and laptops.
	usage_flags = PROGRAM_ALL

	/// This one is kinda cool. If you have the program minimized, this will
	/// show up in the header of the computer screen. You can even have the
	/// program change what the header is based on the situation! See `alarm.dm`
	/// for an example.
	var/ui_header = "downloader_finished.gif"
```
