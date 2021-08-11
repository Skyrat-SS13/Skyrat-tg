/datum/surgery_step/pacify/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, span_userdanger("Your head pounds with unimaginable pain!"))

/datum/surgery_step/pacify/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, span_userdanger("Your head pounds... the concept of violence flashes in your head, and nearly makes you hurl!"))

/datum/surgery_step/pacify/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	display_pain(target, span_userdanger("Your head pounds, and it feels like it's getting worse!"))
