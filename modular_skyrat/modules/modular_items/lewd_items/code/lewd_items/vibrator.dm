//This code huge and blocky, but we're working on update for... my god, 4 months. If you can upgrade it - do it, but don't remove or break something, test carefully. This item is insertable.
/obj/item/clothing/sextoy/vibrator
	name = "vibrator"
	desc = "Woah. What an... Interesting item. I wonder what this red button does..."
	icon_state = "vibrator"
	inhand_icon_state = "vibrator"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	slot_flags = ITEM_SLOT_VAGINA|ITEM_SLOT_ANUS
	var/toy_on = FALSE
	var/current_color = "pink"
	var/color_changed = FALSE
	var/vibration_mode = "off"
	var/list/modes = list("low" = "medium", "medium" = "hard", "hard" = "off", "off" = "low")
	var/datum/looping_sound/vibrator/low/soundloop1
	var/datum/looping_sound/vibrator/medium/soundloop2
	var/datum/looping_sound/vibrator/high/soundloop3
	var/mode = "off"
	var/static/list/vibrator_designs
	w_class = WEIGHT_CLASS_TINY
	moth_edible = FALSE

//create radial menu
/obj/item/clothing/sextoy/vibrator/proc/populate_vibrator_designs()
	vibrator_designs = list(
		"pink" = image (icon = src.icon, icon_state = "vibrator_pink_low"),
		"teal" = image(icon = src.icon, icon_state = "vibrator_teal_low"),
		"red" = image(icon = src.icon, icon_state = "vibrator_red_low"),
		"yellow" = image(icon = src.icon, icon_state = "vibrator_yellow_low"),
		"green" = image(icon = src.icon, icon_state = "vibrator_green_low"))

/obj/item/clothing/sextoy/vibrator/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, vibrator_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon_state()
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change vibrator's model
/obj/item/clothing/sextoy/vibrator/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/sextoy/vibrator/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(vibrator_designs))
		populate_vibrator_designs()

	//soundloop
	soundloop1 = new(src, FALSE)
	soundloop2 = new(src, FALSE)
	soundloop3 = new(src, FALSE)

/obj/item/clothing/sextoy/vibrator/Destroy()
	QDEL_NULL(soundloop1)
	QDEL_NULL(soundloop2)
	QDEL_NULL(soundloop3)
	return ..()

/obj/item/clothing/sextoy/vibrator/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[vibration_mode]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/sextoy/vibrator/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(src == H.anus || src == H.vagina)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/vibrator/dropped(mob/user, slot)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/vibrator/process(delta_time)
	var/mob/living/carbon/human/U = loc
	if(toy_on == TRUE)
		if(vibration_mode == "low" && U.arousal < 40) //prevent non-stop cumming from wearing this thing
			U.adjustArousal(0.7 * delta_time)
			U.adjustPleasure(0.7 * delta_time)
		if(vibration_mode == "medium" && U.arousal < 70)
			U.adjustArousal(1 * delta_time)
			U.adjustPleasure(1 * delta_time)
		if(vibration_mode == "hard") //no mercy
			U.adjustArousal(1.5 * delta_time)
			U.adjustPleasure(1.5 * delta_time)
	if(toy_on == FALSE && U.arousal < 30)
		U.adjustArousal(0.5 * delta_time)
		U.adjustPleasure(0.5 * delta_time)

//SHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODESHITCODE
/obj/item/clothing/sextoy/vibrator/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""
	if(toy_on == TRUE)
		if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			switch(user.zone_selected) //to let code know what part of body we gonna vibe
				if(BODY_ZONE_PRECISE_GROIN)
					var/obj/item/organ/genital/penis = M.getorganslot(ORGAN_SLOT_PENIS)
					var/obj/item/organ/genital/vagina = M.getorganslot(ORGAN_SLOT_VAGINA)
					if(vibration_mode == "low")
						if(vagina && penis)
							if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]","massages their penis with the [src]","gently teases their penis with [src]") : pick("delicately massages [M]'s vagina with [src]", "uses [src] to gently massage [M]'s crotch","leans the massager against [M]'s pussy","delicately massages [M]'s penis with [src]", "uses [src] to gently massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]") : pick("delicately massages [M]'s vagina with [src]", "uses [src] to gently massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else if(penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]") : pick("delicately massages [M]'s penis with [src]", "uses [src] to gently massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(penis)
							if(penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]") : pick("delicately massages [M]'s penis with [src]", "uses [src] to gently massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(vagina)
							if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]") : pick("delicately massages [M]'s vagina with [src]", "uses [src] to gently massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								user.visible_message(span_danger("Looks like [M]'s groin is covered!"))
								return
						else
							user.visible_message(span_danger("Looks like [M] don't have suitable organs for that!"))
							return

					if(vibration_mode == "medium")
						if(vagina && penis)
							if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]","massages their vagina with the [src]","teases teases their pussy with [src]") : pick("massages [M]'s penis with [src]", "uses [src] to massage [M]'s penis","leans the massager against [M]'s penis","massages [M]'s vagina with [src]", "uses [src] to massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

							else if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]") : pick("massages [M]'s vagina with [src]", "uses [src] to massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else if(penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]") : pick("massages [M]'s penis with [src]", "uses [src] to massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(penis)
							if(penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]") : pick("massages [M]'s penis with [src]", "uses [src] to massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(vagina)
							if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]") : pick("massages [M]'s vagina with [src]", "uses [src] to massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else
							user.visible_message(span_danger("Looks like [M] don't have suitable organs for that!"))
							return

					if(vibration_mode == "hard")
						if(vagina && penis)
							if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","hardly teases their penis with [src]","massages their vagina with the [src]","hardly teases their pussy with [src]") : pick("leans massager tight to [M]'s penis with [src]", "uses [src] to agressively massage [M]'s penis","leans the massager against [M]'s penis","leans massager tight to [M]'s vagina with [src]", "uses [src] to agressively massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

							else if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","hardly teases their pussy with [src]") : pick("leans massager tight to [M]'s vagina with [src]", "uses [src] to agressively massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else if(penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","hardly teases their penis with [src]") : pick("leans massager tight to [M]'s penis with [src]", "uses [src] to agressively massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan","blush"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(penis)
							if(penis.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their penis with the [src]","hardly teases their penis with [src]") : pick("leans massager tight to [M]'s penis with [src]", "uses [src] to agressively massage [M]'s penis","leans the massager against [M]'s penis")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(vagina)
							if(vagina.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_bottomless())
								message = (user == M) ? pick("massages their vagina with the [src]","hardly teases their pussy with [src]") : pick("leans massager tight to [M]'s vagina with [src]", "uses [src] to agressively massage [M]'s crotch","leans the massager against [M]'s pussy")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(50) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else
							user.visible_message(span_danger("Looks like [M] don't have suitable organs for that!"))
							return

				if(BODY_ZONE_CHEST)
					var/obj/item/organ/genital/breasts = M.getorganslot(ORGAN_SLOT_BREASTS)
					if(M.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW)
						if(vibration_mode == "low")
							if(breasts)
								message = (user == M) ? pick("massages their breasts with the [src]","gently teases their tits with [src]") : pick("delicately teases [M]'s breasts with [src]", "uses [src] to slowly massage [M]'s tits", "uses [src] to tease [M]'s boobs", "rubs [M]'s tits with [src]")
								M.adjustArousal(4)
								M.adjustPleasure(1)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								message = (user == M) ? pick("massages their nipples with the [src]","gently teases their nipples with [src]") : pick("delicately teases [M]'s nipples with [src]", "uses [src] to slowly massage [M]'s nipples", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(2)
								M.adjustPleasure(1)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)


						if(vibration_mode == "medium")
							if(breasts)
								message = (user == M) ? pick("massages their breasts with the [src]","gently teases their nipples with [src]") : pick("teases [M]'s nipples with [src]", "uses [src] to massage [M]'s tits", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(5)
								M.adjustPleasure(4)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)
							else
								message = (user == M) ? pick("massages their nipples with the [src]","gently teases their nipples with [src]") : pick("teases [M]'s nipples with [src]", "uses [src] to massage [M]'s nipples", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(3)
								M.adjustPleasure(1)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

						if(vibration_mode == "hard")
							if(breasts)
								message = (user == M) ? pick("massages their breasts with the [src]","hardly teases their nipples with [src]") : pick("leans massager tight against [M]'s nipples with [src]", "uses [src] to massage [M]'s tits", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(7)
								M.adjustPleasure(9)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)
							else
								message = (user == M) ? pick("massages their nipples with the [src]","hardly teases their nipples with [src]") : pick("leans massager tight against [M]'s nipples with [src]", "uses [src] to massage [M]'s nipples", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

					else
						to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
						return
		else
			to_chat(user, span_danger("Looks like [M] don't want you to do that."))
			return
	else
		to_chat(user, span_notice("You must turn on the toy, to use it!"))
		return

/obj/item/clothing/sextoy/vibrator/attack_self(mob/user, obj/item/I)
	toggle_mode()
	if(vibration_mode == "low")
		to_chat(user, span_notice("Vibration mode now is low. Bzzz..."))
	if(vibration_mode == "medium")
		to_chat(user, span_notice("Vibration mode now is medium. Bzzzz!"))
	if(vibration_mode == "hard")
		to_chat(user, span_notice("Vibration mode now is hard. Careful with that thing."))
	if(vibration_mode == "off")
		to_chat(user, span_notice("Vibrator turned off. Fun is over?"))
	update_icon()
	update_icon_state()

/obj/item/clothing/sextoy/vibrator/proc/toggle_mode()
	mode = modes[mode]
	switch(mode)
		if("low")
			toy_on = TRUE
			vibration_mode = "low"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
			soundloop1.start()
		if("medium")
			toy_on = TRUE
			vibration_mode = "medium"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
			soundloop1.stop()
			soundloop2.start()
		if("hard")
			toy_on = TRUE
			vibration_mode = "hard"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
			soundloop2.stop()
			soundloop3.start()
		if("off")
			toy_on = FALSE
			vibration_mode = "off"
			playsound(loc, 'sound/weapons/magout.ogg', 20, TRUE)
			soundloop3.stop()
