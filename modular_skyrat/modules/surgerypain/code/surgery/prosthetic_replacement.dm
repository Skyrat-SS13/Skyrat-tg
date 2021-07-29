/datum/surgery_step/add_prosthetic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(istype(tool, /obj/item/bodypart) && user.temporarilyRemoveItemFromInventory(tool))
		display_pain(target, "<span class='userdanger'>You feel synthetic sensation wash from your [parse_zone(target_zone)], which you can feel again!</span>")
	else
		display_pain(target, "<span class='userdanger'>You feel a strange sensation from your new [parse_zone(target_zone)].</span>")

