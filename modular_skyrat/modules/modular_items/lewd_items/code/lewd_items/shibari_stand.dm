/////////////////////
//s-stand code here//
/////////////////////

/obj/structure/chair/x_stand
	name = "shibari stand"
	desc = "A stand for buckling people with ropes."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	icon_state = "xstand"
	max_buckled_mobs = 1
	max_integrity = 75
	var/static/mutable_appearance/xstand_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi', "xstand_overlay", LYING_MOB_LAYER)
	var/mob/living/carbon/human/current_mob = null

/obj/structure/chair/shibari_stand/Destroy()
	. = ..()
	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
	unbuckle_all_mobs(TRUE)

/obj/structure/chair/shibari_stand/attack_hand(mob/living/user)
	var/mob/living/M = locate() in src.loc
	if(!has_buckled_mobs())
		if(M)
			if(M.can_buckle_to)
				user_buckle_mob(M, user, check_loc = TRUE)
	else
		var/mob/living/buckled_mob = buckled_mobs[1]
		user_unbuckle_mob(buckled_mob, user)


// Object cannot rotate
/obj/structure/chair/shibari_stand/can_be_rotated(mob/user)
	return FALSE
// User cannot rotate the object
/obj/structure/chair/shibari_stand/can_user_rotate(mob/user)
	return FALSE
// Another plug to disable rotation
/obj/structure/chair/shibari_stand/attack_tk(mob/user)
	return FALSE

/obj/structure/chair/shibari_stand/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	var/mob/living/M = unbuckle_mob(buckled_mob)
	if(M)
		if(M != user)
			if((HAS_TRAIT(user, TRAIT_RIGGER)))
				if(!do_after(user, 5 SECONDS, M))
					return FALSE
			else
				if(!do_after(user, 10 SECONDS, M))
					return FALSE
			M.visible_message(span_notice("[user] unbuckles [M] from [src]."),\
				span_notice("[user] unbuckles you from [src]."),\
				span_hear("You hear loose ropes."))
		else
			user.visible_message(span_notice("You unbuckle yourself from [src]."),\
				span_hear("You hear loose ropes."))
		add_fingerprint(user)
		if(isliving(M.pulledby))
			var/mob/living/L = M.pulledby
			L.set_pull_offsets(M, L.grab_state)
	return M

/obj/structure/chair/shibari_stand/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	if(!is_user_buckle_possible(M, user, check_loc))
		return FALSE
	add_fingerprint(user)

	if(!ishuman(M))
		return FALSE

	var/mob/living/carbon/human/hooman = M
	if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari_body)))
		to_chat(user, span_warning("There's no way to tie them to the stand!"))
		return FALSE

	if(M != user)
		M.visible_message(span_warning("[user] starts tying [M] to [src]!"),\
			span_userdanger("[user] starts tying you to [src]!"),\
			span_hear("You hear ropes being tightened."))
		if((HAS_TRAIT(user, TRAIT_RIGGER)))
			if(!do_after(user, 5 SECONDS, M))
				return FALSE
		else
			if(!do_after(user, 10 SECONDS, M))
				return FALSE

		if(!is_user_buckle_possible(M, user, check_loc))
			return FALSE

		if(buckle_mob(M, check_loc = check_loc))
			M.visible_message(span_warning("[user] tied [M] to [src]!"),\
				span_userdanger("[user] tied you to [src]!"),\
				span_hear("You hear ropes being completely tightened."))
	else
		to_chat(user, span_warning("You cannot buckle yourself to this stand, there is no way that level of self-bondage exists!"))
		return FALSE

// Machine deconstruction process handler
/obj/structure/chair/shibari_stand/deconstruct()
	qdel(src)
	return TRUE

/obj/structure/chair/shibari_stand/post_buckle_mob(mob/living/M)
	M.pixel_y = M.base_pixel_y
	M.pixel_x = M.base_pixel_x
	M.layer = BELOW_MOB_LAYER

	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.forceMove(loc)
			current_mob.handcuffed.dropped(current_mob)
			current_mob.set_handcuffed(null)
			current_mob.update_handcuffed()
		current_mob.set_handcuffed(new /obj/item/restraints/handcuffs/milker(current_mob))
		current_mob.handcuffed.parented_struct = src
		if(HAS_TRAIT(current_mob, TRAIT_ROPEBUNNY))
			current_mob.handcuffed.breakouttime = 4 MINUTES
		current_mob.update_abstract_handcuffed()

//Restore the position of the mob after unbuckling.
/obj/structure/chair/shibari_stand/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.base_pixel_x + M.body_position_pixel_x_offset
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset
	M.layer = initial(M.layer)

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
	current_mob = null

/obj/item/restraints/handcuffs/milker/shibari
	name = "ropes"
	desc = "A shibari rope for restraining hands."
	breakouttime = 2 MINUTES

///////////////////////////
//s-stand construction kit/
///////////////////////////

/obj/item/shibari_stand_kit
	name = "xstand construction kit"
	desc = "Construction requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "xstand_kit"
	var/unwrapped = 0
	w_class = WEIGHT_CLASS_HUGE

/obj/item/shibari_stand_kit/attackby(obj/item/P, mob/user, params) //constructing a bed here.
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		if (!(item_flags & IN_INVENTORY))
			to_chat(user, span_notice("You begin fastening the frame to the floor."))
			if(P.use_tool(src, user, 8 SECONDS, volume=50))
				to_chat(user, span_notice("You assemble the x-stand."))
				var/obj/structure/chair/shibari_stand/C = new
				C.loc = loc
				qdel(src)
			return
	else
		return ..()

/obj/structure/chair/shibari_stand/attackby(obj/item/P, mob/user, params) //deconstructing a bed. Aww(
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		to_chat(user, span_notice("You begin unfastening the frame of x-stand..."))
		if(P.use_tool(src, user, 8 SECONDS, volume=50))
			to_chat(user, span_notice("You disassemble the x-stand."))
			var/obj/item/shibari_stand_kit/C = new
			C.loc = loc
			unbuckle_all_mobs()
			qdel(src)
		return
	else
		return ..()
