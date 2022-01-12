/*
	The healthbar is displayed along the top of the client's screen
*/
/atom/movable/screen/meter/health
	name = "healthbar"

	alpha = 200
	color = COLOR_DARK_GRAY



	//The healthbar size is dynamic and scales with diminishing returns based on the user's health.
	//From 0 to 100, it is 2 pixels wide per health point, then from 100 to 200, 1 pixel for each additional health, and so on. The list below holds the data
	//This ensures that it gets bigger with more health, but never -toooo- big
	size_pixels = list("0" = 2,
	"100" = 1,
	"200" = 0.5,
	"400" = 0.3)


/atom/movable/screen/meter/health/Destroy()
	L = null
	GLOB.updatehealth_event.unregister(L, src, .proc/update)
	.=..()

/atom/movable/screen/meter/health/Initialize()
	. = ..()
	GLOB.updatehealth_event.register(L, src, .proc/update)
	set_health()


/atom/movable/screen/meter/health/proc/set_health()

	if (total_value != L.max_health)
		total_value = L.max_health
		if (!total_value && ishuman(L))
			var/mob/living/carbon/human/H = L
			if (H.species)
				total_value = H.species.total_health

		set_size()

/atom/movable/screen/meter/health/get_data()
	var/list/data = L.get_health_report()
	data["current"]	=	data["max"]	-	data["damage"]
	return data

/*
	This examines the mob and returns a report in this format:
	list("key" = numbervalue)

	The keys:
	"max": The mob's maximum health
	"damage": The total of damage taken
	"blocked": The total of health which is unrecoverable, limiting the max
*/
/mob/living/proc/get_health_report()
	return list ("max" = max_health, "damage" = 0, "blocked" = lasting_damage)

/mob/living/simple_animal/get_health_report()
	return list ("max" = max_health, "damage" = max_health - health, "blocked" = lasting_damage)

/mob/living/carbon/human/get_health_report()
	return species.get_health_report(src)


/datum/species/proc/get_health_report(mob/living/carbon/human/H)
	return list ("max" = H.max_health, "damage" = 0, "blocked" = H.lasting_damage)

/datum/species/necromorph/get_health_report(mob/living/carbon/human/H)
	var/list/things = get_weighted_total_limb_damage(H, TRUE)
	things["max"] = H.max_health
	return things

