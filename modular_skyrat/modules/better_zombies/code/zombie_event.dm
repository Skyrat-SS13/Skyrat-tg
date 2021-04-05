/datum/round_event_control/zombie_infestation //Admin only
	name = "HNZ-1 Pathogen Outbreak"
	typepath = /datum/round_event/zombie_infestation
	weight = 0
	dynamic_should_hijack = TRUE

/datum/round_event/zombie_infestation
	announceWhen = 30
	fakeable = TRUE
	var/infected = 1

/datum/round_event/zombie_infestation/setup()
	. = ..()
	infected = rand(1, 2)

/datum/round_event/zombie_infestation/start()
	. = ..()
	var/infectees = 0
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		if(infectees >= infected)
			break
		if(try_to_zombie_infect(H, TRUE))
			infectees++
			notify_ghosts("[H] has been infected by the HNZ-1 pathogen!", source = H)

/datum/round_event/zombie_infestation/announce(fake)
	priority_announce("Automated air filtration screeing systems have flagged an unknown pathogen in the air systems, biohazard quarantine is in effect.", "Viral Biohazard Alert", ANNOUNCER_ALIENS)
