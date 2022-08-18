/datum/action/cooldown/alien/larva_evolve/Activate(atom/target)
	var/mob/living/carbon/alien/larva/larva = owner
	var/static/list/caste_options
	if(!caste_options)
		caste_options = list()

		// This can probably be genericized in the future.
		var/mob/hunter_path = /mob/living/carbon/alien/humanoid/hunter
		var/datum/radial_menu_choice/hunter = new()
		hunter.name = "Hunter"
		hunter.image  = image(icon = initial(hunter_path.icon), icon_state = initial(hunter_path.icon_state))
		hunter.info = span_info("Hunters are the most agile caste, tasked with hunting for hosts. \
			They are faster than a human and can even pounce, but are not much tougher than a drone.")

		caste_options["Hunter"] = hunter

		var/mob/sentinel_path = /mob/living/carbon/alien/humanoid/sentinel
		var/datum/radial_menu_choice/sentinel = new()
		sentinel.name = "Sentinel"
		sentinel.image  = image(icon = initial(sentinel_path.icon), icon_state = initial(sentinel_path.icon_state))
		sentinel.info = span_info("Sentinels are tasked with protecting the hive. \
			With their ranged spit, invisibility, and high health, they make formidable guardians \
			and acceptable secondhand hunters.")

		caste_options["Sentinel"] = sentinel

		var/mob/drone_path = /mob/living/carbon/alien/humanoid/drone
		var/datum/radial_menu_choice/drone = new()
		drone.name = "Drone"
		drone.image  = image(icon = initial(drone_path.icon), icon_state = initial(drone_path.icon_state))
		drone.info = span_info("Drones are the weakest and slowest of the castes, \
			but can grow into a praetorian and then queen if no queen exists, \
			and are vital to maintaining a hive with their resin secretion abilities.")

		caste_options["Drone"] = drone

	var/alien_caste = show_radial_menu(owner, owner, caste_options, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(QDELETED(src) || QDELETED(owner) || !IsAvailable() || isnull(alien_caste))
		return

	var/mob/living/carbon/alien/humanoid/new_xeno
	switch(alien_caste)
		if("Hunter")
			new_xeno = new /mob/living/carbon/alien/humanoid/hunter(larva.loc)
		if("Sentinel")
			new_xeno = new /mob/living/carbon/alien/humanoid/sentinel(larva.loc)
		if("Drone")
			new_xeno = new /mob/living/carbon/alien/humanoid/drone(larva.loc)
		else
			CRASH("Alien evolve was given an invalid / incorrect alien cast type. Got: [alien_caste]")

	larva.alien_evolve(new_xeno)
	return TRUE
