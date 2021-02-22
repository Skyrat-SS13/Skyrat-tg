
/*
	Lunge, variant of charge used by ubermorph.

*/
/datum/extension/charge/lunge
	verb_action = "lunges"
	verb_name = "lunging"
	name = "Lunge"
	var/vector2/cached_pixels
	force_multiplier = 0 //No knockback

/datum/extension/charge/lunge/New(var/datum/holder, var/atom/_target, var/_speed , var/_lifespan, var/_maxrange, var/_homing, var/_inertia = FALSE, var/_power, var/_cooldown, var/_delay)
	..()
	//Do a chargeup animation
	var/mob/living/M = user
	M.face_atom(get_turf(_target))
	var/vector2/pixel_offset = Vector2.DirectionBetween(user, _target) * -24
	cached_pixels = get_new_vector(user.pixel_x, user.pixel_y)
	animate(user, pixel_x = user.pixel_x + pixel_offset.x, pixel_y = user.pixel_y + pixel_offset.y, time = delay, easing = BACK_EASING)



/datum/extension/charge/lunge/start()
	animate(user, pixel_y = cached_pixels.y, pixel_x = cached_pixels.x, time = 0.5 SECONDS, easing = BACK_EASING)
	release_vector(cached_pixels)
	..()






