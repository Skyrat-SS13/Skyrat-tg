/datum/surgery_step/brainwash/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	display_pain(target, "<span class='userdanger'>Your head pounds with unimaginable pain!</span>")

/datum/surgery_step/brainwash/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_pain(target, "<span class='userdanger'>Your head throbs with horrible pain!</span>")

