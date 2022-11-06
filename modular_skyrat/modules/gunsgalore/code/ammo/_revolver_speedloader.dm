/obj/item/ammo_box/revolver
	name = "speed loader"
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	var/round_type = AMMO_TYPE_LETHAL
	var/list/possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)
	start_empty = TRUE //SOmething strange going on with refills.

/obj/item/ammo_box/revolver/AltClick(mob/user)
	. = ..()
	var/new_type = input("Please select a magazine type to reskin to:", "Reskin", null, null) as null|anything in sort_list(possible_types)
	if(!new_type)
		new_type = AMMO_TYPE_LETHAL
	round_type = new_type
	name = "[initial(name)] [round_type]"
	update_appearance()

/obj/item/ammo_box/revolver/update_overlays()
	. = ..()
	if(stored_ammo.len)
		. += "[initial(icon_state)]_[round_type]"
