/datum/surgery_step/handle_cavity/preop(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	if(tool)
		display_pain(target, "<span class='userdanger'>You can feel something being inserted into your [target_zone], it hurts like hell!</span>")

/datum/surgery_step/handle_cavity/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery = FALSE)
	. = ..()
	if(!tool)
		if(item_for_cavity)
			display_pain(target, "<span class='userdanger'>Something is pulled out of your [target_zone]! It hurts like hell!</span>")
