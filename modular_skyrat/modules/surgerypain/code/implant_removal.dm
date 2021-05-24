/datum/surgery_step/extract_implant/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/O in target.implants)
		I = O
		break
	if(I)
		display_pain(target, "<span class='userdanger'>You feel a horrible pain in your [target_zone]!</span>")
	..()

/datum/surgery_step/extract_implant/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(I)
		display_pain(target, "<span class='userdanger'>You can feel your [I] pulled out of you!</span>")
	..()
