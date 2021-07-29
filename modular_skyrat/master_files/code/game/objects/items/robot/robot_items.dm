
/obj/item/borg/stun
	name = "electrically-charged arm"
	icon_state = "elecarm"
	var/charge_cost = 30

/obj/item/borg/stun/attack(mob/living/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.check_shields(src, 0, "[M]'s [name]", MELEE_ATTACK))
			playsound(M, 'sound/weapons/genhit.ogg', 50, TRUE)
			return FALSE
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(!R.cell.use(charge_cost))
			return

	user.do_attack_animation(M)
	M.StaminaKnockdown(60, TRUE)
	M.apply_effect(EFFECT_STUTTER, 5)

	M.visible_message(span_danger("[user] prods [M] with [src]!"), \
					span_userdanger("[user] prods you with [src]!"))

	playsound(loc, 'sound/weapons/egloves.ogg', 50, TRUE, -1)

	log_combat(user, M, "stunned", src, "(Combat mode: [user.combat_mode ? "On" : "Off"])")
