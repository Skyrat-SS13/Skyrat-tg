// Modular extension of surgery stasis tables.

/obj/structure/table/optable/proc/chill_out(mob/living/target)
	var/freq = rand(24750, 26550)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = freq)
	target.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
	ADD_TRAIT(target, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)
	target.extinguish_mob()
	handle_glow(target, FALSE)
/obj/structure/table/optable/proc/handle_glow(passed_mob, removing)
	var/atom/movable/mob = passed_mob
	if(!istype(mob))
		return
	if(removing)
		mob.remove_filter("thaw_glow")
	else if(!removing)
		mob.add_filter("thaw_glow", 2, list("type" = "outline", "color" = "#14b5ff30", "size" = 2))
/obj/structure/table/optable/proc/thaw_them(mob/living/target)
	target.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
	REMOVE_TRAIT(target, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)
	handle_glow(target, TRUE)

/obj/structure/table/optable/post_buckle_mob(mob/living/L)
	set_patient(L)
	chill_out(L)

/obj/structure/table/optable/post_unbuckle_mob(mob/living/L)
	set_patient(null)
	thaw_them(L)
