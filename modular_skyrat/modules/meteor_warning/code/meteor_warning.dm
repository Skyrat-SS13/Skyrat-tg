#define METEOR_WAVE_MIN_NOTICE 210
#define METEOR_WAVE_MAX_NOTICE 240
#define METEOR_WAVE_DURATION 37

/datum/round_event/meteor_wave/New()
	..()
	start_when = rand(METEOR_WAVE_MIN_NOTICE, METEOR_WAVE_MAX_NOTICE)
	end_when = start_when + METEOR_WAVE_DURATION

/datum/round_event/meteor_wave/announce(fake)
	priority_announce("Meteors have been detected on collision course with the station. The early warning system estimates first collision in approximately [start_when * 2] seconds. Ensure all sensitive areas and equipment are shielded.", "Meteor Alert", ANNOUNCER_METEORS)

#undef METEOR_WAVE_MIN_NOTICE
#undef METEOR_WAVE_MAX_NOTICE
#undef METEOR_WAVE_DURATION
