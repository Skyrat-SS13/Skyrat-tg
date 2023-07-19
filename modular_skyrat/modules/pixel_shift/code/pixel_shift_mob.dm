/mob/living/Login()
	. = ..()
	if(.)
		add_pixel_shift_component()

/mob/proc/add_pixel_shift_component()
	return

/mob/living/add_pixel_shift_component()
	if(!GetComponent(/datum/component/pixel_shift))
		AddComponent(/datum/component/pixel_shift)

/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	// Make sure to not allow projectiles of any kind past where they normally wouldn't.
	if(!isprojectile(mover) && !mover.throwing)
		if(SEND_SIGNAL(src, COMSIG_MOB_PIXEL_SHIFT_CHECK_PASSABLE, border_dir) & COMPONENT_LIVING_PASSABLE)
			return TRUE
	return ..()
