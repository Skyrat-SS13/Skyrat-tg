//Yes, whip is mask item, because character can take it in mouth. For some BDSM scenarios it would be cool, but if you make it better with same functionality - go ahead, make me proud.

/obj/item/clothing/mask/leatherwhip
	name = "leather whip"
	desc = "A tool used for domination. Hurts in a way you like it."
	icon_state = "leather_whip_pink_hard"
	worn_icon_state = "leather_whip"
	base_icon_state = "leather"
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/whip.ogg'
	clothing_flags = INEDIBLE_CLOTHING
	//When taking that thing in mouth
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH
	/// If the color of the toy has been changed before
	var/color_changed = FALSE
	/// If the form (or size) of the toy has been changed before
	var/form_changed = FALSE
	/// Current color of the toy, can be changed, affects sprite
	var/current_whip_color = "pink"
	/// Current form of the toy, can be changed, affects sprite
	var/current_whip_form = "whip"
	/// If the whip is hitting weak or hard
	var/current_whip_type = "hard"
	/// A list of designs of the whip for use in the radial selection menu
	var/static/list/whip_designs
	/// A list of forms of the whip for use in the radial selection menu
	var/static/list/whip_forms
	/// A list of types of the whip for use in the radial selection menu
	var/static/list/whip_types
	/// Mutable appearance containing the whip's overlay
	var/mutable_appearance/whip_overlay

	/// Assoc list of pain modes
	var/list/modes = list("hard" = "weak", "weak" = "hard")
	/// Phrases to be said when the player attempts to talk when their speech is being modified
	var/list/moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	/// Lower probability phrases to be said when talking.
	var/list/moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	/// Probabilty that `moans_alt` is used instead of `moans`
	var/moans_alt_probability = 5

/obj/item/clothing/mask/leatherwhip/worn_overlays(isinhands = FALSE)
	. = ..()
	. = list()
	if(!isinhands)
		. += whip_overlay

// Speech handler for moansing when talking
/obj/item/clothing/mask/leatherwhip/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)
	play_lewd_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/under_moan_f4.ogg'), 70, 1, -1)

/// Radial menu helper
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_designs()
	whip_designs = list(
		"pink" = image (icon = src.icon, icon_state = "leather_whip_pink_hard"),
		"teal" = image(icon = src.icon, icon_state = "leather_whip_teal_hard"))

/// Radial menu helper
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_forms()
	whip_forms = list(
		"whip" = image (icon = src.icon, icon_state = "leather_whip_pink_hard"),
		"crotch" = image(icon = src.icon, icon_state = "leather_crotch_pink_hard"))

/// Radial menu helper
/obj/item/clothing/mask/leatherwhip/proc/populate_whip_types()
	whip_types = list(
		"weak" = image (icon = src.icon, icon_state = "leather_whip_pink_weak"),
		"hard" = image(icon = src.icon, icon_state = "leather_crotch_pink_hard"))

/obj/item/clothing/mask/leatherwhip/equipped(mob/target, slot)
	. = ..()

	update_icon_state()

	whip_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi', "[base_icon_state]_[current_whip_form]", ABOVE_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays()

//to change color
/obj/item/clothing/mask/leatherwhip/click_alt(mob/user)
	if(!color_changed)
		var/choice = show_radial_menu(user, src, whip_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_whip_color = choice
		update_icon()
		update_icon_state()
		color_changed = TRUE
		return CLICK_ACTION_SUCCESS
	else
		if(form_changed)
			return CLICK_ACTION_BLOCKING
		var/choice = show_radial_menu(user, src, whip_forms, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return CLICK_ACTION_BLOCKING
		current_whip_form = choice
		update_icon()
		update_icon_state()
		form_changed = TRUE
		return CLICK_ACTION_SUCCESS

/// A check to see if the radial menu can be used
/obj/item/clothing/mask/leatherwhip/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/mask/leatherwhip/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_icon_state()
	update_icon()
	if(!length(whip_designs))
		populate_whip_designs()
	if(!length(whip_forms))
		populate_whip_forms()
	if(!length(whip_types))
		populate_whip_types()

	update_icon_state()

	whip_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_masks.dmi', "[base_icon_state]_[current_whip_form]", ABOVE_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays()

/obj/item/clothing/mask/leatherwhip/update_icon_state()
	. = ..()
	icon_state = icon_state = "[base_icon_state]_[current_whip_form]_[current_whip_color]_[current_whip_type]"
	inhand_icon_state = "[base_icon_state]_[current_whip_form]_[current_whip_color]_[current_whip_type]"
	worn_icon_state = "[base_icon_state]_[current_whip_form]"

//safely discipline someone without damage
/obj/item/clothing/mask/leatherwhip/attack(mob/living/target, mob/living/user)
	. = ..()
	var/mob/living/carbon/human/carbon_target
	if(istype(target,/mob/living/carbon/human))
		carbon_target = target
	else if(istype(target,/mob/living/silicon/robot))
		// Just use target var, return if it isn't human or robot
	else
		return
	if(!istype(user,/mob/living/carbon/human) && !istype(user,/mob/living/silicon/robot))
		return

	var/message = ""
//and there is code for successful check, so we are whipping someone
	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] doesn't want you to do that."))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna whip
		if(BODY_ZONE_L_LEG)
			if(carbon_target && !carbon_target.has_feet())
				to_chat(user, span_danger("[target] is missing their left leg!"))
				return
			if(current_whip_type == "hard")
				message = (user == target) ? pick("Knocks [target.p_them()]self down with [src]", "Uses [src] to knock [target.p_them()]self on the ground") : pick("drops [target] to the ground with [src]", "uses [src] to put [target] on [target.p_their()] knees")
				if(target.stat != DEAD)
					if(prob(60))
						target.try_lewd_autoemote(pick("gasp", "shiver"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
				target.Paralyze(1)//don't touch it. It's domination tool, it should have ability to put someone on kneels. I already inserted check for PREF YOU CAN'T ABUSE THIS ITEM
				target.adjust_pain(5)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 100)
			else
				message = (user == target) ? pick("knocks [target.p_them()]self down with [src]", "gently uses [src] to knock [target.p_them()]self on the ground") : pick("drops [target] to the ground with [src]", "uses [src] to put [target] on [target.p_their()] knees")
				if(target.stat != DEAD)
					if(prob(30))
						target.try_lewd_autoemote(pick("gasp", "shiver"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
				target.Paralyze(1)
				target.adjust_pain(3)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 60)

		if(BODY_ZONE_R_LEG)
			if(carbon_target && !carbon_target.has_feet())
				to_chat(user, span_danger("[target] is missing their right leg!"))
				return
			if(current_whip_type == "hard")
				message = (user == target) ? pick("knocks [target.p_them()]self down with [src]", "uses [src] to knock [target.p_them()]self on the ground") : pick("Hardly drops [target] on the ground with [src]", "uses [src] to put [target] on [target.p_their()] knees")
				if(target.stat != DEAD)
					if(prob(60))
						target.try_lewd_autoemote(pick("gasp", "shiver"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
				target.Paralyze(1)//don't touch it. It's domination tool, it should have ability to put someone on kneels. I already inserted check for PREF YOU CAN'T ABUSE THIS ITEM
				target.adjust_pain(5)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 100)
			else
				message = (user == target) ? pick("Knocks [target.p_them()]self down with [src]", "gently uses [src] to knock [target.p_them()]self on the ground") : pick("drops [target] to the ground with [src]", "uses [src] to put [target] on [target.p_their()] knees")
				if(target.stat != DEAD)
					if(prob(30))
						target.try_lewd_autoemote(pick("gasp", "shiver"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
				target.Paralyze(1)
				target.adjust_pain(3)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 60)

		if(BODY_ZONE_HEAD)
			message = (user == target) ? pick("wraps [src] around [target.p_their()] neck, choking [target.p_them()]self", "chokes [target.p_them()]self with [src]") : pick("chokes [target] with [src]", "twines [src] around [target]'s neck!")
			if(prob(70) && (target.stat != DEAD))
				target.try_lewd_autoemote(pick("gasp", "choke", "moan"))
			if(carbon_target)
				carbon_target.adjust_arousal(3)
			target.adjust_pain(5)
			play_lewd_sound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg', 80)

		if(BODY_ZONE_PRECISE_GROIN)
			if(carbon_target && !carbon_target.is_bottomless())
				to_chat(user, span_danger("[target]'s butt is covered!"))
				return
			if(current_whip_type == "weak")
				message = (user == target) ? pick("whips [target.p_them()]self with [src]", "flogs [target.p_them()]self with [src]") :pick("playfully flogs [target]'s thighs with [src]", "flogs [target] with [src]", "mercilessly flogs [target] with [src]")
				if(target.stat != DEAD)
					if(prob(70))
						target.try_lewd_autoemote(pick("moan", "twitch"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
				if(carbon_target)
					carbon_target.adjust_arousal(5)
				target.adjust_pain(5)
				target.apply_status_effect(/datum/status_effect/spanked)
				if(HAS_TRAIT(target, TRAIT_MASOCHISM || TRAIT_BIMBO))
					target.add_mood_event("pervert spanked", /datum/mood_event/perv_spanked)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 60)

			if(current_whip_type == "hard")
				message = (user == target) ? pick("roughly flogs [target.p_them()]self with [src]", "flogs [target.p_them()]self with [src]") : pick("playfully flogs [target]'s thighs with [src]", "flogs [target] with [src]", "mercilessly flogs [target] with [src]")
				if(target.stat != DEAD)
					if(prob(70))
						target.try_lewd_autoemote(pick("moan", "twitch", "twitch_s", "scream"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
				if(carbon_target)
					carbon_target.adjust_arousal(3)
				target.adjust_pain(8)
				target.apply_status_effect(/datum/status_effect/spanked)
				if(HAS_TRAIT(target, TRAIT_MASOCHISM || TRAIT_BIMBO))
					target.add_mood_event("pervert spanked", /datum/mood_event/perv_spanked)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 100)
		else
			if(current_whip_type == "hard")
				message = (user == target) ? pick("disciplines [target.p_them()]self with [src]", "lashes [target.p_them()]self with [src]") : pick("lashes [target] with [src]", "Uses [src] to discipline [target]", "disciplines [target] with [src]")
				if(target.stat != DEAD)
					if(prob(50))
						target.try_lewd_autoemote(pick("moan", "twitch", "twitch_s", "scream"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
					target.do_jitter_animation()
				target.adjust_pain(7)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 100)

			else
				message = (user == target) ? pick("whips [target.p_them()]self with [src]", "lashes [target.p_them()]self with [src]") : pick("playfully lashes [target] with [src]", "disciplines [target] with [src]", "gently lashes [target] with [src]")
				if(target.stat != DEAD)
					if(prob(30))
						target.try_lewd_autoemote(pick("moan", "twitch"))
					if(prob(10))
						target.apply_status_effect(/datum/status_effect/subspace)
					target.do_jitter_animation()
				target.adjust_pain(4)
				if(carbon_target)
					carbon_target.adjust_arousal(5)
				play_lewd_sound(loc, 'sound/weapons/whip.ogg', 60)

	user.visible_message(span_purple("[user] [message]!"))

//toggle low pain mode. Because sometimes screaming isn't good
/obj/item/clothing/mask/leatherwhip/attack_self(mob/user)
	toggle_mode()
	switch(current_whip_type)
		if("hard")
			to_chat(user, span_notice("[src] is now hard. Someone need to be punished!"))
		if("weak")
			to_chat(user, span_notice("[src] feels softer. Easy mode!"))
	update_icon()
	update_icon_state()

/// Switches between hard and weak mode
/obj/item/clothing/mask/leatherwhip/proc/toggle_mode()
	current_whip_type = modes[current_whip_type]
