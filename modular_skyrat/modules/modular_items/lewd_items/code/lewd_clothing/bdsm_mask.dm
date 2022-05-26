/*
// Set up the types of items that can be placed in the mask
/datum/component/storage/concrete/pockets/small/bdsm_mask
	max_items = 1

/datum/component/storage/concrete/pockets/small/bdsm_mask/Initialize()
	. = ..()
	can_hold = typecacheof(/obj/item/reagent_containers/glass/lewd_filter)

/obj/item/clothing/mask/gas/bdsm_mask
	name = "latex gasmask"
	desc = "A toned gas mask that completely muffles the wearer. Wearing this makes breathing a lot difficult."
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "mask"
	inhand_icon_state = "mask"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/bdsm_mask
	slot_flags = ITEM_SLOT_MASK
	var/mask_on = FALSE
	var/current_mask_color = "pink"
	var/breath_status = TRUE
	var/time_to_choke = 12	// How long can breath hold
	var/time_to_choke_left	// Time left before start choking
	var/time = 2			// Interval for emotes
	var/tt					// Interval timer
	var/color_changed = FALSE
	var/static/list/mask_designs
	actions_types = list(/datum/action/item_action/toggle_breathcontrol,
						 /datum/action/item_action/mask_inhale)
	var/list/moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...") // Phrases to be said when the player attempts to talk when speech modification / voicebox is enabled.
	var/list/moans_alt = list("Mhgm...", "Hmmmp!...", "Gmmmhp!") // Power probability phrases to be said when talking.
	var/moans_alt_probability = 5 // Probability for alternative sounds to play.
	var/temp_check = TRUE //Used to check if user unconsious to prevent choking him until he wakes up

// We can only moan with that thing on
/obj/item/clothing/mask/gas/bdsm_mask
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/gas/bdsm_mask/proc/update_action_buttons_icons()
	var/datum/action/item_action/button

	for(button in src.actions)
		if(istype(button, /datum/action/item_action/toggle_breathcontrol))
			button.button_icon_state = "[current_mask_color]_switch_[mask_on? "on" : "off"]"
			button.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
		if(istype(button, /datum/action/item_action/mask_inhale))
			button.button_icon_state = "[current_mask_color]_breath"
			button.icon_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	update_icon()

/obj/item/clothing/mask/gas/bdsm_mask/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 70, 1, -1, ignore_walls = FALSE)

// Create radial menu
/obj/item/clothing/mask/gas/bdsm_mask/proc/populate_mask_designs()
	mask_designs = list(
		"pink" = image (icon = src.icon, icon_state = "mask_pink_off"),
		"cyan" = image(icon = src.icon, icon_state = "mask_cyan_off"))

// Using multitool on pole
/obj/item/clothing/mask/gas/bdsm_mask/AltClick(mob/user)
	if(color_changed == FALSE)
		if(.)
			return
		var/choice = show_radial_menu(user, src, mask_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_mask_color = choice
		update_icon_state()
		update_icon()
		update_action_buttons_icons()
		color_changed = TRUE
		return
	. = ..()

// To check if we can change mask's model
/obj/item/clothing/mask/gas/bdsm_mask/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

// Initializing stuff
/obj/item/clothing/mask/gas/bdsm_mask/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	update_action_buttons_icons()
	if(!length(mask_designs))
		populate_mask_designs()

// To update icon by magic
/obj/item/clothing/mask/gas/bdsm_mask/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

// To update icon state properly
/obj/item/clothing/mask/gas/bdsm_mask/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_mask_color]_[mask_on? "on" : "off"]"
	inhand_icon_state = "[initial(icon_state)]_[current_mask_color]_[mask_on? "on" : "off"]"

// To make in unremovable without helping when mask is on
/obj/item/clothing/mask/gas/bdsm_mask/attack_hand(mob/user)
	if(iscarbon(user))
		if(mask_on == TRUE)
			var/mob/living/carbon/wearer = user
			if(wearer.wear_mask == src)
				if(!do_after(wearer, 600, target = src))
					to_chat(wearer, span_warning("You fail to remove the gas mask!"))
					return
				else
					to_chat(wearer, span_notice("You remove the gas mask."))
	add_fingerprint(usr)
	. = ..()

// To make in unremovable without helping when mask is on (for MouseDrop)
/obj/item/clothing/mask/gas/bdsm_mask/MouseDrop(atom/over_object)
	var/mob/target_mob = usr
	var/mob/living/carbon/human/target_carbon = usr
	if(ismecha(target_mob.loc)) // Stops inventory actions in a mech
		return
	if(!target_mob.incapacitated())
		if(loc == target_mob)
			if(istype(over_object, /atom/movable/screen/inventory/hand))
				var/atom/movable/screen/inventory/hand/hand = over_object
				if(iscarbon(usr))
					if(mask_on == TRUE)
						if(src == target_carbon.wear_mask || . == target_carbon.wear_mask)
							if(!do_after(target_carbon, 600, target = src))
								to_chat(target_mob, span_warning("You fail to remove the gas mask!"))
								return
							else
								to_chat(target_mob, span_notice("You remove the gas mask."))
				if(target_mob.putItemFromInventoryInHandIfPossible(src, hand.held_index))
					add_fingerprint(usr)
				. = ..()

// Handler for clicking on a slot in a mask by hand with a filter
/datum/component/storage/concrete/pockets/small/bdsm_mask/attackby(datum/source, obj/item/used_item, mob/user, params)
	. = ..()
	var/obj/item/clothing/mask/gas/bdsm_mask/worn_mask = user.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(used_item, /obj/item/reagent_containers/glass/lewd_filter))
		if(worn_mask) // Null check
			if(istype(worn_mask, /obj/item/clothing/mask/gas/bdsm_mask)) // Check that the mask is of the correct type
				if(worn_mask.mask_on == TRUE)
					// Place for text about the impossibility to attach a filter
					to_chat(usr, span_warning("You can't attach a filter while the mask is locked!"))
					return

// Breathing valve control button
/datum/action/item_action/toggle_breathcontrol
    name = "Toggle breath control filter"
    desc = "Makes breathing through this mask far harder. Use with caution."

// Trigger thing for manual breath
/datum/action/item_action/toggle_breathcontrol/Trigger(trigger_flags)
	var/obj/item/clothing/mask/gas/bdsm_mask/mask = target
	if(istype(mask))
		mask.check()

/datum/action/item_action/mask_inhale
    name = "Inhale oxygen"
    desc = "You must inhale oxygen!"

// Open the valve when press the button
/datum/action/item_action/mask_inhale/Trigger(trigger_flags)
	if(istype(target, /obj/item/clothing/mask/gas/bdsm_mask))
		var/obj/item/clothing/mask/gas/bdsm_mask/mask = target
		if(mask.breath_status == FALSE)
			mask.time_to_choke_left = mask.time_to_choke
			mask.breath_status = TRUE
			var/mob/living/carbon/affected_mob = usr
			affected_mob.emote("inhale")
			var/obj/item/reagent_containers/glass/lewd_filter/filter = mask.contents[1]
			filter.reagent_consumption(affected_mob, filter.amount_per_transfer_from_this)
		return
	return ..()

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
				affected_human.emote("inhale")
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
/obj/item/clothing/mask/gas/bdsm_mask/proc/check()
	var/mob/living/carbon/affected_carbon = usr
	if(src == affected_carbon.wear_mask)
		to_chat(usr, span_notice("You can't reach the air filter switch!"))
	else
		toggle(affected_carbon)

// Switch the mask valve to the opposite state
/obj/item/clothing/mask/gas/bdsm_mask/proc/toggle(user)
	mask_on = !mask_on
	to_chat(user, span_notice("You turn the air filter [mask_on ? "on. Use with caution!" : "off. Now it's safe to wear."]"))
	playsound(user, mask_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE, ignore_walls = FALSE)
	update_icon_state()
	update_action_buttons_icons()
	update_icon()
	var/mob/living/carbon/human/affected_human = usr
	if(mask_on)
		if(src == affected_human.wear_mask && affected_human.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			START_PROCESSING(SSobj, src)
			time_to_choke_left = time_to_choke
	else
		STOP_PROCESSING(SSobj, src)

// Mask choke processor
/obj/item/clothing/mask/gas/bdsm_mask/process(delta_time)
	var/mob/living/affected_mob = loc
	if(time_to_choke_left < time_to_choke/2 && breath_status == TRUE)
		if(temp_check == FALSE && affected_mob.stat == CONSCIOUS) // If user passed out while wearing this we should continue when he wakes up
			breath_status = FALSE
			time_to_choke_left = time_to_choke
			temp_check = TRUE

		if(affected_mob.stat == CONSCIOUS)
			affected_mob.emote("exhale")
			breath_status = FALSE
			if(rand(0, 3) == 0)
				affected_mob.emote("moan")
		else
			breath_status = TRUE
			temp_check = FALSE

	if(time_to_choke_left <= 0)
		if(tt <= 0)
			if(affected_mob.stat == CONSCIOUS)
				affected_mob.adjustOxyLoss(rand(4, 8)) // Oxy dmg
				affected_mob.emote(pick("gasp", "choke", "moan"))
				tt = time
			else
				breath_status = TRUE
				temp_check = FALSE
		else
			tt -= delta_time
	else
		time_to_choke_left -= delta_time

/*
*	FILTERS
*/

// Here goes code for lewd gasmask filter
/obj/item/reagent_containers/glass/lewd_filter
	name = "gasmask filter"
	desc = "A strange looking air filter. It may not be a good idea to breathe this in..."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "filter_pink"
	unique_reskin = list("pink" = "filter_pink",
						"teal" = "filter_teal")
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/glass = 1500, /datum/material/plastic = 2000)
	volume = 50
	possible_transfer_amounts = list(1, 2, 3, 4, 5)
	list_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 50)

// Standard initialize code for filter
/obj/item/reagent_containers/glass/lewd_filter/Initialize()
	. = ..()
	update_icon()

// Legacy code from reagent_containers class. Most likely not really needed and can be cleared
/obj/item/reagent_containers/glass/lewd_filter/get_part_rating()
	return reagents.maximum_volume

// Reagent consumption process handler
/obj/item/reagent_containers/glass/lewd_filter/proc/reagent_consumption(mob/living/user, amount_per_transfer_from_this)
	SEND_SIGNAL(src, COMSIG_GLASS_DRANK, user, user)
	addtimer(CALLBACK(reagents, /datum/reagents.proc/trans_to, user, amount_per_transfer_from_this, TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)

// I just wanted to add 2th color variation. Because.
/obj/item/reagent_containers/glass/lewd_filter/AltClick(mob/user)
	// Catch first AltClick and open reskin menu
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)
		return
	// After reskin all clicks go normal, but we can't change the flow rate if mask on and equipped
	var/obj/item/clothing/mask/gas/bdsm_mask/worn_mask = user.get_item_by_slot(ITEM_SLOT_MASK)
	if(worn_mask)
		if(iscarbon(user))
			if(istype(worn_mask, /obj/item/clothing/mask/gas/bdsm_mask))
				if(worn_mask.mask_on == TRUE)
					if(istype(src, /obj/item/reagent_containers/glass/lewd_filter))
						to_chat(user, span_warning("You can't change the flow rate of the valve while the mask is on!"))
						return
	. = ..()

// Filter click handling
/obj/item/reagent_containers/glass/lewd_filter/attack_hand(mob/user)
	var/obj/item/clothing/mask/gas/bdsm_mask/worn_mask = user.get_item_by_slot(ITEM_SLOT_MASK)
	if(worn_mask)
		if(iscarbon(user))
			if(istype(worn_mask, /obj/item/clothing/mask/gas/bdsm_mask))
				if(worn_mask.mask_on == TRUE)
					if(istype(src, /obj/item/reagent_containers/glass/lewd_filter))
						// Place for text about the impossibility of detaching the filter
						to_chat(user, span_warning("You can't detach the filter while the mask is locked!"))
						return

	. = ..()
	add_fingerprint(usr)

// Processing a click with a mask filter on the mask. Needed to intercept call at the object class level. Returns automatically to attack_hand(mob/user) method.
/obj/item/clothing/mask/gas/bdsm_mask/attackby(obj/item/used_item, mob/living/user, params)
	return ..() || ((obj_flags & CAN_BE_HIT) && used_item.attack_atom(src, user))

// Mouse drop handler
/obj/item/reagent_containers/glass/lewd_filter/MouseDrop(atom/over_object)
	var/mob/affected_mob = usr
	var/mob/living/carbon/human/affected_human = usr
	var/obj/item/clothing/mask/gas/bdsm_mask/worn_mask = affected_human.get_item_by_slot(ITEM_SLOT_MASK)

	if(ismecha(affected_mob.loc)) // Stops inventory actions in a mech
		return

	if(!affected_mob.incapacitated())
		if(loc == affected_mob)
			if(iscarbon(usr))
				if(worn_mask.mask_on == TRUE)
					if(istype(over_object, /atom/movable/screen/inventory/hand))
						// Place for text about the impossibility of detaching the filter
						to_chat(usr, span_warning("You can't detach the filter while the mask is locked!"))
						return
					else
						// Place for text about the impossibility to attach a filter
						to_chat(usr, span_warning("You can't attach a filter while the mask is locked!"))
						return
			add_fingerprint(usr)
		. = ..()
*/
