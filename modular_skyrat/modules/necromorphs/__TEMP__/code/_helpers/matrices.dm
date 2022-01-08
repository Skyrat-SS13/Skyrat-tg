/matrix/proc/TurnTo(old_angle, new_angle)
	. = new_angle - old_angle
	Turn(.) //BYOND handles cases such as -270, 360, 540 etc. DOES NOT HANDLE 180 TURNS WELL, THEY TWEEN AND LOOK LIKE SHIT




/atom/proc/shake_animation(var/intensity = 8)
	var/initial_transform = new/matrix(transform)
	var/init_px = pixel_x
	var/shake_dir = pick(-1, 1)
	var/rotation = 2+soft_cap(intensity, 1, 1, 0.94)
	var/offset = 1+soft_cap(intensity*0.3, 1, 1, 0.8)
	var/time = 2+soft_cap(intensity*0.3, 2, 1, 0.92)
	animate(src, transform=turn(transform, rotation*shake_dir), pixel_x=init_px + offset*shake_dir, time=1, flags = ANIMATION_PARALLEL)
	animate(transform=initial_transform, pixel_x=init_px, time=time, easing=ELASTIC_EASING)


/atom/proc/custom_shake_animation(var/rotation = 15, var/offset = 3, var/time = 10, var/y_offset = TRUE, var/parallel = TRUE)
	var/initial_transform = new/matrix(transform)
	var/vector2/init_px = get_new_vector(pixel_x, pixel_y)

	var/shake_dir = pick(-1, 1)

	var/vector2/newpix = get_new_vector(init_px.x, init_px.y)
	newpix.x += offset * pick(-1, 1)
	if (y_offset)
		newpix.y += offset * pick(-1, 1)

	var/aflags = 0
	if (parallel)
		aflags |= ANIMATION_PARALLEL
	animate(src, transform=turn(transform, rotation*shake_dir), pixel_x=newpix.x, pixel_y = newpix.y + offset*shake_dir, time=1, flags = aflags)
	animate(transform=initial_transform, pixel_x=init_px.x, pixel_y=init_px.y, time=(time-1), easing=ELASTIC_EASING)
	release_vector(newpix)
	release_vector(init_px)


//Duration is in deciseconds
//Strength is an offset in tiles
//Non integer values are perfectly fine for both inputs
/proc/shake_camera(mob/M, duration= 4, strength=1, var/flags = ANIMATION_PARALLEL)
	if(!istype(M) || !M.client || M.stat || isEye(M) || isAI(M))
		return

	spawn(1)
		if(!M.client)
			return

		var/px_y = rand(0, strength*world.icon_size) * pick(-1, 1)
		var/px_x = rand(0, strength*world.icon_size) * pick(-1, 1)
		var/vector2/init_px = get_new_vector(M.client.pixel_x, M.client.pixel_y)
		animate(M.client, pixel_x=init_px.x + px_x, pixel_y=init_px.y + px_y, time=1,flags = ANIMATION_PARALLEL)
		animate(pixel_x=init_px.x, pixel_y=init_px.y, time=duration, easing=ELASTIC_EASING)
		release_vector(init_px)

//The X pixel offset of this matrix
/matrix/proc/get_x_shift()
	. = c

//The Y pixel offset of this matrix
/matrix/proc/get_y_shift()
	. = f
// Color matrices:

//Luma coefficients suggested for HDTVs. If you change these, make sure they add up to 1.
#define LUMR 0.2126
#define LUMG 0.7152
#define LUMB 0.0722

//Still need color matrix addition, negation, and multiplication.

//Returns an identity color matrix which does nothing
/proc/color_identity()
	return list(1,0,0, 0,1,0, 0,0,1)

//Moves all colors angle degrees around the color wheel while maintaining intensity of the color and not affecting whites
//TODO: Need a version that only affects one color (ie shift red to blue but leave greens and blues alone)
/proc/color_rotation(angle)
	if(angle == 0)
		return color_identity()
	angle = Clamp(angle, -180, 180)
	var/cos = cos(angle)
	var/sin = sin(angle)

	var/constA = 0.143
	var/constB = 0.140
	var/constC = -0.283
	return list(
	LUMR + cos * (1-LUMR) + sin * -LUMR, LUMR + cos * -LUMR + sin * constA, LUMR + cos * -LUMR + sin * -(1-LUMR),
	LUMG + cos * -LUMG + sin * -LUMG, LUMG + cos * (1-LUMG) + sin * constB, LUMG + cos * -LUMG + sin * LUMG,
	LUMB + cos * -LUMB + sin * (1-LUMB), LUMB + cos * -LUMB + sin * constC, LUMB + cos * (1-LUMB) + sin * LUMB
	)

//Makes everything brighter or darker without regard to existing color or brightness
/proc/color_brightness(power)
	power = Clamp(power, -255, 255)
	power = power/255

	return list(1,0,0, 0,1,0, 0,0,1, power,power,power)

/var/list/delta_index = list(
	0,    0.01, 0.02, 0.04, 0.05, 0.06, 0.07, 0.08, 0.1,  0.11,
	0.12, 0.14, 0.15, 0.16, 0.17, 0.18, 0.20, 0.21, 0.22, 0.24,
	0.25, 0.27, 0.28, 0.30, 0.32, 0.34, 0.36, 0.38, 0.40, 0.42,
	0.44, 0.46, 0.48, 0.5,  0.53, 0.56, 0.59, 0.62, 0.65, 0.68,
	0.71, 0.74, 0.77, 0.80, 0.83, 0.86, 0.89, 0.92, 0.95, 0.98,
	1.0,  1.06, 1.12, 1.18, 1.24, 1.30, 1.36, 1.42, 1.48, 1.54,
	1.60, 1.66, 1.72, 1.78, 1.84, 1.90, 1.96, 2.0,  2.12, 2.25,
	2.37, 2.50, 2.62, 2.75, 2.87, 3.0,  3.2,  3.4,  3.6,  3.8,
	4.0,  4.3,  4.7,  4.9,  5.0,  5.5,  6.0,  6.5,  6.8,  7.0,
	7.3,  7.5,  7.8,  8.0,  8.4,  8.7,  9.0,  9.4,  9.6,  9.8,
	10.0)

//Exxagerates or removes brightness
/proc/color_contrast(value)
	value = Clamp(value, -100, 100)
	if(value == 0)
		return color_identity()

	var/x = 0
	if (value < 0)
		x = 127 + value / 100 * 127;
	else
		x = value % 1
		if(x == 0)
			x = delta_index[value]
		else
			x = delta_index[value] * (1-x) + delta_index[value+1] * x//use linear interpolation for more granularity.
		x = x * 127 + 127

	var/mult = x / 127
	var/add = 0.5 * (127-x) / 255
	return list(mult,0,0, 0,mult,0, 0,0,mult, add,add,add)

//Exxagerates or removes colors
/proc/color_saturation(value as num)
	if(value == 0)
		return color_identity()
	value = Clamp(value, -100, 100)
	if(value > 0)
		value *= 3
	var/x = 1 + value / 100
	var/inv = 1 - x
	var/R = LUMR * inv
	var/G = LUMG * inv
	var/B = LUMB * inv

	return list(R + x,R,R, G,G + x,G, B,B,B + x)


//This proc moves mover to target instantly, but plays an animation to make it appear like they're sliding there smoothly.
//This movement is effectively teleporting, it will ignore any obstacles. Do any checks before moving
//Speed is in metres (tiles) per second
//Client lag is a divisor on client animation time. Lower values will cause it to take longer to catch up with the mob, this is a cool effect for conveying speed
/proc/animate_movement(var/atom/movable/mover, var/atom/target, var/speed, var/client_lag = 1.0)
	var/vector2/target_pixel_loc = target.get_global_pixel_loc()
	target_pixel_loc.x += mover.default_pixel_x
	target_pixel_loc.y += mover.default_pixel_y
	var/vector2/pixel_delta = mover.get_global_pixel_loc() - target_pixel_loc //This is an inverse delta that gives the offset FROM target TO mover
	var/vector2/cached_pixels = get_new_vector(mover.default_pixel_x, mover.default_pixel_y)
	var/pixel_distance = pixel_delta.Magnitude()
	var/pixels_per_decisecond = (world.icon_size * speed) * 0.1




	//Lets handle clients too
	var/client/C = mover.get_client()
	var/mob/living/L
	//var/vector2/client_pixel_delta
	var/vector2/cached_client_pixels
	if (C)
		L = mover
		L.lock_view = TRUE
		cached_client_pixels = get_new_vector(C.pixel_x, C.pixel_y)


	//Okay, lets set ourselves there
	mover.forceMove(target)
	mover.pixel_x += pixel_delta.x
	mover.pixel_y += pixel_delta.y
	if (C)
		C.pixel_x += pixel_delta.x
		C.pixel_y += pixel_delta.y

	//If we were to stop now, the mover would technically be in the new tile, but visually appear to have not moved at all,
	//due to being pixel-offset to exactly where we came from

	var/animtime  = (pixel_distance / pixels_per_decisecond)
	animate(mover, pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, time = animtime,flags = ANIMATION_PARALLEL)
	if (C)
		animate(C, pixel_x = cached_client_pixels.x, pixel_y = cached_client_pixels.y, time = (animtime / client_lag),flags = ANIMATION_PARALLEL)

	//Lets make sure view stays locked until we're done animating client
	if (C && istype(L))
		spawn(animtime / client_lag)
			L.lock_view = FALSE

	release_vector(target_pixel_loc)
	release_vector(pixel_delta)
	release_vector(cached_pixels)
	release_vector(cached_client_pixels)

//Returns the rotation necessary to point source's forward_direction at target
//The default value of south, will point the source's feet at the target
/proc/rotation_to_target(var/atom/source, var/atom/target, var/forward_direction = SOUTH)
	var/vector2/direction = Vector2.DirectionBetween(source, target)
	var/angle = direction.AngleFrom(Vector2.FromDir(forward_direction))
	release_vector(direction)
	return angle


/obj/proc/animate_fade_in(var/animtime = 10)
	alpha = 0
	animate(src, alpha = 255, time = animtime, flags = ANIMATION_PARALLEL)	//Cool fade in effect

//Clear references before calling this
/obj/proc/animate_fade_out(var/animtime = 10)
	set waitfor = FALSE
	animate(src, alpha = 0, time = animtime, flags = ANIMATION_PARALLEL)	//Cool fade in effect
	sleep(animtime)
	qdel(src)

//Returns a transform with all vars set to their default
/atom/proc/get_default_transform()
	var/matrix/M = matrix()
	M.Scale(default_scale)
	M.Turn(default_rotation)
	return M


//Returns a transform with all vars set to their default
/atom/proc/animate_to_default(var/animtime = 5, var/reset_pixels = TRUE)

	if (animtime > 0)
		animate(src, transform = get_default_transform(), pixel_x = (reset_pixels ? default_pixel_x : pixel_x), pixel_y = (reset_pixels ? default_pixel_y : pixel_y), alpha = default_alpha, time = animtime)
	else
		transform = get_default_transform()
		if (reset_pixels)
			pixel_x = default_pixel_x
			pixel_y = default_pixel_y
		alpha = default_alpha

#undef LUMR
#undef LUMG
#undef LUMB