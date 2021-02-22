/*
	Autosound
	This simple extension periodically plays audio files.

	Mainly used for necromorphs that should be noisy, to prevent uncharacteristic stealth
	Make subtypes of it for whatever you want to do
*/
//auto_sound
//Auto Sound
//making sounds
///mob/living/carbon/human
/datum/extension/auto_sound
	name = "Auto Sound"
	base_type = /datum/extension/auto_sound
	expected_type = /mob/living/carbon/human
	flags = EXTENSION_FLAG_IMMEDIATE


	var/mob/living/carbon/human/user
	var/volume = VOLUME_MID
	var/extrarange = 2

	//A list of SOUND_X defines indicating what type of sound to play
	var/list/valid_sounds = list(SOUND_SHOUT)

	//If true, only play sounds when a client is controlling the mob
	//If false, only play when not controlled
	//If null, play in both states
	var/require_client = TRUE

	//How often to try to play sounds
	var/interval = 20 SECONDS

	//Random variation either side of interval
	var/variation = 0.15

	//Chance on each attempt, to actually play a sound
	var/probability = 50


	var/ongoing_timer
	var/started_at
	var/stopped_at



/datum/extension/auto_sound/New(var/mob/living/carbon/human/_user)
	.=..()
	user = _user
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/auto_sound/proc/start), 0)
	start()


/datum/extension/auto_sound/proc/start()
	started_at	=	world.time

	var/delay = (interval * (1+ (rand_between(-variation, variation))))
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/auto_sound/proc/try_play_sound), delay)


/datum/extension/auto_sound/proc/can_play_sound()
	if (QDELETED(user) || user.stat == DEAD)
		stop()
		return FALSE

	if (!isnull(require_client))
		var/hasclient = FALSE
		if (user.client)
			hasclient = TRUE
		if (hasclient != require_client)
			return FALSE

	return TRUE


/datum/extension/auto_sound/proc/try_play_sound()
	if (can_play_sound())

		if (prob(probability))
			user.play_species_audio(user, pick(valid_sounds), volume, TRUE, extrarange)

	//The safety check may have stopped us
	if (!stopped_at)

		var/delay = (interval * (1+ (rand_between(-variation, variation))))
		ongoing_timer = addtimer(CALLBACK(src, /datum/extension/auto_sound/proc/try_play_sound), delay)

/datum/extension/auto_sound/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	remove_extension(holder, base_type)




