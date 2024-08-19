/obj/item/tickle_feather
	name = "tickling feather"
	desc = "A rather ticklish feather that can be used in both mirth and malice."
	icon_state = "feather"
	inhand_icon_state = "feather"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/tickle_feather/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return
	var/mob/living/carbon/human/carbon_target = target
	if(!carbon_target && !iscyborg(target))
		return

	var/message = ""
	switch(user.zone_selected) //to let code know what part of body we gonna tickle
		if(BODY_ZONE_PRECISE_GROIN)
			if(!carbon_target?.is_bottomless())
				to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
				return

			message = (user == target) ? pick("tickles [target.p_them()]self with [src]",
					"gently teases [target.p_their()] belly with [src]") \
				: pick("teases [target]'s belly with [src]",
					"uses [src] to tickle [target]'s belly",
					"tickles [target] with [src]")
		if(BODY_ZONE_CHEST)
			if(carbon_target)
				var/obj/item/organ/external/genital/badonkers = carbon_target.get_organ_slot(ORGAN_SLOT_BREASTS)
				if(!badonkers?.is_exposed())
					to_chat(user, span_danger("Looks like [target]'s chest is covered!"))
					return

				message = (user == target) ? pick("tickles [target.p_them()]self with [src]",
						"gently teases [target.p_their()] own nipples with [src]") \
					: pick("teases [target]'s nipples with [src]",
						"uses [src] to tickle [target]'s left nipple",
						"uses [src] to tickle [target]'s right nipple")
			else
				message = (user == target) ? pick("tickles [target.p_them()]self with [src]",
						"gently teases [target.p_their()] synthetic body with [src]") \
					: pick("teases [target]'s touch sensors with [src]")
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(!carbon_target?.has_feet(REQUIRE_GENITAL_EXPOSED))
				to_chat(user, span_danger("Looks like [target]'s feets are covered!"))
				return

			message = (user == target) ? pick("tickles [target.p_them()]self with [src]",
					"gently teases [target.p_their()] own feet with [src]") \
				: pick("teases [target]'s feet with [src]",
					"uses [src] to tickle [target]'s [user.zone_selected == BODY_ZONE_L_LEG ? "left" : "right"] foot",
					"uses [src] to tickle [target]'s toes")
		if(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
			if(!carbon_target?.is_topless())
				to_chat(user, span_danger("Looks like [target]'s armpits are covered!"))
				return

			message = (user == target) ? pick("tickles [target.p_them()]self with [src]",
					"gently teases [target.p_their()] own armpit with [src]") \
				: pick("teases [target]'s right armpit with [src]",
					"uses [src] to tickle [target]'s [user.zone_selected == BODY_ZONE_L_ARM ? "left" : "right"] armpit",
					"uses [src] to tickle [target]'s underarm")
		else
			return

	if(prob(70))
		target.try_lewd_autoemote(pick("laugh", "giggle", "twitch", "twitch_s", "moan", ))
	target.do_jitter_animation()
	target.adjustStaminaLoss(4)
	target.add_mood_event("tickled", /datum/mood_event/tickled)
	carbon_target?.adjust_arousal(3)
	user.visible_message(span_purple("[user] [message]!"))
	play_lewd_sound(loc, \
		pick(
			'sound/items/handling/cloth_drop.ogg', // I duplicate this part of code because im useless shitcoder that can't make it work properly without tons of repeating code blocks
			'sound/items/handling/cloth_pickup.ogg', // If you can make it better - go ahead, modify it, please.
			'sound/items/handling/cloth_pickup.ogg',
		), 70, 1, -1)

//Mood boost
/datum/mood_event/tickled
	description = span_nicegreen("Wooh... I was tickled. It was... Funny!\n")
	mood_change = 0
	timeout = 2 MINUTES
