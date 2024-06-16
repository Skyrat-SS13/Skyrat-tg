/// -- Outfit and mob helpers to equip our loadout items. --

/// An empty outfit we fill in with our loadout items to dress our dummy.
/datum/outfit/player_loadout
	name = "Player Loadout"

/datum/outfit/player_loadout/equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	user.equip_outfit_and_loadout(new /datum/outfit(), user.client.prefs)

/*
 * Actually equip our mob with our job outfit and our loadout items.
 * Loadout items override the pre-existing item in the corresponding slot of the job outfit.
 * Some job items are preserved after being overridden - belt items, ear items, and glasses.
 * The rest of the slots, the items are overridden completely and deleted.
 *
 * Plasmamen are snowflaked to not have any envirosuit pieces removed just in case.
 * Their loadout items for those slots will be added to their backpack on spawn.
 *
 * outfit - the job outfit we're equipping
 * visuals_only - whether we call special equipped procs, or if we just look like we equipped it
 * preference_source - the preferences of the thing we're equipping
 */
/mob/living/carbon/human/proc/equip_outfit_and_loadout(datum/outfit/outfit, datum/preferences/preference_source, visuals_only = FALSE, datum/job/equipping_job)
	if (!preference_source)
		equipOutfit(outfit, visuals_only) // no prefs for loadout items, but we should still equip the outfit.
		return FALSE

	var/datum/outfit/equipped_outfit

	if(ispath(outfit))
		equipped_outfit = new outfit()
	else if(istype(outfit))
		equipped_outfit = outfit
	else
		CRASH("Outfit passed to equip_outfit_and_loadout was neither a path nor an instantiated type!")

	var/override_preference = preference_source.read_preference(/datum/preference/choiced/loadout_override_preference)

	var/list/loadout_datums = loadout_list_to_datums(preference_source?.loadout_list)

	if(override_preference == LOADOUT_OVERRIDE_CASE && !visuals_only)
		var/obj/item/storage/briefcase/empty/briefcase = new(loc)

		for(var/datum/loadout_item/item as anything in loadout_datums)
			if(item.restricted_roles && equipping_job && !(equipping_job.title in item.restricted_roles))
				if(client)
					to_chat(src, span_warning("You were unable to get a loadout item([initial(item.item_path.name)]) due to job restrictions!"))
				continue

			if(item.blacklisted_roles && equipping_job && (equipping_job.title in item.blacklisted_roles))
				if(client)
					to_chat(src, span_warning("You were unable to get a loadout item([initial(item.item_path.name)]) due to job blacklists!"))
				continue

			if(item.restricted_species && !(dna.species.id in item.restricted_species))
				if(client)
					to_chat(src, span_warning("You were unable to get a loadout item ([initial(item.item_path.name)]) due to species restrictions!"))
				continue

			new item.item_path(briefcase)

		briefcase.name = "[preference_source.read_preference(/datum/preference/name/real_name)]'s travel suitcase"
		equipOutfit(equipped_outfit, visuals_only)
		put_in_hands(briefcase)
	else
		for(var/datum/loadout_item/item as anything in loadout_datums)
			if(item.restricted_roles && equipping_job && !(equipping_job.title in item.restricted_roles))
				if(client)
					to_chat(src, span_warning("You were unable to get a loadout item([initial(item.item_path.name)]) due to job restrictions!"))
				continue

			if(item.blacklisted_roles && equipping_job && (equipping_job.title in item.blacklisted_roles))
				if(client)
					to_chat(src, span_warning("You were unable to get a loadout item([initial(item.item_path.name)]) due to job blacklists!"))
				continue

			if(item.restricted_species && !(dna.species.id in item.restricted_species))
				if(client)
					to_chat(src, span_warning("You were unable to get a loadout item ([initial(item.item_path.name)]) due to species restrictions!"))
				continue

			// Make sure the item is not overriding an important for life outfit item
			var/datum/outfit/outfit_important_for_life = dna.species.outfit_important_for_life
			if(!outfit_important_for_life || !item.pre_equip_item(equipped_outfit, outfit_important_for_life, src, visuals_only))
				item.insert_path_into_outfit(equipped_outfit, src, visuals_only, override_preference)


		equipOutfit(equipped_outfit, visuals_only)

	for(var/datum/loadout_item/item as anything in loadout_datums)
		if(item.restricted_roles && equipping_job && !(equipping_job.title in item.restricted_roles))
			continue
		item.on_equip_item(preference_source, src, visuals_only)

	regenerate_icons()
	return TRUE

/*
 * Takes a list of paths (such as a loadout list)
 * and returns a list of their singleton loadout item datums
 *
 * loadout_list - the list being checked
 *
 * returns a list of singleton datums
 */
/proc/loadout_list_to_datums(list/loadout_list)
	RETURN_TYPE(/list)

	. = list()

	if(!GLOB.all_loadout_datums.len)
		CRASH("No loadout datums in the global loadout list!")

	for(var/path in loadout_list)
		if(!GLOB.all_loadout_datums[path])
			stack_trace("Could not find ([path]) loadout item in the global list of loadout datums!")
			continue

		. |= GLOB.all_loadout_datums[path]


/*
 * Removes all invalid paths from loadout lists.
 *
 * passed_list - the loadout list we're sanitizing.
 *
 * returns a list
 */
/proc/update_loadout_list(list/passed_list)
	RETURN_TYPE(/list)

	var/list/list_to_update = LAZYLISTDUPLICATE(passed_list)
	for(var/thing in list_to_update) //thing, 'cause it could be a lot of things
		if(ispath(thing))
			break
		var/our_path = text2path(list_to_update[thing])

		LAZYREMOVE(list_to_update, thing)
		if(ispath(our_path))
			LAZYSET(list_to_update, our_path, list())

	return list_to_update

/*
 * Removes all invalid paths from loadout lists.
 *
 * passed_list - the loadout list we're sanitizing.
 *
 * returns a list
 */
/proc/sanitize_loadout_list(list/passed_list)
	RETURN_TYPE(/list)

	var/list/list_to_clean = LAZYLISTDUPLICATE(passed_list)
	for(var/path in list_to_clean)
		if(!ispath(path))
			stack_trace("invalid path found in loadout list! (Path: [path])")
			LAZYREMOVE(list_to_clean, path)

		else if(!(path in GLOB.all_loadout_datums))
			stack_trace("invalid loadout slot found in loadout list! Path: [path]")
			LAZYREMOVE(list_to_clean, path)

	return list_to_clean

/obj/item/storage/briefcase/empty/PopulateContents()
	return
