/datum/surgery_step/extract_implant/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	for(var/obj/item/object in target.implants)
		implant = object
		break
	if(implant)
		display_pain(target, span_userdanger("You feel a horrible pain in your [target_zone]!"))

/datum/surgery_step/extract_implant/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(implant)
		display_pain(target, span_userdanger("You can feel your [implant] pulled out of you!"))
