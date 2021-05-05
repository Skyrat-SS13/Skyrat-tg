/mob/living/proc/do_jackoff(mob/living/user)
	var/message
	var/t_His = p_their()
	var/t_Him = p_them()

	if(user.is_fucking(src, CUM_TARGET_HAND))
		message = "[pick("jerks [t_Him]self off.",
			"works [t_His] shaft.",
			"strokes [t_His] penis.",
			"wanks [t_His] cock hard.")]"
	else
		message = "[pick("wraps [t_His] hand around [t_His] cock.",
			"starts to stroke [t_His] cock.",
			"starts playing with [t_His] cock.")]"
		user.set_is_fucking(src, CUM_TARGET_HAND, user.getorganslot(ORGAN_SLOT_PENIS) ? user.getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>") //can't not consent to yourself, if you did it, you wanted it
	user.handle_post_sex(CUM_TARGET_HAND, src)
	user.adjustArousal(8)
	user.adjustPleasure(8)

/mob/living/proc/do_fingerass_self(mob/living/user)
	var/t_His = p_their()
	var/t_Him = p_them()

	visible_message(message = "<font color=purple><b>\The [src]</b> [pick("fingers [t_Him]self.",
		"fingers [t_His] asshole.",
		"fingers [t_Him]self hard.")]</font>") //can't not consent to yourself, if you did it, you wanted it
	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/champ_fingering.ogg', 50, 1, -1)
	user.handle_post_sex(CUM_TARGET_HAND, src)
	user.adjustArousal(8)
	user.adjustPleasure(8)

/mob/living/proc/do_fingering_self(mob/living/user)
	var/t_His = p_their()

	visible_message(message = "<font color=purple><b>\The [src]</b> [pick("fingers [t_His] pussy deep.",
		"fingers [t_His] pussy.",
		"plays with [t_His] pussy.",
		"fingers [t_His] own pussy hard.")]</font>") //can't not consent to yourself, if you did it, you wanted it
	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/champ_fingering.ogg', 50, 1, -1)
	user.handle_post_sex(CUM_TARGET_HAND, src)
	user.adjustArousal(8)
	user.adjustPleasure(8)

/mob/living/proc/do_titgrope_self(mob/living/user)
	var/message
	var/t_His = p_their()

	message = "[pick("aggressively gropes [t_His] breast.",
				"grabs [t_His] breasts.",
				"tightly squeezes [t_His] breasts.",
				"slaps at [t_His] breasts.",
				"gropes [t_His] breasts roughly.")]"

	if(prob(5 + user.arousal))
		visible_message(message = "<font color=purple><b>\The [src]</b> [pick("shivers in arousal.",
				"moans quietly.",
				"breathes out a soft moan.",
				"gasps.",
				"shudders softly.",
				"trembles as [t_His] hands run across bare skin.")]</font>")
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>") //can't not consent to yourself, if you did it, you wanted it
	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch1.ogg', 50, 1, -1)
	user.handle_post_sex(CUM_TARGET_HAND, src)
	user.adjustArousal(8)
