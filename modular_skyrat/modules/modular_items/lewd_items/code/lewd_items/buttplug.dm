/obj/item/clothing/sextoy/buttplug
	name = "buttplug"
	desc = "I'm meant to put that WHERE?!"
	icon_state = "buttplug_pink_small"
	base_icon_state = "buttplug"
	worn_icon_state = "buttplug_pink"
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	lewd_slot_flags = LEWD_SLOT_ANUS | LEWD_SLOT_VAGINA
	/// Current color of the toy, can be changed, affects sprite
	var/current_color = "pink"
	/// Current size of the toy, can be changed, affects sprite and arousal
	var/current_size = "small"
	light_color = LIGHT_COLOR_ELECTRIC_GREEN
	/// A bool of if the color's been changed before
	var/color_changed = FALSE
	/// A bool of if the form has been altered before
	var/form_changed = FALSE
	/// A static list containing all designs (or colors) of toys
	var/static/list/buttplug_designs
	/// A static list containing all forms (or sizes) of toys
	var/static/list/buttplug_forms
	w_class = WEIGHT_CLASS_TINY

//create radial menu
/obj/item/clothing/sextoy/buttplug/proc/populate_buttplug_designs()
	buttplug_designs = list(
		"pink" = image(icon = src.icon, icon_state = "buttplug_pink_small"),
		"teal" = image(icon = src.icon, icon_state = "buttplug_teal_small"),
		"tail" = image(icon = src.icon, icon_state = "buttplug_tail_small"),
		"yellow" = image(icon = src.icon, icon_state = "buttplug_yellow_small"),
		"metal" = image(icon = src.icon, icon_state = "buttplug_metal_small"),
		"green" = image(icon = src.icon, icon_state = "buttplug_green_small"))

/obj/item/clothing/sextoy/buttplug/proc/populate_buttplug_forms()
	buttplug_forms = list(
		"small" = image(icon = src.icon, icon_state = "buttplug_pink_small"),
		"medium" = image(icon = src.icon, icon_state = "buttplug_pink_medium"),
		"big" = image(icon = src.icon, icon_state = "buttplug_pink_big"))

/obj/item/clothing/sextoy/buttplug/examine(mob/user)
	. = ..()
	if(!color_changed)
		. += span_notice("Alt-click to change it's colors.")
	else if(!form_changed)
		. += span_notice("Alt-click to change it's size.")

/obj/item/clothing/sextoy/buttplug/click_alt(mob/user)
	if(!color_changed)
		var/choice = show_radial_menu(user, src, buttplug_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_color = choice
		update_icon()
		if(choice == "green")
			set_light(0.25)
			update_light()
		color_changed = TRUE
		return CLICK_ACTION_SUCCESS
	else
		if(!form_changed)
			var/choice = show_radial_menu(user, src, buttplug_forms, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
			if(!choice)
				return CLICK_ACTION_BLOCKING
			current_size = choice
			update_icon()
			form_changed = TRUE
			return CLICK_ACTION_SUCCESS

/obj/item/clothing/sextoy/buttplug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	set_light(0)
	update_light()
	update_icon_state()
	update_icon()
	if(!length(buttplug_designs))
		populate_buttplug_designs()
	if(!length(buttplug_forms))
		populate_buttplug_forms()

/obj/item/clothing/sextoy/buttplug/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]_[current_size]"
	worn_icon_state = "[base_icon_state]_[current_color]"

/obj/item/clothing/sextoy/buttplug/lewd_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!istype(user))
		return
	if(src == user.anus || src == user.vagina)
		START_PROCESSING(SSobj, src)

	if(src == user.vagina && current_color == "tail")
		user.cut_overlay(user.overlays_standing[VAGINA_LAYER])

	// I did this shit with taur icons on purpose because fuck skyrat's system with taurs, it's dumb and maybe dumber than me I CANT DO THIS ANYMORE WHY THIS OVERLAPPING WITH MY SPRITES AAAAAARGH
	if(user.dna.species.mutant_bodyparts["taur"] && src == user.anus)
		user.cut_overlay(user.overlays_standing[ANUS_LAYER])

/obj/item/clothing/sextoy/buttplug/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/buttplug/process(seconds_per_tick)
	var/mob/living/carbon/human/target = loc
	if(!istype(target))
		return
	// I tried using switch here, but it need static value, and u.arousal can't be it. So fuck switches. Reject it, embrace the IFs
	if(current_size == "small" && target.arousal < 30)
		target.adjust_arousal(0.6 * seconds_per_tick)
		target.adjust_pleasure(0.7 * seconds_per_tick)
	else if(current_size == "medium" && target.arousal < 40)
		target.adjust_arousal(0.8 * seconds_per_tick)
		target.adjust_pleasure(0.8 * seconds_per_tick)
	else if(current_size == "big" && target.arousal < 50)
		target.adjust_arousal(seconds_per_tick)
		target.adjust_pleasure(seconds_per_tick)
		if(target.pain < 22.5) //yeah, this will cause pain. No buttplug gib intended, sry
			target.adjust_pain(1 * seconds_per_tick)
