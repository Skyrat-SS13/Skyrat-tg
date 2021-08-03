/datum/surgery_step/lobectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel a stabbing pain in your chest!</span>")

/datum/surgery_step/lobectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(ishuman(target))
		display_pain(target, "<span class='userdanger'>Your chest hurts like hell, but breathng becomes slightly easier.</span>")

/datum/surgery_step/lobectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	if(ishuman(target))
		display_pain(target, "<span class='userdanger'>You feel a sharp stab in your chest as the wind is knocked out of you, and it hurts to catch your breath!</span>")
