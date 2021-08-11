/mob/living/simple_animal/hostile/zombie/proc/setup_visuals()
	var/list/jobs_to_pick = list()
	for(var/datum/job/job as anything in shuffle(SSjob.joinable_occupations))
		if(job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
			continue
		if(job.departments_bitflags & DEPARTMENT_BITFLAG_CENTRAL_COMMAND)
			continue
		jobs_to_pick += job
	var/datum/job/J = pick(jobs_to_pick)
	var/datum/outfit/O
	if(J.outfit)
		O = new J.outfit
		//They have claws now.
		O.r_hand = null
		O.l_hand = null

	var/icon/P = get_flat_human_icon_skyrat(null, J, /datum/species/zombie, SPECIES_ZOMBIE_HALLOWEEN, outfit_override = O)
	icon = P
	corpse = new(src)
	corpse.outfit = O
	corpse.mob_species = /datum/species/zombie
	corpse.mob_name = name
