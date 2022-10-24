GLOBAL_LIST_EMPTY(clockwork_datums)
GLOBAL_VAR_INIT(clock_power, 2500)
GLOBAL_VAR_INIT(clock_vitality, 200)
GLOBAL_VAR_INIT(clock_installed_cogs, 0)

/*
/datum/clockwork_holder // Consider reverting to the GLOB use // DEFINITELY DO THIS TOMORROW LMAO
	/// Reference to the human who holds this
	var/mob/living/carbon/human/human_holder

	/// Vitality; one of the stats, gain more from draining people, unsure if to keep or not
	var/vitality = 200
	/// Power; the more important stat, you need this to cast spells and do shit
	var/power = 2500
	/// How many cogs have been inserted into APCs
	var/installed_cogs = 0

/datum/clockwork_holder/Destroy(force, ...)
	GLOB.clockwork_datums.Remove(human_holder.mind)
	human_holder = null
	return ..()
*/
