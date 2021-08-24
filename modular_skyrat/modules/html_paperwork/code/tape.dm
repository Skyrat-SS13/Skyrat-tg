/obj/item/stack/sticky_tape/proc/stick_to_paper(obj/item/target, mob/user)
	if(!istype(target, /obj/item/paper) || istype(target, /obj/item/paper/sticky) || !user.canUnEquip(target))
		return
	var/obj/item/ducttape/tape = new(get_turf(src))
	tape.attach(target)
	user.put_in_hands(tape)

/obj/item/ducttape
	name = "piece of tape"
	desc = "A piece of sticky tape."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "tape"
	w_class = WEIGHT_CLASS_TINY
	layer = ABOVE_OBJ_LAYER

	var/obj/item/stuck = null

/obj/item/ducttape/attack_hand(mob/user)
	anchored = FALSE // Unattach it from whereever it's on, if anything.
	return ..()

/obj/item/ducttape/examine()
	return stuck ? stuck.examine(arglist(args)) : ..()

/obj/item/ducttape/proc/attach(var/obj/item/stuckitem)
	stuck = stuckitem
	anchored = TRUE
	stuckitem.forceMove(src)
	icon_state = stuckitem.icon_state + "_taped"
	name = stuckitem.name + " (taped)"
	overlays = stuckitem.overlays

/obj/item/ducttape/attack_self(mob/user)
	if(!stuck)
		return

	to_chat(user, "You remove \the [initial(name)] from [stuck].")
	user.put_in_hands(stuck)
	stuck = null
	qdel(src)

/obj/item/ducttape/afterattack(A, mob/user, flag, params)

	if(!in_range(user, A) || istype(A, /obj/machinery/door) || !stuck)
		return

	var/turf/target_turf = get_turf(A)
	var/turf/source_turf = get_turf(user)

	var/dir_offset = 0
	if(target_turf != source_turf)
		dir_offset = get_dir(source_turf, target_turf)
		if(!(dir_offset in GLOB.cardinals))
			to_chat(user, "You cannot reach that from here.")// can only place stuck papers in cardinal directions, to
			return											// reduce papers around corners issue.

	if(!user.transferItemToLoc(src, source_turf))
		return
	playsound(src, 'sound/effects/tape.ogg',25)

	layer = ABOVE_WINDOW_LAYER

	if(params)
		var/list/mouse_control = params2list(params)
		if(mouse_control["icon-x"])
			pixel_x = text2num(mouse_control["icon-x"]) - 16
			if(dir_offset & EAST)
				pixel_x += 32
			else if(dir_offset & WEST)
				pixel_x -= 32
		if(mouse_control["icon-y"])
			pixel_y = text2num(mouse_control["icon-y"]) - 16
			if(dir_offset & NORTH)
				pixel_y += 32
			else if(dir_offset & SOUTH)
				pixel_y -= 32
