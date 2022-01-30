//Yes, whip is mask item, because character can take it in mouth. For some BDSM scenarios it would be cool, but if you make it better with same functionality - go ahead, make me proud.

/obj/item/clothing/mask/leatherwhip
	name = "leather whip"
	desc = "A tool used for domination. Hurts in a way you like it."
	icon_state = "leather"
	worn_icon_state = "leather"
	inhand_icon_state = "leather"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/whip.ogg'
	moth_edible = FALSE
	//Customization
	var/color_changed = FALSE
	var/form_changed = FALSE
	var/current_whip_color = "pink"
	var/current_whip_form = "whip"
	var/current_whip_type = "hard"
	var/static/list/whip_designs
	var/static/list/whip_forms
	var/static/list/whip_types

	var/mutable_appearance/whip_overlay

	//Changing pain mode
	var/list/modes = list("hard" = "weak", "weak" = "hard")
	var/mode = "hard"

	//When taking that thing in mouth
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH
	var/list/moans ///phrases to be said when the player attempts to talk when speech modification
	var/list/moans_alt ///lower probability phrases to be said when talking.
	var/moans_alt_probability
	moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	moans_alt_probability = 5

/obj/item/clothing/mask/leatherwhip/worn_overlays(isinhands = FALSE)
	.=..()
	. = list()
	if(!isinhands)
		. += whip_overlay

//No speaking
/obj/item/clothing/mask/leatherwhip/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	playsound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 70, 1, -1)

//create radial menu
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_designs()
	whip_designs = list(
		"pink" = image (icon = src.icon, icon_state = "leather_whip_pink_hard"),
		"teal" = image(icon = src.icon, icon_state = "leather_whip_teal_hard"))

//radial menu for changing form
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_forms()
	whip_forms = list(
		"whip" = image (icon = src.icon, icon_state = "leather_whip_pink_hard"),
		"crotch" = image(icon = src.icon, icon_state = "leather_crotch_pink_hard"))

//radial menu for changing type
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_types()
	whip_types = list(
		"weak" = image (icon = src.icon, icon_state = "leather_whip_pink_weak"),
		"hard" = image(icon = src.icon, icon_state = "leather_crotch_pink_hard"))

//to update model lol
/obj/item/clothing/mask/leatherwhip/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/mask/leatherwhip/equipped(mob/M, slot)
	. = ..()

	update_icon_state()

	whip_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi', "[initial(icon_state)]_[current_whip_form]", ABOVE_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays()

//to change color
/obj/item/clothing/mask/leatherwhip/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, whip_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_whip_color = choice
		update_icon()
		update_icon_state()
		color_changed = TRUE

	if(color_changed == TRUE)
		if(form_changed == FALSE)
			. = ..()
			if(.)
				return
			var/choice = show_radial_menu(user,src, whip_forms, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
			if(!choice)
				return FALSE
			current_whip_form = choice
			update_icon()
			update_icon_state()
			form_changed = TRUE
	else
		return

//to check if we can change whip's model
/obj/item/clothing/mask/leatherwhip/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/mask/leatherwhip/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(whip_designs))
		populate_whip_designs()
	if(!length(whip_forms))
		populate_whip_forms()
	if(!length(whip_types))
		populate_whip_types()

	update_icon_state()

	whip_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi', "[initial(icon_state)]_[current_whip_form]", ABOVE_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays()

/obj/item/clothing/mask/leatherwhip/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_whip_form]_[current_whip_color]_[current_whip_type]"
	inhand_icon_state = "[initial(icon_state)]_[current_whip_form]_[current_whip_color]_[current_whip_type]"
	worn_icon_state = "[initial(icon_state)]_[current_whip_form]"

//safely discipline someone without damage
/obj/item/clothing/mask/leatherwhip/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""
//and there is code for successful check, so we are whipping someone
	if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		switch(user.zone_selected) //to let code know what part of body we gonna whip
			if(BODY_ZONE_L_LEG)
				if(M.has_feet())
					if(current_whip_type == "hard")
						message = (user == M) ? pick("Knocks [M.p_them()]self down with [src]", "Uses [src] to knock [M.p_them()]self on the ground") : pick("drops [M] to the ground with [src]", "uses [src] to put [M] on [M.p_their()] knees")
						if(M.stat != DEAD)
							if(prob(60))
								M.emote(pick("gasp","shiver"))
							if(prob(10))
								M.apply_status_effect(/datum/status_effect/subspace)
						M.Paralyze(1)//don't touch it. It's domination tool, it should have ability to put someone on kneels. I already inserted check for PREF YOU CAN'T ABUSE THIS ITEM
						M.adjustPain(5)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, 'sound/weapons/whip.ogg', 100)

					if(current_whip_type == "weak")
						message = (user == M) ? pick("knocks [M.p_them()]self down with [src]", "gently uses [src] to knock [M.p_them()]self on the ground") : pick("drops [M] to the ground with [src]", "uses [src] to put [M] on [M.p_their()] knees")
						if(M.stat != DEAD)
							if(prob(30))
								M.emote(pick("gasp","shiver"))
							if(prob(10))
								M.apply_status_effect(/datum/status_effect/subspace)
						M.Paralyze(1)
						M.adjustPain(3)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, 'sound/weapons/whip.ogg', 60)
				else
					to_chat(user, span_danger("[M] is missing their left leg!"))
					return

			if(BODY_ZONE_R_LEG)
				if(M.has_feet())
					if(current_whip_type == "hard")
						message = (user == M) ? pick("knocks [M.p_them()]self down with [src]", "uses [src] to knock [M.p_them()]self on the ground") : pick("Hardly drops [M] on the ground with [src]", "uses [src] to put [M] on [M.p_their()] knees")
						if(M.stat != DEAD)
							if(prob(60))
								M.emote(pick("gasp","shiver"))
							if(prob(10))
								M.apply_status_effect(/datum/status_effect/subspace)
						M.Paralyze(1)//don't touch it. It's domination tool, it should have ability to put someone on kneels. I already inserted check for PREF YOU CAN'T ABUSE THIS ITEM
						M.adjustPain(5)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, 'sound/weapons/whip.ogg', 100)

					if(current_whip_type == "weak")
						message = (user == M) ? pick("Knocks [M.p_them()]self down with [src]", "gently uses [src] to knock [M.p_them()]self on the ground") : pick("drops [M] to the ground with [src]", "uses [src] to put [M] on [M.p_their()] knees")
						if(M.stat != DEAD)
							if(prob(30))
								M.emote(pick("gasp","shiver"))
							if(prob(10))
								M.apply_status_effect(/datum/status_effect/subspace)
						M.Paralyze(1)
						M.adjustPain(3)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, 'sound/weapons/whip.ogg', 60)
				else
					to_chat(user, span_danger("[M] is missing their right leg!"))
					return

			if(BODY_ZONE_HEAD)
				message = (user == M) ? pick("wraps [src] around [M.p_their()] neck, choking [M.p_them()]self", "chokes [M.p_them()]self with [src]") : pick("chokes [M] with [src]", "twines [src] around [M]'s neck!")
				if(prob(70) && (M.stat != DEAD))
					M.emote(pick("gasp","choke", "moan"))
				M.adjustArousal(3)
				M.adjustPain(5)
				M.adjustOxyLoss(2)//DON'T TOUCH THIS TOO, IT DEALS REALLY LOW DAMAGE. I DARE YOU!
				user.visible_message(span_purple("[user] [message]!"))
				playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 80)

			if(BODY_ZONE_PRECISE_GROIN)
				if(M.is_bottomless())
					if(current_whip_type == "weak")
						message = (user == M) ? pick("whips [M.p_them()]self with [src]", "flogs [M.p_them()]self with [src]") :pick("playfully flogs [M]'s thighs with [src]","flogs [M] with [src]","mercilessly flogs [M] with [src]")
						if(M.stat != DEAD)
							if(prob(70))
								M.emote(pick("moan","twitch"))
							if(prob(10))
								M.apply_status_effect(/datum/status_effect/subspace)
						M.adjustArousal(5)
						M.adjustPain(5)
						M.apply_status_effect(/datum/status_effect/spanked)
						if(HAS_TRAIT(M, TRAIT_MASOCHISM || TRAIT_BIMBO))
							SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "pervert spanked", /datum/mood_event/perv_spanked)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, 'sound/weapons/whip.ogg', 60)

					if(current_whip_type == "hard")
						message = (user == M) ? pick("roughly flogs [M.p_them()]self with [src]", "flogs [M.p_them()]self with [src]") : pick("playfully flogs [M]'s thighs with [src]","flogs [M] with [src]","mercilessly flogs [M] with [src]")
						if(M.stat != DEAD)
							if(prob(70))
								M.emote(pick("moan","twitch","twitch_s","scream"))
							if(prob(10))
								M.apply_status_effect(/datum/status_effect/subspace)
						M.adjustArousal(3)
						M.adjustPain(8)
						M.apply_status_effect(/datum/status_effect/spanked)
						if(HAS_TRAIT(M, TRAIT_MASOCHISM || TRAIT_BIMBO))
							SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "pervert spanked", /datum/mood_event/perv_spanked)
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc, 'sound/weapons/whip.ogg', 100)
					else
						return
				else
					to_chat(user, span_danger("[M]'s butt is covered!"))
					return

			else
				if(current_whip_type == "hard")
					message = (user == M) ? pick("disciplines [M.p_them()]self with [src]","lashes [M.p_them()]self with [src]") : pick("lashes [M] with [src]","Uses [src] to discipline [M]", "disciplines [M] with [src]")
					if(M.stat != DEAD)
						if(prob(50))
							M.emote(pick("moan","twitch","twitch_s","scream"))
						if(prob(10))
							M.apply_status_effect(/datum/status_effect/subspace)
						M.do_jitter_animation()
					M.adjustPain(7)
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, 'sound/weapons/whip.ogg', 100)

				if(current_whip_type == "weak")
					message = (user == M) ? pick("whips [M.p_them()]self with [src]","lashes [M.p_them()]self with [src]") : pick("playfully lashes [M] with [src]","disciplines [M] with [src]", "gently lashes [M] with [src]")
					if(M.stat != DEAD)
						if(prob(30))
							M.emote(pick("moan","twitch"))
						if(prob(10))
							M.apply_status_effect(/datum/status_effect/subspace)
						M.do_jitter_animation()
					M.adjustPain(4)
					M.adjustArousal(5)
					user.visible_message(span_purple("[user] [message]!"))
					playsound(loc, 'sound/weapons/whip.ogg', 60)
				else
					return
	else
		to_chat(user, span_danger("[M] doesn't want you to do that."))
		return

//toggle low pain mode. Because sometimes screaming isn't good
/obj/item/clothing/mask/leatherwhip/attack_self(mob/user)
	toggle_mode()
	switch(mode)
		if("hard")
			to_chat(user, span_notice("[src] is now hard. Someone need to be punished!"))
		if("weak")
			to_chat(user, span_notice("[src] feels softer. Easy mode!"))
	update_icon()
	update_icon_state()

//pain mode switch
/obj/item/clothing/mask/leatherwhip/proc/toggle_mode()
	mode = modes[mode]
	switch(mode)
		if("hard")
			current_whip_type = "hard"
		if("weak")
			current_whip_type = "weak"
