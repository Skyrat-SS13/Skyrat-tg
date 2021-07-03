/obj/item/kinky_shocker
	name = "kinky shocker"
	desc = "Just a toy, that can weakly shock someone."
	icon_state = "shocker"
	inhand_icon_state = "shocker"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/shocker_on = FALSE

/obj/item/kinky_shocker/attack_self(mob/user)
	shocker_on = !shocker_on
	to_chat(user, "<span class='notice'>You turn the shocker [shocker_on? "on. Buzz!" : "off."]</span>")
	playsound(user, shocker_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
	update_icon_state()
	update_icon()

/obj/item/kinky_shocker/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

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
		if(M.client?.prefs.erp_pref == "Yes")
			switch(user.zone_selected) //to let code know what part of body we gonna tickle
				if(BODY_ZONE_PRECISE_GROIN)
					var/obj/item/organ/genital/penis = M.getorganslot(ORGAN_SLOT_PENIS)
					var/obj/item/organ/genital/vagina = M.getorganslot(ORGAN_SLOT_VAGINA)
					if(vagina && penis)
						if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW && vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans the shocker against their penis, letting it shock it. Ouch...","shocks their penis with [src]","leans the shocker against their vagina, letting it shock it. Ouch...","shocks their pussy with [src]") : pick("uses [src] to shock [M]'s penis", "shocks [M]'s penis with [src]","leans the shocker against [M]'s penis, turning shocker on","uses [src] to shock [M]'s vagina", "shocks [M]'s pussy with [src]","leans the shocker against [M]'s vagina, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')

						else if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans the shocker against their penis, letting it shock it. Ouch...","shocks their penis with [src]") : pick("uses [src] to shock [M]'s penis", "shocks [M]'s penis with [src]","leans the shocker against [M]'s penis, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')

						else if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans the shocker against their vagina, letting it shock it. Ouch...","shocks their pussy with [src]") : pick("uses [src] to shock [M]'s vagina", "shocks [M]'s pussy with [src]","leans the shocker against [M]'s vagina, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s groin is covered!</span>")
							return

					else if(penis)
						if(M.is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans the shocker against their penis, letting it shock it. Ouch...","shocks their penis with [src]") : pick("uses [src] to shock [M]'s penis", "shocks [M]'s penis with [src]","leans the shocker against [M]'s penis, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s groin is covered!</span>")
							return

					else if(vagina)
						if(M.is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
							message = (user == M) ? pick("leans the shocker against their vagina, letting it shock it. Ouch...","shocks their pussy with [src]") : pick("uses [src] to shock [M]'s vagina", "shocks [M]'s pussy with [src]","leans the shocker against [M]'s vagina, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s groin is covered!</span>")
							return

					else
						if(M.is_bottomless())
							message = (user == M) ? pick("leans the shocker against their belly, letting it shock it. Ouch...","shocks their tummy with [src]") : pick("uses [src] to shock [M]'s belly", "shocks [M]'s tummy with [src]","leans the shocker against [M]'s belly, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')

						else
							to_chat(user, "<span class='danger'>Looks like [M]'s groin is covered!</span>")
							return

				if(BODY_ZONE_CHEST)
					var/obj/item/organ/genital/breasts = M.getorganslot(ORGAN_SLOT_BREASTS)
					if(breasts)
						if(breasts.visibility_preference == GENITAL_ALWAYS_SHOW || M.is_topless())
							message = (user == M) ? pick("leans the shocker against their breasts, letting it shock it.","shocks their tits with [src]") : pick("uses [src] to shock [M]'s breasts", "shocks [M]'s nipples with [src]","leans the shocker against [M]'s tits, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s chest is covered!</span>")
							return

					else
						if(M.is_topless())
							message = (user == M) ? pick("leans the shocker against their chest, letting it shock it.","shocks their nipples with [src]") : pick("uses [src] to shock [M]'s chest", "shocks [M]'s nipples with [src]","leans the shocker against [M]'s chest, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s chest is covered!</span>")
							return

				if(BODY_ZONE_R_ARM)
					if(M.has_arms())
						if(M.is_hands_uncovered())
							message = (user == M) ? pick("leans the shocker against their right arm, letting it shock it.","shocks their arm with [src]") : pick("uses [src] to shock [M]'s right arm", "shocks [M]'s right arm with [src]","leans the shocker against [M]'s right arm, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s arms is covered!</span>")
							return
					else
						to_chat(user, "<span class='danger'>Looks like [M] dont have any arms!</span>")
						return

				if(BODY_ZONE_L_ARM)
					if(M.has_arms())
						if(M.is_hands_uncovered())
							message = (user == M) ? pick("leans the shocker against their left arm, letting it shock it.","shocks their arm with [src]") : pick("uses [src] to shock [M]'s left arm", "shocks [M]'s left arm with [src]","leans the shocker against [M]'s left arm, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(3)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s arms is covered!</span>")
							return
					else
						to_chat(user, "<span class='danger'>Looks like [M] dont have any arms!</span>")
						return

				if(BODY_ZONE_HEAD)
					if(M.is_head_uncovered())
						message = (user == M) ? pick("leans the shocker against their head, letting it shock it. Ouch! Why would they do that?!","shocks their head with [src]") : pick("uses [src] to shock [M]'s head", "shocks [M]'s neck with [src]","leans the shocker against [M]'s neck, turning shocker on")
						if(prob(80))
							M.emote(pick("twitch","twitch_s","shiver","scream"))
						M.do_jitter_animation()
						M.adjustStaminaLoss(2)
						M.adjustPain(9)
						M.stuttering += 20
						user.visible_message("<font color=purple>[user] [message].</font>")
						playsound(loc,'sound/weapons/taserhit.ogg')
					else
						to_chat(user, "<span class='danger'>Looks like [M]'s head is covered!</span>")
						return

				if(BODY_ZONE_L_LEG)
					if(M.has_feet())
						if(M.is_barefoot())
							message = (user == M) ? pick("leans the shocker against their left leg, letting it shock it.","shocks their leg with [src]") : pick("uses [src] to shock [M]'s left leg", "shocks [M]'s left foot with [src]","leans the shocker against [M]'s left leg, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(2)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')
						else
							to_chat(user, "<span class='danger'>Looks like [M]'s toes is covered!</span>")
							return
					else
						to_chat(user, "<span class='danger'>Looks like [M] don't have any legs!</span>")
						return

				if(BODY_ZONE_R_LEG)
					if(M.has_feet())
						if(M.is_barefoot())
							message = (user == M) ? pick("leans the shocker against their right leg, letting it shock it.","shocks their leg with [src]") : pick("uses [src] to shock [M]'s right leg", "shocks [M]'s right foot with [src]","leans the shocker against [M]'s right leg, turning shocker on")
							if(prob(80))
								M.emote(pick("twitch","twitch_s","shiver","scream"))
							M.do_jitter_animation()
							M.adjustStaminaLoss(2)
							M.adjustPain(9)
							M.stuttering += 20
							user.visible_message("<font color=purple>[user] [message].</font>")
							playsound(loc,'sound/weapons/taserhit.ogg')

						else
							to_chat(user, "<span class='danger'>Looks like [M]'s toes is covered!</span>")
							return
					else
						to_chat(user, "<span class='danger'>Looks like [M] don't have any legs!</span>")
						return
		else
			to_chat(user, "<span class='danger'>Looks like [M] don't want you to do that.</span>")
			return
	else
		to_chat(user, "<span class='danger'>Shocker must be enabled before use!</span>")
		return
