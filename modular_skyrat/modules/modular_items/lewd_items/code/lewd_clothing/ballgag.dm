// Flags for what we can change
#define GAG_SIZABLE 1
#define GAG_COLORABLE 2
#define GAG_COLORABLE_AND_SIZABLE 3

/obj/item/clothing/mask/ballgag
	name = "ball gag"
	desc = "Prevents the wearer from speaking."
	icon_state = "ballgag"
	inhand_icon_state = "ballgag"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	// equip_delay_other = 40
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH
	var/list/moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...") ///phrases to be said when the player attempts to talk when speech modification.
	var/list/moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!") ///lower probability phrases to be said when talking.
	var/moans_alt_probability = 5 ///probability for alternative sounds to play.
	var/time //how often user will be choked
	var/tt
	var/chokes_wearer = FALSE // Does this chunk choke the choom?
	var/list/moan_sounds = list('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg') // Sounds that the proud wearer makes when they try to speak.
	var/moan_volume = 70 // How loud are these moan-noises?
	var/moan_volume_choking = 20 // How loud are these moan-noises when we're choking on it?
	var/gag_customizability = GAG_COLORABLE
	var/gag_size = "small"
	var/gag_color = "pink"
	var/list/gag_colors // Populated after init, the available colors it can be
	var/list/gag_sizes // Populated after init, the available sizes it can be (if any)
	var/list/gag_choices

// A ballgag, but it chokes! Also its a dick!
/obj/item/clothing/mask/ballgag/phallic
	name = "phallic ball gag"
	desc = "Prevents the wearer from speaking, as well as making breathing harder."
	icon_state = "chokegag"
	inhand_icon_state = "blindfold"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	time = 2
	chokes_wearer = TRUE
	moan_volume = 40
	gag_customizability = GAG_COLORABLE_AND_SIZABLE

// Basically just a kazoo that goes in the moan hole
/obj/item/clothing/mask/ballgag/phallic/kazoo
	name = "phallic kazoo gag"
	desc = "While it doesn't prevent the wearer from breathing, it does make everything they say sound quite silly."
	moans = list("BVVV...", "VRRRRH...", "VRRR...", "VZZZ...", "ZYYY...", "BZZZ...")
	moans_alt = list("WHOOONK!", "VAAAAMP!", "BRRRVVV!")
	moan_sounds = list('modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_4.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_5.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_6.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_7.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/kazoo_8.ogg') // BZZZZZ
	chokes_wearer = FALSE

//no speaking
/obj/item/clothing/mask/ballgag/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	playsound(loc, LAZYLEN(moan_sounds) ? pick(moan_sounds) : pick(
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), moan_volume, 1, -1, ignore_walls = FALSE)

//to update model lol
/obj/item/clothing/mask/ballgag/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/mask/ballgag/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	populate_gag_colors()
	populate_gag_sizes()
	populate_gag_choices()

// Update the gag's image so it looks right
/obj/item/clothing/mask/ballgag/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[gag_color]"
	inhand_icon_state = "[initial(icon_state)]_[gag_color]"

/obj/item/clothing/mask/ballgag/phallic/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[gag_size]_[gag_color]"
	inhand_icon_state = "[initial(icon_state)]_[gag_size]_[gag_color]"

// Fill the list of gag colors with gag colors
/obj/item/clothing/mask/ballgag/proc/populate_gag_colors()
	gag_colors = list(
		"pink" = image (icon = src.icon, icon_state = "ballgag_pink"),
		"teal" = image(icon = src.icon, icon_state = "ballgag_teal"))

// Fill the list of gag sizes with gag sizes
/obj/item/clothing/mask/ballgag/proc/populate_gag_sizes()
	gag_sizes = list(
		"small" = image (icon = src.icon, icon_state = "chokegag_small_[gag_color]"),
		"medium" = image(icon = src.icon, icon_state = "chokegag_medium_[gag_color]"),
		"big" = image(icon = src.icon, icon_state = "chokegag_big_[gag_color]"))

// The cockgag has different iconstates for colors
/obj/item/clothing/mask/ballgag/phallic/populate_gag_colors()
	gag_colors = list(
		"pink" = image (icon = src.icon, icon_state = "chokegag_[gag_size]_pink"),
		"teal" = image(icon = src.icon, icon_state = "chokegag_[gag_size]_teal"))

// The cockgag can choose both color AND size!
/obj/item/clothing/mask/ballgag/proc/populate_gag_choices()
	gag_choices = list(
		"Recolor Toy" = image (icon = 'icons/obj/crayons.dmi', icon_state = "crayonrainbow"),
		"Resize Toy" = image(icon = src.icon, icon_state = "chokegag_[gag_size]_[gag_color]"))

//to change model
/obj/item/clothing/mask/ballgag/AltClick(mob/user, obj/item/I)
	. = ..()
	switch(gag_customizability)
		if(GAG_SIZABLE)
			gag_menu_size(user, I)
		if(GAG_COLORABLE)
			gag_menu_color(user, I)
		if(GAG_COLORABLE_AND_SIZABLE)
			var/choice = show_radial_menu(user,src, gag_choices, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
			switch(choice)
				if("Recolor Toy")
					gag_menu_color(user, I)
				if("Resize Toy")
					gag_menu_size(user, I)
		else
			return FALSE

/obj/item/clothing/mask/ballgag/proc/gag_menu_color(mob/user, obj/item/I)
	var/choice = show_radial_menu(user,src, gag_colors, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	gag_color = choice
	update_icon()
	update_icon_state()

/obj/item/clothing/mask/ballgag/proc/gag_menu_size(mob/user, obj/item/I)
	var/choice = show_radial_menu(user,src, gag_sizes, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	gag_size = choice
	update_icon()
	update_icon_state()

//to check if we can change gag's model
/obj/item/clothing/mask/ballgag/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

//start choking when equipping choke-enabled gag
/obj/item/clothing/mask/ballgag/equipped(mob/user, slot)
	if(chokes_wearer)
		var/mob/living/carbon/human/U = loc
		if(src == U.wear_mask && U.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)) //To prevent abusing this thing on non-erp players. We care about them, yes.
			START_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag/dropped(mob/user, slot)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag/process(delta_time)
	if(chokes_wearer)
		var/mob/living/carbon/human/U = loc
		tt += delta_time
		if(tt >= time)
			if(gag_size == "small")
				U.adjustOxyLoss(rand(0, 2))
				if(prob(15))
					U.emote(pick("gasp","choke","moan"))
				tt = 0
			if(gag_size == "medium")
				U.adjustOxyLoss(rand(0, 3))
				if(prob(20))
					U.emote(pick("gasp","choke","moan"))
				tt = 0
			if(gag_size == "big")
				U.adjustOxyLoss(rand(1, 4))
				if(prob(25))
					U.emote(pick("gasp","choke","moan"))
				tt = 0

// Be kind, undefined
#undef GAG_SIZABLE
#undef GAG_COLORABLE
#undef GAG_COLORABLE_AND_SIZABLE
