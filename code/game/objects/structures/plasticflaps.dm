/obj/structure/plasticflaps
	name = "airtight plastic flaps"
	desc = "Heavy duty, airtight, plastic flaps. Definitely can't get past those. No way."
	gender = PLURAL
	icon = 'icons/obj/structures.dmi'//ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	icon_state = "plasticflaps"
	armor_type = /datum/armor/structure_plasticflaps
	density = FALSE
	anchored = TRUE
	can_atmos_pass = ATMOS_PASS_NO
	can_astar_pass = CANASTARPASS_ALWAYS_PROC

/obj/structure/plasticflaps/opaque
	opacity = TRUE

/datum/armor/structure_plasticflaps
	melee = 100
	bullet = 80
	laser = 80
	energy = 100
	bomb = 50
	fire = 50
	acid = 50

/obj/structure/plasticflaps/Initialize(mapload)
	. = ..()
	alpha = 0
	gen_overlay()
	air_update_turf(TRUE, TRUE)

/obj/structure/plasticflaps/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	if(same_z_layer)
		return ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	gen_overlay()
	return ..()

/obj/structure/plasticflaps/proc/gen_overlay()
	var/turf/our_turf = get_turf(src)
	SSvis_overlays.add_vis_overlay(src, icon, icon_state, ABOVE_MOB_LAYER, MUTATE_PLANE(GAME_PLANE, our_turf), dir, add_appearance_flags = RESET_ALPHA) //you see mobs under it, but you hit them like they are above it

/obj/structure/plasticflaps/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("[src] are <b>screwed</b> to the floor.")
	else
		. += span_notice("[src] are no longer <i>screwed</i> to the floor, and the flaps can be <b>cut</b> apart.")

/obj/structure/plasticflaps/screwdriver_act(mob/living/user, obj/item/W)
	if(..())
		return TRUE
	add_fingerprint(user)
	var/action = anchored ? "unscrews [src] from" : "screws [src] to"
	var/uraction = anchored ? "unscrew [src] from" : "screw [src] to"
	user.visible_message(span_warning("[user] [action] the floor."), span_notice("You start to [uraction] the floor..."), span_hear("You hear rustling noises."))
	if(!W.use_tool(src, user, 100, volume=100, extra_checks = CALLBACK(src, PROC_REF(check_anchored_state), anchored)))
		return TRUE
	set_anchored(!anchored)
	update_atmos_behaviour()
	air_update_turf(TRUE)
	to_chat(user, span_notice("You [uraction] the floor."))
	return TRUE

///Update the flaps behaviour to gases, if not anchored will let air pass through
/obj/structure/plasticflaps/proc/update_atmos_behaviour()
	can_atmos_pass = anchored ? ATMOS_PASS_YES : ATMOS_PASS_NO

/obj/structure/plasticflaps/wirecutter_act(mob/living/user, obj/item/W)
	. = ..()
	if(!anchored)
		user.visible_message(span_warning("[user] cuts apart [src]."), span_notice("You start to cut apart [src]."), span_hear("You hear cutting."))
		if(W.use_tool(src, user, 50, volume=100))
			if(anchored)
				return TRUE
			to_chat(user, span_notice("You cut apart [src]."))
			var/obj/item/stack/sheet/plastic/five/P = new(loc)
			if (!QDELETED(P))
				P.add_fingerprint(user)
			qdel(src)
		return TRUE

/obj/structure/plasticflaps/proc/check_anchored_state(check_anchored)
	if(anchored != check_anchored)
		return FALSE
	return TRUE

/obj/structure/plasticflaps/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(pass_info.is_living)
		if(pass_info.is_bot)
			return TRUE
		if(pass_info.can_ventcrawl && pass_info.mob_size != MOB_SIZE_TINY)
			return FALSE

	if(pass_info.pulling_info)
		return CanAStarPass(to_dir, pass_info.pulling_info)
	return TRUE //diseases, stings, etc can pass


/obj/structure/plasticflaps/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(mover.pass_flags & PASSFLAPS) //For anything specifically engineered to cross plastic flaps.
		return TRUE
	if(mover.pass_flags & PASSGLASS)
		return prob(60)

	if(istype(mover, /obj/structure/bed))
		var/obj/structure/bed/bed_mover = mover
		if(bed_mover.density || bed_mover.has_buckled_mobs())//if it's a bed/chair and is dense or someone is buckled, it will not pass
			return FALSE

	else if(istype(mover, /obj/structure/closet/cardboard))
		var/obj/structure/closet/cardboard/cardboard_mover = mover
		if(cardboard_mover.move_delay)
			return FALSE

	else if(ismecha(mover))
		return FALSE

	else if(isliving(mover)) // You Shall Not Pass!
		var/mob/living/living_mover = mover
		if(istype(living_mover.buckled, /mob/living/simple_animal/bot/mulebot)) // mulebot passenger gets a free pass.
			return TRUE

		if(living_mover.body_position == STANDING_UP && living_mover.mob_size != MOB_SIZE_TINY && !(HAS_TRAIT(living_mover, TRAIT_VENTCRAWLER_ALWAYS) || HAS_TRAIT(living_mover, TRAIT_VENTCRAWLER_NUDE)))
			return FALSE //If you're not laying down, or a small creature, or a ventcrawler, then no pass.


/obj/structure/plasticflaps/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/plastic/five(loc)

/obj/structure/plasticflaps/Destroy()
	var/atom/oldloc = loc
	. = ..()
	if (oldloc)
		oldloc.air_update_turf(TRUE, FALSE)
