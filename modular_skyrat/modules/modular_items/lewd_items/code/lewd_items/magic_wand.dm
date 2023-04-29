/obj/item/clothing/sextoy/magic_wand
	name = "magic wand"
	desc = "Not sure where is magic in this thing, but if you press button - it makes funny vibrations"
	icon_state = "magicwand_off"
	base_icon_state = "magicwand"
	worn_icon_state = "magicwand"
	inhand_icon_state = "magicwand"
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	/// What mode the vibrator is on
	var/vibration_mode = "off"
	/// Assoc list of modes, used to shift between them
	var/list/modes = list("low", "medium", "hard", "off")
	/// Looping sound called on process()
	var/datum/looping_sound/vibrator/low/soundloop1
	/// Looping sound called on process()
	var/datum/looping_sound/vibrator/medium/soundloop2
	/// Looping sound called on process()
	var/datum/looping_sound/vibrator/high/soundloop3
	/// Mutable appearance for the human overlay of this itme
	var/mutable_appearance/magicwand_overlay
	w_class = WEIGHT_CLASS_TINY
	lewd_slot_flags = LEWD_SLOT_VAGINA | LEWD_SLOT_PENIS
	clothing_flags = INEDIBLE_CLOTHING

//some stuff for making overlay of this item. Why? Because.
/obj/item/clothing/sextoy/magic_wand/worn_overlays(isinhands = FALSE)
	. = ..()
	. = list()
	if(!isinhands)
		. += magicwand_overlay

/obj/item/clothing/sextoy/magic_wand/Initialize(mapload)
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
	icon_state = "[base_icon_state]_[vibration_mode]"

/obj/item/clothing/sextoy/magic_wand/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(vibration_mode == "off" || !istype(user))
		return
	if(src == user.penis || src == user.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/process(delta_time)
	var/mob/living/carbon/human/current_user = loc
	if(!istype(current_user) || current_user.stat == DEAD)
		return FALSE

	var/adjustment_amount = 0
	switch(vibration_mode)
		if("low")
			if(current_user.arousal < 30)
				adjustment_amount = 0.6

		if("medium")
			if(current_user.arousal < 60)
				adjustment_amount = 0.8

		if("hard")
			adjustment_amount = 1

	if(!adjustment_amount)
		return

	current_user.adjust_arousal(adjustment_amount * delta_time)
	current_user.adjust_pleasure(adjustment_amount * delta_time)


/obj/item/clothing/sextoy/magic_wand/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target) || target.stat == DEAD)
		return FALSE

	var/message = ""
	if(vibration_mode == "off")
		to_chat(user, span_warning("You must turn on the toy, to use it!"))
		return FALSE

	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("Looks like [target] don't want you to do that."))
		return FALSE

	switch(user.zone_selected)
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/external/genital/penis = target.getorganslot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/external/genital/vagina = target.getorganslot(ORGAN_SLOT_VAGINA)

			if(!vagina && !penis)
				return FALSE

			var/currently_bottomless = target.is_bottomless
			if(!currently_bottomless && !vagina?.visibility_preference && !penis?.visibility_preference)
				to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
				return FALSE

			if(vagina && penis)
				if(currently_bottomless || vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					message = (user == target) ? pick("massages their penis with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their penis with [src]", "massages their pussy with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their pussy with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s penis with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s penis", "leans the vibrator against [target]'s penis", "[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s pussy with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s pussy", "leans the vibrator against [target]'s pussy")

				else if(currently_bottomless || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					message = (user == target) ? pick("massages their penis with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their penis with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s penis with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s penis", "leans the vibrator against [target]'s penis")

				else if(currently_bottomless || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
					message = (user == target) ? pick("massages their pussy with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their pussy with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s pussy with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s pussy", "leans the vibrator against [target]'s pussy")

			else if(penis)
				message = (user == target) ? pick("massages their penis with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their penis with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s penis with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s penis", "leans the vibrator against [target]'s penis")

			else if(vagina)
				message = (user == target) ? pick("massages their pussy with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their pussy with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] massages [target]'s pussy with [src]", "uses [src] to [vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] massage [target]'s pussy", "leans the vibrator against [target]'s pussy")

			target.adjust_arousal((vibration_mode == "low" ? 4 : (vibration_mode == "hard" ? 8 : 5)))
			target.adjust_pleasure((vibration_mode == "low" ? 2 : (vibration_mode == "hard" ? 10 : 5)))

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/external/genital/breasts = target.getorganslot(ORGAN_SLOT_BREASTS)
			if(!(target.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW))
				to_chat(user, span_danger("Looks like [target]'s chest is covered!"))
				return FALSE

			var/breasts_or_nipples = breasts ? ORGAN_SLOT_BREASTS : ORGAN_SLOT_NIPPLES
			message = (user == target) ? pick("massages their [breasts_or_nipples] with the [src]", "[vibration_mode == "low" ? "gently" : ""][vibration_mode = "hard" ? "roughly" : ""] teases their [breasts ? "tits" : ORGAN_SLOT_NIPPLES] with [src]") : pick("[vibration_mode == "low" ? "delicately" : ""][vibration_mode = "hard" ? "aggressively" : ""] teases [target]'s [breasts_or_nipples] with [src]", "uses [src] to[vibration_mode == "low" ? " slowly" : ""] massage [target]'s [breasts ? "tits" : ORGAN_SLOT_NIPPLES]", "uses [src] to tease [target]'s [breasts ? "boobs" : ORGAN_SLOT_NIPPLES]")
			target.adjust_arousal((vibration_mode == "low" ? 3 : (vibration_mode == "hard" ? 7 : 4)))
			target.adjust_pleasure((vibration_mode == "low" ? 1 : (vibration_mode == "hard" ? 9 : 4)))

	if(prob(30))
		target.try_lewd_autoemote(pick("twitch_s", "moan"))

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
	if(vibration_mode != "high")
		playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)

	switch(vibration_mode)
		if("off")
			soundloop1.start()
			vibration_mode = "low"
		if("low")
			soundloop1.stop()
			soundloop2.start()
			vibration_mode = "medium"
		if("medium")
			soundloop2.stop()
			soundloop3.start()
			vibration_mode = "high"
		if("high")
			playsound(loc, 'sound/weapons/magout.ogg', 20, TRUE)
			soundloop3.stop()
			vibration_mode = "off"
