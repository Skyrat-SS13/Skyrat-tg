/obj/item/gun/energy/cell_loaded //The basic cell loaded gun
	name = "Cell loaded gun"
	desc = "A energy gun that functions by loading cells for ammo types"
	var/list/allowed_cells = list() //What kind of cells can the gun load? This can either be an entire type or only very specific cells.
	var/maxcells = 3 //How much cells can the gun hold.
	var/cellcount = 0 //How many cells are currently inserted
	var/list/installedcells = list() //What cells are currently inserted?
	has_gun_safety = TRUE

/obj/item/gun/energy/cell_loaded/examine(mob/user)
	. = ..()
	if(maxcells)
		. += "<b>[cellcount]</b> out of <b>[maxcells]</b> cell slots are filled."
		. += span_info("You can use AltClick with an empty hand to remove the most recently inserted cell from the chamber.")
		for(var/cell in installedcells)
			. += span_notice("There is \a [cell] loaded in the chamber.") //Shows what cells are currently inside of the gun

/obj/item/gun/energy/cell_loaded/attackby(obj/item/weaponcell/C, mob/user) //Inserts a cell.
	if(is_type_in_list(C, allowed_cells))//Checks to see if the gun has the capacity based on allowed_types to load a cell.
		if(cellcount >= maxcells) //Are there too many cells inside of the gun?
			to_chat(user, span_notice("The [src] is full, take a cell out to make room"))
		else
			var/obj/item/weaponcell/cell = C
			if(!user.transferItemToLoc(cell, src))
				return
			playsound(loc, 'sound/machines/click.ogg', 50, 1)
			to_chat(user, span_notice("You install the [cell]."))
			ammo_type += new cell.ammo_type(src)
			installedcells += cell
			cellcount += 1
	else
		..()

/obj/item/gun/energy/cell_loaded/AltClick(mob/user, modifiers)
	if(cellcount >= 1) //Is there a cell inside?
		to_chat(user, span_notice("You remove a cell"))
		var/obj/item/last_cell = installedcells[installedcells.len]
		if(last_cell)
			last_cell.forceMove(drop_location())
			user.put_in_hands(last_cell)
		installedcells -= last_cell
		ammo_type.len--
		cellcount -= 1
		select_fire(user)
	else
		to_chat(user, span_notice("The [src] has no cells inside"))
		return ..()

/obj/item/gun/energy/cell_loaded/alltypes //This is for debug.
	name = "omni gun"
	allowed_cells = list(/obj/item/weaponcell)
