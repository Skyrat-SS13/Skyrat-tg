/datum/station_trait/overflow_job_bureaucracy
	weight = 0

/datum/station_trait/overflow_job_bureaucracy/set_overflow_job_override(datum/source)
	var/datum/job/picked_job = pick(SSjob.joinable_occupations)
	while(picked_job.veteran_only)
		picked_job = pick(SSjob.joinable_occupations)
	chosen_job_name = lowertext(picked_job.title) // like Chief Engineers vs like chief engineers
	SSjob.set_overflow_role(picked_job.type)

/datum/station_trait/random_event_weight_modifier/rad_storms
	weight = 0
	max_occurrences_modifier = 0

/datum/station_trait/cybernetic_revolution
	name = "Cybernetic Revolution (DISABLED)"
	weight = 0

/datum/station_trait/cybernetic_revolution/New()
	log_game("[src.name] attempted to run, but was disabled.")

/datum/station_trait/birthday
	weight = 3
