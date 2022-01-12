/*
	This extension attempts to detect when its holder moves under certain conditions, and triggers an event appropriately.

	The default behaviour attempts to trigger when the holder moves under their own power, or they are physically dragged by another mob.
	It will rule out movement caused by:
		-Being thrown (impulses, knockback, etc)
		-Kinesis
*/

/datum/extension/conditionalmove
	name = "Conditional move"
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	var/mob/living/L

	//Do we trigger when dragged by other mobs?
	var/allow_grabbed = TRUE

	var/reset_animate = TRUE

/datum/extension/conditionalmove/New(var/datum/holder)
	.=..()
	L = holder
	GLOB.moved_event.register(holder, src, /datum/extension/conditionalmove/proc/handle_move)

/datum/extension/conditionalmove/Destroy()
	GLOB.moved_event.unregister(holder, src, /datum/extension/conditionalmove/proc/handle_move)
	.=..()

/datum/extension/conditionalmove/proc/handle_move(var/atom/movable/am, var/atom/old_loc, var/atom/new_loc)
	if (check_move(am, old_loc, new_loc))
		conditional_move(am, old_loc, new_loc)

/datum/extension/conditionalmove/proc/check_move(var/atom/movable/am, var/atom/old_loc, var/atom/new_loc)

	//If we're being grabbed or pulled, that overrides other things
	//Grabbed by is a list of grabs
	//Pulledby is a single reference to another mob
	if (L.grabbed_by.len || L.pulledby)
		return allow_grabbed

	//Its being manipulated by kinesis, nope
	if (am.kinesis_gripped())
		return FALSE

	//We're currently flying through the air
	if (L.throwing)
		return FALSE

	//If the mob is unable to move, then it didn't move.
	if (L.incapacitated(INCAPACITATION_IMMOBILE))
		return FALSE

	//If we get here, things are fine
	return TRUE




//This is called when everything works. Override it in subtypes
/datum/extension/conditionalmove/proc/conditional_move(var/atom/movable/am, var/atom/old_loc, var/atom/new_loc)
	return


/datum/extension/conditionalmove/proc/end()
	if (holder)
		remove_extension(holder, type)


//Pixel restore subtype

/datum/extension/conditionalmove/pixel_align
	var/pixels_per_step = 1
	var/animate_time = 3


/datum/extension/conditionalmove/pixel_align/conditional_move(var/atom/movable/am, var/atom/old_loc, var/atom/new_loc)
	var/vector2/target_pixels = get_new_vector(L.default_pixel_x, L.default_pixel_y)

	//If we are at the target pixel coords, we are done
	if (L.pixel_x == target_pixels.x && L.pixel_y == target_pixels.y)
		end()
		release_vector(target_pixels)
		return

	//Alright, lets move towards them
	var/vector2/delta = get_new_vector(target_pixels.x - L.pixel_x, target_pixels.y - L.pixel_y)
	delta.SelfClampMag(0, pixels_per_step)
	animate(L, pixel_x = L.pixel_x + delta.x, pixel_y = L.pixel_y + delta.y, time = animate_time)

	release_vector(delta)
	release_vector(target_pixels)