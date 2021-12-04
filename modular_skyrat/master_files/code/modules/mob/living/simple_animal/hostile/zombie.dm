/mob/living/simple_animal/hostile/zombie
	var/no_corpse = FALSE
	var/list/possible_jobs = list(
		"Assistant",
		"Station Engineer",
		"Cook",
		"Bartender",
		"Chemist",
		"Medical Doctor",
		"Virologist",
		"Clown",
		"Mime",
		"Scientist",
		"Cargo Technician",
		"Security Officer",
		"Security Medic",
		"Geneticist",
		"Botanist",
	)

/mob/living/simple_animal/hostile/zombie/nocorpse
	no_corpse = TRUE

/mob/living/simple_animal/hostile/zombie/proc/setup_visuals()
	var/picked_job = pick(possible_jobs)
	var/datum/job/zombie_job = SSjob.GetJob(picked_job)
	var/datum/outfit/zombie_outfit
	if(zombie_job.outfit)
		zombie_outfit = new zombie_job.outfit
		//They have claws now.
		zombie_outfit.r_hand = null
		zombie_outfit.l_hand = null

/mob/living/simple_animal/hostile/zombie/cheesezombie
	name = "Cheese Zombie"
	desc = "Oh God it stinks!!"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "cheesezomb"
	icon_living = "cheesezomb"
	maxHealth = 100
	health = 100
	del_on_death = 1
	loot = list(/obj/effect/gibspawner/human)

