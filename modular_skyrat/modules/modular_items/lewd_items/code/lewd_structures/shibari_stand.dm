/obj/structure/chair/shibari_stand
	name = "shibari stand"
	desc = "A stand for buckling people with ropes."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi'
	icon_state = "shibari_stand"
	max_integrity = 75
	layer = 4
	item_chair = null
	buildstacktype = null
	///Overlays for ropes
	var/static/mutable_appearance/shibari_rope_overlay
	var/static/mutable_appearance/shibari_rope_overlay_behind
	var/static/mutable_appearance/shibari_shadow_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "shibari_shadow", LOW_OBJ_LAYER)

	greyscale_config = /datum/greyscale_config/shibari_stand
	greyscale_colors = "#bd8fcf"

	///obviously, this is for doing things to the currentmob
	var/mob/living/carbon/human/current_mob = null

	///The rope inside the stand, that's actually tying the person to it
	var/obj/item/stack/shibari_rope/ropee = null

/obj/structure/chair/shibari_stand/MakeRotate()
	return

/obj/structure/chair/shibari_stand/Destroy()
	cut_overlay(shibari_shadow_overlay)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)
	if(ropee)
		ropee.forceMove(get_turf(src))
	. = ..()
	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
	unbuckle_all_mobs(TRUE)

//Examine changes for this structure
/obj/structure/chair/shibari_stand/examine(mob/user)
	. = ..()
	if(!has_buckled_mobs() && can_buckle)
		. += span_notice("They need to be wearing <b>full-body shibari</b>, and you need to be <b>holding ropes</b>!")

// previously NO_DECONSTRUCT
/obj/structure/chair/shibari_stand/wrench_act_secondary(mob/living/user, obj/item/weapon)
	return NONE

/obj/structure/chair/shibari_stand/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	var/mob/living/buckled = buckled_mob
	if(buckled)
		if(buckled != user)
			buckled.visible_message(span_notice("[user] starts unbuckling [buckled] from [src]."),\
				span_notice("[user] tries to unbuckle you from [src]."),\
				span_hear("You hear loose ropes."))
			if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 5 SECONDS : 10 SECONDS, buckled))
				return FALSE
			buckled.visible_message(span_notice("[user] unbuckles [buckled] from [src]."),\
				span_notice("[user] unbuckles you from [src]."),\
				span_hear("You hear loose ropes."))
		else
			user.visible_message(span_notice("[user] starts unbuckling themselves from [src]."),\
				span_notice("[user] unbuckles themselves from [src]."),\
				span_hear("You hear loose ropes."))
		add_fingerprint(user)
		if(isliving(buckled.pulledby))
			var/mob/living/living_mob = buckled.pulledby
			living_mob.set_pull_offsets(buckled, living_mob.grab_state)
	unbuckle_mob(buckled_mob)
	return buckled

/obj/structure/chair/shibari_stand/user_buckle_mob(mob/living/buckled, mob/user, check_loc = TRUE)

	if(!buckled.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
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
		if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 5 SECONDS : 10 SECONDS, buckled))
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
			ropee.set_greyscale(rope.greyscale_colors)
			rope.use(1)
			add_overlay(shibari_shadow_overlay)
			add_rope_overlays(ropee.greyscale_colors, hooman?.dna?.species?.mutant_bodyparts["taur"])
			buckled.visible_message(span_warning("[user] tied [buckled] to \the [src]!"),\
				span_userdanger("[user] tied you to \the [src]!"),\
				span_hear("You hear ropes being completely tightened."))
			return TRUE
		else
			return FALSE
	else
		to_chat(user, span_warning("You cannot buckle yourself to this stand, there is no way that level of self-bondage exists!"))
		return FALSE

/obj/structure/chair/shibari_stand/atom_deconstruct(disassembled)
	qdel(src)

/obj/structure/chair/shibari_stand/proc/add_rope_overlays(color, taur)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)
	var/icon/rope_overlays = SSgreyscale.GetColoredIconByType(/datum/greyscale_config/shibari_stand_ropes, color)
	shibari_rope_overlay = mutable_appearance(rope_overlays, "ropes_above[taur ? "_snek" : ""]", ABOVE_MOB_LAYER)
	shibari_rope_overlay_behind = mutable_appearance(rope_overlays, "ropes_behind", BELOW_MOB_LAYER)
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

		var/obj/item/restraints/handcuffs/milker/shibari/cuffs = new (current_mob)
		current_mob.set_handcuffed(cuffs)
		cuffs.parent_chair = WEAKREF(src)
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

//Disassembling shibari stand
/obj/structure/chair/shibari_stand/click_ctrl_shift(mob/user)
	. = ..()
	if(. == FALSE)
		return FALSE

	to_chat(user, span_notice("You begin unfastening the frame of \the [src]..."))
	if(!do_after(user, 8 SECONDS, src))
		to_chat(user, span_warning("You fail to disassemble \the [src]."))
		return FALSE

	to_chat(user, span_notice("You disassemble \the [src]."))
	var/obj/item/construction_kit/bdsm/shibari/kit = new(get_turf(src))
	kit.set_greyscale(greyscale_colors)
	unbuckle_all_mobs()
	qdel(src)
	return TRUE

//Changing color of shibari stand
/obj/structure/chair/shibari_stand/click_ctrl(mob/user)
	var/list/allowed_configs = list()
	allowed_configs += "[greyscale_config]"
	var/datum/greyscale_modify_menu/menu = new(
		src, usr, allowed_configs, null, \
		starting_icon_state = icon_state, \
		starting_config = greyscale_config, \
		starting_colors = greyscale_colors
	)
	menu.ui_interact(usr)
	to_chat(user, span_notice("You switch the frame's plastic fittings color."))
	return TRUE

/obj/structure/chair/shibari_stand/examine(mob/user)
	. = ..()
	. += span_purple("[src] can be disassembled by using <b>Ctrl+Shift+Click<b>")
	. += span_purple("[src]'s color can be customized with <b>Ctrl+Click</b>.")
