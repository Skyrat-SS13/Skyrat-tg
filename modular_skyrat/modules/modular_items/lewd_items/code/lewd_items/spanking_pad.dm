/obj/item/spanking_pad
	name = "spanking pad"
	desc = "A leather pad with a handle."
	icon_state = "spankpad_pink"
	base_icon_state = "spankpad"
	inhand_icon_state = "spankpad_pink"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_SMALL
	/// Current color, can be changed and affects sprite
	var/current_color = "pink"
	/// If the color has been changed before
	var/color_changed = FALSE
	/// A list of all designs for the color choice radial menu
	var/static/list/spankpad_designs

/// Create the designs for the radial menu
/obj/item/spanking_pad/proc/populate_spankpad_designs()
	spankpad_designs = list(
		"pink" = image(icon = src.icon, icon_state = "spankpad_pink"),
		"teal" = image(icon = src.icon, icon_state = "spankpad_teal"),
	)

/// A check to ensure the user can use the radial menu
/obj/item/spanking_pad/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/spanking_pad/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon()
	update_icon_state()
	if(!length(spankpad_designs))
		populate_spankpad_designs()

/obj/item/spanking_pad/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"
	inhand_icon_state = "[base_icon_state]_[current_color]"

/obj/item/spanking_pad/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = show_radial_menu(user, src, spankpad_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_color = choice
	update_icon_state()
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/spanking_pad/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return
	var/mob/living/carbon/human/carbon_target = target
	if(!carbon_target && !iscyborg(target))
		return

	var/message = ""
	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] doesn't want you to do that."))
		return

	if(!carbon_target?.is_bottomless() && !iscyborg(target))
		to_chat(user, span_danger("[target]'s butt is covered!"))
		return

	message = (user == target) ? pick("spanks themselves with [src]",
			"uses [src] to slap their hips") \
		: pick("slaps [target]'s hips with [src]",
			"uses [src] to slap [target]'s butt",
			"spanks [target] with [src], making a loud slapping noise",
			"slaps [target]'s thighs with [src]")
	user.visible_message(span_purple("[user] [message]!"))
	play_lewd_sound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/slap.ogg', 100, 1, -1)
	if(prob(40))
		target.try_lewd_autoemote(pick("twitch_s", "moan", "blush", "gasp"))
	if(prob(10))
		target.apply_status_effect(/datum/status_effect/subspace)
	if(HAS_TRAIT(target, TRAIT_MASOCHISM) || HAS_TRAIT(target, TRAIT_BIMBO))
		target.add_mood_event("pervert spanked", /datum/mood_event/perv_spanked)
	carbon_target?.adjust_arousal(2)
	target.adjust_pain(4)
	target.apply_status_effect(/datum/status_effect/spanked)
