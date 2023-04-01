/*
/// Fully randomizes everything in the character.
/datum/preferences/proc/randomise_appearance_prefs(randomise_flags = ALL)
	if(randomise_flags & RANDOMIZE_SPECIES)
		var/rando_race = GLOB.species_list[pick(GLOB.roundstart_races)]
		pref_species = new rando_race()
	if(randomise_flags & RANDOMIZE_NAME)
		real_name = pref_species.random_name(gender, TRUE)

/// Randomizes the character according to preferences.
/datum/preferences/proc/apply_character_randomization_prefs(antag_override = FALSE)
	return

/datum/preferences/proc/random_species()
	var/random_species_type = GLOB.species_list[pick(GLOB.roundstart_races)]
	set_new_species(random_species_type)
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)

///Setup the random hardcore quirks and give the character the new score prize.
/datum/preferences/proc/hardcore_random_setup(mob/living/carbon/human/character)
	var/next_hardcore_score = select_hardcore_quirks()
	character.hardcore_survival_score = next_hardcore_score ** 1.2  //30 points would be about 60 score

/**
 * Goes through all quirks that can be used in hardcore mode and select some based on a random budget.
 * Returns the new value to be gained with this setup, plus the previously earned score.
 **/
/datum/preferences/proc/select_hardcore_quirks()
	. = 0

	var/quirk_budget = rand(8, 35)

	all_quirks = list() //empty it out

	var/list/available_hardcore_quirks = SSquirks.hardcore_quirks.Copy()

	while(quirk_budget > 0)
		for(var/i in available_hardcore_quirks) //Remove from available quirks if its too expensive.
			var/datum/quirk/available_quirk = i
			if(available_hardcore_quirks[available_quirk] > quirk_budget)
				available_hardcore_quirks -= available_quirk

		if(!available_hardcore_quirks.len)
			break

		var/datum/quirk/picked_quirk = pick(available_hardcore_quirks)

		var/picked_quirk_blacklisted = FALSE
		for(var/bl in SSquirks.quirk_blacklist) //Check if the quirk is blacklisted with our current quirks. quirk_blacklist is a list of lists.
			var/list/blacklist = bl
			if(!(picked_quirk in blacklist))
				continue
			for(var/iterator_quirk in all_quirks) //Go through all the quirks we've already selected to see if theres a blacklist match
				if((iterator_quirk in blacklist) && !(iterator_quirk == picked_quirk)) //two quirks have lined up in the list of the list of quirks that conflict with each other, so return (see quirks.dm for more details)
					picked_quirk_blacklisted = TRUE
					break
			if(picked_quirk_blacklisted)
				break

		if(picked_quirk_blacklisted)
			available_hardcore_quirks -= picked_quirk
			continue

		if(initial(picked_quirk.mood_quirk) && CONFIG_GET(flag/disable_human_mood)) //check for moodlet quirks
			available_hardcore_quirks -= picked_quirk
			continue

		all_quirks += initial(picked_quirk.name)
		quirk_budget -= available_hardcore_quirks[picked_quirk]
		. += available_hardcore_quirks[picked_quirk]
		available_hardcore_quirks -= picked_quirk


/datum/preferences/proc/update_preview_icon()
	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob
	var/highest_pref = 0
	for(var/job in job_preferences)
		if(job_preferences[job] > highest_pref)
			previewJob = SSjob.GetJob(job)
			highest_pref = job_preferences[job]

	if(previewJob)
		// Silicons only need a very basic preview since there is no customization for them.
		if(istype(previewJob,/datum/job/ai))
			parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = resolve_ai_icon(preferred_ai_core_display), dir = SOUTH))
			return
		if(istype(previewJob,/datum/job/cyborg))
			parent.show_character_previews(image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH))
			return

	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	apply_prefs_to(mannequin, TRUE)

	switch(preview_pref)
		if(PREVIEW_PREF_JOB)
			if(previewJob)
				mannequin.job = previewJob.title
				mannequin.dress_up_as_job(previewJob, TRUE)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_LOADOUT)
			mannequin.underwear_visibility = NONE
			equip_preference_loadout(mannequin, TRUE, previewJob)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_NAKED)
			mannequin.underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
	mannequin.update_body() //Unfortunately, due to a certain case we need to update this just in case

	parent.show_character_previews(new /mutable_appearance(mannequin))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)

//SKYRAT SPECIFIC PROCS

//This proc makes sure that we only have the parts that the species should have, add missing ones, remove extra ones(should any be changed)
//Also, this handles missing color keys
/datum/preferences/proc/validate_species_parts()
	if(!pref_species)
		return

	var/list/target_bodyparts = pref_species.default_mutant_bodyparts.Copy()

	//Remove all "extra" accessories
	for(var/key in mutant_bodyparts)
		if(!GLOB.sprite_accessories[key]) //That accessory no longer exists, remove it
			mutant_bodyparts -= key
			continue
		if(!pref_species.default_mutant_bodyparts[key])
			mutant_bodyparts -= key
			continue
		if(!GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]) //The individual accessory no longer exists
			mutant_bodyparts[key][MUTANT_INDEX_NAME] = pref_species.default_mutant_bodyparts[key]
		validate_color_keys_for_part(key) //Validate the color count of each accessory that wasnt removed

	//Add any missing accessories
	for(var/key in target_bodyparts)
		if(!mutant_bodyparts[key])
			var/datum/sprite_accessory/SA
			if(target_bodyparts[key] == ACC_RANDOM)
				SA = random_accessory_of_key_for_species(key, pref_species)
			else
				SA = GLOB.sprite_accessories[key][target_bodyparts[key]]
			var/final_list = list()
			final_list[MUTANT_INDEX_NAME] = SA.name
			final_list[MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
			mutant_bodyparts[key] = final_list

	if(!allow_advanced_colors)
		reset_colors()

/datum/preferences/proc/validate_color_keys_for_part(key)
	var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
	var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
	if(SA.color_src == USE_MATRIXED_COLORS && colorlist.len != 3)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
	else if (SA.color_src == USE_ONE_COLOR && colorlist.len != 1)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

/datum/preferences/proc/set_new_species(new_species_path)
	pref_species = new new_species_path()
	var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
	for(var/key in new_features)
		features[key] = new_features[key]
	mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
	body_markings = pref_species.get_random_body_markings(features)
	if(pref_species.use_skintones)
		features["uses_skintones"] = TRUE
	//We reset the quirk-based stuff
	augments = list()
	all_quirks = list()
	pref_scream = new /datum/scream_type/human
	//Reset cultural stuff
	pref_culture = pref_species.cultures[1]
	pref_location = pref_species.locations[1]
	pref_faction = pref_species.factions[1]
	try_get_common_language()
	validate_languages()

/datum/preferences/proc/reset_colors()
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(SA.always_color_customizable)
			continue
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

	for(var/zone in body_markings)
		var/list/bml = body_markings[zone]
		for(var/key in bml)
			var/datum/body_marking/BM = GLOB.body_markings[key]
			bml[key] = BM.get_default_color(features, pref_species)

/datum/preferences/proc/equip_preference_loadout(mob/living/carbon/human/H, just_preview = FALSE, datum/job/choosen_job, blacklist, initial)
	if(!ishuman(H))
		return
	var/list/items_to_pack = list()
	for(var/item_name in loadout)
		var/datum/loadout_item/LI = GLOB.loadout_items[item_name]
		var/obj/item/ITEM = LI.get_spawned_item(loadout[item_name])
		//Skip the item if the job doesn't match, but only if that not used for the preview
		if(!just_preview && (choosen_job && LI.restricted_roles && !(choosen_job.title in LI.restricted_roles)))
			continue
		if(!H.equip_to_appropriate_slot(ITEM,blacklist=blacklist,initial=initial))
			if(!just_preview)
				items_to_pack += ITEM
				//Here we stick it into a bag, if possible
				if(!H.equip_to_slot_if_possible(ITEM, ITEM_SLOT_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial=initial))
					//Otherwise - on the ground
					ITEM.forceMove(get_turf(H))
			else
				qdel(ITEM)
	return items_to_pack

//This needs to be a seperate proc because the character could not have the proper backpack during the moment of loadout equip
/datum/preferences/proc/add_packed_items(mob/living/carbon/human/H, list/packed_items, del_on_fail = TRUE)
	//Here we stick loadout items that couldn't be equipped into a bag.
	var/obj/item/back_item = H.back
	for(var/item in packed_items)
		var/obj/item/ITEM = item
		if(back_item)
			ITEM.forceMove(back_item)
		else if (del_on_fail)
			qdel(ITEM)
		else
			ITEM.forceMove(get_turf(H))

//For creating consistent icons for human looking simple animals
/proc/get_flat_human_icon_skyrat(icon_id, datum/job/job, datum/species/species_to_set, dummy_key, showDirs = GLOB.cardinals, outfit_override = null)
	var/static/list/humanoid_icon_cache = list()
	if(icon_id && humanoid_icon_cache[icon_id])
		return humanoid_icon_cache[icon_id]

	var/mob/living/carbon/human/dummy/body = generate_or_wait_for_human_dummy(dummy_key)

	if(species_to_set)
		body.set_species(species_to_set, TRUE)

	var/datum/outfit/outfit = outfit_override || job?.outfit
	if(job)
		body.dna.species.pre_equip_species_outfit(job, body, TRUE)
	if(outfit)
		body.equipOutfit(outfit, TRUE)

	var/icon/out_icon = icon('icons/effects/effects.dmi', "nothing")
	for(var/D in showDirs)
		var/icon/partial = getFlatIcon(body, defdir=D)
		out_icon.Insert(partial,dir=D)

	humanoid_icon_cache[icon_id] = out_icon
	dummy_key? unset_busy_human_dummy(dummy_key) : qdel(body)
	return out_icon
*/
