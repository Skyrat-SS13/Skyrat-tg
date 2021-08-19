//things for normal ballgag
/obj/item/clothing/mask/ballgag
	var/list/moans ///phrases to be said when the player attempts to talk when speech modification.
	var/list/moans_alt ///lower probability phrases to be said when talking.
	var/moans_alt_probability ///probability for alternative sounds to play.

//things for choking ballgag
/obj/item/clothing/mask/ballgag_phallic
	var/list/moans //same thing as on top
	var/list/moans_alt
	var/moans_alt_probability
	var/was_recolored = FALSE
	var/was_reformed = FALSE
	var/time //how often user will be choked
	var/tt

//here goes code for normal ballgag that just replaces speaking with moans
/obj/item/clothing/mask/ballgag
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH

//no speaking
/obj/item/clothing/mask/ballgag/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 70, 1, -1)

//here goes code for chocking ballgag

/obj/item/clothing/mask/ballgag_phallic
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/ballgag_phallic/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 40, 1, -1)

/////////////////////////////////////////////////////////////////////
//////////here goes code for normal version of ballgag///////////////
/////////////////////////////////////////////////////////////////////

/obj/item/clothing/mask/ballgag
	name = "ball gag"
	desc = "Prevents wearer from speaking"
	icon_state = "ballgag"
	inhand_icon_state = "ballgag"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	gas_transfer_coefficient = 0.9
	// equip_delay_other = 40
	moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	moans_alt_probability = 5
	var/color_changed = FALSE
	var/current_ballgag_color = "pink"
	var/static/list/ballgag_designs

//create radial menu
/obj/item/clothing/mask/ballgag/proc/populate_ballgag_designs()
	ballgag_designs = list(
		"pink" = image (icon = src.icon, icon_state = "ballgag_pink"),
		"teal" = image(icon = src.icon, icon_state = "ballgag_teal"))

//to update model lol
/obj/item/clothing/mask/ballgag/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/clothing/mask/ballgag/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, ballgag_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_ballgag_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change kinkphones's model
/obj/item/clothing/mask/ballgag/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/mask/ballgag/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(ballgag_designs))
		populate_ballgag_designs()

/obj/item/clothing/mask/ballgag/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_ballgag_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_ballgag_color]"

/////////////////////////////////////////////////////////////////////
/////////here goes code for choking version of ballgag///////////////
/////////////////////////////////////////////////////////////////////

/obj/item/clothing/mask/ballgag_phallic
	name = "phallic ball gag"
	desc = "Prevents wearer from speaking and make breathing even harder"
	icon_state = "chokegag"
	inhand_icon_state = "blindfold"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_masks.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	gas_transfer_coefficient = 0.9
	moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	moans_alt_probability = 5
	time = 2
	var/ballgag_size = "small"
	var/ballgag_color = "pink"
	var/static/list/gag_colors
	var/static/list/gag_designs

//create radial menu
/obj/item/clothing/mask/ballgag_phallic/proc/populate_gag_designs()
	gag_designs = list(
		"small" = image (icon = src.icon, icon_state = "chokegag_small_[ballgag_color]"),
		"medium" = image(icon = src.icon, icon_state = "chokegag_medium_[ballgag_color]"),
		"big" = image(icon = src.icon, icon_state = "chokegag_big_[ballgag_color]"))

//or even two radial menus, they are cool
/obj/item/clothing/mask/ballgag_phallic/proc/populate_gag_colors()
	gag_colors = list(
		"pink" = image (icon = src.icon, icon_state = "chokegag_[ballgag_size]_pink"),
		"teal" = image(icon = src.icon, icon_state = "chokegag_[ballgag_size]_teal"))

//to change size and colour
/obj/item/clothing/mask/ballgag_phallic/AltClick(mob/user, obj/item/I)
	if(was_reformed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, gag_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		ballgag_size = choice
		update_icon()
		update_icon_state()
		was_reformed = TRUE
	if(was_reformed == TRUE)
		if(was_recolored == FALSE)
			var/choice = show_radial_menu(user,src, gag_colors, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
			if(!choice)
				return FALSE
			ballgag_color = choice
			update_icon()
			update_icon_state()
			was_recolored = TRUE
	else
		return

//to check if we can change ballgag's model
/obj/item/clothing/mask/ballgag_phallic/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

//initializing
/obj/item/clothing/mask/ballgag_phallic/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(gag_designs))
		populate_gag_designs()
	if(!length(gag_colors))
		populate_gag_colors()

/obj/item/clothing/mask/ballgag_phallic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//updating icon after succesccscful thing. Yeah, english is not my best talent.
/obj/item/clothing/mask/ballgag_phallic/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[ballgag_size]_[ballgag_color]"
	inhand_icon_state = "[initial(icon_state)]_[ballgag_size]_[ballgag_color]"

//start choking when equipping gag
/obj/item/clothing/mask/ballgag_phallic/equipped(mob/user, slot)
	var/mob/living/carbon/human/U = loc
	if(src == U.wear_mask && U.client?.prefs.sextoys_pref == "Yes") //To prevent abusing this thing on non-erp players. We care about them, yes.
		START_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag_phallic/dropped(mob/user, slot)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag_phallic/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/ballgag_phallic/process(delta_time)
	var/mob/living/carbon/human/U = loc
	tt += delta_time
	if(tt >= time)
		if(ballgag_size == "small")
			U.adjustOxyLoss(rand(0, 2))
			if(prob(15))
				U.emote(pick("gasp","choke","moan"))
			tt = 0
		if(ballgag_size == "medium")
			U.adjustOxyLoss(rand(0, 3))
			if(prob(20))
				U.emote(pick("gasp","choke","moan"))
			tt = 0
		if(ballgag_size == "big")
			U.adjustOxyLoss(rand(1, 4))
			if(prob(25))
				U.emote(pick("gasp","choke","moan"))
			tt = 0
