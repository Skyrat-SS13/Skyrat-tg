/obj/item/spanking_pad
	name = "spanking pad"
	desc = "A leather pad with a handle."
	icon_state = "spankpad"
	inhand_icon_state = "spankpad"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/current_color = "pink"
	var/color_changed = FALSE
	var/static/list/spankpad_designs

//to change color of fleshlight
//create radial menu
/obj/item/spanking_pad/proc/populate_spankpad_designs()
    spankpad_designs = list(
		"pink" = image (icon = src.icon, icon_state = "spankpad_pink"),
		"teal" = image(icon = src.icon, icon_state = "spankpad_teal"))

/obj/item/spanking_pad/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/spanking_pad/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/spanking_pad/Initialize()
	. = ..()
	update_icon()
	update_icon_state()
	if(!length(spankpad_designs))
		populate_spankpad_designs()

/obj/item/spanking_pad/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/spanking_pad/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, spankpad_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon_state()
		update_icon()
		color_changed = TRUE
	else
		return

/obj/item/spanking_pad/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		switch(user.zone_selected) //to let code know what part of body we gonna spank.
			if(BODY_ZONE_PRECISE_GROIN)
				if(M.is_bottomless())
					message = (user == M) ? pick("spanks themselves with [src]","uses [src] to slap their hips") : pick("slaps [M]'s hips with [src]", "uses [src] to slap [M]'s butt","spanks [M] with [src], making a loud slapping noise","slaps [M]'s thighs with [src]")
					if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
						if(prob(40) && (M.stat != DEAD))
							M.emote(pick("twitch_s","moan","blush","gasp"))
						M.adjustArousal(2)
						M.adjustPain(4)
						M.apply_status_effect(/datum/status_effect/spanked)
						if(HAS_TRAIT(M, TRAIT_MASOCHISM || TRAIT_BIMBO))
							SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "pervert spanked", /datum/mood_event/perv_spanked)
						if(prob(10) && (M.stat != DEAD))
							M.apply_status_effect(/datum/status_effect/subspace)
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/slap.ogg', 100, 1, -1)
				else
					to_chat(user, span_danger("[M]'s butt is covered!"))
					return
			else
				return
	else
		to_chat(user, span_danger("[M] doesn't want you to do that."))
		return
