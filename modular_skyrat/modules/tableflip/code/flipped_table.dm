/obj/structure/flippedtable
	name = "flipped table"
	desc = "A flipped table."
	icon = 'modular_skyrat/modules/tableflip/icons/flipped_tables.dmi'
	icon_state = "metal-flipped"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_MOB_LAYER
	opacity = FALSE
	var/table_type = /obj/structure/table

/obj/structure/flippedtable/Initialize()
	. = ..()

	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = .proc/on_exit,
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flippedtable/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	var/attempted_dir = get_dir(loc, target)
	if(table_type == /obj/structure/table/glass) //Glass table, jolly ranchers pass
		if(istype(mover) && (mover.pass_flags & PASSGLASS))
			return TRUE
	if(istype(mover, /obj/projectile))
		var/obj/projectile/P = mover
		//Lets through bullets shot from behind the cover of the table
		if(P.trajectory && angle2dir_cardinal(P.trajectory.angle) == dir)
			return TRUE
		return FALSE
	if(attempted_dir == dir)
		return FALSE
	else if(attempted_dir != dir)
		return TRUE

/obj/structure/flippedtable/proc/on_exit(datum/source, atom/movable/leaving, atom/new_location)
	SIGNAL_HANDLER

	if(table_type == /obj/structure/table/glass) //Glass table, jolly ranchers pass
		if(istype(leaving) && (leaving.pass_flags & PASSGLASS))
			return

	if(istype(leaving, /obj/projectile))
		return

	if(get_dir(leaving.loc, new_location) == dir)
		return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/flippedtable/CtrlShiftClick(mob/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src) || iscorticalborer(user)) //skyrat edit: no borer flipping
		return FALSE
	user.visible_message(span_danger("[user] starts flipping [src]!"), span_notice("You start flipping over the [src]!"))
	if(do_after(user, max_integrity/4))
		var/obj/structure/table/T = new table_type(src.loc)
		T.update_integrity(src.get_integrity())
		user.visible_message(span_danger("[user] flips over the [src]!"), span_notice("You flip over the [src]!"))
		playsound(src, 'sound/items/trayhit2.ogg', 100)
		qdel(src)

//TABLES

/obj/structure/table/CtrlShiftClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src) || isobserver(user) || iscorticalborer(user)) //skyrat edit: no borer flipping
		return
	if(can_flip)
		user.visible_message(span_danger("[user] starts flipping [src]!"), span_notice("You start flipping over the [src]!"))
		if(do_after(user, max_integrity/4))
			var/obj/structure/flippedtable/T = new flipped_table_type(src.loc)
			T.name = "flipped [src.name]"
			T.desc = "[src.desc] It is flipped!"
			T.icon_state = src.base_icon_state
			var/new_dir = get_dir(user, T)
			T.dir = new_dir
			if(new_dir == NORTH)
				T.layer = BELOW_MOB_LAYER
			T.max_integrity = src.max_integrity
			T.update_integrity(src.get_integrity())
			T.table_type = src.type
			user.visible_message(span_danger("[user] flips over the [src]!"), span_notice("You flip over the [src]!"))
			playsound(src, 'sound/items/trayhit2.ogg', 100)
			qdel(src)

/obj/structure/table
	var/flipped_table_type = /obj/structure/flippedtable
	var/can_flip = TRUE

/obj/structure/table/rolling
	can_flip = FALSE

/obj/structure/table/reinforced //It's bolted to the ground mate
	can_flip = FALSE

/obj/structure/table/optable
	can_flip = FALSE
