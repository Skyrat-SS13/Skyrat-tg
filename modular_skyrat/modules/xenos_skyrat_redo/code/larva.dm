/// SKYRAT MODULE SKYRAT_XENO_REDO

/datum/action/cooldown/alien/larva_evolve/Activate(atom/target)
	var/mob/living/carbon/alien/larva/larva = owner
	var/static/list/caste_options
	if(!caste_options)
		caste_options = list()

		// This --can probably-- (will not) be genericized in the future.
		var/datum/radial_menu_choice/runner = new()
		runner.name = "Runner"
		runner.image  = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_runner")
		runner.info = span_info("Runners are the most agile caste, the short stature of running on all fours \
		gives them great speed, the ability to dodge projectiles, and allows them to tackle while holding throw and clicking. \
		Eventually, runners can evolve onwards into the fearsome ravager, should the hive permit it.")

		caste_options["Runner"] = runner

		var/datum/radial_menu_choice/sentinel = new()
		sentinel.name = "Sentinel"
		sentinel.image  = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_sentinel")
		sentinel.info = span_info("Sentinels are a caste similar in shape to a drone, forfeiting the ability to \
		become royalty in exchange for spitting either acid, or a potent neurotoxin. They aren't as strong in close combat \
		as the other options, but can eventually evolve into a more dangerous form of acid spitter, should the hive have capacity.")

		caste_options["Sentinel"] = sentinel

		var/datum/radial_menu_choice/defender = new()
		defender.name = "Defender"
		defender.image  = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_defender")
		defender.info = span_info("Slow, tough, hard hitting, the defender is well and capable of what the name implies, \
		the defender's thick armor allows it to take a few more hits than other castes, which can be paired with a deadly tail club \
		and ability to make short charges to cause some real damage. Eventually, it will be able to evolve into the feared crusher, \
		destroyer of stationary objects should the hive have the capacity.")

		caste_options["Defender"] = defender

		var/datum/radial_menu_choice/drone = new()
		drone.name = "Drone"
		drone.image  = image(icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi', icon_state = "preview_drone")
		drone.info = span_info("Drones are a somewhat weak, although fairly quick caste that fills a mainly \
		support role in a hive, having a higher plasma capacity than most first evolutions, and the ability to \
		make a healing aura for nearby xenos. Drones are the only caste that can evolve into both praetorians and \
		queens, though only one queen and one praetorian may exist at any time.")

		caste_options["Drone"] = drone

	var/alien_caste = show_radial_menu(owner, owner, caste_options, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(QDELETED(src) || QDELETED(owner) || !IsAvailable() || isnull(alien_caste))
		return

	var/mob/living/carbon/alien/humanoid/new_xeno
	switch(alien_caste)
		if("Runner")
			new_xeno = new /mob/living/carbon/alien/humanoid/skyrat/runner(larva.loc)
		if("Sentinel")
			new_xeno = new /mob/living/carbon/alien/humanoid/skyrat/sentinel(larva.loc)
		if("Defender")
			new_xeno = new /mob/living/carbon/alien/humanoid/skyrat/defender(larva.loc)
		if("Drone")
			new_xeno = new /mob/living/carbon/alien/humanoid/skyrat/drone(larva.loc)
		else
			CRASH("Alien evolve was given an invalid / incorrect alien cast type. Got: [alien_caste]")

	larva.alien_evolve(new_xeno)
	return TRUE
