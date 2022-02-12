/// Give a shitbird some liquor, they'll get back in the fight quicker
/datum/reagent/consumable/ethanol/hooch/on_mob_life(mob/living/carbon/drinker, delta_time, times_fired)
	var/obj/item/organ/liver/liver = drinker.getorganslot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_GREYTIDE_METABOLISM))
		drinker.heal_bodypart_damage(1 * REM * delta_time, 1 * REM * delta_time)
		. = TRUE
	return ..() || .
