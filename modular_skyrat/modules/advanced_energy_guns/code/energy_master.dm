// Master file for cell loadable energy guns. PROCS ONLY YOU MONKEYS!

/obj/item/gun/energy/microfusion
	name = "prototype detatchable cell energy projection aparatus"
	desc = "The coders have obviously failed to realise this is broken."
	icon = 'modular_skyrat/modules/advanced_energy_guns/icons/guns.dmi'
	lefthand_file = 'modular_skyrat/modules/advanced_energy_guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/advanced_energy_guns/icons/guns_lefthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/advanced)
	cell_type = /obj/item/stock_parts/cell/microfusion

	/// The time it takes for someone to (tactically) reload this gun. In deciseconds.
	var/reload_time = 2 SECONDS
	/// The sound played when you insert a cell.
	var/sound_cell_insert = 'modular_skyrat/modules/advanced_energy_guns/sound/mag_insert.ogg'
	/// Should the insertion sound played vary?
	var/sound_cell_insert_vary = TRUE
	/// The volume at which we will play the insertion sound.
	var/sound_cell_insert_volume = 100
	/// The sound played when you remove a cell.
	var/sound_cell_remove = 'modular_skyrat/modules/advanced_energy_guns/sound/mag_insert.ogg'
	/// Should the removal sound played vary?
	var/sound_cell_remove_vary = TRUE
	/// The volume at which we will play the removal sound.
	var/sound_cell_remove_volume = 100

/obj/item/gun/energy/microfusion/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if (.)
		return
	if(istype(attacking_item, cell_type))
		insert_cell(user, attacking_item)

/obj/item/gun/energy/microfusion/attack_hand(mob/user, list/modifiers)
	if(loc == user && user.is_holding(src) && cell)
		eject_cell(user)
		return
	return ..()

/// Try to insert the cell into the gun, if successful, return TRUE
/obj/item/gun/energy/microfusion/proc/insert_cell(mob/user, obj/item/stock_parts/cell/microfusion/inserting_cell, display_message = TRUE)
	if(cell)
		if(reload_time && !HAS_TRAIT(user, TRAIT_INSTANT_RELOAD)) //This only happens when you're attempting a tactical reload, e.g. there's a mag already inserted.
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
	update_appearance()
	return TRUE

/// Ejecting a cell.
/obj/item/gun/energy/microfusion/proc/eject_cell(mob/user, display_message = TRUE)
	var/obj/item/stock_parts/cell/microfusion/old_cell = cell
	old_cell.forceMove(get_turf(src))
	if(user)
		user.put_in_hands(old_cell)
		if(display_message)
			to_chat(user, span_notice("You remove [old_cell] from [src]!"))
	if(sound_cell_remove)
		playsound(src, sound_cell_remove, sound_cell_remove_volume, sound_cell_remove_vary)
	old_cell.update_appearance()
	cell = null
	update_appearance()

