// Master file for cell loadable energy guns. PROCS ONLY YOU MONKEYS!

/obj/item/gun/energy/cell
	name = "prototype detatchable cell energy projection aparatus"
	desc = "The coders have obviously failed to realise this is broken."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/advanced)

	/// The time it takes for someone to (tactically) reload this gun. In deciseconds.
	var/reload_time = 2 SECONDS
	/// The sound played when you insert a cell.
	var/sound_cell_insert
	/// Should the insertion sound played vary?
	var/sound_cell_insert_vary = FALSE
	/// The volume at which we will play the insertion sound.
	var/sound_cell_insert_volume = 100
	/// The sound played when you remove a cell.
	var/sound_cell_remove
	/// Should the removal sound played vary?
	var/sound_cell_remove_vary = FALSE
	/// The volume at which we will play the removal sound.
	var/sound_cell_remove_volume = 100

/obj/item/gun/energy/cell/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if (.)
		return
	if(istype(attacking_item, /obj/item/stock_parts/cell/advanced_gun))
		try_insert_cell(attacking_item, user)

/obj/item/gun/energy/cell/attack_hand(mob/user, list/modifiers)
	if(loc == user && user.is_holding(src) && cell)
		eject_cell(user)
		return
	return ..()

/// Try to insert the cell into the gun, if successful, return TRUE
/obj/item/gun/energy/cell/proc/insert_cell(obj/item/stock_parts/cell/advanced_gun/inserting_cell, mob/user, display_message = TRUE)
	if(cell)
		if(reload_time && !HAS_TRAIT(user, TRAIT_WEAPON_RELOAD)) //This only happens when you're attempting a tactical reload, e.g. there's a mag already inserted.
			if(display_message)
				to_chat(user, span_notice("You start to insert [inserting_cell] into [src]!"))
			if(!do_after(user, reload_time, src))
				if(display_message)
					to_chat(user, span_warning("You fail to insert [inserting_cell] into [src]!"))
				return FALSE
		if(display_message)
			to_chat(user, span_notice("You tactically reload [src], replacing [cell] inside!"))
		eject_cell(user, FALSE)
	else if(display_message)
		to_chat(user, span_notice("You insert [inserting_cell] into [src]!"))
	if(sound_cell_insert)
		playsound(src, sound_cell_insert, sound_cell_insert_volume, sound_cell_insert_vary)
	cell = inserting_cell
	inserting_cell.forceMove(src)
	cut_overlays()
	update_overlays()
	return TRUE

/// Ejecting a cell.
/obj/item/gun/energy/cell/proc/eject_cell(mob/user, display_message = TRUE)
	var/obj/item/stock_parts/cell/advanced_gun/old_cell = cell
	old_cell.forceMove(get_turf(src))
	if(user)
		user.put_in_hands(old_cell)
		if(display_message)
			to_chat(user, span_notice("You remove [old_cell] from [src]!"))
	if(sound_cell_remove)
		playsound(src, sound_cell_remove, sound_cell_remove_volume, sound_cell_remove_vary)
	old_cell.update_appearance()
	cell = null
	cut_overlays()
	update_overlays()

