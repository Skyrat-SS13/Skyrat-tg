/*
/obj/item/tickle_feather
	name = "tickling feather"
	desc = "A rather ticklish feather that can be used in both mirth and malice."
	icon_state = "feather"
	inhand_icon_state = "feather"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/tickle_feather/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return

	var/message = ""
	var/targetedsomewhere = FALSE
	switch(user.zone_selected) //to let code know what part of body we gonna tickle
		if(BODY_ZONE_PRECISE_GROIN)
			targetedsomewhere = TRUE
			if(!(target.is_bottomless()))
				to_chat(user, span_danger("[target]'s groin is covered!"))
				return
			message = (user == target) ? pick("tickles [target.p_them()]self with [src]", "gently teases [target.p_their()] belly with [src]") : pick("teases [target]'s belly with [src]", "uses [src] to tickle [target]'s belly", "tickles [target] with [src]")
			if(target.stat == DEAD)
				return
			if(prob(70))
				target.emote(pick("laugh", "giggle", "twitch", "twitch_s"))

		if(BODY_ZONE_CHEST)
			targetedsomewhere = TRUE
			var/obj/item/organ/genital/badonkers = target.getorganslot(ORGAN_SLOT_BREASTS)
			if(!(target.is_topless() || badonkers.visibility_preference == GENITAL_ALWAYS_SHOW))
				to_chat(user, span_danger("[target]'s chest is covered!"))
				return
			message = (user == target) ? pick("tickles [target.p_them()]self with [src]", "gently teases [target.p_their()] own nipples with [src]") : pick("teases [target]'s nipples with [src]", "uses [src] to tickle [target]'s left nipple", "uses [src] to tickle [target]'s right nipple")
			if(target.stat == DEAD)
				return
			if(prob(70))
				target.emote(pick("laugh", "giggle", "twitch", "twitch_s", "moan", ))

		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			targetedsomewhere = TRUE
			if(!target.has_feet())
				to_chat(user, span_danger("[target] doesn't have any feet!"))
				return

			if(!target.is_barefoot())
				to_chat(user, span_danger("[target]'s feet are covered!"))
				return
			message = (user == target) ? pick("tickles [target.p_them()]self with [src]", "gently teases [target.p_their()] own feet with [src]") : pick("teases [target]'s feet with [src]", "uses [src] to tickle [target]'s [user.zone_selected == BODY_ZONE_L_LEG ? "left" : "right"] foot", "uses [src] to tickle [target]'s toes")
			if(target.stat == DEAD)
				return
			if(prob(70))
				target.emote(pick("laugh", "giggle", "twitch", "twitch_s", "moan", ))

		if(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
			targetedsomewhere = TRUE
			if(!target.is_topless())
				to_chat(user, span_danger("[target]'s armpits are covered!"))
				return
			message = (user == target) ? pick("tickles [target.p_them()]self with [src]", "gently teases [target.p_their()] own armpit with [src]") : pick("teases [target]'s right armpit with [src]", "uses [src] to tickle [target]'s [user.zone_selected == BODY_ZONE_L_ARM ? "left" : "right"] armpit", "uses [src] to tickle [target]'s underarm")
			if(target.stat == DEAD)
				return
			if(prob(70))
				target.emote(pick("laugh", "giggle", "twitch", "twitch_s", "moan", ))
	if(!targetedsomewhere)
		return
	target.do_jitter_animation()
	target.adjustStaminaLoss(4)
	SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
	target.adjustArousal(3)
	user.visible_message(span_purple("[user] [message]!"))
	playsound(loc, pick('sound/items/handling/cloth_drop.ogg', // I duplicate this part of code because im useless shitcoder that can't make it work properly without tons of repeating code blocks
            			'sound/items/handling/cloth_pickup.ogg', // If you can make it better - go ahead, modify it, please.
        	       	    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1, ignore_walls = FALSE)

//Mood boost
/datum/mood_event/tickled
	description = span_nicegreen("Wooh... I was tickled. It was... Funny!\n")
	mood_change = 0
	timeout = 2 MINUTES
*/
