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
	var/toy_on = FALSE
	var/vibration_mode = "off"
	var/list/modes = list("low" = "medium", "medium" = "hard", "hard" = "off", "off" = "low")
	var/datum/looping_sound/vibrator/low/soundloop1
	var/datum/looping_sound/vibrator/medium/soundloop2
	var/datum/looping_sound/vibrator/high/soundloop3
	var/mode = "off"
	var/mutable_appearance/magicwand_overlay
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_VAGINA|ITEM_SLOT_PENIS
	moth_edible = FALSE

//some stuff for making overlay of this item. Why? Because.
/obj/item/clothing/sextoy/magic_wand/worn_overlays(isinhands = FALSE)
	.=..()
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

/obj/item/clothing/sextoy/magic_wand/equipped(mob/user, slot)
	.=..()
	var/mob/living/carbon/human/H = user
	if(toy_on == TRUE)
		if(src == H.penis || src == H.vagina)
			START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/dropped(mob/user, slot)
	.=..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/magic_wand/process(delta_time)
	var/mob/living/carbon/human/U = loc
	//i tried using switch here, but it need static value, and u.arousal can't be it. So fuck switches. Reject it, embrace the IFs
	if(vibration_mode == "low" && U.arousal < 30)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.7 * delta_time)
	if(vibration_mode == "medium" && U.arousal < 60)
		U.adjustArousal(0.8 * delta_time)
		U.adjustPleasure(0.8 * delta_time)
	if(vibration_mode == "hard")
		U.adjustArousal(1 * delta_time)
		U.adjustPleasure(1 * delta_time)

/obj/item/clothing/sextoy/magic_wand/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""
	if(toy_on == TRUE)
		if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			switch(user.zone_selected) //to let code know what part of body we gonna... Yeah.
				if(BODY_ZONE_PRECISE_GROIN)
					var/obj/item/organ/genital/penis = M.getorganslot(ORGAN_SLOT_PENIS)
					var/obj/item/organ/genital/vagina = M.getorganslot(ORGAN_SLOT_VAGINA)
					if(vibration_mode == "low")
						if(vagina && penis)
							if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW && penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]","massages their pussy with the [src]","gently teases their pussy with [src]") : pick("delicately massages [M]'s penis with [src]", "uses [src] to gently massage [M]'s penis","leans the vibrator against [M]'s penis","delicately massages [M]'s pussy with [src]", "uses [src] to gently massage [M]'s pussy","leans the vibrator against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]") : pick("delicately massages [M]'s penis with [src]", "uses [src] to gently massage [M]'s penis","leans the vibrator against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their pussy with the [src]","gently teases their pussy with [src]") : pick("delicately massages [M]'s pussy with [src]", "uses [src] to gently massage [M]'s pussy","leans the vibrator against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(penis)
							if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","gently teases their penis with [src]") : pick("delicately massages [M]'s penis with [src]", "uses [src] to gently massage [M]'s penis","leans the vibrator against [M]'s penis")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(vagina)
							if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their pussy with the [src]","gently teases their pussy with [src]") : pick("delicately massages [M]'s pussy with [src]", "uses [src] to gently massage [M]'s pussy","leans the vibrator against [M]'s pussy")
								M.adjustArousal(4)
								M.adjustPleasure(2)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

					if(vibration_mode == "medium")
						if(vagina && penis)
							if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW && vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","teases teases their penis with [src]","massages their vagina with the [src]","gently teases their pussy with [src]") : pick("massages [M]'s penis with [src]", "uses [src] to massage [M]'s penis","leans the vibrator against [M]'s penis","massages [M]'s vagina with [src]", "uses [src] to massage [M]'s crotch","leans the vibrator against [M]'s pussy")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

							else if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]") : pick("massages [M]'s vagina with [src]", "uses [src] to massage [M]'s crotch","leans the vibrator against [M]'s pussy")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

							else if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","teases teases their penis with [src]") : pick("massages [M]'s penis with [src]", "uses [src] to massage [M]'s penis","leans the vibrator against [M]'s penis")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(penis)
							if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","teases teases their penis with [src]") : pick("massages [M]'s penis with [src]", "uses [src] to massage [M]'s penis","leans the vibrator against [M]'s penis")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(vagina)
							if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their vagina with the [src]","gently teases their pussy with [src]") : pick("massages [M]'s vagina with [src]", "uses [src] to massage [M]'s crotch","leans the vibrator against [M]'s pussy")
								M.adjustArousal(5)
								M.adjustPleasure(5)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

					if(vibration_mode == "hard")
						if(vagina && penis)
							if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW && vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","hardly teases their penis with [src]","massages their vagina with the [src]","hardly teases their pussy with [src]") : pick("leans vibrator tight to [M]'s penis with [src]", "uses [src] to agressively massage [M]'s penis","leans the vibrator against [M]'s penis","leans vibrator tight to [M]'s vagina with [src]", "uses [src] to agressively massage [M]'s crotch","leans the vibrator against [M]'s pussy")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

							else if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their vagina with the [src]","hardly teases their pussy with [src]") : pick("leans vibrator tight to [M]'s vagina with [src]", "uses [src] to agressively massage [M]'s crotch","leans the vibrator against [M]'s pussy")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

							else if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","hardly teases their penis with [src]") : pick("leans vibrator tight to [M]'s penis with [src]", "uses [src] to agressively massage [M]'s penis","leans the vibrator against [M]'s penis")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)

							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(penis)
							if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their penis with the [src]","hardly teases their penis with [src]") : pick("leans vibrator tight to [M]'s penis with [src]", "uses [src] to agressively massage [M]'s penis","leans the vibrator against [M]'s penis")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

						else if(vagina)
							if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their vagina with the [src]","hardly teases their pussy with [src]") : pick("leans vibrator tight to [M]'s vagina with [src]", "uses [src] to agressively massage [M]'s crotch","leans the vibrator against [M]'s pussy")
								M.adjustArousal(8)
								M.adjustPleasure(10)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
								return

				if(BODY_ZONE_CHEST)
					var/obj/item/organ/genital/breasts = M.getorganslot(ORGAN_SLOT_BREASTS)
					if(vibration_mode == "low")
						if(breasts)
							if(M.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their breasts with the [src]","gently teases their tits with [src]") : pick("delicately teases [M]'s breasts with [src]", "uses [src] to slowly massage [M]'s tits", "uses [src] to tease [M]'s boobs", "rubs [M]'s tits with [src]")
								M.adjustArousal(3)
								M.adjustPleasure(1)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
								return
						else
							if(M.is_topless())
								message = (user == M) ? pick("massages their nipples with the [src]","gently teases their nipples with [src]") : pick("delicately teases [M]'s nipples with [src]", "uses [src] to slowly massage [M]'s nipples", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(2)
								M.adjustPleasure(1)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 10, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
								return

					if(vibration_mode == "medium")
						if(breasts)
							if(M.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their breasts with the [src]","teases their tits with [src]") : pick("teases [M]'s breasts with [src]", "uses [src] to massage [M]'s tits", "uses [src] to tease [M]'s boobs", "rubs [M]'s tits with [src]")
								M.adjustArousal(4)
								M.adjustPleasure(4)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
								return
						else
							if(M.is_topless())
								message = (user == M) ? pick("massages their nipples with the [src]","teases their nipples with [src]") : pick("teases [M]'s nipples with [src]", "uses [src] to massage [M]'s nipples", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(4)
								M.adjustPleasure(4)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 20, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
								return

					if(vibration_mode == "hard")
						if(breasts)
							if(M.is_topless() || breasts.visibility_preference == GENITAL_ALWAYS_SHOW)
								message = (user == M) ? pick("massages their breasts with the [src]","hardly teases their tits with [src]") : pick("leans vibrator tight against [M]'s breasts with [src]", "uses [src] to massage [M]'s tits", "uses [src] to tease [M]'s boobs", "rubs [M]'s tits with [src]")
								M.adjustArousal(7)
								M.adjustPleasure(9)
								if(prob(30) && (M.stat != DEAD))
									M.emote(pick("twitch_s","moan"))
								user.visible_message(span_purple("[user] [message]!"))
								playsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/vibrate.ogg', 30, TRUE, ignore_walls = FALSE)
							else
								to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
								return

						else
							if(M.is_topless())
								message = (user == M) ? pick("massages their nipples with the [src]","hardly teases their nipples with [src]") : pick("leans vibrator tight against [M]'s nipples with [src]", "uses [src] to massage [M]'s nipples", "uses [src] to tease [M]'s nipples")
								M.adjustArousal(7)
								M.adjustPleasure(9)
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

/obj/item/clothing/sextoy/magic_wand/attack_self(mob/user, obj/item/I)
	toggle_mode()
	if(vibration_mode == "low")
		to_chat(user, span_notice("Vibration mode now is low. Bzzz..."))
	if(vibration_mode == "medium")
		to_chat(user, span_notice("Vibration mode now is medium. Bzzzz!"))
	if(vibration_mode == "hard")
		to_chat(user, span_notice("Vibration mode now is hard. Careful with that thing."))
	if(vibration_mode == "off")
		to_chat(user, span_notice("Hitachi magic wand turned off. Fun is over?"))
	update_icon()
	update_icon_state()

/obj/item/clothing/sextoy/magic_wand/proc/toggle_mode()
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
