/datum/job/detective/after_latejoin_spawn(mob/living/spawning)
	. = ..()
	if(GLOB.families_handler) // If Families is active, put this guy in the Security Family.
		var/datum/antagonist/gang/security/security_gangster_datum = new
		security_gangster_datum.handler = GLOB.families_handler
		spawning.mind.add_antag_datum(security_gangster_datum)


/datum/job/head_of_security/after_latejoin_spawn(mob/living/spawning)
	. = ..()
	if(GLOB.families_handler) // If Families is active, put this guy in the Security Family, and make him a Leader because the HoS runs Security.
		var/datum/antagonist/gang/security/security_gangster_datum = new
		security_gangster_datum.starter_gangster = TRUE
		security_gangster_datum.handler = GLOB.families_handler
		spawning.mind.add_antag_datum(security_gangster_datum)

/datum/job/warden/after_latejoin_spawn(mob/living/spawning)
	. = ..()
	if(GLOB.families_handler) // If Families is active, put this guy in the Security Family, and make him a Leader because the Warden runs Security for the HoS.
		var/datum/antagonist/gang/security/security_gangster_datum = new
		security_gangster_datum.starter_gangster = TRUE
		security_gangster_datum.handler = GLOB.families_handler
		spawning.mind.add_antag_datum(security_gangster_datum)

/datum/job/brigoff/after_latejoin_spawn(mob/living/spawning)
	. = ..()
	if(GLOB.families_handler) // If Families is active, put this guy in the Security Family.
		var/datum/antagonist/gang/security/security_gangster_datum = new
		security_gangster_datum.handler = GLOB.families_handler
		spawning.mind.add_antag_datum(security_gangster_datum)

/datum/job/security_medic/after_latejoin_spawn(mob/living/spawning)
	. = ..()
	if(GLOB.families_handler) // If Families is active, put this guy in the Security Family.
		var/datum/antagonist/gang/security/security_gangster_datum = new
		security_gangster_datum.handler = GLOB.families_handler
		spawning.mind.add_antag_datum(security_gangster_datum)
