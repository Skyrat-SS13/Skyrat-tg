/*
	Individual Particle
*/
/obj/effect/particle
	name = "particle"
	mouse_opacity = 0
	opacity = FALSE
	density = FALSE
	dir = NORTH

	var/vector2/pixel_delta
	var/vector2/origin_pixels

	var/scale_x_start = 	1
	var/scale_y_start = 	1
	var/alpha_start	=	255

	var/scale_x_end = 	1
	var/scale_y_end = 	1
	var/alpha_end	=	0

	var/matrix/target_transform
	var/matrix/starting_transform

	var/lifespan	=	1.0 SECOND
	var/vector2/direction

	var/list/random_icons

/obj/effect/particle/New(var/location, var/vector2/direction, var/lifespan, var/range, var/vector2/offset, var/color)

	if (random_icons)
		icon_state = pick(random_icons)

	//Set starting pixel offset
	if (offset)
		pixel_x = offset.x
		pixel_y = offset.y
		release_vector(offset)



	//Rotate towards facing direction
	src.direction = direction
	if (direction)
		starting_transform = direction.Rotation()
	else
		starting_transform = matrix()
	target_transform = matrix(starting_transform)

	if (color)
		src.color = color

	//Set starting scale
	starting_transform.Scale(scale_x_start, scale_y_start)

	//Setup expiration
	src.lifespan = lifespan
	QDEL_IN(src, lifespan)

	//Lets calculate the destination pixel_loc
	origin_pixels = get_global_pixel_loc()
	pixel_delta = (direction * (range * WORLD_ICON_SIZE))
	release_vector(direction)

	//And the transform we'll eventually transition to
	target_transform.Scale(scale_x_end, scale_y_end)
	.=..()

/obj/effect/particle/Initialize()
	.=..()
	animation()

//I bladed this proc off into an async one to avoid hanging initialize()
/obj/effect/particle/proc/animation()
	set waitfor = FALSE
	//Lets start the animation!
	animate(src, transform = starting_transform, time = 0)
	animate(
	pixel_x = pixel_x+pixel_delta.x,
	pixel_y = pixel_y+pixel_delta.y,
	transform = target_transform,
	alpha = alpha_end,
	time = lifespan,
	flags = ANIMATION_LINEAR_TRANSFORM)


/obj/effect/particle/Destroy()
	release_vector(origin_pixels)
	release_vector(pixel_delta)
	.=..()