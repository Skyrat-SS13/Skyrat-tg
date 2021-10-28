/obj/item/clothing/sextoy/fleshlight
	name = "fleshlight"
	desc = "What a strange flashlight."
	icon_state = "fleshlight"
	inhand_icon_state = "fleshlight"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/current_color = "pink"
	var/color_changed = FALSE
	var/static/list/fleshlight_designs
	slot_flags = NONE
	moth_edible = FALSE

//to change color of fleshlight
//create radial menu
/obj/item/clothing/sextoy/fleshlight/proc/populate_fleshlight_designs()
    fleshlight_designs = list(
		"green" = image (icon = src.icon, icon_state = "fleshlight_green"),
		"pink" = image (icon = src.icon, icon_state = "fleshlight_pink"),
		"teal" = image (icon = src.icon, icon_state = "fleshlight_teal"),
		"red" = image (icon = src.icon, icon_state = "fleshlight_red"),
		"yellow" = image(icon = src.icon, icon_state = "fleshlight_yellow"))

/obj/item/clothing/sextoy/fleshlight/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/sextoy/fleshlight/Initialize()
	. = ..()
	update_icon()
	update_icon_state()
	if(!length(fleshlight_designs))
		populate_fleshlight_designs()

/obj/item/clothing/sextoy/fleshlight/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/sextoy/fleshlight/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, fleshlight_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

/obj/item/clothing/sextoy/fleshlight/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		switch(user.zone_selected) //to let code know what part of body we gonna... Uhh... You get the point.
			if(BODY_ZONE_PRECISE_GROIN)
				var/obj/item/organ/genital/penis = M.getorganslot(ORGAN_SLOT_PENIS)
				if(penis)
					if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
						message = (user == M) ? pick("moans in ecstasy as [M.p_they()] use the [src]","slowly moves [src] up and down on [M]'s penis, causing [M.p_them()] to bend in pleasure","slightly shivers in pleasure as [M.p_they()] use [src].") : pick("uses [src] on [M]'s penis","fucks [M] with [src]","masturbates [M] with [src], causing [M.p_them()] to moan in ecstasy")
						if(prob(40) && (M.stat != DEAD))
							M.emote(pick("twitch_s","moan","blush"))
						M.adjustArousal(6)
						M.adjustPleasure(9)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
											'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 70, 1, -1, ignore_walls = FALSE)
					else
						to_chat(user, span_danger("[M]'s groin is covered!"))
						return
				else
					to_chat(user, span_danger("[M] doesn't have a penis!"))
					return
			else
				return
	else
		to_chat(user, span_danger("[M] doesn't want you to do that!"))
		return
