/*/obj/item/spanking_pad
	name = "spanking pad"
	desc = "A leather pad with a handle."
	icon_state = "spankpad"
	inhand_icon_state = "spankpad"
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
		"pink" = image (icon = src.icon, icon_state = "spankpad_pink"),
		"teal" = image(icon = src.icon, icon_state = "spankpad_teal"))

/obj/item/spanking_pad/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/// A check to ensure the user can use the radial menu
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

/obj/item/spanking_pad/AltClick(mob/user)
	if(color_changed)
		return
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, spankpad_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	current_color = choice
	update_icon_state()
	update_icon()
	color_changed = TRUE

/obj/item/spanking_pad/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return

	var/message = ""
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("[target] doesn't want you to do that."))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna spank.
		if(BODY_ZONE_PRECISE_GROIN)
			if(!target.is_bottomless())
				to_chat(user, span_danger("[target]'s butt is covered!"))
				return
			message = (user == target) ? pick("spanks themselves with [src]", "uses [src] to slap their hips") : pick("slaps [target]'s hips with [src]", "uses [src] to slap [target]'s butt", "spanks [target] with [src], making a loud slapping noise", "slaps [target]'s thighs with [src]")
			if(prob(40) && (target.stat != DEAD))
				target.emote(pick("twitch_s", "moan", "blush", "gasp"))
			target.adjustArousal(2)
			target.adjustPain(4)
			target.apply_status_effect(/datum/status_effect/spanked)
			if(HAS_TRAIT(target, TRAIT_MASOCHISM || TRAIT_BIMBO))
				SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "pervert spanked", /datum/mood_event/perv_spanked)
			if(prob(10) && (target.stat != DEAD))
				target.apply_status_effect(/datum/status_effect/subspace)
			user.visible_message(span_purple("[user] [message]!"))
			playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/slap.ogg', 100, 1, -1)
*/
