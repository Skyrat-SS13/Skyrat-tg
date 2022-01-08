/mob/living/carbon/human/proc/stop_gunning()
	set name = "Stop Gunning"
	set category = "Asteroid Defense System"
	var/datum/extension/asteroidcannon/AC = get_extension(GLOB.asteroidcannon, /datum/extension/asteroidcannon)
	AC.remove_gunner()

/mob/living/carbon/human/proc/recenter_gunning()
	set name = "Jump To Cannon"
	set category = "Asteroid Defense System"
	var/datum/extension/asteroidcannon/AC = get_extension(GLOB.asteroidcannon, /datum/extension/asteroidcannon)
	AC.recenter()