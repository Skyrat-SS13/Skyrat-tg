/datum/surgery_step/cut_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel a stabbing in your [target_zone]!</span>")

/datum/surgery_step/cut_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	. = ..()
	display_pain(target, "<span class='userdanger'>The fat in your [target_zone] comes loose, dangling and hurting like hell!</span>")

/datum/surgery_step/remove_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	..()
	display_pain(target, "<span class='userdanger'>You feel an oddly painless tugging on your loose fat!</span>")
