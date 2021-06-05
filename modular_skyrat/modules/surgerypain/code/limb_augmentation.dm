/datum/surgery_step/replace_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	display_pain(target, "<span class='userdanger'>You feel a horrible pain in your [parse_zone(user.zone_selected)]!</span>")

/datum/surgery_step/replace_limb/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/bodypart/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(target_limb)
		display_pain(target, "<span class='userdanger'>Your [parse_zone(target_zone)] comes awash with synthetic sensation!</span>")
