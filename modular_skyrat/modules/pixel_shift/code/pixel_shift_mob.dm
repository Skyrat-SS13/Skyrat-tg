/mob/living/Login()
	. = ..()
	if(.)
		add_pixel_shift_component()

/mob/proc/add_pixel_shift_component()
	return

/mob/living/add_pixel_shift_component()
	AddComponent(/datum/component/pixel_shift)
