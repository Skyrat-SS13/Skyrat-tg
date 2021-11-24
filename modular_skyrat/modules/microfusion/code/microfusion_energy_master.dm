// Master file for cell loadable energy guns. PROCS ONLY YOU MONKEYS!

/// This is called regardless of if a cell is in the gun.
/obj/item/gun/energy/proc/auxiliary_update_overlays()
	return

/obj/item/gun/energy/microfusion
	name = "prototype detatchable cell energy projection aparatus"
	desc = "The coders have obviously failed to realise this is broken."
	icon = 'modular_skyrat/modules/microfusion/icons/guns40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/microfusion/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/microfusion/icons/guns_lefthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/microfusion)
	cell_type = /obj/item/stock_parts/cell/microfusion

	/// The time it takes for someone to (tactically) reload this gun. In deciseconds.
	var/reload_time = 2 SECONDS
	/// The sound played when you insert a cell.
	var/sound_cell_insert = 'modular_skyrat/modules/microfusion/sound/mag_insert.ogg'
	/// Should the insertion sound played vary?
	var/sound_cell_insert_vary = TRUE
	/// The volume at which we will play the insertion sound.
	var/sound_cell_insert_volume = 100
	/// The sound played when you remove a cell.
	var/sound_cell_remove = 'modular_skyrat/modules/microfusion/sound/mag_insert.ogg'
	/// Should the removal sound played vary?
	var/sound_cell_remove_vary = TRUE
	/// The volume at which we will play the removal sound.
	var/sound_cell_remove_volume = 100
	/// A list of attached upgrades
	var/list/attached_upgrades = list()
	/// How many attachments can this gun hold?
	var/max_attachments = 1
	/// The starting phase emitter in this weapon.
	var/phase_emitter_type = /obj/item/microfusion_phase_emitter
	/// The phase emitter that this gun currently has.
	var/obj/item/microfusion_phase_emitter/phase_emitter
	/// The amount of heat produced per shot
	var/heat_per_shot = 10

/obj/item/gun/energy/microfusion/Initialize(mapload)
	. = ..()
	if(phase_emitter_type)
		phase_emitter = new phase_emitter_type(src)
	else
		phase_emitter = new(src)

/obj/item/gun/energy/microfusion/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if (.)
		return
	if(istype(attacking_item, cell_type))
		insert_cell(user, attacking_item)
	if(istype(attacking_item, /obj/item/microfusion_gun_attachment))
		attach_upgrade(attacking_item, user)

/obj/item/gun/energy/microfusion/process_chamber(empty_chamber, from_firing, chamber_next_round)
	. = ..()
	if(!cell.stabalised && prob(50))
		do_sparks(2, FALSE, src) //Microfusion guns create sparks!

/obj/item/gun/energy/microfusion/can_shoot()
	if(!phase_emitter)
		return FALSE
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	if(QDELETED(cell) || cell.charge < shot.e_cost )
		return FALSE
	if(!phase_emitter.generate_shot(heat_per_shot))
		return FALSE
	return TRUE


/obj/item/gun/energy/microfusion/attack_hand(mob/user, list/modifiers)
	if(loc == user && user.is_holding(src) && cell)
		eject_cell(user)
		return
	return ..()

/obj/item/gun/energy/microfusion/auxiliary_update_overlays()
	for(var/obj/item/microfusion_gun_attachment/microfusion_gun_attachment in attached_upgrades)
		. += "[icon_state]_[microfusion_gun_attachment.attachment_overlay_icon_state]"
	return .

/obj/item/gun/energy/microfusion/examine(mob/user)
	. = ..()
	if(attached_upgrades.len)
		for(var/obj/item/microfusion_gun_attachment/microfusion_gun_attachment in attached_upgrades)
			. += span_notice("It has a [microfusion_gun_attachment.name] installed.")
		. += span_notice("Use a <b>screwdriver</b> to remove the upgrades.")
	if(phase_emitter)
		. += span_notice("It has a [phase_emitter.name] installed, at [phase_emitter.get_heat_percent()]% heat capacity.")
		. += span_notice("Use a crowbar to remove the phase emitter.")
	else
		. += span_danger("It does not have a phase emitter installed!")

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

/// Attatching an upgrade.
/obj/item/gun/energy/microfusion/proc/attach_upgrade(obj/item/microfusion_gun_attachment/microfusion_gun_attachment, mob/living/user)
	if(attached_upgrades.len >= max_attachments)
		to_chat(user, span_warning("[src] cannot fit any more attachments!"))
		return FALSE
	if(is_type_in_list(microfusion_gun_attachment, attached_upgrades))
		to_chat(user, span_warning("[src] already has [microfusion_gun_attachment] installed!"))
		return FALSE
	for(var/obj/item/microfusion_gun_attachment/iterating_attachment in attached_upgrades)
		if(is_type_in_list(microfusion_gun_attachment, iterating_attachment.incompatable_attachments))
			to_chat(user, span_warning("[microfusion_gun_attachment] is not compatible with [iterating_attachment]!"))
			return FALSE
	attached_upgrades += microfusion_gun_attachment
	microfusion_gun_attachment.forceMove(src)
	microfusion_gun_attachment.run_attachment(src)
	to_chat(user, span_notice("You successfully install [microfusion_gun_attachment] onto [src]!"))
	playsound(src, 'sound/effects/structure_stress/pop2.ogg', 70, TRUE)
	return TRUE
