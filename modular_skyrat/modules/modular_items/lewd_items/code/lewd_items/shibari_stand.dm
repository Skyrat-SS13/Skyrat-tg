/////////////////////
//s-stand code here//
/////////////////////

/obj/structure/chair/shibari_stand
	name = "shibari stand"
	desc = "A stand for buckling people with ropes."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi'
	icon_state = "shibari_stand_"
	max_buckled_mobs = 1
	max_integrity = 75
	var/static/mutable_appearance/shibari_rope_overlay
	var/static/mutable_appearance/shibari_rope_overlay_behind
	var/static/mutable_appearance/shibari_shadow_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "shibari_shadow", OBJ_LAYER)
	var/mob/living/carbon/human/current_mob = null

/obj/structure/chair/shibari_stand/Destroy()
	cut_overlay(shibari_shadow_overlay)
	cut_overlay(shibari_rope_overlay)
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
	var/mob/living/M = buckled_mob
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
	unbuckle_mob(buckled_mob)
	return M

/obj/structure/chair/shibari_stand/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	if(!is_user_buckle_possible(M, user, check_loc))
		return FALSE
	add_fingerprint(user)

	if(!ishuman(M))
		return FALSE

	var/mob/living/carbon/human/hooman = M
	if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari_body) || istype(hooman.w_uniform, /obj/item/clothing/under/shibari_fullbody)))
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

		if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari_body) || istype(hooman.w_uniform, /obj/item/clothing/under/shibari_fullbody)))
			to_chat(user, span_warning("There's no way to tie them to the stand!"))
			return FALSE

		if(buckle_mob(M, check_loc = check_loc))
			add_overlay(shibari_shadow_overlay)
			var/obj/item/clothing/under/shibari_body/sheebari = hooman.w_uniform
			add_rope_overlays(sheebari.current_color)
			M.visible_message(span_warning("[user] tied [M] to [src]!"),\
				span_userdanger("[user] tied you to [src]!"),\
				span_hear("You hear ropes being completely tightened."))
	else
		to_chat(user, span_warning("You cannot buckle yourself to this stand, there is no way that level of self-bondage exists!"))
		return FALSE

/obj/structure/chair/shibari_stand/deconstruct()
	qdel(src)
	return TRUE

/obj/structure/chair/shibari_stand/proc/add_rope_overlays(color)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)
	shibari_rope_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "ropes_above_[color]", ABOVE_MOB_LAYER)
	shibari_rope_overlay_behind = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "ropes_behind_[color]", BELOW_MOB_LAYER)
	add_overlay(shibari_rope_overlay)
	add_overlay(shibari_rope_overlay_behind)

/obj/structure/chair/shibari_stand/post_buckle_mob(mob/living/M)
	M.pixel_y = M.base_pixel_y + 4
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
		current_mob.set_handcuffed(new /obj/item/restraints/handcuffs/milker/shibari(current_mob))
		current_mob.handcuffed.parented_struct = src
		if(HAS_TRAIT(current_mob, TRAIT_ROPEBUNNY))
			current_mob.handcuffed.breakouttime = 4 MINUTES
		current_mob.update_abstract_handcuffed()

//Restore the position of the mob after unbuckling.
/obj/structure/chair/shibari_stand/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.base_pixel_x + M.body_position_pixel_x_offset
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset - 4
	M.layer = initial(M.layer)

	cut_overlay(shibari_shadow_overlay)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)

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
	name = "shibari stand construction kit"
	desc = "Construction requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "xstand_kit"
	w_class = WEIGHT_CLASS_HUGE
	var/list/color_list = list(
		"black",
		"teal",
		"pink"
	)

/obj/item/shibari_stand_kit/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	var/color = input("Pick a color for your stand", "Color") as null|anything in color_list
	to_chat(user, span_notice("You begin fastening the frame to the floor."))
	if(tool.use_tool(src, user, 8 SECONDS, volume=50))
		to_chat(user, span_notice("You assemble the frame."))
		var/obj/structure/chair/shibari_stand/C = new
		C.icon_state = "shibari_stand_[color]"
		C.loc = loc
		qdel(src)
	return TRUE

/obj/structure/chair/shibari_stand/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("You begin unfastening the frame of x-stand..."))
	if(I.use_tool(src, user, 8 SECONDS, volume=50))
		to_chat(user, span_notice("You disassemble the x-stand."))
		var/obj/item/shibari_stand_kit/C = new
		C.loc = loc
		unbuckle_all_mobs()
		qdel(src)
	return TRUE
