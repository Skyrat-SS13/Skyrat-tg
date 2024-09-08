//WARNING - Lot's of shitcode here. I'm not the best coder but this stuff works and I'm happy. Improve it if you want, but don't break anything.

/*
*	CODE FOR PILLOW ITEM
*/

/obj/item/fancy_pillow
	name = "pillow"
	desc = "A big, soft pillow."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "pillow_pink_round"
	base_icon_state = "pillow"
	inhand_icon_state = "pillow_pink_round"
	var/datum/effect_system/feathers/pillow_feathers
	var/current_color = "pink"
	var/current_form = "round"
	var/color_changed = FALSE
	var/form_changed = FALSE
	var/static/list/pillow_colors
	var/static/list/pillow_forms
	w_class = WEIGHT_CLASS_SMALL

// Create radial menu
/obj/item/fancy_pillow/proc/populate_pillow_colors()
	pillow_colors = list(
		"pink" = image (icon = src.icon, icon_state = "pillow_pink_round"),
		"teal" = image(icon = src.icon, icon_state = "pillow_teal_round"))

// Create radial menu, BUT for forms. I'm smort
/obj/item/fancy_pillow/proc/populate_pillow_forms()
	pillow_forms = list(
		"square" = image (icon = src.icon, icon_state = "pillow_pink_square"),
		"round" = image(icon = src.icon, icon_state = "pillow_pink_round"))

/obj/item/fancy_pillow/click_alt(mob/user)
	if(!color_changed)
		var/choice = show_radial_menu(user, src, pillow_colors, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_color = choice
		update_icon()
		color_changed = TRUE
		update_icon_state()
		return CLICK_ACTION_SUCCESS
	else
		if(form_changed)
			return CLICK_ACTION_BLOCKING
		var/choice = show_radial_menu(user, src, pillow_forms, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_form = choice
		update_icon()
		form_changed = TRUE
		update_icon_state()
		return CLICK_ACTION_SUCCESS


//to check if we can change pillow's model
/obj/item/fancy_pillow/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/fancy_pillow/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	if(!length(pillow_colors))
		populate_pillow_colors()
	if(!length(pillow_forms))
		populate_pillow_forms()
	//part of code for feathers spawn on hit
	pillow_feathers = new
	pillow_feathers.set_up(2, 0, src)
	pillow_feathers.attach(src)

/obj/item/fancy_pillow/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]_[current_form]"
	inhand_icon_state = "[base_icon_state]_[current_color]_[current_form]"

/obj/item/fancy_pillow/Destroy()
	if(pillow_feathers)
		qdel(pillow_feathers)
		pillow_feathers = null
	return ..()

//feathers effect on hit

/obj/effect/temp_visual/feathers
	name = "feathers"
	icon_state = "feathers"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
	duration = 14

/datum/effect_system/feathers
	effect_type = /obj/effect/temp_visual/feathers

/obj/item/fancy_pillow/attack(mob/living/carbon/human/affected_mob, mob/living/carbon/human/user)
	. = ..()
	if(!istype(affected_mob, /mob/living/carbon/human))
		return

	if(prob(1.5)) // 1.5% chance of special tickling feather spawning. No idea why, i was thinking that this is funny idea. Do not erase it plz
		new /obj/item/tickle_feather(loc)

//and there is code for successful check, so we are hitting someone with a pillow
	pillow_feathers.start()
	switch(user.zone_selected) //to let code know what part of body we gonna hit

		if(BODY_ZONE_HEAD)
			var/message = ""
			message = (user == affected_mob) ? pick("hits [affected_mob.p_them()]self with [src]", "hits [affected_mob.p_their()] head with [src]") : pick("hits [affected_mob] with [src]", "hits [affected_mob] over the head with [src]! Luckily, [src] is soft.")
			if(prob(30))
				affected_mob.emote(pick("laugh", "giggle"))
			user.visible_message(span_notice("[user] [message]!"))
			playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/hug.ogg', 50, 1, -1)

		if(BODY_ZONE_CHEST)
			var/message = ""
			message = (user == affected_mob) ? pick("has a solo pillow fight, hitting [affected_mob.p_them()]self with [src]", "hits [affected_mob.p_them()]self with [src]") : pick("hits [affected_mob] in the chest with [src]", "playfully hits [affected_mob]'s chest with [src]")
			if(prob(30))
				affected_mob.emote(pick("laugh", "giggle"))
			user.visible_message(span_notice("[user] [message]!"))
			playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/hug.ogg', 50, 1, -1)

		else
			var/message = ""
			message = (user == affected_mob) ? pick("hits [affected_mob.p_them()]self with [src]", "playfully hits [affected_mob.p_them()]self with a [src]", "grabs [src], hitting [affected_mob.p_them()]self with it") : pick("hits [affected_mob] with [src]", "playfully hits [affected_mob] with [src].", "hits [affected_mob] with [src]. Looks like fun")
			if(prob(30))
				affected_mob.emote(pick("laugh", "giggle"))
			user.visible_message(span_notice("[user] [message]!"))
			playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/hug.ogg', 50, 1, -1)

//spawning pillow on the ground when clicking on pillow	by LBM

/obj/item/fancy_pillow/attack_self(mob/user)
	if(IN_INVENTORY)
		to_chat(user, span_notice("You set [src] down on the floor."))
		var/obj/structure/bed/pillow_tiny/pillow_pile = new(get_turf(src))
		pillow_pile.current_color = current_color
		pillow_pile.current_form = current_form
		pillow_pile.color_changed = color_changed
		pillow_pile.form_changed = form_changed
		pillow_pile.update_icon_state()
		pillow_pile.update_icon()
		qdel(src)
	return

/*
*	TINY
*/

/obj/structure/bed/pillow_tiny
	name = "pillow"
	desc = "A tiny pillow, for tiny heads."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi'
	icon_state = "pillow_pink_round"
	base_icon_state = "pillow"
	var/current_color = "pink"
	var/current_form = "round"

	var/color_changed = FALSE
	var/form_changed = FALSE

	build_stack_type = /obj/item/stack/sheet/cloth

/obj/structure/bed/pillow_tiny/Initialize(mapload)
	.=..()
	update_icon_state()
	update_icon()

/obj/structure/bed/pillow_tiny/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]_[current_form]"

//picking up the pillow

/obj/structure/bed/pillow_tiny/click_alt(mob/user)
	to_chat(user, span_notice("You pick up [src]."))
	var/obj/item/fancy_pillow/taken_pillow = new()
	user.put_in_hands(taken_pillow)

	taken_pillow.current_form = current_form
	taken_pillow.current_color = current_color
	taken_pillow.color_changed = color_changed
	taken_pillow.form_changed = form_changed

	taken_pillow.update_icon_state()
	taken_pillow.update_icon()
	qdel(src)
	return CLICK_ACTION_SUCCESS

//when we lay on it

/obj/structure/bed/pillow_tiny/post_buckle_mob(mob/living/affected_mob)
	. = ..()
	density = TRUE
	//Push them up from the normal lying position
	affected_mob.pixel_y = affected_mob.base_pixel_y + 2

/obj/structure/bed/pillow_tiny/post_unbuckle_mob(mob/living/affected_mob)
	. = ..()
	density = FALSE
	//Set them back down to the normal lying position
	affected_mob.pixel_y = affected_mob.base_pixel_y

//"Upgrading" pillow
/obj/structure/bed/pillow_tiny/attackby(obj/item/used_item, mob/living/user, params)
	if(istype(used_item, /obj/item/fancy_pillow))
		var/obj/item/fancy_pillow/used_pillow = used_item
		var/obj/structure/chair/pillow_small/pillow_pile
		if(used_pillow.current_color == current_color)
			to_chat(user, span_notice("You add [src] to a pile."))
			pillow_pile = new(get_turf(src))
			pillow_pile.current_color = current_color
			pillow_pile.pillow2_color = used_pillow.current_color
			pillow_pile.pillow1_color = current_color
			pillow_pile.pillow1_form = current_form
			pillow_pile.pillow2_form = used_pillow.current_form

			pillow_pile.pillow1_color_changed = color_changed
			pillow_pile.pillow1_form_changed = color_changed
			pillow_pile.pillow2_color_changed = used_pillow.color_changed
			pillow_pile.pillow2_form_changed = used_pillow.color_changed

			pillow_pile.update_icon_state()
			pillow_pile.update_icon()
			qdel(src)
			qdel(used_pillow)
		else
			to_chat(user, span_notice("You feel that those colours would clash...")) //Too lazy to add multicolor pillow pile sprites.
			return
	else
		return ..()

/*
*	SMALL
*/

/obj/structure/chair/pillow_small
	name = "small pillow pile"
	desc = "A small pile of pillows. A comfortable seat, especially for taurs or nagas."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi'
	icon_state = "pillowpile_small_pink"
	base_icon_state = "pillowpile_small"
	pseudo_z_axis = 4
	var/current_color = "pink"
	var/mutable_appearance/armrest

	//Containing pillows that we have here.
	var/pillow1_color = "pink"
	var/pillow2_color = "pink"

	var/pillow1_color_changed = FALSE
	var/pillow2_color_changed = FALSE

	var/pillow1_form = "round"
	var/pillow2_form = "round"

	var/pillow1_form_changed = FALSE
	var/pillow2_form_changed = FALSE

	buildstacktype = /obj/item/stack/sheet/cloth

/obj/structure/chair/pillow_small/Initialize(mapload)
	update_icon()
	return ..()

/obj/structure/chair/pillow_small/proc/GetArmrest()
	if(current_color == "pink")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_small_pink_overlay")
	if(current_color == "teal")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_small_teal_overlay")

/obj/structure/chair/pillow_small/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/chair/pillow_small/post_buckle_mob(mob/living/affected_mob)
	. = ..()
	update_icon()
	density = TRUE
	//Push them up from the normal lying position
	affected_mob.pixel_y = affected_mob.base_pixel_y + 2

/obj/structure/chair/pillow_small/update_overlays()
	. = ..()
	if(has_buckled_mobs())
		. += mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_small_[current_color]_overlay", layer = ABOVE_MOB_LAYER + 0.2)

/obj/structure/chair/pillow_small/post_unbuckle_mob(mob/living/affected_mob)
	. = ..()
	density = FALSE
	//Set them back down to the normal lying position
	affected_mob.pixel_y = affected_mob.base_pixel_y

/obj/structure/chair/pillow_small/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"

//Removing pillow from a pile
/obj/structure/chair/pillow_small/click_alt(mob/user)
	to_chat(user, span_notice("You take [src] from the pile."))
	var/obj/item/fancy_pillow/taken_pillow = new()
	var/obj/structure/bed/pillow_tiny/pillow_pile = new(get_turf(src))
	user.put_in_hands(taken_pillow)
	//magic
	taken_pillow.current_color = pillow2_color
	taken_pillow.current_form = pillow2_form
	pillow_pile.current_color = pillow1_color
	pillow_pile.current_form = pillow1_form

	pillow_pile.color_changed = pillow1_color_changed
	pillow_pile.form_changed = pillow1_form_changed
	taken_pillow.color_changed = pillow2_color_changed
	taken_pillow.form_changed = pillow2_form_changed

	//magic
	taken_pillow.update_icon_state()
	taken_pillow.update_icon()
	pillow_pile.update_icon_state()
	pillow_pile.update_icon()
	qdel(src)
	return CLICK_ACTION_SUCCESS

//Upgrading pillow pile to a PILLOW PILE!
/obj/structure/chair/pillow_small/attackby(obj/item/used_item, mob/living/user, params)
	if(istype(used_item, /obj/item/fancy_pillow))
		var/obj/item/fancy_pillow/used_pillow = used_item
		var/obj/structure/bed/pillow_large/pillow_pile
		if(used_pillow.current_color == current_color)
			to_chat(user, span_notice("You add [src] to the pile."))
			pillow_pile = new(get_turf(src))
			pillow_pile.current_color = current_color
			pillow_pile.pillow3_color = used_pillow.current_color
			pillow_pile.pillow2_color = pillow2_color
			pillow_pile.pillow1_color = pillow1_color
			pillow_pile.pillow3_form = used_pillow.current_form
			pillow_pile.pillow1_form = pillow1_form
			pillow_pile.pillow2_form = pillow2_form

			pillow_pile.pillow1_color_changed = pillow1_color_changed
			pillow_pile.pillow1_form_changed = pillow1_form_changed
			pillow_pile.pillow2_color_changed = pillow2_color_changed
			pillow_pile.pillow2_form_changed = pillow2_form_changed
			pillow_pile.pillow3_color_changed = used_pillow.color_changed
			pillow_pile.pillow3_form_changed = used_pillow.form_changed

			pillow_pile.update_icon_state()
			pillow_pile.update_icon()
			qdel(src)
			qdel(used_pillow)
		else
			to_chat(user, span_notice("You feel that those colours would clash...")) //Too lazy to add multicolor pillow pile sprites.
			return
	else
		return ..()

//to prevent creating metal chair from pillow
/obj/structure/chair/pillow_small/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	return

/*
*	BED
*/

/obj/structure/bed/pillow_large
	name = "large pillow pile"
	desc = "A large pile of pillows. Jump on it!"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi'
	icon_state = "pillowpile_large_pink"
	base_icon_state = "pillowpile_large"
	pseudo_z_axis = 4
	var/current_color = "pink"
	var/mutable_appearance/armrest
	//Containing pillows that we have here
	var/pillow1_color = "pink"
	var/pillow2_color = "pink"
	var/pillow3_color = "pink"

	var/pillow1_color_changed = FALSE
	var/pillow2_color_changed = FALSE
	var/pillow3_color_changed = FALSE

	var/pillow1_form = "round"
	var/pillow2_form = "round"
	var/pillow3_form = "round"

	var/pillow1_form_changed = FALSE
	var/pillow2_form_changed = FALSE
	var/pillow3_form_changed = FALSE

	build_stack_type = /obj/item/stack/sheet/cloth

/obj/structure/bed/pillow_large/Initialize(mapload)
	update_icon()
	return ..()

/obj/structure/bed/pillow_large/proc/GetArmrest()
	if(current_color == "pink")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_large_pink_overlay")
	if(current_color == "teal")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_large_teal_overlay")

/obj/structure/bed/pillow_large/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/bed/pillow_large/post_buckle_mob(mob/living/affected_mob)
	. = ..()
	update_icon()
	density = TRUE
	//Push them up from the normal lying position
	affected_mob.pixel_y = affected_mob.base_pixel_y + 0.5

/obj/structure/bed/pillow_large/update_overlays()
	. = ..()
	if(has_buckled_mobs())
		. += mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_large_[current_color]_overlay", layer = ABOVE_MOB_LAYER + 0.2)

/obj/structure/bed/pillow_large/post_unbuckle_mob(mob/living/affected_mob)
	. = ..()
	density = FALSE
	//Set them back down to the normal lying position
	affected_mob.pixel_y = affected_mob.base_pixel_y

/obj/structure/bed/pillow_large/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"

//Removing pillow from a pile
/obj/structure/bed/pillow_large/click_alt(mob/user)
	to_chat(user, span_notice("You take [src] from the pile."))
	var/obj/item/fancy_pillow/taken_pillow = new()
	var/obj/structure/chair/pillow_small/pillow_pile = new(get_turf(src))
	user.put_in_hands(taken_pillow)
	//magic
	pillow_pile.current_color = current_color
	taken_pillow.current_color = pillow3_color
	taken_pillow.current_form = pillow3_form
	pillow_pile.pillow2_form = pillow2_form
	pillow_pile.pillow2_color = pillow2_color
	pillow_pile.pillow1_form = pillow1_form
	pillow_pile.pillow1_color = pillow1_color

	pillow_pile.pillow1_color_changed = pillow1_color_changed
	pillow_pile.pillow2_color_changed = pillow2_color_changed
	pillow_pile.pillow1_form_changed = pillow1_form_changed
	pillow_pile.pillow2_form_changed = pillow2_form_changed
	taken_pillow.color_changed = pillow3_color_changed
	taken_pillow.form_changed = pillow3_form_changed

	//magic
	taken_pillow.update_icon_state()
	taken_pillow.update_icon()
	pillow_pile.update_icon_state()
	pillow_pile.update_icon()
	qdel(src)
	return CLICK_ACTION_SUCCESS
