/*
#define AROUSAL_REGULAR_THRESHOLD 25

/*
*	NORMAL DILDO
*/

/obj/item/clothing/sextoy/dildo
	name = "dildo"
	desc = "A large plastic penis, much like the one in your mother's bedside drawer."
	icon_state = "dildo"
	inhand_icon_state = "dildo"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// Current design of the toy, affects sprite and can change
	var/current_color = "human"
	/// If the design has been changed before
	var/color_changed = FALSE
	/// Assoc list of designs, used in the radial menu for picking one
	var/static/list/dildo_designs
	/// How large is the toy? ("small", "medium", "large") (only changed on `custom_dildo`)
	var/poly_size = "medium"
	/// If the size has been changed before (only changed on `custom_dildo`, left here for consistency with `poly_size`)
	var/size_changed = FALSE
	/// If it's part of a double-sided toy or not
	var/side_double = FALSE
	/// If the toy can have its sprite changed
	var/change_sprite = TRUE
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ANUS|ITEM_SLOT_VAGINA
	moth_edible = FALSE

/// Create an assoc list of designs for the radial color/design menu
/obj/item/clothing/sextoy/dildo/proc/populate_dildo_designs()
	dildo_designs = list(
		"avian" = image (icon = src.icon, icon_state = "[initial(icon_state)]_avian"),
		"canine" = image(icon = src.icon, icon_state = "[initial(icon_state)]_canine"),
		"equine" = image(icon = src.icon, icon_state = "[initial(icon_state)]_equine"),
		"dragon" = image(icon = src.icon, icon_state = "[initial(icon_state)]_dragon"),
		"human" = image(icon = src.icon, icon_state = "[initial(icon_state)]_human"),
		"tentacle" = image(icon = src.icon, icon_state = "[initial(icon_state)]_tentacle"))

/obj/item/clothing/sextoy/dildo/AltClick(mob/user)
	if(color_changed)
		return
	. = ..()
	if(.)
		return
	var/choice = show_radial_menu(user, src, dildo_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	current_color = choice
	update_icon()
	color_changed = TRUE

/obj/item/clothing/sextoy/dildo/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(dildo_designs))
		populate_dildo_designs()

/obj/item/clothing/sextoy/dildo/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][change_sprite ? "_[current_color]" : ""]"
	inhand_icon_state = "[initial(icon_state)][change_sprite ? "_[current_color]" : ""]"

/obj/item/clothing/sextoy/dildo/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	if(src == user.anus || src == user.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/dildo/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/dildo/process(delta_time)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		return
	if(poly_size == "small" && user.arousal < (AROUSAL_REGULAR_THRESHOLD * 0.8))
		user.adjustArousal(0.6 * delta_time)
		user.adjustPleasure(0.6 * delta_time)
	else if(poly_size == "medium" && user.arousal < AROUSAL_REGULAR_THRESHOLD)
		user.adjustArousal(0.8 * delta_time)
		user.adjustPleasure(0.8 * delta_time)
	else if(poly_size == "big" && user.arousal < (AROUSAL_REGULAR_THRESHOLD * 1.2))
		user.adjustArousal(1 * delta_time)
		user.adjustPleasure(1 * delta_time)

/obj/item/clothing/sextoy/dildo/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return

	var/message = ""
	var/obj/item/organ/genital/vagina = target.getorganslot(ORGAN_SLOT_VAGINA)
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("[target] doesn't want you to do that."))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna fuck
		if(BODY_ZONE_PRECISE_GROIN)
			if(!vagina)
				to_chat(user, span_danger("[target] don't have suitable genitalia for that!"))
				return
			if(!(target.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW))
				to_chat(user, span_danger("[target]'s groin is covered!"))
				return
			message = (user == target) ? pick("rubs [target.p_their()] vagina with [src]", "gently jams [target.p_their()] pussy with [src]", "fucks [target.p_their()] vagina with a [src]") : pick("delicately rubs [target]'s vagina with [src]", "uses [src] to fuck [target]'s vagina", "jams [target]'s pussy with [src]", "teasing [target]'s pussy with [src]")
			if(poly_size == "small")
				target.adjustArousal(4)
				target.adjustPleasure(5)
				if(prob(20) && (target.stat != DEAD))
					target.emote("moan")
			else if(poly_size == "medium")
				target.adjustArousal(6)
				target.adjustPleasure(8)
				if(prob(40) && (target.stat != DEAD))
					target.emote(pick("twitch_s", "moan"))
			else if(poly_size == "big")
				target.adjustArousal(8)
				target.adjustPleasure(10)
				target.adjustPain(2)
				if(prob(60) && (target.stat != DEAD))
					target.emote(pick("twitch_s", "moan", "gasp"))
			if(side_double)
				user.adjustArousal(6)
				user.adjustPleasure(8)

		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES) //Mouth only. Sorry, perverts. No eye/ear penetration for you today.
			if(!target.is_mouth_covered())
				to_chat(user, span_danger("Looks like [target]'s mouth is covered!"))
				return
			message = (user == target) ? pick("licks [src] erotically", "sucks on [src], slowly inserting it into [target.p_their()] throat") : pick("fucks [target]'s mouth with [src]", "inserts [src] into [target]'s throat, choking [target.p_them()]", "forces [target] to suck [src]", "inserts [src] into [target]'s throat")
			target.adjustArousal(4)
			target.adjustPleasure(1)
			if(prob(70) && (target.stat != DEAD))
				target.emote(pick("gasp", "moan"))


		else
			if(!target.is_bottomless())
				to_chat(user, span_danger("[target]'s anus is covered!"))
				return
			message = (user == target) ? pick("puts [src] into [target.p_their()] anus", "slowly inserts [src] into [target.p_their()] ass") : pick("fucks [target]'s ass with [src]", "uses [src] to fuck [target]'s anus", "jams [target]'s ass with [src]", "roughly fucks [target]'s ass with [src], making [target.p_their()] eyes roll back")
			target.adjustArousal(5)
			target.adjustPleasure(5)
			if(prob(60) && (target.stat != DEAD))
				target.emote(pick("twitch_s", "moan", "shiver"))

	user.visible_message(span_purple("[user] [message]!"))
	playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 100, TRUE, ignore_walls = FALSE)

/*
*	POLYCHROMIC // this doesn't even use polychromism I Want To Die
*/

GLOBAL_LIST_INIT(dildo_colors, list(//mostly neon colors
		"Cyan"		= "#00f9ff", //cyan
		"Green"		= "#49ff00", //green
		"Pink"		= "#ff4adc", //pink
		"Yellow"	= "#fdff00", //yellow
		"Blue"		= "#00d2ff", //blue
		"Lime"		= "#89ff00", //lime
		"Black"		= "#101010", //black
		"Red"		= "#ff0000", //red
		"Orange"	= "#ff9a00", //orange
		"Purple"	= "#e300ff", //purple
		"White"		= "#c0c0c0", //white
		))

/obj/item/clothing/sextoy/dildo/custom_dildo
	name = "custom dildo"
	desc = "A dildo that can be customized to your specification."
	icon_state = "polydildo"
	inhand_icon_state = "polydildo"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// Static list of possible colors for the toy
	var/static/list/poly_colors = list("#FFFFFF", "#FF8888", "#888888")
	current_color = null

	var/static/list/dildo_sizes = list()
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ANUS|ITEM_SLOT_VAGINA
	moth_edible = FALSE

/obj/item/clothing/sextoy/dildo/custom_dildo/populate_dildo_designs()
	dildo_sizes = list(
		"small" = image (icon = src.icon, icon_state = "[initial(icon_state)]_small"),
		"medium" = image(icon = src.icon, icon_state = "[initial(icon_state)]_medium"),
		"big" = image(icon = src.icon, icon_state = "[initial(icon_state)]_big"))

/obj/item/clothing/sextoy/dildo/custom_dildo/AltClick(mob/living/user)
	if(!size_changed)
		var/choice = show_radial_menu(user, src, dildo_sizes, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		poly_size = choice
		update_icon()
		size_changed = TRUE

	else
		if(color_changed)
			return
		if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
			return
		customize(user)
		color_changed = TRUE
		return TRUE

/// Choose a color and transparency level for the toy
/obj/item/clothing/sextoy/dildo/custom_dildo/proc/customize(mob/living/user)
	if(src && !user.incapacitated() && in_range(user, src))
		var/color_choice = tgui_input_list(user, "Choose a color for your dildo.", "Dildo Color", GLOB.dildo_colors)
		if(src && color_choice && !user.incapacitated() && in_range(user, src))
			sanitize_inlist(color_choice, GLOB.dildo_colors, "Red")
			color = GLOB.dildo_colors[color_choice]
	update_icon_state()
	if(src && !user.incapacitated() && in_range(user, src))
		var/transparency_choice = tgui_input_number(user, "Choose the transparency of your dildo. Lower is more transparent! (192-255)", "Dildo Transparency", 255, 255, 192)
		if(src && transparency_choice && !user.incapacitated() && in_range(user, src))
			sanitize_integer(transparency_choice, 191, 255, 192)
			alpha = transparency_choice
	update_icon_state()
	return TRUE

/obj/item/clothing/sextoy/dildo/custom_dildo/examine(mob/user)
	. = ..()
	. += span_notice("<br>Alt-Click \the [src.name] to customize it.")

/obj/item/clothing/sextoy/dildo/custom_dildo/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[poly_size]"
	inhand_icon_state = "[initial(icon_state)]_[poly_size]"

/*
*	DOUBLE DILDO
*/

/obj/item/clothing/sextoy/dildo/double_dildo
	name = "double dildo"
	desc = "You'll have to be a real glizzy gladiator to contend with this."
	icon_state = "dildo_double"
	inhand_icon_state = "dildo_double"
	worn_icon_state = "dildo_side"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_ANUS|ITEM_SLOT_VAGINA
	actions_types = list(/datum/action/item_action/take_dildo)
	/// If one end of the toy is in your hand
	var/in_hands = FALSE
	/// Reference to the end of the toy that you can hold when the other end is inserted in you
	var/obj/item/clothing/sextoy/dildo_side/the_toy
	change_sprite = FALSE
	moth_edible = FALSE

/obj/item/clothing/sextoy/dildo/double_dildo/Initialize()
	. = ..()
	update_action_buttons_icons()

/obj/item/clothing/sextoy/dildo/double_dildo/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/sextoy/dildo/double_dildo/populate_dildo_designs()
	return

/obj/item/clothing/sextoy/dildo/double_dildo/AltClick(mob/user)
	return

/// Proc to update the actionbutton icon
/obj/item/clothing/sextoy/dildo/double_dildo/proc/update_action_buttons_icons()
	var/datum/action/item_action/action_button
	if(istype(action_button, /datum/action/item_action/take_dildo))
		action_button.button_icon_state = "dildo_side"
		action_button.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	update_icon()

//button stuff
/datum/action/item_action/take_dildo
    name = "Take the other side of the double dildo in hand"
    desc = "You can feel one side inside you, time to share this feeling with someone..."

/datum/action/item_action/take_dildo/Trigger(trigger_flags)
	var/obj/item/clothing/sextoy/dildo/double_dildo/dildo = target
	if(istype(dildo))
		dildo.check()

/// A check to make sure the user can actually take one end in their hand
/obj/item/clothing/sextoy/dildo/double_dildo/proc/check()
	var/mob/living/carbon/human/user = usr
	if(src == user.vagina)
		toggle(user)
	else if(src == user.anus)
		to_chat(user, span_warning("You can't use [src] from this angle!"))
	else
		to_chat(user, span_warning("You need to equip [src] before you can use it!"))

/// Code for taking out/putting away the other end of the toy when one end is in you
/obj/item/clothing/sextoy/dildo/double_dildo/proc/toggle(mob/living/carbon/human/user)
	playsound(user, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 40, TRUE, ignore_walls = FALSE)
	var/obj/item/held = user.get_active_held_item()
	var/obj/item/secondary_held = user.get_inactive_held_item()

	if(in_hands)
		if((istype(held, /obj/item/clothing/sextoy/dildo/dildo_side) || istype(secondary_held, /obj/item/clothing/sextoy/dildo/dildo_side)) && held?.item_flags == ABSTRACT | HAND_ITEM)
			var/qdel_hand = ((istype(held, /obj/item/clothing/sextoy/dildo/dildo_side)) ? held : secondary_held)
			QDEL_NULL(qdel_hand)
			user.visible_message(span_notice("[user] puts one end of [src] back.")) // I tried to work out what this message is trying to say, but I can't quite get it.
			in_hands = FALSE
			return

		else if(!held)
			if(istype(secondary_held, /obj/item/clothing/sextoy/dildo/dildo_side) && secondary_held.item_flags == ABSTRACT | HAND_ITEM)
				if(src == user.belt)
					QDEL_NULL(secondary_held)
					new_dildo(user)
		else
			user.visible_message(span_notice("[user] tries to hold one end of [src] in [user.p_their()] hand, but [user.p_their()] hand isn't empty!"))
	else
		new_dildo(user)

/// Code for creating the other end of the toy when one end's in you
/obj/item/clothing/sextoy/dildo/double_dildo/proc/new_dildo(mob/living/carbon/human/user)
	the_toy = new()
	user.put_in_hands(the_toy)
	the_toy.update_icon_state()
	the_toy.update_icon()
	user.visible_message(span_notice("[user] holds one end of [src] in [user.p_their()] hand."))
	in_hands = TRUE

//dumb way to fix organs overlapping with toys, but WHY NOT. Find a better way if you're not lazy as me.
/obj/item/clothing/sextoy/dildo/double_dildo/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	var/obj/item/organ/genital/vagina/vagina = user.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/womb = user.getorganslot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/penis = user.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/testicles = user.getorganslot(ORGAN_SLOT_TESTICLES)


	if(src == user.vagina)
		vagina?.visibility_preference = GENITAL_NEVER_SHOW
		womb?.visibility_preference = GENITAL_NEVER_SHOW
		penis?.visibility_preference = GENITAL_NEVER_SHOW
		testicles?.visibility_preference = GENITAL_NEVER_SHOW
		user.update_body()

	else if(src == user.anus)
		user.cut_overlay(user.overlays_standing[ANUS_LAYER])

/obj/item/clothing/sextoy/dildo/double_dildo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user))
		return
	if(the_toy && !ismob(loc) && in_hands && src != user.belt)
		QDEL_NULL(the_toy)
		in_hands = FALSE

/obj/item/clothing/sextoy/dildo/double_dildo/process(delta_time)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		return
	if(user.arousal < AROUSAL_REGULAR_THRESHOLD)
		user.adjustArousal(0.8 * delta_time)
		user.adjustPleasure(0.8 * delta_time)

/obj/item/clothing/sextoy/dildo/double_dildo/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user))
		return
	var/obj/item/organ/genital/vagina/vagina = user.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/womb/womb = user.getorganslot(ORGAN_SLOT_WOMB)
	var/obj/item/organ/genital/penis/penis = user.getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/testicles/testicles = user.getorganslot(ORGAN_SLOT_TESTICLES)

	if(!(src == user.vagina))
		return
	vagina?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	womb?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	penis?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	testicles?.visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	user.update_body()

/obj/item/clothing/sextoy/dildo/dildo_side
	name = "dildo side"
	desc = "You looking so hot!"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	icon_state = "dildo_side"
	inhand_icon_state = "nothing"
	item_flags = ABSTRACT | HAND_ITEM
	moth_edible = FALSE
	side_double = TRUE

/obj/item/clothing/sextoy/dildo_side/dildo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, STRAPON_TRAIT)

#undef AROUSAL_REGULAR_THRESHOLD
*/
