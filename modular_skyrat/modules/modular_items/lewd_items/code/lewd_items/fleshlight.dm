/obj/item/clothing/sextoy/fleshlight
	name = "fleshlight"
	desc = "What a strange flashlight."
	icon_state = "fleshlight_pink"
	base_icon_state = "fleshlight"
	inhand_icon_state = "fleshlight_pink"
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
	clothing_flags = INEDIBLE_CLOTHING

/// Generates a list of toy colors (or designs) for use in the radial color choice menu
/obj/item/clothing/sextoy/fleshlight/proc/populate_fleshlight_designs()
	fleshlight_designs = list(
		"green" = image(icon = src.icon, icon_state = "[base_icon_state]_green"),
		"pink" = image(icon = src.icon, icon_state = "[base_icon_state]_pink"),
		"teal" = image(icon = src.icon, icon_state = "[base_icon_state]_teal"),
		"red" = image(icon = src.icon, icon_state = "[base_icon_state]_red"),
		"yellow" = image(icon = src.icon, icon_state = "[base_icon_state]_yellow"),
	)

/obj/item/clothing/sextoy/fleshlight/examine(mob/user)
	. = ..()
	if(!color_changed)
		. += span_notice("Alt-click to change it's color.")

/obj/item/clothing/sextoy/fleshlight/Initialize(mapload)
	. = ..()
	update_icon()
	update_icon_state()
	if(!length(fleshlight_designs))
		populate_fleshlight_designs()

/obj/item/clothing/sextoy/fleshlight/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"
	inhand_icon_state = "[base_icon_state]_[current_color]"

/obj/item/clothing/sextoy/fleshlight/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, fleshlight_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_color = choice
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/sextoy/fleshlight/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return
	if(target.stat == DEAD)
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] doesn't want you to do that!"))
		return

	var/obj/item/organ/external/genital/penis = target.get_organ_slot(ORGAN_SLOT_PENIS)
	if(!penis?.is_exposed())
		to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
		return

	var/message = (user == target) ? pick("moans in ecstasy as [target.p_they()] fuck the [src]",
			"slowly moves [src] up and down on [target]'s penis, causing [target.p_them()] to bend in pleasure",
			"shivers in pleasure as [target.p_they()] move [src] on their penis") \
		: pick("uses [src] on [target]'s penis",
			"fucks [target] with [src]",
			"masturbates [target] with [src], causing [target.p_them()] to moan in ecstasy")

	if(prob(70))
		target.try_lewd_autoemote(pick("twitch_s", "moan", "blush"))
	target.adjust_arousal(6)
	target.adjust_pleasure(9)
	user.visible_message(span_purple("[user] [message]!"))
	play_lewd_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 70, 1, -1)
