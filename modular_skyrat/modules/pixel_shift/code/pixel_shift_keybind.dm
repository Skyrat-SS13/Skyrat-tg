/datum/keybinding/mob/item_pixel_shift
	hotkey_keys = list("V")
	name = "item_pixel_shift"
	full_name = "Item Pixel Shift"
	description = "Shift a pulled item's offset"
	category = CATEGORY_MISC
	keybind_signal = COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_DOWN

/datum/keybinding/mob/item_pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_DOWN)

/datum/keybinding/mob/item_pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_ITEM_PIXEL_SHIFT_UP)

/datum/keybinding/mob/pixel_shift
	hotkey_keys = list("B")
	name = "pixel_shift"
	full_name = "Pixel Shift"
	description = "Shift your characters offset."
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXEL_SHIFT_DOWN

/datum/keybinding/mob/pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_SHIFT_DOWN)

/datum/keybinding/mob/pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_SHIFT_UP)

/datum/keybinding/mob/pixel_tilting
	hotkey_keys = list("N")
	name = "Pixel Tilting"
	full_name = "Pixel Tilt"
	description = "Shift a mob's rotational value"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_MOB_PIXEL_TILT_DOWN

/datum/keybinding/mob/pixel_tilting/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_TILT_DOWN)

/datum/keybinding/mob/pixel_tilting/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_MOB_PIXEL_TILT_UP)
