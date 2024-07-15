// Set up the types of items that can be placed in the mask
/datum/storage/pockets/small/bdsm_mask
	max_slots = 1
	click_alt_open = FALSE

/datum/storage/pockets/small/bdsm_mask/New()
	. = ..()
	can_hold = typecacheof(/obj/item/reagent_containers/cup/lewd_filter)

/obj/item/clothing/mask/gas/bdsm_mask
	name = "latex gasmask"
	desc = "A toned gas mask that completely muffles the wearer. Wearing this makes breathing a lot difficult."
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	icon_state = "mask_pink_off"
	base_icon_state = "mask"
	slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSMOUTH
	starting_filter_type = null
	var/mask_on = FALSE
	var/current_mask_color = "pink"
	var/breath_status = TRUE
	var/time_to_choke = 12	// How long can breath hold
	var/time_to_choke_left	// Time left before start choking
	var/time = 2			// Interval for emotes
	var/tt					// Interval timer
	var/color_changed = FALSE
	var/static/list/mask_designs
	actions_types = list(
		/datum/action/item_action/toggle_breathcontrol,
		/datum/action/item_action/mask_inhale,
		/datum/action/item_action/toggle_gag,
	)
	var/list/moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...") // Phrases to be said when the player attempts to talk when speech modification / voicebox is enabled.
	var/list/moans_alt = list("Mhgm...", "Hmmmp!...", "Gmmmhp!") // Power probability phrases to be said when talking.
	var/moans_alt_probability = 5 // Probability for alternative sounds to play.
	var/temp_check = TRUE //Used to check if user unconsious to prevent choking him until he wakes up
	/// Does the gasmask impede the user's ability to talk?
	var/speech_disabled
	var/modifies_speech = TRUE

/obj/item/clothing/mask/gas/bdsm_mask/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/bdsm_mask)

	new /obj/item/reagent_containers/cup/lewd_filter(src)
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	update_mob_action_buttonss()
	if(!length(mask_designs))
		populate_mask_designs()

/// Can the user reach the filter, false if equipped and active
/obj/item/clothing/mask/gas/bdsm_mask/proc/is_locked(mob/living/carbon/user)
	var/obj/item/clothing/mask/gas/bdsm_mask/worn_mask = user.get_item_by_slot(ITEM_SLOT_MASK)
	return istype(user) && src == worn_mask && src.mask_on

/obj/item/clothing/mask/gas/bdsm_mask/proc/update_mob_action_buttonss()
	var/datum/action/item_action/button

	for(button in src.actions)
		if(istype(button, /datum/action/item_action/toggle_breathcontrol))
			button.button_icon_state = "[current_mask_color]_switch_[mask_on? "on" : "off"]"
			button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
		if(istype(button, /datum/action/item_action/mask_inhale))
			button.button_icon_state = "[current_mask_color]_breath"
			button.button_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	update_icon()

/obj/item/clothing/mask/gas/bdsm_mask/equipped(mob/equipper, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK) && modifies_speech)
		RegisterSignal(equipper, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(equipper, COMSIG_MOB_SAY)

/obj/item/clothing/mask/gas/bdsm_mask/dropped(mob/dropper)
	. = ..()
	UnregisterSignal(dropper, COMSIG_MOB_SAY)

/obj/item/clothing/mask/gas/bdsm_mask/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if(speech_disabled)
		return

	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	play_lewd_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 70, 1, -1)

// Create radial menu
/obj/item/clothing/mask/gas/bdsm_mask/proc/populate_mask_designs()
	mask_designs = list(
		"pink" = image (icon = src.icon, icon_state = "mask_pink_off"),
		"cyan" = image(icon = src.icon, icon_state = "mask_cyan_off"))

// Using multitool on pole
/obj/item/clothing/mask/gas/bdsm_mask/click_alt(mob/user)
	if(color_changed == FALSE)
		var/choice = show_radial_menu(user, src, mask_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		atom_storage.click_alt_open = TRUE
		current_mask_color = choice
		update_icon_state()
		update_icon()
		update_mob_action_buttonss()
		color_changed = TRUE
	return CLICK_ACTION_SUCCESS

// To check if we can change mask's model
/obj/item/clothing/mask/gas/bdsm_mask/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

// To update icon state properly
/obj/item/clothing/mask/gas/bdsm_mask/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_mask_color]_[mask_on? "on" : "off"]"
	inhand_icon_state = "[base_icon_state]_[current_mask_color]_[mask_on? "on" : "off"]"

/obj/item/clothing/mask/gas/bdsm_mask/proc/try_unequip(mob/user)
	if(!do_after(user, 60 SECONDS, target = user))
		to_chat(user, span_warning("You fail to remove the gas mask!"))
		return FALSE
	to_chat(user, span_notice("You remove the gas mask."))
	return TRUE
/obj/item/clothing/mask/gas/bdsm_mask/attack_hand_secondary(mob/user, list/modifiers)


// To make in unremovable without helping when mask is on
/obj/item/clothing/mask/gas/bdsm_mask/attack_hand(mob/user)
	if(!is_locked(user))
		return ..()
	if(try_unequip(user))
		. = ..()
	if(.)
		to_chat(user, span_notice("You remove the gas mask."))

// To make in unremovable without helping when mask is on (for MouseDrop)
/datum/storage/pockets/small/bdsm_mask/on_mousedrop_onto(datum/source, atom/over_object, mob/user)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = source
	if(!istype(mask) || ismecha(user.loc) || user.incapacitated() || !mask.is_locked(user))
		return ..()
	return NONE //handled in mask mousedrop, don't allow content dumping

/obj/item/clothing/mask/gas/bdsm_mask/mouse_drop_dragged(atom/over_object, mob/user, src_location, over_location, params)
	if(ismecha(user.loc) || user.incapacitated() || !is_locked(user))
		return
	if(!istype(over_object, /atom/movable/screen/inventory/hand))
		return
	var/atom/movable/screen/inventory/hand/hand = over_object
	if(!istype(hand))
		return
	if(!try_unequip(user) || !user.putItemFromInventoryInHandIfPossible(src, hand.held_index))
		return
	to_chat(user, span_notice("You remove the gas mask."))
	add_fingerprint(user)

/datum/storage/pockets/small/bdsm_mask/remove_single(mob/removing, obj/item/thing, atom/remove_to_loc, silent)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = parent
	if(!istype(mask) || !mask.is_locked(removing))
		return ..()
	to_chat(removing, span_warning("You can't detach the filter while the mask is locked!"))
	return FALSE

/datum/storage/pockets/small/bdsm_mask/attempt_insert(obj/item/to_insert, mob/user, override, force, messages)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = parent
	if(!istype(mask) || !mask.is_locked(user))
		return ..()
	to_chat(user, span_warning("You can't attach a filter while the mask is locked!"))
	return FALSE

// Breathing valve control button
/datum/action/item_action/toggle_breathcontrol
	name = "Toggle breath control filter"
	desc = "Makes breathing through this mask far harder. Use with caution."

// Trigger thing for manual breath
/datum/action/item_action/toggle_breathcontrol/Trigger(trigger_flags)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = target
	if(istype(mask))
		mask.check(owner)

/datum/action/item_action/toggle_gag
	name = "Toggle gag"
	desc = "Toggles whether or not the wearer is able to speak."

/datum/action/item_action/toggle_gag/Trigger(trigger_flags)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = target
	if(istype(mask))
		mask.check_gag(owner)

/datum/action/item_action/mask_inhale
	name = "Inhale oxygen"
	desc = "You must inhale oxygen!"

// Open the valve when press the button
/datum/action/item_action/mask_inhale/Trigger(trigger_flags)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = target
	if(!istype(mask))
		return ..()

	if(mask.breath_status)
		return FALSE

	mask.time_to_choke_left = mask.time_to_choke
	mask.breath_status = TRUE

	var/mob/living/carbon/affected_mob = owner
	if(!istype(affected_mob))
		return FALSE

	affected_mob.try_lewd_autoemote("inhale")
	if(!length(mask.contents))
		return TRUE
	var/obj/item/reagent_containers/cup/lewd_filter/filter = mask.contents[1]
	if(istype(filter))
		filter.reagent_consumption(affected_mob, filter.amount_per_transfer_from_this)

	return TRUE

// Adding breath_manually on equip
/obj/item/clothing/mask/gas/bdsm_mask/equipped(/mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = loc
	var/worn_mask = affected_human.get_item_by_slot(ITEM_SLOT_MASK)
	if(worn_mask == src)
		if(mask_on)
			if(breath_status == FALSE)
				time_to_choke_left = time_to_choke
				breath_status = TRUE
				affected_human.try_lewd_autoemote("inhale")
			to_chat(affected_human, span_purple("You suddenly find it much harder to breathe!."))
			START_PROCESSING(SSobj, src)
			time_to_choke_left = time_to_choke

// We unequipped mask, now we can breath without buttons
/obj/item/clothing/mask/gas/bdsm_mask/dropped(mob/user)
	. = ..()
	if(mask_on == TRUE)
		STOP_PROCESSING(SSobj, src)
		temp_check = TRUE

// To check if player already have this mask on and trying to change mode
/obj/item/clothing/mask/gas/bdsm_mask/proc/check(mob/living/carbon/user)
	if(!istype(user) || src == user.wear_mask)
		to_chat(user, span_notice("You can't reach the air filter switch!"))
		return
	toggle(user)

// Switch the mask valve to the opposite state
/obj/item/clothing/mask/gas/bdsm_mask/proc/toggle(mob/living/carbon/user)
	mask_on = !mask_on
	to_chat(user, span_notice("You turn the air filter [mask_on ? "on. Use with caution!" : "off. Now it's safe to wear."]"))
	play_lewd_sound(user, mask_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
	update_icon_state()
	update_mob_action_buttonss()
	update_icon()
	if(mask_on)
		if(src == user.wear_mask && user.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			START_PROCESSING(SSobj, src)
			time_to_choke_left = time_to_choke
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/clothing/mask/gas/bdsm_mask/proc/check_gag(user)
	var/mob/living/carbon/affected_carbon = user
	if(src == affected_carbon.wear_mask)
		to_chat(user, span_notice("You can't reach the gag switch!"))
	else
		toggle_gag(affected_carbon)

/obj/item/clothing/mask/gas/bdsm_mask/proc/toggle_gag(user)
	speech_disabled = !speech_disabled
	to_chat(user, span_notice("You [speech_disabled ? "disable" : "enable"] the gag on the mask."))
	update_mob_action_buttonss()
	update_icon()

// Mask choke processor
/obj/item/clothing/mask/gas/bdsm_mask/process(seconds_per_tick)
	var/mob/living/carbon/affected_carbon = loc
	if(!istype(affected_carbon))
		return FALSE

	if(time_to_choke_left < time_to_choke/2 && breath_status == TRUE)
		if(temp_check == FALSE && affected_carbon.stat == CONSCIOUS) // If user passed out while wearing this we should continue when he wakes up
			breath_status = FALSE
			time_to_choke_left = time_to_choke
			temp_check = TRUE

		if(affected_carbon.stat == CONSCIOUS)
			affected_carbon.try_lewd_autoemote("exhale")
			breath_status = FALSE
			if(rand(0, 3) == 0)
				affected_carbon.try_lewd_autoemote("moan")
		else
			breath_status = TRUE
			temp_check = FALSE

	if(time_to_choke_left <= 0)
		if(tt <= 0)
			if(affected_carbon.stat == CONSCIOUS)
				affected_carbon.adjustOxyLoss(rand(4, 8)) // Oxy dmg
				affected_carbon.try_lewd_autoemote(pick("gasp", "choke", "moan"))
				tt = time
			else
				breath_status = TRUE
				temp_check = FALSE
		else
			tt -= seconds_per_tick
	else
		time_to_choke_left -= seconds_per_tick

/*
*	FILTERS
*/

// Here goes code for lewd gasmask filter
/obj/item/reagent_containers/cup/lewd_filter
	name = "gasmask filter"
	desc = "A strange looking air filter. It may not be a good idea to breathe this in..."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "filter_pink"
	unique_reskin = list("pink" = "filter_pink",
						"teal" = "filter_teal")
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	volume = 50
	possible_transfer_amounts = list(1, 2, 3, 4, 5, 10, 25, 50)
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 50)
	amount_per_transfer_from_this = 1
	interaction_flags_click = NEED_DEXTERITY

// Standard initialize code for filter
/obj/item/reagent_containers/cup/lewd_filter/Initialize(mapload)
	. = ..()
	update_icon()

// Legacy code from reagent_containers class. Most likely not really needed and can be cleared
/obj/item/reagent_containers/cup/lewd_filter/get_part_rating()
	return reagents.maximum_volume

// Reagent consumption process handler
/obj/item/reagent_containers/cup/lewd_filter/proc/reagent_consumption(mob/living/user, amount_per_transfer_from_this)
	SEND_SIGNAL(src, COMSIG_GLASS_DRANK, user, user)
	reagents.trans_to(user, amount_per_transfer_from_this, transferred_by = user, methods = INGEST)

// I just wanted to add 2nd color variation. Because.
/obj/item/reagent_containers/cup/lewd_filter/click_alt(mob/user)
	// After reskin all clicks go normal, but we can't change the flow rate if mask on and equipped
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = loc
	if(!istype(mask) || !mask.is_locked(user))
		return ..()
	to_chat(user, span_warning("You can't change the flow rate of the valve while the mask is on!"))
	return CLICK_ACTION_BLOCKING
