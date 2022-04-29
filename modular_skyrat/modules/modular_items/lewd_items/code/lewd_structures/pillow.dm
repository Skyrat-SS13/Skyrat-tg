//WARNING - Lot's of shitcode here. I'm not the best coder but this stuff works and i'm happy. Improve it if you want, but don't break anything.

//////////////////////////
///CODE FOR PILLOW ITEM///
//////////////////////////

/obj/item/pillow
	name = "pillow"
	desc = "A big, soft pillow."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "pillow"
	inhand_icon_state = "pillow"
	var/datum/effect_system/feathers/pillow_feathers
	var/current_color = "pink"
	var/current_form = "round"
	var/color_changed = FALSE
	var/form_changed = FALSE
	var/static/list/pillow_colors
	var/static/list/pillow_forms
	w_class = WEIGHT_CLASS_SMALL

//to update model
/obj/item/pillow/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//create radial menu
/obj/item/pillow/proc/populate_pillow_colors()
	pillow_colors = list(
		"pink" = image (icon = src.icon, icon_state = "pillow_pink_round"),
		"teal" = image(icon = src.icon, icon_state = "pillow_teal_round"))

//create radial menu, BUT for forms. I'm smort
/obj/item/pillow/proc/populate_pillow_forms()
	pillow_forms = list(
		"square" = image (icon = src.icon, icon_state = "pillow_pink_square"),
		"round" = image(icon = src.icon, icon_state = "pillow_pink_round"))

/obj/item/pillow/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, pillow_colors, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
		update_icon_state()
	if(color_changed == TRUE)
		if(form_changed == FALSE)
			. = ..()
			if(.)
				return
			var/choice = show_radial_menu(user,src, pillow_forms, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
			if(!choice)
				return FALSE
			current_form = choice
			update_icon()
			form_changed = TRUE
			update_icon_state()
	else
		return

//to check if we can change pillow's model
/obj/item/pillow/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/pillow/Initialize()
	. = ..()
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

/obj/item/pillow/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[current_form]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]_[current_form]"

/obj/item/pillow/Destroy()
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

/obj/item/pillow/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	if(prob(1.5)) // 1.5% chance of special tickling feather spawning. No idea why, i was thinking that this is funny idea. Do not erase it plz
		new /obj/item/tickle_feather(loc)

//and there is code for successful check, so we are hitting someone with a pillow
	pillow_feathers.start()
	switch(user.zone_selected) //to let code know what part of body we gonna hit

		if(BODY_ZONE_HEAD)
			var/message = ""
			message = (user == M) ? pick("hits [M.p_them()]self with [src]", "hits [M.p_their()] head with [src]") : pick("hits [M] with [src]", "hits [M] over the head with [src]! Luckily, [src] is soft.")
			if(prob(30))
				M.emote(pick("laugh","giggle"))
			user.visible_message(span_notice("[user] [message]!"))
			playsound(loc,'modular_skyrat/modules/modular_items/lewd_items/sounds/hug.ogg', 50, 1, -1)

		if(BODY_ZONE_CHEST)
			var/message = ""
			message = (user == M) ? pick("has a solo pillow fight, hitting [M.p_them()]self with [src]","hits [M.p_them()]self with [src]") : pick("hits [M] in the chest with [src]", "playfully hits [M]'s chest with [src]")
			if(prob(30))
				M.emote(pick("laugh","giggle"))
			user.visible_message(span_notice("[user] [message]!"))
			playsound(loc,'modular_skyrat/modules/modular_items/lewd_items/sounds/hug.ogg', 50, 1, -1)

		else
			var/message = ""
			message = (user == M) ? pick("hits [M.p_them()]self with [src]","playfully hits [M.p_them()]self with a [src]", "grabs [src], hitting [M.p_them()]self with it") : pick("hits [M] with [src]", "playfully hits [M] with [src].","hits [M] with [src]. Looks like fun")
			if(prob(30))
				M.emote(pick("laugh","giggle"))
			user.visible_message(span_notice("[user] [message]!"))
			playsound(loc,'modular_skyrat/modules/modular_items/lewd_items/sounds/hug.ogg', 50, 1, -1)

//spawning pillow on the ground when clicking on pillow	by LBM

/obj/item/pillow/attack_self(mob/user)
	if(IN_INVENTORY)
		to_chat(user, span_notice("You set [src] down on the floor."))
		var/obj/structure/bed/pillow_tiny/C = new(get_turf(src))
		C.current_color = current_color
		C.current_form = current_form
		C.color_changed = color_changed
		C.form_changed = form_changed
		C.update_icon_state()
		C.update_icon()
		qdel(src)
	return

////////////////////////////////////
///CODE FOR TINY PILLOW FURNITURE///
////////////////////////////////////

/obj/structure/bed/pillow_tiny
	name = "pillow"
	desc = "A tiny pillow, for tiny heads."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi'
	icon_state = "pillow"
	var/current_color = "pink"
	var/current_form = "round"

	var/color_changed = FALSE
	var/form_changed = FALSE

	buildstacktype = /obj/item/stack/sheet/cloth

/obj/structure/bed/pillow_tiny/Initialize()
	.=..()
	update_icon_state()
	update_icon()

/obj/structure/bed/pillow_tiny/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[current_form]"

//picking up the pillow

/obj/structure/bed/pillow_tiny/AltClick(mob/user)
	to_chat(user, span_notice("You pick up [src]."))
	var/obj/item/pillow/W = new()
	user.put_in_hands(W)

	W.current_form = current_form
	W.current_color = current_color
	W.color_changed = color_changed
	W.form_changed = form_changed

	W.update_icon_state()
	W.update_icon()
	qdel(src)

//when we lay on it

/obj/structure/bed/pillow_tiny/post_buckle_mob(mob/living/M)
	. = ..()
	density = TRUE
	//Push them up from the normal lying position
	M.pixel_y = M.base_pixel_y + 2

/obj/structure/bed/pillow_tiny/post_unbuckle_mob(mob/living/M)
	. = ..()
	density = FALSE
	//Set them back down to the normal lying position
	M.pixel_y = M.base_pixel_y

//"Upgrading" pillow
/obj/structure/bed/pillow_tiny/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/pillow))
		var/obj/item/pillow/P = I
		var/obj/structure/chair/pillow_small/C
		if(P.current_color == current_color)
			to_chat(user, span_notice("You add [src] to a pile."))
			C = new(get_turf(src))
			C.current_color = current_color
			C.pillow2_color = P.current_color
			C.pillow1_color = current_color
			C.pillow1_form = current_form
			C.pillow2_form = P.current_form

			C.pillow1_color_changed = color_changed
			C.pillow1_form_changed = color_changed
			C.pillow2_color_changed = P.color_changed
			C.pillow2_form_changed = P.color_changed

			C.update_icon_state()
			C.update_icon()
			qdel(src)
			qdel(P)
		else
			to_chat(user, span_notice("You feel that those colours would clash...")) //Too lazy to add multicolor pillow pile sprites.
			return
	else
		return ..()

/////////////////////////////////////
///CODE FOR SMALL PILLOW FURNITURE///
/////////////////////////////////////

/obj/structure/chair/pillow_small
	name = "small pillow pile"
	desc = "A small pile of pillows. A comfortable seat, especially for taurs or nagas."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi'
	icon_state = "pillowpile_small"
//	pseudo_z_axis = 4
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

/obj/structure/chair/pillow_small/Initialize()
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

/obj/structure/chair/pillow_small/post_buckle_mob(mob/living/M)
    . = ..()
    update_icon()
    density = TRUE
    //Push them up from the normal lying position
    M.pixel_y = M.base_pixel_y + 2

/obj/structure/chair/pillow_small/update_overlays()
    . = ..()
    if(has_buckled_mobs())
        . += mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_small_[current_color]_overlay", layer = ABOVE_MOB_LAYER + 0.2)

/obj/structure/chair/pillow_small/post_unbuckle_mob(mob/living/M)
	. = ..()
	density = FALSE
	//Set them back down to the normal lying position
	M.pixel_y = M.base_pixel_y

/obj/structure/chair/pillow_small/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"

//Removing pillow from a pile
/obj/structure/chair/pillow_small/AltClick(mob/user)
	to_chat(user, span_notice("You take [src] from the pile."))
	var/obj/item/pillow/W = new()
	var/obj/structure/bed/pillow_tiny/C = new(get_turf(src))
	user.put_in_hands(W)
	//magic
	W.current_color = pillow2_color
	W.current_form = pillow2_form
	C.current_color = pillow1_color
	C.current_form = pillow1_form

	C.color_changed = pillow1_color_changed
	C.form_changed = pillow1_form_changed
	W.color_changed = pillow2_color_changed
	W.form_changed = pillow2_form_changed

	//magic
	W.update_icon_state()
	W.update_icon()
	C.update_icon_state()
	C.update_icon()
	qdel(src)

//Upgrading pillow pile to a PILLOW PILE!
/obj/structure/chair/pillow_small/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/pillow))
		var/obj/item/pillow/P = I
		var/obj/structure/bed/pillow_large/C
		if(P.current_color == current_color)
			to_chat(user, span_notice("You add [src] to the pile."))
			C = new(get_turf(src))
			C.current_color = current_color
			C.pillow3_color = P.current_color
			C.pillow2_color = pillow2_color
			C.pillow1_color = pillow1_color
			C.pillow3_form = P.current_form
			C.pillow1_form = pillow1_form
			C.pillow2_form = pillow2_form

			C.pillow1_color_changed = pillow1_color_changed
			C.pillow1_form_changed = pillow1_form_changed
			C.pillow2_color_changed = pillow2_color_changed
			C.pillow2_form_changed = pillow2_form_changed
			C.pillow3_color_changed = P.color_changed
			C.pillow3_form_changed = P.form_changed

			C.update_icon_state()
			C.update_icon()
			qdel(src)
			qdel(P)
		else
			to_chat(user, span_notice("You feel that those colours would clash...")) //Too lazy to add multicolor pillow pile sprites.
			return
	else
		return ..()

//to prevent creating metal chair from pillow
/obj/structure/chair/pillow_small/MouseDrop(over_object, src_location, over_location)
	return

/////////////////////////
///CODE FOR PILLOW BED///
/////////////////////////

/obj/structure/bed/pillow_large
	name = "large pillow pile"
	desc = "A large pile of pillows. Jump on it!"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi'
	icon_state = "pillowpile_large"
//	pseudo_z_axis = 4
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

	buildstacktype = /obj/item/stack/sheet/cloth

/obj/structure/bed/pillow_large/Initialize()
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

/obj/structure/bed/pillow_large/post_buckle_mob(mob/living/M)
    . = ..()
    update_icon()
    density = TRUE
    //Push them up from the normal lying position
    M.pixel_y = M.base_pixel_y + 0.5

/obj/structure/bed/pillow_large/update_overlays()
    . = ..()
    if(has_buckled_mobs())
        . += mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/pillows.dmi', "pillowpile_large_[current_color]_overlay", layer = ABOVE_MOB_LAYER + 0.2)

/obj/structure/bed/pillow_large/post_unbuckle_mob(mob/living/M)
	. = ..()
	density = FALSE
	//Set them back down to the normal lying position
	M.pixel_y = M.base_pixel_y

/obj/structure/bed/pillow_large/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"

//Removing pillow from a pile
/obj/structure/bed/pillow_large/AltClick(mob/user)
	to_chat(user, span_notice("You take [src] from the pile."))
	var/obj/item/pillow/W = new()
	var/obj/structure/chair/pillow_small/C = new(get_turf(src))
	user.put_in_hands(W)
	//magic
	C.current_color = current_color
	W.current_color = pillow3_color
	W.current_form = pillow3_form
	C.pillow2_form = pillow2_form
	C.pillow2_color = pillow2_color
	C.pillow1_form = pillow1_form
	C.pillow1_color = pillow1_color

	C.pillow1_color_changed = pillow1_color_changed
	C.pillow2_color_changed = pillow2_color_changed
	C.pillow1_form_changed = pillow1_form_changed
	C.pillow2_form_changed = pillow2_form_changed
	W.color_changed = pillow3_color_changed
	W.form_changed = pillow3_form_changed

	//magic
	W.update_icon_state()
	W.update_icon()
	C.update_icon_state()
	C.update_icon()
	qdel(src)
