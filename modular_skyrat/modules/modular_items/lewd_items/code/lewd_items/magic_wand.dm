/*
/obj/item/clothing/sextoy/magic_wand
	name = "magic wand"
	desc = "Not sure where is magic in this thing, but if you press button - it makes funny vibrations"
	icon_state = "magicwand"
	worn_icon_state = "magicwand"
	inhand_icon_state = "magicwand"
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// If the toy is on or off
	var/toy_on = FALSE
	/// What mode the vibrator is on
	var/vibration_mode = "off"
	/// Assoc list of modes, used to shift between them
	var/list/modes = list("low" = "medium", "medium" = "hard", "hard" = "off", "off" = "low")
	/// Looping sound called on process()
	var/datum/looping_sound/vibrator/low/soundloop1
	/// Looping sound called on process()
	var/datum/looping_sound/vibrator/medium/soundloop2
	/// Looping sound called on process()
	var/datum/looping_sound/vibrator/high/soundloop3
	/// Mutable appearance for the human overlay of this itme
	var/mutable_appearance/magicwand_overlay
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_VAGINA|ITEM_SLOT_PENIS
	moth_edible = FALSE

//some stuff for making overlay of this item. Why? Because.
/obj/item/clothing/sextoy/magic_wand/worn_overlays(isinhands = FALSE)
	. = ..()
	. = list()
	if(!isinhands)
		. += magicwand_overlay

/obj/item/clothing/sextoy/magic_wand/Initialize()
	. = ..()

	magicwand_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "magicwand", ABOVE_MOB_LAYER + 0.1) //two arguments

	update_icon_state()
	update_icon()
	update_appearance()

	//soundloop
	soundloop1 = new(src, FALSE)
	soundloop2 = new(src, FALSE)
	soundloop3 = new(src, FALSE)

/obj/item/clothing/sextoy/magic_wand/Destroy()
	QDEL_NULL(soundloop1)
	QDEL_NULL(soundloop2)
	QDEL_NULL(soundloop3)
	return ..()

/obj/item/clothing/sextoy/magic_wand/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[vibration_mode]"

/obj/item/clothing/sextoy/magic_wand/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!toy_on || !istype(user))
		return
	if(src == user.penis || src == user.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/process(delta_time)
	var/mob/living/carbon/human/vibrated = loc
	if(!istype(vibrated))
		return
	// I tried using switch here, but it need static value, and u.arousal can't be it. So fuck switches. Reject it, embrace the IFs
	if(vibration_mode == "low" && vibrated.arousal < 30)
		vibrated.adjustArousal(0.6 * delta_time)
		vibrated.adjustPleasure(0.7 * delta_time)
	else if(vibration_mode == "medium" && vibrated.arousal < 60)
		vibrated.adjustArousal(0.8 * delta_time)
		vibrated.adjustPleasure(0.8 * delta_time)
	else if(vibration_mode == "hard")
		vibrated.adjustArousal(1 * delta_time)
		vibrated.adjustPleasure(1 * delta_time)

/obj/item/clothing/sextoy/magic_wand/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return

	var/message = ""
	if(!toy_on)
		to_chat(user, span_notice("You must turn on the toy, to use it!"))
		return
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("Looks like [target] don't want you to do that."))
		return
	switch(user.zone_selected) //to let code know what part of body we gonna... Yeah.
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/genital/penis = target.getorganslot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina = target.getorganslot(ORGAN_SLOT_VAGINA)
			if(vagina && penis)
				if(target.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					message = (user == target) ? pick("massages their penis with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their penis with [src]", "massages their pussy with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their pussy with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s penis with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s penis", "leans the vibrator against [target]'s penis", "[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s pussy with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s pussy", "leans the vibrator against [target]'s pussy")

				else if(target.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					message = (user == target) ? pick("massages their penis with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their penis with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s penis with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s penis", "leans the vibrator against [target]'s penis")

				else if(target.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
					message = (user == target) ? pick("massages their pussy with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their pussy with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s pussy with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s pussy", "leans the vibrator against [target]'s pussy")

				else
					to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
					return

			else if(penis)
				if(!(target.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW))
					to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
					return
				message = (user == target) ? pick("massages their penis with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their penis with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s penis with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s penis", "leans the vibrator against [target]'s penis")

			else if(vagina)
				if(!(target.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW))
					to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
					return
				message = (user == target) ? pick("massages their pussy with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their pussy with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s pussy with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s pussy", "leans the vibrator against [target]'s pussy")
			target.adjustArousal((vibration_mode == "low" ? 4 : (vibration_mode == "hard" ? 8 : 5)))
			target.adjustPleasure((vibration_mode == "low" ? 2 : (vibration_mode == "hard" ? 10 : 5)))

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/genital/breasts = target.getorganslot(ORGAN_SLOT_BREASTS)
			if(!(target.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW))
				to_chat(user, span_danger("Looks like [target]'s chest is covered!"))
				return
			message = (user == target) ? pick("massages their [breasts ? "breasts" : "nipples"] with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their [breasts ? "tits" : "nipples"] with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] teases [target]'s [breasts ? "breasts" : "nipples"] with [src]", "uses [src] to[vibration_mode == "low" ? " slowly" : ""] massage [target]'s [breasts ? "tits" : "nipples"]", "uses [src] to tease [target]'s [breasts ? "boobs" : "nipples"]")
			target.adjustArousal((vibration_mode == "low" ? 3 : (vibration_mode == "hard" ? 7 : 4)))
			target.adjustPleasure((vibration_mode == "low" ? 1 : (vibration_mode == "hard" ? 9 : 4)))

	if(prob(30) && (target.stat != DEAD))
		target.emote(pick("twitch_s", "moan"))
	user.visible_message(span_purple("[user] [message]!"))
	playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', (vibration_mode == "low" ? 10 : (vibration_mode == "hard" ? 30 : 20)), TRUE, ignore_walls = FALSE)

/obj/item/clothing/sextoy/magic_wand/attack_self(mob/user)
	toggle_mode()
	switch(vibration_mode)
		if("low")
			to_chat(user, span_notice("Vibration mode now is low. Bzzz..."))
		if("medium")
			to_chat(user, span_notice("Vibration mode now is medium. Bzzzz!"))
		if("hard")
			to_chat(user, span_notice("Vibration mode now is hard. Careful with that thing."))
		if("off")
			to_chat(user, span_notice("[src] is now turned off. Fun time's over?"))
	update_icon()
	update_icon_state()

/// Toggle between toy modes in a specific order
/obj/item/clothing/sextoy/magic_wand/proc/toggle_mode()
	vibration_mode = modes[vibration_mode]
	switch(vibration_mode)
		if("low")
			toy_on = TRUE
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
			soundloop1.start()
		if("medium")
			toy_on = TRUE
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
			soundloop1.stop()
			soundloop2.start()
		if("hard")
			toy_on = TRUE
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
			soundloop2.stop()
			soundloop3.start()
		if("off")
			toy_on = FALSE
			playsound(loc, 'sound/weapons/magout.ogg', 20, TRUE)
			soundloop3.stop()
*/
