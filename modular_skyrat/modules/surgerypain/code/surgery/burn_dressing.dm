/datum/surgery_step/debride/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	if(surgery.operated_wound)
		display_pain(target, span_userdanger("The infection in your [parse_zone(user.zone_selected)] stings like hell! It feels like you're being stabbed!"))

/datum/surgery_step/dress/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	if(surgery.operated_wound)
		display_pain(target, span_userdanger("The burns on your [parse_zone(user.zone_selected)] sting like hell!"))
