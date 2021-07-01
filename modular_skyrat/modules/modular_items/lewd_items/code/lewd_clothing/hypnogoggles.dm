/obj/item/clothing/glasses/hypno
	name = "hypnotic goggles"
	desc = "Woaa-a-ah... This is lewd."
	icon_state = "hypnogoggles"
	inhand_icon_state = "hypnogoggles"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_eyes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_eyes.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	var/color_changed = FALSE
	var/current_hypnogoggles_color = "pink"
	var/static/list/hypnogoggles_designs

	var/mob/living/carbon/victim
	var/codephrase = "Obey"//There SHOULD be default phrase, because if there is none - goggles will go buggy when you equip them without setting phrase.

/obj/item/clothing/glasses/hypno/equipped(mob/user, slot)//Adding hypnosis on equip
	. = ..()
	victim = user
	if(slot != ITEM_SLOT_EYES)
		return
	if(iscarbon(victim) && victim.client?.prefs.erp_pref == "Yes")
		if(codephrase != "")
			victim.gain_trauma(new /datum/brain_trauma/hypnosis(codephrase), TRAUMA_RESILIENCE_BASIC)
		else
			codephrase = "Obey"
			victim.gain_trauma(new /datum/brain_trauma/hypnosis(codephrase), TRAUMA_RESILIENCE_BASIC)

/obj/item/clothing/glasses/hypno/dropped(mob/user)//Removing hypnosis on unequip
	. = ..()
	if(victim.glasses == src)
		victim.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_BASIC)
		victim = null

/obj/item/clothing/glasses/hypno/attack_self(mob/user)//Setting up hypnotising phrase
	. = ..()
	codephrase = stripped_input(user, "Change the hypnotic phrase")

//create radial menu
/obj/item/clothing/glasses/hypno/proc/populate_hypnogoggles_designs()
	hypnogoggles_designs = list(
		"pink" = image (icon = src.icon, icon_state = "hypnogoggles_pink"),
		"teal" = image(icon = src.icon, icon_state = "hypnogoggles_teal"))

//to update model lol
/obj/item/clothing/glasses/hypno/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/glasses/hypno/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, hypnogoggles_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_hypnogoggles_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change kinkphones's model
/obj/item/clothing/glasses/hypno/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/glasses/hypno/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(hypnogoggles_designs))
		populate_hypnogoggles_designs()

/obj/item/clothing/glasses/hypno/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_hypnogoggles_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_hypnogoggles_color]"
