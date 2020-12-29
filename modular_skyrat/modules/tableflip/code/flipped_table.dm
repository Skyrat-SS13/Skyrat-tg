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

/obj/structure/flippedtable/CheckExit(atom/movable/O, turf/target)
	if(table_type == /obj/structure/table/glass) //Glass table, jolly ranchers pass
		if(istype(O) && (O.pass_flags & PASSGLASS))
			return TRUE
	if(istype(O, /obj/projectile))
		return TRUE
	if(get_dir(O.loc, target) == dir)
		return FALSE
	return TRUE

/obj/structure/flippedtable/CtrlShiftClick(mob/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src))
		return FALSE
	user.visible_message("<span class='danger'>[user] starts flipping [src]!</span>", "<span class='notice'>You start flipping over the [src]!</span>")
	if(do_after(user, max_integrity/4))
		var/obj/structure/table/T = new table_type(src.loc)
		T.obj_integrity = src.obj_integrity
		user.visible_message("<span class='danger'>[user] flips over the [src]!</span>", "<span class='notice'>You flip over the [src]!</span>")
		playsound(src, 'sound/items/trayhit2.ogg', 100)
		qdel(src)

//TABLES

/obj/structure/table/CtrlShiftClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src))
		return
	if(can_flip)
		user.visible_message("<span class='danger'>[user] starts flipping [src]!</span>", "<span class='notice'>You start flipping over the [src]!</span>")
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
			T.obj_integrity = src.obj_integrity
			T.table_type = src.type
			user.visible_message("<span class='danger'>[user] flips over the [src]!</span>", "<span class='notice'>You flip over the [src]!</span>")
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
