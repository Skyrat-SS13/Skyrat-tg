/obj/item/bodypart/proc/get_wrenched(mob/living/carbon/user, mob/living/carbon/victim, silent = FALSE)
	. = FALSE
	if(!owner || !user)
		return
	if(!victim)
		victim = owner

	var/bio_state = victim.get_biological_state()

	if(!bio_state)
		return

	for(var/datum/wound/W in wounds)
		if(bio_state & BIO_JUST_BONE)
			if(W.wound_type in WOUND_BLUNT)
				return
		else if(bio_state & BIO_JUST_FLESH)
			if(W.wound_type in WOUND_SLASH)
				return

	var/time = 4 SECONDS
	var/time_mod = 1
	var/prob_mod = 20
	if(time_mod)
		time *= time_mod

	if(INTERACTING_WITH(user, victim))
		return

	if(!silent)
		user.visible_message("<span class='danger'>[user] starts wrenching [victim]'s [name]!</span>", "<span class='danger'>You start wrenching [victim]'s [name]!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] starts wrenching your [name]!</span>")

	if(!do_after(user, time, target=victim))
		return

	if(prob(30 + prob_mod))
		user.visible_message("<span class='danger'>[user] dislocates [victim]'s [name] with a sickening crack!</span>", "<span class='danger'>You dislocate [victim]'s [name] with a sickening crack!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] dislocates your [name] with a sickening crack!</span>")
		victim.emote("scream")
		var/datum/wound/W
		if(status)
			if(body_zone == BODY_ZONE_HEAD)
				W = new /datum/wound/blunt/moderate/jaw()
			else if(body_zone == BODY_ZONE_PRECISE_GROIN)
				W = new /datum/wound/blunt/moderate/hips()
			else if(body_zone == BODY_ZONE_CHEST)
				W = new /datum/wound/blunt/moderate/ribcage()
			else
				W = new /datum/wound/blunt/moderate()
		if(istype(W))
			W.apply_wound(src, FALSE)
		receive_damage(brute=15)
	else
		user.visible_message("<span class='danger'>[user] wrenches [victim]'s [name] around painfully!</span>", "<span class='danger'>You wrench [victim]'s [name] around painfully!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] wrenches your [name] around painfully!</span>")
		receive_damage(brute=7)
		get_wrenched(user, victim, TRUE)
	return TRUE

