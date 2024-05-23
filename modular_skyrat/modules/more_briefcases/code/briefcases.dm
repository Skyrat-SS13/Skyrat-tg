/obj/item/storage/briefcase
	icon = 'modular_skyrat/modules/more_briefcases/icons/briefcases.dmi'
	inhand_icon_state = "briefcase"

/obj/item/storage/briefcase/lawyer
	icon_state = "briefcase_black"
	inhand_icon_state = "sec-case"

/obj/item/storage/briefcase/central_command
	name = "nanotrasen briefcase"
	icon_state = "briefcase_cc"
	inhand_icon_state = "sec-case"

/obj/item/storage/briefcase/medical
	name = "medical briefcase"
	icon_state = "briefcase_med"
	inhand_icon_state = "lockbox"

/obj/item/storage/briefcase/virology
	name = "virology briefcase"
	icon_state = "briefcase_vir"
	inhand_icon_state = "lockbox"

/obj/item/storage/briefcase/engineering
	name = "engineering briefcase"
	icon_state = "briefcase_eng"

/obj/item/storage/briefcase/secure
	icon = 'modular_skyrat/modules/more_briefcases/icons/briefcases.dmi'
	inhand_icon_state = "sec-case"
	icon_state = "briefcase_secure_black"

/obj/item/storage/briefcase/secure/attack_self(mob/user)
	. = ..()
	update_appearance()

/obj/item/storage/briefcase/secure/update_overlays()
	. = ..()
	if(atom_storage?.locked)
		. += "briefcase_locked"
	else
		. += "briefcase_open"

/obj/item/storage/briefcase/secure/update_icon_state()
	. = ..()
	// Remove icon state functionality in favor of the overlays above.
	icon_state = "[initial(icon_state)]"

/obj/item/storage/briefcase/secure/white
	name = "white secure briefcase"
	icon_state = "briefcase_secure_white"
	inhand_icon_state = "lockbox"
