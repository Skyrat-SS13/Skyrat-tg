/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You can feel your [parse_zone(target_zone)] grow numb as the sensory panel is unscrewed.</span>")

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel the faint pricks of sensation return as your [parse_zone(target_zone)]'s panel is screwed in.</span>")

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You can feel a faint buzz in your [parse_zone(target_zone)] as the electronics reboot.</span>")

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel a jostle in your [parse_zone(target_zone)] as the bolts begin to loosen.</span>")

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel a jostle in your [parse_zone(target_zone)] as the bolts begin to tighten.</span>")

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>The last faint pricks of tactile sensation fade from your [parse_zone(target_zone)] as the hatch is opened.</span>")
