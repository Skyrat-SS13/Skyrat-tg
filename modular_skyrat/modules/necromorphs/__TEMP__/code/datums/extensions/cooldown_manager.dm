//This extension is a low cost way of adding per-datum cooldowns for various types of audio files
/datum/extension/cooldown
	base_type = /datum/extension/cooldown
	expected_type = /datum
	flags = EXTENSION_FLAG_IMMEDIATE
	var/list/times = list()



//Sets a time for when this category can be next used
/datum/proc/set_cooldown(var/category, var/cooldown)
	var/datum/extension/cooldown/AC = get_extension(src, /datum/extension/cooldown)
	if (!AC)
		AC = set_extension(src, /datum/extension/cooldown)

	AC.times[category] = max(AC.times[category], world.time + cooldown)

//Checks if a category is off cooldown.
/datum/proc/check_cooldown(var/category)
	.=FALSE
	var/datum/extension/cooldown/AC = get_extension(src, /datum/extension/cooldown)
	if (!AC)
		return TRUE //If no AC exists, then nothing is cooling. We won't create it unless its needed

	var/next_allowed = AC.times[category]
	if (!next_allowed || next_allowed < world.time)
		.= TRUE

		//If its off cooldown we don't need to store that data anymore
		AC.times -= category

		//And maybe we don't need to store ANY data anymore
		if (!LAZYLEN(AC.times))
			remove_extension(src, /datum/extension/cooldown)