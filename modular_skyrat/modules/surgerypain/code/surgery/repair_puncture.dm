/datum/surgery_step/repair_innards/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	var/datum/wound/pierce/pierce_wound = surgery.operated_wound
	if(pierce_wound && (pierce_wound.blood_flow > 0))
		display_pain(target, "<span class='userdanger'>You feel a horrible stabbing pain in your [parse_zone(user.zone_selected)]!</span>")

/datum/surgery_step/seal_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	var/datum/wound/pierce/pierce_wound = surgery.operated_wound
	if(pierce_wound)
		display_pain(target, "<span class='userdanger'>You're being burned inside your [parse_zone(user.zone_selected)]!</span>")
