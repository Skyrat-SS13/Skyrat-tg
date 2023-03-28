/datum/job/chaplain/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/spawned_chaplain = spawned
	if(!spawned_chaplain.mind)
		return
	if(spawned_chaplain.mind.holy_role != HOLY_ROLE_HIGHPRIEST)
		if(isnull(GLOB.holy_successors)) 
			GLOB.holy_successors = list()
		GLOB.holy_successors |= WEAKREF(spawned_chaplain)
		return

	if(isnull(GLOB.current_highpriest)) // so priests who spawn after the previous high priest has entered cryosleep can get their own null rod
		spawned_chaplain.put_in_hands(new /obj/item/nullrod(spawned_chaplain))

	GLOB.current_highpriest = WEAKREF(spawned_chaplain) // keep a record of the current high priest
