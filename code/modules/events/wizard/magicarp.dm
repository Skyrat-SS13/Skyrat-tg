/datum/round_event_control/wizard/magicarp //these fish is loaded
	name = "Magicarp"
	weight = 1
	typepath = /datum/round_event/carp_migration/wizard
	max_occurrences = 1
	earliest_start = 0 MINUTES
	description = "Summons a school of carps with magic projectiles."

<<<<<<< HEAD
/datum/round_event/wizard/magicarp
	announce_when = 3
	start_when = 50

/datum/round_event/wizard/magicarp/setup()
	start_when = rand(40, 60)

/datum/round_event/wizard/magicarp/announce(fake)
	priority_announce("Unknown magical entities have been detected near [station_name()], please stand-by.", "Lifesign Alert")

/datum/round_event/wizard/magicarp/start()
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(5))
			new /mob/living/simple_animal/hostile/carp/ranged/chaos(C.loc)
		else
			new /mob/living/simple_animal/hostile/carp/ranged(C.loc)
=======
/datum/round_event/carp_migration/wizard
	carp_type = /mob/living/basic/carp/magic
	boss_type = /mob/living/basic/carp/magic/chaos
	fluff_signal = "Unknown magical entities"
>>>>>>> 6200bc23602 (Basic Mob Carp IX: Carp Rifts & Migration (#72265))
