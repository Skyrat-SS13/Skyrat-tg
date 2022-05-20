/*
/obj/item/clothing/sextoy/fleshlight
	name = "fleshlight"
	desc = "What a strange flashlight."
	icon_state = "fleshlight"
	inhand_icon_state = "fleshlight"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_SMALL
	/// Current color of the toy, can be changed, affects sprite
	var/current_color = "pink"
	/// If the color of the toy has been changed before
	var/color_changed = FALSE
	/// A list of toy designs for use in the radial color choice menu
	var/static/list/fleshlight_designs
	slot_flags = NONE
	moth_edible = FALSE

/// Generates a list of toy colors (or designs) for use in the radial color choice menu
/obj/item/clothing/sextoy/fleshlight/proc/populate_fleshlight_designs()
    fleshlight_designs = list(
		"green" = image (icon = src.icon, icon_state = "[initial(icon_state)]_green"),
		"pink" = image (icon = src.icon, icon_state = "[initial(icon_state)]_pink"),
		"teal" = image (icon = src.icon, icon_state = "[initial(icon_state)]_teal"),
		"red" = image (icon = src.icon, icon_state = "[initial(icon_state)]_red"),
		"yellow" = image(icon = src.icon, icon_state = "[initial(icon_state)]_yellow"))

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

/obj/item/clothing/sextoy/fleshlight/AltClick(mob/user)
	if(color_changed)
		return
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, fleshlight_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	current_color = choice
	update_icon()
	color_changed = TRUE

/obj/item/clothing/sextoy/fleshlight/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return

	var/message = ""
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("[target] doesn't want you to do that!"))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna... Uhh... You get the point.
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/genital/penis = target.getorganslot(ORGAN_SLOT_PENIS)
			if(!penis)
				to_chat(user, span_danger("[target] doesn't have a penis!"))
				return
			if(!(target.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW))
				to_chat(user, span_danger("[target]'s groin is covered!"))
				return
			message = (user == target) ? pick("moans in ecstasy as [target.p_they()] use the [src]", "slowly moves [src] up and down on [target]'s penis, causing [target.p_them()] to bend in pleasure", "slightly shivers in pleasure as [target.p_they()] use [src]") : pick("uses [src] on [target]'s penis", "fucks [target] with [src]", "masturbates [target] with [src], causing [target.p_them()] to moan in ecstasy")
			if(!(prob(40) && (target.stat != DEAD)))
				return
			target.emote(pick("twitch_s", "moan", "blush"))
			target.adjustArousal(6)
			target.adjustPleasure(9)
			user.visible_message(span_purple("[user] [message]!"))
			playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
								'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
								'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
								'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
								'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
								'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 70, 1, -1, ignore_walls = FALSE)
*/
