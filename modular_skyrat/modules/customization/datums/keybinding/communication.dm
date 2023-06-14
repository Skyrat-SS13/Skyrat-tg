/datum/keybinding/client/communication/looc
	hotkey_keys = list("L")
	name = LOOC_CHANNEL
	full_name = "Local OOC (LOOC)"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_DOWN

/datum/keybinding/client/communication/looc/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(LOOC_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/whisper
	hotkey_keys = list("Y")
	name = WHIS_CHANNEL
	full_name = "IC Whisper"
	keybind_signal = COMSIG_KB_CLIENT_WHISPER_DOWN

/datum/keybinding/client/communication/whisper/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(WHIS_CHANNEL)]")
	return TRUE
