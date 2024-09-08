/**
 * Equips this mob with a given outfit and loadout items as per the passed preferences.
 *
 * Loadout items override the pre-existing item in the corresponding slot of the job outfit.
 * Some job items are preserved after being overridden - belt items, ear items, and glasses.
 * The rest of the slots, the items are overridden completely and deleted.
 *
 * Species with special outfits are snowflaked to have loadout items placed in their bags instead of overriding the outfit.
 *
 * * outfit - the job outfit we're equipping
 * * preference_source - the preferences to draw loadout items from.
 * * visuals_only - whether we call special equipped procs, or if we just look like we equipped it
 */
/mob/living/carbon/human/proc/equip_outfit_and_loadout(
	datum/outfit/outfit = /datum/outfit,
	datum/preferences/preference_source,
	visuals_only = FALSE,
	datum/job/equipping,
) // SKYRAT EDIT CHANGE - Added equipping param
	if(isnull(preference_source))
		return equipOutfit(outfit, visuals_only)

	var/datum/outfit/equipped_outfit
	if(ispath(outfit, /datum/outfit))
		equipped_outfit = new outfit()
	else if(istype(outfit, /datum/outfit))
		equipped_outfit = outfit
	else
		CRASH("Invalid outfit passed to equip_outfit_and_loadout ([outfit])")

	var/list/preference_list = preference_source.read_preference(/datum/preference/loadout)
	var/list/loadout_datums = loadout_list_to_datums(preference_list)
	// SKYRAT EDIT ADDITION BEGIN
	var/obj/item/storage/briefcase/empty/travel_suitcase
	var/loadout_placement_preference = preference_source.read_preference(/datum/preference/choiced/loadout_override_preference)
	// Slap our things into the outfit given
	for(var/datum/loadout_item/item as anything in loadout_datums)
		if(item.restricted_roles && equipping && !(equipping.title in item.restricted_roles))
			if(preference_source.parent)
				to_chat(preference_source.parent, span_warning("You were unable to get a loadout item([initial(item.item_path.name)]) due to job restrictions!"))
			continue

		if(item.blacklisted_roles && equipping && (equipping.title in item.blacklisted_roles))
			if(preference_source.parent)
				to_chat(preference_source.parent, span_warning("You were unable to get a loadout item([initial(item.item_path.name)]) due to job blacklists!"))
			continue

		if(item.restricted_species && !(dna.species.id in item.restricted_species))
			if(preference_source.parent)
				to_chat(preference_source.parent, span_warning("You were unable to get a loadout item ([initial(item.item_path.name)]) due to species restrictions!"))
			continue

		if(item.ckeywhitelist && !(preference_source?.parent?.ckey in item.ckeywhitelist)) // Sanity checking
			if(preference_source.parent)
				to_chat(preference_source.parent, span_warning("You were unable to get a loadout item ([initial(item.item_path.name)]) due to CKEY restrictions!"))
			continue

		if(loadout_placement_preference == LOADOUT_OVERRIDE_CASE && !visuals_only)
			if(!travel_suitcase)
				travel_suitcase  = new(loc)
			new item.item_path(travel_suitcase)
		else // SKYRAT EDIT END
			item.insert_path_into_outfit(equipped_outfit, src, visuals_only, loadout_placement_preference)
	// Equip the outfit loadout items included
	if(!equipped_outfit.equip(src, visuals_only))
		return FALSE

	// SKYRAT EDIT ADDITION
	if(travel_suitcase)
		put_in_hands(travel_suitcase)
	// SKYRAT EDIT END

	// Handle any snowflake on_equips.
	var/list/new_contents = get_all_gear()
	var/update = NONE
	for(var/datum/loadout_item/item as anything in loadout_datums)
		var/obj/item/equipped = locate(item.item_path) in new_contents
		if(isnull(equipped))
			continue
		update |= item.on_equip_item(
			equipped_item = equipped,
			preference_source = preference_source,
			preference_list = preference_list,
			equipper = src,
			visuals_only = visuals_only,
		)

	if(update)
		update_clothing(update)

	return TRUE

/**
 * Takes a list of paths (such as a loadout list)
 * and returns a list of their singleton loadout item datums
 *
 * loadout_list - the list being checked
 *
 * Returns a list of singleton datums
 */
/proc/loadout_list_to_datums(list/loadout_list) as /list
	var/list/datums = list()

	if(!length(GLOB.all_loadout_datums))
		CRASH("No loadout datums in the global loadout list!")

	for(var/path in loadout_list)
		var/actual_datum = GLOB.all_loadout_datums[path]
		if(!istype(actual_datum, /datum/loadout_item))
			stack_trace("Could not find ([path]) loadout item in the global list of loadout datums!")
			continue

		datums += actual_datum

	return datums

// SKYRAT EDIT ADDITION
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
// SKYRAT EDIT END
