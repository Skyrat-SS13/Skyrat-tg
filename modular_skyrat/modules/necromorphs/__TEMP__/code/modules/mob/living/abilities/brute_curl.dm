/*
	Brute curl up.
	Not really an attack.
		It can be triggered manually at any time
		It is also triggered automatically, with a longer force time, when

	While curled up, the brute has 75% more front and side armor, and that armor no longer exposes weak spots in the front.
	However, the brute can't move or turn while curled, vision range is reduced,  and its back is still as exposed as ever
*/


//Status flags for the curl extension
#define CURLING	1	//We are currently in the animation to enter/leave curled state
#define CURLED	2	//We are currently curled up
#define FORCE_COOLDOWN	3	//We are not currently curled up, but We were recently forced into a curl and can't be forced again for a while
								//However, we can still curl up willingly
/*
	Extension
*/
/datum/extension/curl
	name = "Curl"
	var/verb_name = "Curled"
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE
	var/mob/living/user

	var/status = 0
	var/force_time	=	0				//How long are we forced to stay curled up? There should always be a minimum on this to prevent spam. It shouldn't be
	var/forced_cooldown = 1.5 MINUTE		//After an automatic curl, how long before we can be forced to do it again?
	var/automatic = FALSE				//Did we curl up manually or automatically
	var/animtime = 1 SECOND //How long the animation to curl/uncurl actually takes

	//Extra runtime vars
	var/started_at	=	0				//When did we curl up
	var/stopped_at	=	0				//When did we uncurl
	var/vector2/cached_pixels
	var/matrix/cached_transform
	var/cached_view_range
	var/cached_view_offset
	var/force_cooldown_timer
	var/force_notify_timer

/datum/extension/curl/New(var/mob/living/_user, var/_automatic, var/_force_time, var/_animtime)
	..()
	user = _user
	force_time = _force_time
	automatic = _automatic
	animtime = _animtime
	animtime /= user.get_attack_speed_factor()

	start()


/datum/extension/curl/proc/start()
	started_at = world.time
	if (status != CURLED && status != CURLING)
		curl()

/datum/extension/curl/proc/curl()
	status = CURLING
	user.Stun(999999) //The user is stunned until they uncurl
	var/vector2/offset_dir = Vector2.NewFromDir(GLOB.reverse_dir[user.dir]) //Get the opposite of the direction its facing
	var/rotation = 35 * offset_dir.x * -1
	offset_dir *= 8 //Sprite will slide back a bit

	user.play_species_audio(user, SOUND_PAIN, 60, 1)

	//Lets cache some data too
	cached_pixels = get_new_vector(user.pixel_x, user.pixel_y)
	cached_transform = user.transform
	cached_view_range = user.view_range
	cached_view_offset = user.view_offset

	user.default_rotation = rotation
	user.default_scale = 0.9





	//AAAnd do the animation
	animate(user, transform = user.get_default_transform(), pixel_x = user.pixel_x + offset_dir.x, pixel_y = user.pixel_y + offset_dir.y, time = animtime)

	//Reduce the user's vision
	user.view_range -= 1
	user.view_offset = 32
	user.reset_view()

	user.visible_message("[user] curls up, protecting their front")

	//If the brute was forced into this curl, setup a timer to tell them when they can leave it
	if (automatic)
		force_notify_timer = addtimer(CALLBACK(src, /datum/extension/curl/proc/notify_forced), force_time)



	//Set the status after the animation finishes
	spawn(animtime)
		status = CURLED
		//Some extra little impact sounds for the brute's arms hitting the ground as it curls up
		user.play_species_audio(user, SOUND_FOOTSTEP, 40, 1)
		spawn(6) //One then the other
			user.play_species_audio(user, SOUND_FOOTSTEP, 40, 1)
	//Nothing farther happens for now


//In the finish proc, we uncurl. Lets assume safety checks are already done and we're clear to proceed
/datum/extension/curl/proc/finish()
	uncurl()
	//If this was a forced curl, we'll start a cooldown timer
	if (automatic)
		force_cooldown_timer = addtimer(CALLBACK(src, /datum/extension/curl/proc/finish_cooldown), forced_cooldown, TIMER_STOPPABLE)
	else
		//Otherwise, just immediately remove the extension
		finish_cooldown()


/datum/extension/curl/proc/uncurl()
	status = CURLING //We're in an animation, so set this again
	user.default_rotation = 0
	user.default_scale = 1
	animate(user, transform = user.get_default_transform(), pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, time = animtime)
	user.view_range = cached_view_range
	user.view_offset = cached_view_offset
	user.reset_view()
	spawn(animtime)
		user.stunned = 0 //The user is now no longer stunned
		status = FORCE_COOLDOWN

	release_vector(cached_pixels)



/datum/extension/curl/proc/finish_cooldown()
	if (force_cooldown_timer)
		deltimer(force_cooldown_timer)
	remove_extension(holder, /datum/extension/curl)



/datum/extension/curl/proc/notify_forced()
	uncurl()

//	Triggering
//------------------------
/atom/movable/proc/curl_verb()
	set name = "Curl"
	set category = "Abilities"


	return curl_ability()


//Assuming we're standing up, are we able to curl?
/atom/movable/proc/can_curl(var/automatic)
	//Check for an existing charge extension. that means a charge is already in progress or cooling down, don't repeat
	var/datum/extension/curl/E = get_extension(src, /datum/extension/curl)
	if(istype(E))
		if (E.status == CURLING || E.status == CURLED)
			return FALSE
		if (automatic && E.status == FORCE_COOLDOWN)
			return FALSE

	return TRUE

/mob/living/can_curl(var/atom/target, var/error_messages = TRUE)
	if (incapacitated())
		return FALSE

	.=..()


/atom/movable/proc/can_uncurl()
	var/datum/extension/curl/E = get_extension(src, /datum/extension/curl)
	if(istype(E))
		if (E.status == CURLED)
			if ((E.started_at + E.force_time) < world.time)
				return TRUE

	return FALSE

/atom/movable/proc/curl_ability(var/_automatic = FALSE, var/_force_time = 2 SECONDS, var/_animtime = 0.8 SECOND)
	//First of all, uncurling
	if (can_uncurl())
		var/datum/extension/curl/E = get_extension(src, /datum/extension/curl)
		E.finish()
		return

	//If we're not already curled, we're doing a curl
	if (!can_curl(_automatic))
		return

	//If there's an existing curl extension, we'll delete and remake it
	var/datum/extension/curl/E = get_extension(src, /datum/extension/curl)
	if(istype(E))
		E.finish_cooldown()

	//Ok we've passed all safety checks, let's commence curling!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/curl, _automatic, _force_time, _animtime)
	return TRUE