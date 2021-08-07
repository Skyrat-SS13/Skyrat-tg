/mob/living/simple_animal/hostile/zombie
	var/no_corpse = FALSE
	var/list/possible_jobs = list(
		/datum/job/assistant,
		/datum/job/station_engineer,
		/datum/job/cook,
		/datum/job/bartender,
		/datum/job/chemist,
		/datum/job/doctor,
		/datum/job/virologist,
		/datum/job/clown,
		/datum/job/mime,
		/datum/job/scientist,
		/datum/job/cargo_technician,
		/datum/job/security_officer,
		/datum/job/security_medic,
		/datum/job/geneticist,
		/datum/job/botanist,
	)

/mob/living/simple_animal/hostile/zombie/nocorpse
	no_corpse = TRUE

/mob/living/simple_animal/hostile/zombie/proc/setup_visuals()
	var/datum/job/J = pick(possible_jobs)
	J = new()
	var/datum/outfit/O
	if(J.outfit)
		O = new J.outfit
		//They have claws now.
		O.r_hand = null
		O.l_hand = null

	var/icon/P = get_flat_human_icon_skyrat(null, J, /datum/species/zombie, "zombie", outfit_override = O)
	icon = P
	if(!no_corpse)
		corpse = new(src)
		corpse.outfit = O
		corpse.mob_species = /datum/species/zombie
		corpse.mob_name = name
