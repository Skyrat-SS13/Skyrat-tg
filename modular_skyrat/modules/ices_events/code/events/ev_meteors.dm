#define METEOR_WAVE_MIN_NOTICE (180 EVENT_SECONDS)
#define METEOR_WAVE_MAX_NOTICE (300 EVENT_SECONDS)
#define METEOR_WAVE_DURATION (76 EVENT_SECONDS)
#define METEOR_WAVE_NORMAL_WEIGHT 85
#define METEOR_WAVE_THREATENING_WEIGHT 15
#define METEOR_TICKS_BETWEEN_WAVES 3
#define METEORS_PER_WAVE 5

/datum/round_event_control/meteor_wave/ices
	name = "Meteor Wave: ICES"
	typepath = /datum/round_event/meteor_wave/ices
	weight = 16
	min_players = 40
	max_occurrences = 1
	earliest_start = 75 MINUTES
	category = EVENT_CATEGORY_SPACE
	description = "A meteor wave, severity is a surprise!"
	map_flags = EVENT_SPACE_ONLY

/datum/round_event/meteor_wave
	announce_when = 1

/datum/round_event/meteor_wave/ices
	wave_name = null

/datum/round_event/meteor_wave/ices/determine_wave_type()
	var/filter_threshold = get_active_player_count(alive_check = FALSE, afk_check = TRUE, human_check = FALSE)
	if(filter_threshold < 75)
		wave_name = "normal"
	if(check_holidays(HALLOWEEN))
		wave_name = "spooky"
		log_game("EVENT: Meteor Wave: ICES is spookier than usual!")
		deadchat_broadcast("Something feels awfully spooky today!", message_type=DEADCHAT_ANNOUNCEMENT)
	if(!wave_name)
		wave_name = pick_weight(list(
			"normal" = METEOR_WAVE_NORMAL_WEIGHT,
			"threatening" = METEOR_WAVE_THREATENING_WEIGHT))
	switch(wave_name)
		if("normal")
			wave_type = GLOB.meteors_normal
		if("threatening")
			wave_type = GLOB.meteors_threatening
		if("spooky")
			wave_type = GLOB.meteorsSPOOKY
		else
			stack_trace("Wave name of [wave_name] not recognised or disallowed by config.")
			kill()

	log_game("EVENT: Meteor Wave: ICES requested intensity is [wave_name]")

/datum/round_event/meteor_wave/New()
	. = ..()
	start_when = rand(METEOR_WAVE_MIN_NOTICE, METEOR_WAVE_MAX_NOTICE)
	end_when = start_when + METEOR_WAVE_DURATION

/datum/round_event/meteor_wave/announce(fake)
	priority_announce("Meteors have been detected on collision course with the station. The energy field generator is disabled or missing. First collision in approximately [start_when * 2] seconds. Ensure all sensitive areas and equipment are shielded.", "Meteor Alert", ANNOUNCER_METEORS)
	if(wave_name == "threatening" || wave_name == "spooky")
		INVOKE_ASYNC(SSsecurity_level, TYPE_PROC_REF(/datum/controller/subsystem/security_level/, minimum_security_level), SEC_LEVEL_ORANGE, TRUE, FALSE)

/datum/round_event/meteor_wave/tick()
	if(ISMULTIPLE(activeFor, METEOR_TICKS_BETWEEN_WAVES))
		spawn_meteors(METEORS_PER_WAVE, wave_type) //meteor list types defined in gamemode/meteor/meteors.dm

#undef METEOR_WAVE_MIN_NOTICE
#undef METEOR_WAVE_MAX_NOTICE
#undef METEOR_WAVE_DURATION
#undef METEOR_TICKS_BETWEEN_WAVES
#undef METEORS_PER_WAVE
#undef METEOR_WAVE_NORMAL_WEIGHT
#undef METEOR_WAVE_THREATENING_WEIGHT
