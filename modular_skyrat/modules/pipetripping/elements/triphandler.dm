/datum/element/trippipes
	element_flags = ELEMENT_DETACH

/datum/element/trippipes/Attach(datum/target)
  if(!ismovable(target))
    return ELEMENT_INCOMPATIBLE

/datum/element/trippipes/proc/on_examine(list/examine_list)
  examine_list += "<span class='warning'>That pipe looks rather dangerous untiled like that!</span>"

/datum/element/trippipes/proc/Bump(mob/living/target, atom/movable/crossing_movable)
	if(HAS_TRAIT(target, TRAIT_NOTRIP))
		if(prob(10))
			to_chat(target, "<span class='notice'>You avoided tripping due to your training!</span>")
	else
		if(prob(15))
			to_chat(target, "<span class='warning'>You trip over on the exposed pipes!</span>")

/datum/element/trippipes/proc/OnCrossed(mob/living/target, atom/movable/crossing_movable)
	if(HAS_TRAIT(target, TRAIT_NOTRIP))
		if(prob(10))
			to_chat(target, "<span class='notice'>You avoided tripping due to your training!</span>")
	else
		to_chat(target, "<span class='notice'>You trip over a pipe!</span>")


