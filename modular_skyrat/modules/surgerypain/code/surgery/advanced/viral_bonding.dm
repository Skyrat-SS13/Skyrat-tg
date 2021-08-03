/datum/surgery_step/viral_bond/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel a searing heat spread through your chest!</span>")

/datum/surgery_step/viral_bond/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	. = ..()
	display_pain(target, "<span class='userdanger'>It feels like something's alive in your chest!</span>")
