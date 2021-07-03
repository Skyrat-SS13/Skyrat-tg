/datum/surgery_step/wing_reconstruction/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>Your wings sting like hell!</span>")

/datum/surgery_step/wing_reconstruction/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(ishuman(target))
		display_pain(target, "<span class='userdanger'>You can feel your wings again!</span>")
