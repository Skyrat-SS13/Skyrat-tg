/mob/living/basic/venus_human_trap/start_pulling(atom/movable/movable_target, state, force, supress_message)
	if(isliving(movable_target))
		to_chat(src, span_boldwarning("You cannot drag living things!"))
		return
	return ..()
