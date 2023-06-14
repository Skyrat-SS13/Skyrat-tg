/// Action used to pull up the NIF menu
/datum/action/item_action/nif
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/nif/open_menu
	name = "Open NIF Menu"
	button_icon_state = "user"

/datum/action/item_action/nif/open_menu/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = target

	if(target_nif.calibrating)
		target_nif.send_message("The NIF is still calibrating, please wait!", TRUE)
		return FALSE

	if(target_nif.durability < 1)
		target_nif.send_message("Durability low!", TRUE)
		return FALSE

	if(target_nif.broken)
		target_nif.send_message("The NIF is unable to be used at this time!", TRUE)
		return FALSE

	if(!.)
		return

	target_nif.ui_interact(usr)

