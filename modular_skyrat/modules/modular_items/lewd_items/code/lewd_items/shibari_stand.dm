/obj/structure/chair/shibari_stand
	name = "shibari stand"
	desc = "A stand for buckling people with ropes."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi'
	icon_state = "shibari_stand"
	max_buckled_mobs = 1
	max_integrity = 75
	///Overlays for ropes
	var/static/mutable_appearance/shibari_rope_overlay
	var/static/mutable_appearance/shibari_rope_overlay_behind
	var/static/mutable_appearance/shibari_shadow_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "shibari_shadow", OBJ_LAYER)

	///obviously, this is for doing things to the currentmob
	var/mob/living/carbon/human/current_mob = null

	///The rope inside the stand, that's actually tying the person to it
	var/obj/item/stack/shibari_rope/ropee = null
	///color
	var/current_color = "pink"
	var/static/list/shibaristand_designs

//Required for color customisation for already assembled shibari stand
/obj/structure/chair/shibari_stand/proc/populate_shibaristand_designs()
	shibaristand_designs = list(
		"pink" = image (icon = src.icon, icon_state = "shibari_stand_pink"),
		"teal" = image (icon = src.icon, icon_state = "shibari_stand_teal"),
		"black" = image (icon = src.icon, icon_state = "shibari_stand_black"),
		"red" = image (icon = src.icon, icon_state = "shibari_stand_red"),
		"white" = image (icon = src.icon, icon_state = "shibari_stand_white"))

//Some checks so ghosts can't fuck with it in any way. Just a precaution
/obj/structure/chair/shibari_stand/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

// Default initialization
/obj/structure/chair/shibari_stand/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(shibaristand_designs))
		populate_shibaristand_designs()

/obj/structure/chair/shibari_stand/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"

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
	var/mob/living/attacked_mob = locate() in src.loc
	if(!has_buckled_mobs())
		if(attacked_mob?.can_buckle_to)
			user_buckle_mob(attacked_mob, user, check_loc = TRUE)
	else
		var/mob/living/buckled_mob = buckled_mobs[1]
		user_unbuckle_mob(buckled_mob, user)

//Examine changes for this structure
/obj/structure/chair/shibari_stand/examine(mob/user)
	.=..()
	. += span_notice("Looks like it can be customized with a <b>screwdriver</b>.")
	if(!has_buckled_mobs() && can_buckle)
		. += span_notice("While standing on [src], drag and drop character <b>with shibari full-body bondage</b> onto [src] to tie a person to it, <b>while holding ropes in your hands</b>.")

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
	var/mob/living/buckled = buckled_mob
	if(buckled)
		if(buckled != user)
			if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 5 SECONDS : 10 SECONDS, buckled))
				return FALSE
			buckled.visible_message(span_notice("[user] unbuckles [buckled] from [src]."),\
				span_notice("[user] unbuckles you from [src]."),\
				span_hear("You hear loose ropes."))
		else
			user.visible_message(span_notice("You unbuckle yourself from [src]."),\
				span_notice("You unbuckle yourself from [src]."),\
				span_hear("You hear loose ropes."))
		add_fingerprint(user)
		if(isliving(buckled.pulledby))
			var/mob/living/L = buckled.pulledby
			L.set_pull_offsets(buckled, L.grab_state)
	unbuckle_mob(buckled_mob)
	return buckled

/obj/structure/chair/shibari_stand/user_buckle_mob(mob/living/buckled, mob/user, check_loc = TRUE)

	if(!buckled.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("Looks like [buckled] doesn't want you to do that."))
		return FALSE

	if(!is_user_buckle_possible(buckled, user, check_loc))
		return FALSE
	add_fingerprint(user)

	if(!ishuman(buckled))
		return FALSE

	var/mob/living/carbon/human/hooman = buckled
	if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari/full)))
		to_chat(user, span_warning("You'll need to completely tie their body!"))
		return FALSE
	if(!istype(user.get_active_held_item(), /obj/item/stack/shibari_rope))
		to_chat(user, span_warning("You'll need to be holding shibari ropes to tie them to the stand!!"))
		return FALSE

	if(buckled != user)
		buckled.visible_message(span_warning("[user] starts tying [buckled] to \the [src]!"),\
			span_userdanger("[user] starts tying you to \the [src]!"),\
			span_hear("You hear ropes being tightened."))
		if((HAS_TRAIT(user, TRAIT_RIGGER)))
			if(!do_after(user, 5 SECONDS, buckled))
				return FALSE
		else
			if(!do_after(user, 10 SECONDS, buckled))
				return FALSE

		if(!is_user_buckle_possible(buckled, user, check_loc))
			return FALSE

		if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari/full)))
			to_chat(user, span_warning("You'll need to completely tie their body!"))
			return FALSE
		if(!istype(user.get_active_held_item(), /obj/item/stack/shibari_rope))
			to_chat(user, span_warning("You'll need to be holding shibari ropes to tie them to the stand!"))
			return FALSE

		if(buckle_mob(buckled, check_loc = check_loc))
			var/obj/item/stack/shibari_rope/rope = user.get_active_held_item()
			ropee = new()
			ropee.current_color = rope.current_color
			ropee.update_icon_state()
			ropee.update_icon()
			rope.use(1)
			add_overlay(shibari_shadow_overlay)
			add_rope_overlays(ropee.current_color, hooman?.dna?.species?.mutant_bodyparts["taur"])
			buckled.visible_message(span_warning("[user] tied [buckled] to \the [src]!"),\
				span_userdanger("[user] tied you to \the [src]!"),\
				span_hear("You hear ropes being completely tightened."))
	else
		to_chat(user, span_warning("You cannot buckle yourself to this stand, there is no way that level of self-bondage exists!"))
		return FALSE

/obj/structure/chair/shibari_stand/deconstruct(disassembled)
	qdel(src)
	return TRUE

/obj/structure/chair/shibari_stand/proc/add_rope_overlays(color, taur)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)
	shibari_rope_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "ropes_above_[taur ? "[color]_snek" : "[color]"]", ABOVE_MOB_LAYER)
	shibari_rope_overlay_behind = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "ropes_behind_[color]", BELOW_MOB_LAYER)
	add_overlay(shibari_rope_overlay)
	add_overlay(shibari_rope_overlay_behind)

/obj/structure/chair/shibari_stand/post_buckle_mob(mob/living/buckled)
	buckled.pixel_y = buckled.base_pixel_y + 4
	buckled.pixel_x = buckled.base_pixel_x
	buckled.layer = BELOW_MOB_LAYER

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
/obj/structure/chair/shibari_stand/post_unbuckle_mob(mob/living/buckled)
	buckled.pixel_x = buckled.base_pixel_x + buckled.body_position_pixel_x_offset
	buckled.pixel_y = buckled.base_pixel_y + buckled.body_position_pixel_y_offset - 4
	buckled.layer = initial(buckled.layer)

	cut_overlay(shibari_shadow_overlay)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()

	if(ropee)
		ropee.forceMove(get_turf(src))
	current_mob = null

/obj/item/restraints/handcuffs/milker/shibari
	name = "ropes"
	desc = "A shibari rope for restraining hands."
	breakouttime = 2 MINUTES

/obj/item/shibari_stand_kit
	name = "shibari stand construction kit"
	desc = "Construction requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "shibari_kit"
	w_class = WEIGHT_CLASS_HUGE
	var/current_color = "pink"
	var/static/list/shibarikit_designs

/obj/item/shibari_stand_kit/proc/populate_shibarikit_designs()
	shibarikit_designs = list(
		"pink" = image (icon = src.icon, icon_state = "shibari_kit_pink"),
		"teal" = image (icon = src.icon, icon_state = "shibari_kit_teal"),
		"black" = image (icon = src.icon, icon_state = "shibari_kit_black"),
		"red" = image (icon = src.icon, icon_state = "shibari_kit_red"),
		"white" = image (icon = src.icon, icon_state = "shibari_kit_white"))

// Default initialization
/obj/item/shibari_stand_kit/Initialize()
	. = ..()
	populate_shibarikit_designs()
	//random color variation on start. Because why not?
	current_color = pick(shibarikit_designs)
	update_icon_state()
	update_icon()

/obj/item/shibari_stand_kit/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"

//Changing examine for this item
/obj/item/shibari_stand_kit/examine(mob/user)
	.=..()
	. += span_notice("Looks like it can be customized with a <b>screwdriver</b>.")

//to change model
/obj/item/shibari_stand_kit/screwdriver_act(mob/living/user, obj/item/tool)
	var/choice = show_radial_menu(user,src, shibarikit_designs, custom_check = CALLBACK(src, .proc/check_menu, user, tool), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	if(tool.use_tool(src, user, 0, volume=40))
		to_chat(user, span_notice("You switched the frame's plastic fittings color to [choice]."))
		current_color = choice
		update_appearance()
	return TRUE

/obj/item/shibari_stand_kit/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

//Assembling shibari stand
/obj/item/shibari_stand_kit/wrench_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("You begin fastening the frame to the floor."))
	if(tool.use_tool(src, user, 8 SECONDS, volume=50))
		to_chat(user, span_notice("You assemble the frame."))
		var/obj/structure/chair/shibari_stand/stand = new
		stand.icon_state = "shibari_stand_[current_color]"
		stand.current_color = current_color
		stand.forceMove(get_turf(src))
		qdel(src)
	return TRUE

//Disassembling shibari stand
/obj/structure/chair/shibari_stand/wrench_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("You begin unfastening the frame of \the [src]..."))
	if(tool.use_tool(src, user, 8 SECONDS, volume=50))
		to_chat(user, span_notice("You disassemble \the [src]."))
		var/obj/item/shibari_stand_kit/kit = new
		kit.icon_state = "shibari_kit_[current_color]"
		kit.current_color = current_color
		kit.forceMove(get_turf(src))
		unbuckle_all_mobs()
		qdel(src)
	return TRUE

//Changing color of shibari stand
/obj/structure/chair/shibari_stand/screwdriver_act(mob/living/user, obj/item/tool)
	var/choice = show_radial_menu(user,src, shibaristand_designs, custom_check = CALLBACK(src, .proc/check_menu, user, tool), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	if(tool.use_tool(src, user, 0, volume=40))
		to_chat(user, span_notice("You switched the frame's plastic fittings color to [choice]."))
		current_color = choice
		update_appearance()
	return TRUE
