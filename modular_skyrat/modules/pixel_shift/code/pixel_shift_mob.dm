/mob/Initialize(mapload)
	. = ..()
	add_pixel_shift_component()

/mob/proc/add_pixel_shift_component()
	return

/mob/living/add_pixel_shift_component()
	AddComponent(/datum/component/pixel_shift)

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state)
	SEND_SIGNAL(pull_target, COMSIG_MOB_UNPIXEL_SHIFT)
	return ..()

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	SEND_SIGNAL(pull_target, COMSIG_MOB_UNPIXEL_SHIFT)
	return ..()

/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	// Make sure to not allow projectiles of any kind past where they normally wouldn't.
	if(!istype(mover, /obj/projectile) && !mover.throwing)
		if(SEND_SIGNAL(src, COMSIG_MOB_PIXEL_SHIFT_CHECK_PASSABLE, border_dir) & COMPONENT_LIVING_PASSABLE)
			return TRUE
	return ..()
