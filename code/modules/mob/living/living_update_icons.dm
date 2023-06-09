
/// Called whenever the mob is to be resized or when lying/standing up for carbons.
<<<<<<< HEAD
/mob/living/update_transform()
	perform_update_transform() // carbon mobs do it differently than silicons and simple animals.
=======
/mob/living/update_transform(resize = RESIZE_DEFAULT_SIZE)
	perform_update_transform(resize) // carbon mobs do it differently than silicons and simple animals.
	//Make sure the body position y offset is updated if resized.
	if(resize != RESIZE_DEFAULT_SIZE && body_position == STANDING_UP)
		body_position_pixel_y_offset = (current_size-1) * world.icon_size/2
>>>>>>> 007831d4293 (Makes sure body position y offset is updated if resized [NO GBP] (#75932))
	SEND_SIGNAL(src, COMSIG_LIVING_POST_UPDATE_TRANSFORM) // ...and we want the signal to be sent last.

/mob/living/proc/perform_update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/changed = FALSE

	if(resize != RESIZE_DEFAULT_SIZE)
		changed = TRUE
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = 2, easing = EASE_IN|EASE_OUT)
