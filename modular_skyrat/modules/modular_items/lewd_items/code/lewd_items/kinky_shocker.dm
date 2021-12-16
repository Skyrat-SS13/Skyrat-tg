/obj/item/kinky_shocker
	name = "kinky shocker"
	desc = "A small toy that can weakly shock someone."
	icon_state = "shocker"
	inhand_icon_state = "shocker"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY

	var/shocker_on = FALSE
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell
	var/cell_hit_cost = 75
	var/can_remove_cell = TRUE
	var/activate_sound = "sparks"

/obj/item/kinky_shocker/get_cell()
	return cell

/obj/item/kinky_shocker/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)

/obj/item/kinky_shocker/proc/deductcharge(chrgdeductamt)
	if(cell)
		//Note this value returned is significant, as it will determine
		//if a stun is applied or not
		. = cell.use(chrgdeductamt)
		if(shocker_on && cell.charge < cell_hit_cost)
			//we're below minimum, turn off
			shocker_on = FALSE
			update_appearance()
			playsound(src, activate_sound, 75, TRUE, -1, ignore_walls = FALSE)

/obj/item/kinky_shocker/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [src] is [round(cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

/obj/item/kinky_shocker/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, span_warning("[src] already has a cell!"))
		else
			if(C.maxcharge < cell_hit_cost)
				to_chat(user, span_notice("[src] requires a higher capacity cell."))
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("You install a cell in [src]."))
			update_appearance()
	else
		return ..()

/obj/item/kinky_shocker/AltClick(mob/user)
	tryremovecell(user)

/obj/item/kinky_shocker/proc/tryremovecell(mob/user)
	if(cell && can_remove_cell)
		cell.update_appearance()
		cell.forceMove(get_turf(src))
		cell = null
		to_chat(user, span_notice("You remove the cell from [src]."))
		shocker_on = FALSE
		update_appearance()

/obj/item/kinky_shocker/attack_self(mob/user)
	toggle_on(user)

/obj/item/kinky_shocker/proc/toggle_on(mob/user)
	if(cell && cell.charge >= cell_hit_cost)
		shocker_on = !shocker_on
		to_chat(user, span_notice("You turn the shocker [shocker_on? "on. Buzz!" : "off."]"))
		playsound(user, shocker_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE, ignore_walls = FALSE)
	else
		shocker_on = FALSE
		if(!cell)
			to_chat(user, span_warning("[src] does not have a power source!"))
		else
			to_chat(user, span_warning("[src] is out of charge."))
	update_appearance()
	add_fingerprint(user)

/obj/item/kinky_shocker/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[shocker_on? "on" : "off"]"
	inhand_icon_state = "[initial(icon_state)]_[shocker_on? "on" : "off"]"

/obj/item/kinky_shocker/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	if(shocker_on == TRUE)
		var/message = ""
		if(M.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			deductcharge(cell_hit_cost)
			playsound(loc, 'sound/weapons/taserhit.ogg', 70, 1, -1)
			switch(user.zone_selected) //to let code know what part of body we gonna tickle
				if(BODY_ZONE_PRECISE_GROIN)
					var/obj/item/organ/genital/penis = M.getorganslot(ORGAN_SLOT_PENIS)
					var/obj/item/organ/genital/vagina = M.getorganslot(ORGAN_SLOT_VAGINA)
					if(vagina && penis)
						if(M.is_bottomless() || (penis.visibility_preference == GENITAL_ALWAYS_SHOW && vagina.visibility_preference == GENITAL_ALWAYS_SHOW))
							message = (user == M) ? pick("leans [src] against [M.p_their()] penis, letting it shock it. Ouch...",
														"shocks [M.p_their()] penis with [src]",
														"leans [src] against [M.p_their()] vagina, letting it shock it. Ouch...",
														"shocks [M.p_their()] pussy with [src]") : pick("uses [src] to shock [M]'s penis", "shocks [M]'s penis with [src]",
														"leans [src] against [M]'s penis, turning it on",
														"uses [src] to shock [M]'s vagina",
														"shocks [M]'s pussy with [src]",
														"leans the shocker against [M]'s vagina, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')

						else if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans [src] against [M.p_their()] penis, letting it shock it. Ouch...",
														"shocks [M.p_their()] penis with [src]") : pick("uses [src] to shock [M]'s penis",
														"shocks [M]'s penis with [src]",
														"leans [src] against [M]'s penis, turning shocker on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')

						else if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans [src] against [M.p_their()] vagina, letting it shock it. Ouch...",
														"shocks [M.p_their()] pussy with [src]") : pick("uses [src] to shock [M]'s vagina",
														"shocks [M]'s pussy with [src]",
														"leans [src] against [M]'s vagina, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
							return

					else if(penis)
						if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans [src] against [M.p_their()] penis, letting it shock it. Ouch...",
														"shocks [M.p_their()] penis with [src]") : pick("uses [src] to shock [M]'s penis",
														"shocks [M]'s penis with [src]",
														"leans [src] against [M]'s penis, turning shocker on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
							return

					else if(vagina)
						if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans [src] against [M.p_their()] vagina, letting it shock it. Ouch...",
														"shocks [M.p_their()] pussy with [src]") : pick("uses [src] to shock [M]'s vagina",
														"shocks [M]'s pussy with [src]",
														"leans [src] against [M]'s vagina, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
							return

					else
						if(M.is_bottomless())
							message = (user == M) ? pick("leans [src] against [M.p_their()] belly, letting it shock it. Ouch...",
														"shocks [M.p_their()] tummy with [src]") : pick("uses [src] to shock [M]'s belly",
														"shocks [M]'s tummy with [src]",
														"leans [src] against [M]'s belly, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')

						else
							to_chat(user, span_danger("Looks like [M]'s groin is covered!"))
							return

				if(BODY_ZONE_CHEST)
					var/obj/item/organ/genital/breasts = M.getorganslot(ORGAN_SLOT_BREASTS)
					if(breasts)
						if(breasts.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_topless())
							message = (user == M) ? pick("leans [src] against [M.p_their()] breasts, letting it shock it.",
														"shocks [M.p_their()] tits with [src]") : pick("uses [src] to shock [M]'s breasts",
														"shocks [M]'s nipples with [src]",
														"leans [src] against [M]'s tits, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
							return

					else
						if(M.is_topless())
							message = (user == M) ? pick("leans [src] against [M.p_their()] chest, letting it shock it.",
														"shocks [M.p_their()] nipples with [src]") : pick("uses [src] to shock [M]'s chest",
														"shocks [M]'s nipples with [src]",
														"leans [src] against [M]'s chest, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("Looks like [M]'s chest is covered!"))
							return

				if(BODY_ZONE_R_ARM)
					if(M.has_arms())
						if(M.is_hands_uncovered())
							message = (user == M) ? pick("leans [src] against [M.p_their()] right arm, letting it shock it.",
														"shocks [M.p_their()] arm with [src]") : pick("uses [src] to shock [M]'s right arm",
														"shocks [M]'s right arm with [src]",
														"leans [src] against [M]'s right arm, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("[M]'s arms are covered!"))
							return
					else
						to_chat(user, span_danger("[M] doesn't have any arms!"))
						return

				if(BODY_ZONE_L_ARM)
					if(M.has_arms())
						if(M.is_hands_uncovered())
							message = (user == M) ? pick("leans [src] against [M.p_their()] left arm, letting it shock it.",
														"shocks [M.p_their()] arm with [src]") : pick("uses [src] to shock [M]'s left arm",
														"shocks [M]'s left arm with [src]",
														"leans [src] against [M]'s left arm, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("[M]'s arms are covered!"))
							return
					else
						to_chat(user, span_danger("[M] doesn't have any arms!"))
						return

				if(BODY_ZONE_HEAD)
					if(M.is_head_uncovered())
						message = (user == M) ? pick("leans [src] against [M.p_their()] head, letting it shock it. Ouch! Why would they do that?!",
													"shocks [M.p_their()] head with [src]") : pick("uses [src] to shock [M]'s head",
													"shocks [M]'s neck with [src]",
													"leans [src] against [M]'s neck, turning it on")
						if(M.stat != DEAD)
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
						M.adjustStaminaLoss(2)
						M.adjustPain(9)
						M.stuttering += 20
						user.visible_message(span_purple("[user] [message]!"))
						playsound(loc,'sound/weapons/taserhit.ogg')
					else
						to_chat(user, span_danger("[M]'s head is covered!"))
						return

				if(BODY_ZONE_L_LEG)
					if(M.has_feet())
						if(M.is_barefoot())
							message = (user == M) ? pick("leans [src] against [M.p_their()] left leg, letting it shock it.",
														"shocks [M.p_their()] leg with [src]") : pick("uses [src] to shock [M]'s left leg",
														"shocks [M]'s left foot with [src]",
														"leans [src] against [M]'s left leg, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(2)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, span_danger("[M]'s toes are covered!"))
							return
					else
						to_chat(user, span_danger("[M] doesn't have any legs!"))
						return

				if(BODY_ZONE_R_LEG)
					if(M.has_feet())
						if(M.is_barefoot())
							message = (user == M) ? pick("leans [src] against [M.p_their()] right leg, letting it shock it.",
														"shocks [M.p_their()] leg with [src]") : pick("uses [src] to shock [M]'s right leg",
														"shocks [M]'s right foot with [src]",
														"leans [src] against [M]'s right leg, turning it on")
							if(M.stat != DEAD)
								if(prob(80))
									M.emote(pick("twitch","twitch_s","shiver","scream"))
								M.do_jitter_animation()
							M.adjustStaminaLoss(2)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message(span_purple("[user] [message]!"))
							playsound(loc,'sound/weapons/taserhit.ogg')

						else
							to_chat(user, span_danger("[M]'s toes are covered!"))
							return
					else
						to_chat(user, span_danger("[M] doesn't have any legs!"))
						return
		else
			to_chat(user, span_danger("[M] doesn't want you to do that."))
			return
	else
		to_chat(user, span_danger("[src] must be enabled before use!"))
		return
