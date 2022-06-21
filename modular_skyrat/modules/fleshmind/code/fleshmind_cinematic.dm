/// A malfunctioning AI has overriden the shuttle!
/datum/cinematic/fleshmind
	cleanup_time = 10 SECONDS

/datum/cinematic/fleshmind/play_cinematic()
	flick("intro_malf", screen)
	stoplag(7.6 SECONDS)
	special_callback?.Invoke()

/datum/cinematic/malf
