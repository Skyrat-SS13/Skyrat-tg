// Basic ball gag
/obj/item/clothing/mask/ballgag
	name = "ball gag"
	desc = "Prevents the wearer from speaking."
	icon_state = "ballgag"
	inhand_icon_state = "ballgag"
	worn_icon_state = "ballgag"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	greyscale_config = /datum/greyscale_config/ballgag
	greyscale_config_worn = /datum/greyscale_config/ballgag/worn
	greyscale_config_inhand_left = /datum/greyscale_config/ballgag/left_hand
	greyscale_config_inhand_right = /datum/greyscale_config/ballgag/right_hand
	greyscale_colors = "#AD66BE"
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSMOUTH

	/// Does this gag choke the wearer?
	var/chokes_wearer = FALSE
	/// How frequently the player will be choked
	var/choke_interval = 2
	/// Tracks the time between chokes
	var/choke_timer

	/// Phrases when the gag modifies the player's speech.
	var/list/moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	/// Lower probability phrases to be used when speech is modified.
	var/list/moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	/// Probability for alternative phrases to be used when speech is modified.
	var/moans_alt_probability = 5

	/// Sounds that the player makes when they try to speak.
	var/list/moan_sounds = list('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg')
	/// How loud the moan audio is
	var/moan_volume = 50
	/// How loud are these moan-noises if we're choking on it?
	var/moan_volume_choking = 30

	/// Whether the gag can be resized or not
	var/resizable = FALSE
	/// Options for resizing the gag
	var/list/possible_gag_sizes = list("small", "medium", "large")
	/// Where we are in the size list
	var/size_list_position = 1
	/// How big the gag is currently
	var/gag_size = "small"
	var/modifies_speech = TRUE

// To update the sprite
/obj/item/clothing/mask/ballgag/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/mask/ballgag/equipped(mob/equipper, slot)
	. = ..()
	if ((slot & ITEM_SLOT_MASK) && modifies_speech)
		RegisterSignal(equipper, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(equipper, COMSIG_MOB_SAY)

/obj/item/clothing/mask/ballgag/dropped(mob/dropper)
	. = ..()
	UnregisterSignal(dropper, COMSIG_MOB_SAY)

// Changes speech while worn
/obj/item/clothing/mask/ballgag/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(!LAZYLEN(moans))
		return
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	if(moan_sounds)
		play_lewd_sound(loc, pick(moan_sounds), chokes_wearer ? moan_volume_choking : moan_volume, 1, -1)

// Change the size of the gag
/obj/item/clothing/mask/ballgag/attack_self(mob/user)
	var/list_len = length(possible_gag_sizes)
	if(!resizable || !list_len)
		return
	size_list_position = ((size_list_position + 1) % list_len) + 1
	gag_size = possible_gag_sizes[size_list_position]
	balloon_alert(user, "size set to [gag_size]")

// A ballgag that can choke the wearer
/obj/item/clothing/mask/ballgag/choking
	name = "phallic ball gag"
	desc = "Prevents the wearer from speaking, as well as making breathing harder."
	icon_state = "chokegag"
	moan_volume = 40
	resizable = TRUE
	greyscale_config = /datum/greyscale_config/ballgag/choking_small
	chokes_wearer = TRUE

/obj/item/clothing/mask/ballgag/choking/attack_self(mob/user)
	. = ..()
	switch(gag_size)
		if("small")
			set_greyscale(new_config = /datum/greyscale_config/ballgag/choking_small)
		if("medium")
			set_greyscale(new_config = /datum/greyscale_config/ballgag/choking_medium)
		if("large")
			set_greyscale(new_config = /datum/greyscale_config/ballgag/choking_large)

// Start processing choking on equip
/obj/item/clothing/mask/ballgag/choking/equipped(mob/living/carbon/human/user, slot)
	if(!(src == user.wear_mask && user.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return ..()
	if(!chokes_wearer)
		return ..()
	START_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag/choking/dropped(mob/user, slot)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag/choking/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag/choking/process(seconds_per_tick)
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer))
		return
	if(!(wearer.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return
	if(!chokes_wearer)
		return
	choke_timer += seconds_per_tick
	if(choke_timer < choke_interval)
		return
	switch(gag_size)
		if("small")
			wearer.adjustOxyLoss(rand(0, 2))
		if("medium")
			wearer.adjustOxyLoss(rand(0, 3))
		if("large")
			wearer.adjustOxyLoss(rand(1, 4))
	if(prob(10))
		wearer.try_lewd_autoemote(pick("gasp", "choke", "moan"))
	choke_timer = 0
