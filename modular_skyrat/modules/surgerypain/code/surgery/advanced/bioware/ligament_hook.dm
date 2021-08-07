/datum/surgery_step/reshape_ligaments/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, span_userdanger("Your limbs burn with severe pain!"))

/datum/surgery_step/reshape_ligaments/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, span_userdanger("Your limbs feel... strangely loose."))
