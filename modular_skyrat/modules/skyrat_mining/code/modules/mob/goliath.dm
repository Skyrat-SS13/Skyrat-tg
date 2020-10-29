/obj/effect/temp_visual/goliath_tentacle/trip()
	var/latched = FALSE
	for(var/mob/living/L in loc)
		if((!QDELETED(spawner) && spawner.faction_check_mob(L)) || L.stat == DEAD)
			continue
		visible_message("<span class='danger'>[src] grabs hold of [L]!</span>")
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			var/obj/item/clothing/S = C.get_item_by_slot(ITEM_SLOT_OCLOTHING)
			if(S && S.resistance_flags & GOLIATH_RESISTANCE)
				L.Stun(25)
			else if(S && S.resistance_flags & GOLIATH_WEAKNESS)
				L.Stun(125)
			else
				L.Stun(100)
		else
			L.Stun(100)
		L.adjustBruteLoss(rand(10,15))
		latched = TRUE
	if(!latched)
		retract()
	else
		deltimer(timerid)
		timerid = addtimer(CALLBACK(src, .proc/retract), 10, TIMER_STOPPABLE)