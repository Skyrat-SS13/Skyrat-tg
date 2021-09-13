/datum/surgery_step/muscled_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>Your entire body burns in agony!</span>")

/datum/surgery_step/muscled_veins/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, "<span class='userdanger'>You can feel your heartbeat's powerful throbs ripple through your body!</span>")
