/*
*	GUNSET BOXES
*/

/obj/item/storage/toolbox/guncase/skyrat
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/worn/cases.dmi'
	worn_icon_state = "darkcase"

	slot_flags = ITEM_SLOT_BACK

	material_flags = NONE

	/// Is the case visually opened or not
	var/opened = FALSE

/obj/item/storage/toolbox/guncase/skyrat/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 14 // Technically means you could fit multiple large guns in here but its a case you cant backpack anyways so what it do
	atom_storage.max_slots = 6 // We store some extra items in these so lets make a little extra room

/obj/item/storage/toolbox/guncase/skyrat/update_icon()
	. = ..()
	if(opened)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = initial(icon_state)

/obj/item/storage/toolbox/guncase/skyrat/AltClick(mob/user)
	. = ..()
	opened = !opened
	update_icon()

/obj/item/storage/toolbox/guncase/skyrat/attack_self(mob/user)
	. = ..()
	opened = !opened
	update_icon()
