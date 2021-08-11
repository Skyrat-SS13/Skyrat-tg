/datum/surgery_step/splice_nerves/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, span_userdanger("Your entire body goes numb!"))

/datum/surgery_step/splice_nerves/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	display_pain(target, span_userdanger("You regain feeling in your body! It feels like everything's happening around you in slow motion!"))
