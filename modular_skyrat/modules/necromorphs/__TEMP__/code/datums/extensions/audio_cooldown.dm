//This extension is a low cost way of adding per-datum cooldowns for various types of audio files

/*
	Future TODO: Refactor this as a more generic cooldown manager, its not just for audio
*/
/datum/extension/audio_cooldown
	base_type = /datum/extension/audio_cooldown
	expected_type = /datum
	flags = EXTENSION_FLAG_IMMEDIATE
	var/list/times = list()



//Sets a time for when this category can be next used
/datum/proc/set_audio_cooldown(var/category, var/cooldown)
	var/datum/extension/audio_cooldown/AC = get_extension(src, /datum/extension/audio_cooldown)
	if (!AC)
		AC = set_extension(src, /datum/extension/audio_cooldown)

	AC.times[category] = max(AC.times[category], world.time + cooldown)

//Checks if a category is off cooldown.
/datum/proc/check_audio_cooldown(var/category)
	.=FALSE
	var/datum/extension/audio_cooldown/AC = get_extension(src, /datum/extension/audio_cooldown)
	if (!AC)
		return TRUE //If no AC exists, then nothing is cooling. We won't create it unless its needed

	var/next_allowed = AC.times[category]
	if (!next_allowed || next_allowed < world.time)
		.= TRUE

		//If its off cooldown we don't need to store that data anymore
		AC.times -= category

		//And maybe we don't need to store ANY data anymore
		if (!LAZYLEN(AC.times))
			remove_extension(src, /datum/extension/audio_cooldown)