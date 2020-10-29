/obj/item/organ/regenerative_core/afterattack(atom/target, mob/user, proximity_flag)
	if(proximity_flag)
		if(ishuman(target))
			apply_healing_core(target, user)
		else if(istype(target, /mob/living/simple_animal/hostile/megafauna/bubblegum))
			new /mob/living/simple_animal/hostile/megafauna/bubblegum/hard(target.loc)
			visible_message("[user] turned [target] into an enraged [target]!")
			qdel(target)
			qdel(src)
		else if(istype(target, /mob/living/simple_animal/hostile/megafauna/dragon))
			new /mob/living/simple_animal/hostile/megafauna/dragon/hard(target.loc)
			visible_message("[user] turned [target] into an enraged [target]!")
			qdel(target)
			qdel(src)
		else if(istype(target, /mob/living/simple_animal/hostile/megafauna/colossus))
			new /mob/living/simple_animal/hostile/megafauna/colossus/hard(target.loc)
			visible_message("[user] turned [target] into an enraged [target]!")
			qdel(target)
			qdel(src)

/obj/item/organ/regenerative_core/attack_self(mob/user)
	if(iscarbon(user))
		apply_healing_core(user, user)

/obj/item/organ/regenerative_core/proc/apply_healing_core(atom/target, mob/user)
	if(!user || !ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(inert)
		to_chat(user, "<span class='notice'>[src] has decayed and can no longer be used to heal.</span>")
		return
	if(H.stat == DEAD)
		to_chat(user, "<span class='notice'>[src] are useless on the dead.</span>")
		return
	if(H != user)
		H.visible_message("[user] forces [H] to apply [src]... Black tendrils entangle and reinforce [H.p_them()]!")
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
	else
		to_chat(user, "<span class='notice'>You start to smear [src] on yourself. Disgusting tendrils hold you together and allow you to keep moving, but for how long?</span>")
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
	if(is_station_level(H.z))
		H.adjustBruteLoss(-25, 0)
		H.adjustFireLoss(-25, 0)
		for(var/obj/item/organ/O in H)
			O.damage = 0
	else
		H.reagents.remove_reagent(/datum/reagent/determination, 2000, TRUE, TRUE)
		H.revive(full_heal = 1)
	qdel(src)
	user.log_message("[user] used [src] to heal [H == user ? "[H.p_them()]self" : H]! Wake the fuck up, Samurai!", LOG_ATTACK, color="green") //Logging for 'old' style legion core use, when clicking on a sprite of yourself or another.
