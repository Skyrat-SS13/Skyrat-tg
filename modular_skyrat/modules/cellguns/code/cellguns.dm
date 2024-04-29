/obj/item/gun/energy/cell_loaded //The basic cell loaded gun
	name = "cell-loaded gun"
	desc = "A energy gun that functions by loading cells for ammo types"

	/// List containing what cells are allowed to be installed by the gun. This includes all subtypes.
	var/list/allowed_cells = list()
	/// The maximum amount of cells that a cell loaded gun can hold at once.
	var/maxcells = 3
	/// A list that contains the currently installed cells.
	var/list/installedcells = list()

	automatic_charge_overlays = FALSE //This is needed because Cell based guns use their own custom overlay system.

/obj/item/gun/energy/cell_loaded/give_gun_safeties()
	return

/obj/item/gun/energy/cell_loaded/examine(mob/user)
	. = ..()
	if(maxcells)
		. += "<b>[installedcells.len]</b> out of <b>[maxcells]</b> cell slots are filled."
		. += span_info("You can use AltClick with an empty hand to remove the most recently inserted cell from the chamber.")

		for(var/cell in installedcells)
			. += span_notice("There is \a [cell] loaded in the chamber.") //Shows what cells are currently inside of the gun

/// Handles insertion of weapon cells
/obj/item/gun/energy/cell_loaded/attackby(obj/item/weaponcell/used_cell, mob/user)
	if(is_type_in_list(used_cell, allowed_cells)) // Checks allowed_cells to see if the gun is able to load the cells.
		if(installedcells.len >= maxcells) //Prevents the user from loading any cells past the maximum cell allowance
			to_chat(user, span_notice("[src] is full, take a cell out to make room."))
			return

		var/obj/item/weaponcell/cell = used_cell
		if(!user.transferItemToLoc(cell, src))
			return

		playsound(loc, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_notice("You install the [cell]."))
		ammo_type += new cell.ammo_type(src)
		installedcells += cell
	else
		..()

/obj/item/gun/energy/cell_loaded/update_overlays()
	. = ..()
	var/overlay_icon_state = icon_state
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]

	if(modifystate)
		if(single_shot_type_overlay)
			var/mutable_appearance/full_overlay = mutable_appearance(icon, "[icon_state]_full")
			full_overlay.color = shot.select_color
			. += new /mutable_appearance(full_overlay)
		overlay_icon_state += "_charge"

	var/ratio = get_charge_ratio()
	ratio = get_charge_ratio()

	if(!ratio && display_empty)
		. += "[icon_state]_empty"
		return

	var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)

	if(!shot.select_color)
		return

	charge_overlay.color = shot.select_color

	for(var/i in 0 to ratio)
		charge_overlay.pixel_x = ammo_x_offset * (i - 1)
		charge_overlay.pixel_y = ammo_y_offset * (i - 1)
		. += new /mutable_appearance(charge_overlay)

/obj/item/gun/energy/cell_loaded/click_alt(mob/user, modifiers)
	if(!installedcells.len) //Checks to see if there is a cell inside of the gun, before removal.
		to_chat(user, span_notice("The [src] has no cells inside"))
		return CLICK_ACTION_BLOCKING

	to_chat(user, span_notice("You remove a cell"))
	var/obj/item/last_cell = installedcells[installedcells.len]

	if(last_cell)
		last_cell.forceMove(drop_location())
		user.put_in_hands(last_cell)

	installedcells -= last_cell
	ammo_type.len--
	select_fire(user)
	return CLICK_ACTION_SUCCESS

/// A cellgun used for debug, it is able to use any weaponcell.
/obj/item/gun/energy/cell_loaded/alltypes
	name = "omni gun"
	allowed_cells = list(/obj/item/weaponcell)
