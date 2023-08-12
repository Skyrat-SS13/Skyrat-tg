/mob/living/simple_animal/hostile/venus_human_trap/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	. = ..()
	check_vines()

/mob/living/simple_animal/hostile/venus_human_trap/death(gibbed)
	for(var/i in vines)
		qdel(i)
	return ..()

/mob/living/simple_animal/hostile/venus_human_trap/start_pulling(atom/movable/movable_target, state, force, supress_message)
	if(isliving(movable_target))
		to_chat(src, span_boldwarning("You cannot drag living things!"))
		return
	return ..()

/mob/living/simple_animal/hostile/venus_human_trap/proc/check_vines()
	var/obj/structure/spacevine/find_vine = locate() in get_turf(src)
	if(!find_vine)
		adjustHealth(maxHealth * 0.05)
	else
		adjustHealth(maxHealth * -0.05)
