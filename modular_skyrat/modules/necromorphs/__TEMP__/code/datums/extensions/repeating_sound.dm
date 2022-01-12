//Repeating sound support
//This datum is intended to play a sound repeatedly at a given interval over a given duration
//It is not intended for looping audio seamlessly, the sounds can have random gaps between repeats
/datum/proc/play_repeating_sound(_interval, duration, interval_variance = 0, _soundin, _vol, _vary, _extrarange, _falloff, _is_global, _use_pressure = TRUE)
	.=set_extension(src, /datum/extension/repeating_sound, _interval, duration, interval_variance, _soundin, _vol, _vary, _extrarange, _falloff, _is_global, _use_pressure)


/*
	Usage:
	To start and immediately play
	var/datum/extension/repeating_sound/mysound = new(30,100,0.15, src, soundfile, 80, 1)

	to stop
	mysound.stop()
	mysound = null (It will qdel itself)

	Pass in a list of soundfiles and one of them will be randomly picked in each iteration.
	They should probably all be around the same length, or at least all <= the smallest interval
*/
/datum/extension/repeating_sound

	flags = EXTENSION_FLAG_IMMEDIATE
	//The atom we play the sound from, but we'll use a weak reference instead of holding it in memory
	//To prevent GC issues
	var/source

	//Past this time we will no longer loop and delete ourselves
	var/end_time

	//How often to play
	var/interval

	//Should be in the range 0..1. 0 disables the feature, 1 allows interval to be anywhere from 0-2x the norm
	var/variance

	var/soundin
	var/list/soundlist
	var/vol
	var/vary
	var/extrarange
	var/falloff
	var/is_global
	var/use_pressure
	//Used to stop it early
	var/timer_handle

	var/self_id

/datum/extension/repeating_sound/New(var/atom/_source, var/_interval, var/duration, var/interval_variance = 0, var/_soundin, var/_vol, var/_vary, var/_extrarange, var/_falloff, var/_is_global, var/_use_pressure = TRUE)
	.=..()
	end_time = world.time + duration
	source = "\ref[_source]"
	interval = _interval
	variance = interval_variance
	soundin = _soundin
	if (islist(_soundin))
		soundlist = _soundin
	vol = _vol
	vary = _vary
	extrarange = _extrarange
	falloff = _falloff
	is_global = _is_global
	use_pressure = _use_pressure
	self_id = "\ref[src]"

	//When created we do our first sound immediately
	//If you want the first sound delayed, wrap it in a spawn call or something
	do_sound()

/datum/extension/repeating_sound/Destroy()
	.=..()
	if(timer_handle)
		stop(FALSE)	//Its already being deleted so prevent a loop here




/datum/extension/repeating_sound/proc/do_sound()
	timer_handle = null //This has been successfully called, that handle is no use now

	var/atom/playfrom = locate(source)
	if (QDELETED(playfrom))
		//Our source atom is gone, no more sounds
		stop()
		return

	//We're past the end time, no more sounds
	if (world.time > end_time)
		stop()
		return

	//Actually play the sound
	var/spath = soundin
	if (soundlist)

		spath = pick(soundlist)
	playsound(playfrom, spath, vol, vary, extrarange, falloff, is_global)

	//Setup the next sound
	var/nextinterval = interval
	if (variance)
		nextinterval *= rand_between(1-variance, 1+variance)

	//Set the next timer handle
	timer_handle = addtimer(CALLBACK(src, .proc/do_sound, TRUE), nextinterval, TIMER_STOPPABLE)



/datum/extension/repeating_sound/proc/stop(var/delete = TRUE)
	if (timer_handle)
		deltimer(timer_handle)

	if (delete && !QDELETED(src))
		remove_self()