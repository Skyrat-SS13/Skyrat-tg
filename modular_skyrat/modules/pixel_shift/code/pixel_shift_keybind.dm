/datum/keybinding/mob/pixel_shift
	hotkey_keys = list("B")
	name = "pixel_shift"
	full_name = "Pixel Shift"
	description = "Shift your characters offset."
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXELSHIFT

/datum/keybinding/mob/pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_SHIFT_DOWN, TRUE)
	return TRUE

/datum/keybinding/mob/pixel_shift/up(client/user)
	. = ..()
	if(.)
		return
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_SHIFT_DOWN, FALSE)
	return TRUE
