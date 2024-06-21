/datum/keybinding/carbon/toggle_safety
	hotkey_keys = list("ShiftF")
	name = "toggle_safety"
	full_name = "Toggle gun's safety mode"
	description = "Toggles gun's safety mode in an active hand."
	keybind_signal = COMSIG_KB_CARBON_TOGGLE_SAFETY

/datum/keybinding/carbon/toggle_safety/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/owner = user.mob
	var/obj/item/gun = owner.get_active_held_item()
	if(!gun)
		return
	var/datum/component/gun_safety/safety = gun.GetComponent(/datum/component/gun_safety)
	if(!safety)
		return
	safety.toggle_safeties(owner)
