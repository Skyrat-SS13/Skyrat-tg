/datum/surgery_step/repair_bone_hairline/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	if(surgery.operated_wound)
		display_pain(target, "<span class='userdanger'>Your [parse_zone(user.zone_selected)] aches with pain!</span>")

/datum/surgery_step/reset_compound_fracture/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	if(surgery.operated_wound)
		display_pain(target, "<span class='userdanger'>The aching pain in your [parse_zone(user.zone_selected)] is overwhelming!</span>")

/datum/surgery_step/repair_bone_compound/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	if(surgery.operated_wound)
		display_pain(target, "<span class='userdanger'>The aching pain in your [parse_zone(user.zone_selected)] is overwhelming!</span>")
