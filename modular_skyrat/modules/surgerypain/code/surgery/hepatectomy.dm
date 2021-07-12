/datum/surgery_step/hepatectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>Your abdomen burns in horrific stabbing pain!</span>")

/datum/surgery_step/hepatectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, "<span class='userdanger'>The pain receeds slightly.</span>")

/datum/surgery_step/hepatectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel a sharp stab inside your abdomen!</span>")

