// Lets cyborgs move dragged objects onto tables
/obj/structure/table/attack_robot(mob/user, list/modifiers)
	if(!in_range(src, user))
		return
	return attack_hand(user, modifiers)

/obj/structure/table/reinforced/Initialize()
	. = ..()
	AddElement(/datum/element/liquids_height, 20)

/// Used to numb a patient and apply stasis to them if enabled.
/obj/structure/table/optable/proc/chill_out(mob/living/target)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = rand(24750, 26550))
	ADD_TRAIT(target, TRAIT_NUMBED, REF(src))
	target.throw_alert("numbed", /atom/movable/screen/alert/numbed)

///Used to remove the effects of stasis and numbing when a patient is unbuckled
/obj/structure/table/optable/proc/thaw_them(mob/living/target)
	REMOVE_TRAIT(target, TRAIT_NUMBED, REF(src))
	target.clear_alert("numbed", /atom/movable/screen/alert/numbed)
