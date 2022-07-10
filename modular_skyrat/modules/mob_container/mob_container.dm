/mob/proc/store_mob(mob/tostore)
	if(!istype(tostore))
		return

	if(!tostore.on_enter_container(src) || !on_container_entered(tostore))
		return

	ADD_TRAIT(tostore, TRAIT_OXYIMMUNE, REF(src)) // We give the mob inside oxy-damage immunity. Hope this doesn't come back to bite us in the ass.
	tostore.forceMove(src)
	tostore.overlay_fullscreen("in_mob", /atom/movable/screen/fullscreen/impaired, 1)

/mob/proc/remove_mob(mob/toremove)
	if(!istype(toremove))
		return

	if(!(toremove in contents) || toremove.loc !== src)
		return

	if(!toremove.on_exit_container(src) || !on_container_exited(toremove))
		return

	REMOVE_TRAIT(toremove, TRAIT_OXYIMMUNE, REF(src)) // Remove trait prevents the loss of roundstart traits, and we also have ourselves as a source. So don't worry.
	toremove.forceMove(get_turf(src))
	toremove.clear_fullscreen("in_mob")

/mob/proc/on_enter_container(mob/mob_were_entering)
	return TRUE

/mob/proc/on_exit_container(mob/mob_were_exiting)
	return TRUE

/mob/proc/on_container_entered(mob/mob_entering)
	return TRUE

/mob/proc/on_container_exited(mob/mob_exiting)
	return TRUE
