/mob/living/carbon/human/proc/hurt_organ_randomly(damage) // Gamble on your organs...
	for(var/i in internal_organs)
		if(roll(1, length(internal_organs)))
			var/obj/item/organ/O = getorganslot(i)
			O.applyOrganDamage(damage, 15)
