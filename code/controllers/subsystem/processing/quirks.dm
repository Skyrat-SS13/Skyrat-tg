#define EXP_ASSIGN_WAYFINDER 1200
#define RANDOM_QUIRK_BONUS 3
#define MINIMUM_RANDOM_QUIRKS 3

// Shifted to glob so they are generated at world start instead of risking players doing preference stuff before the subsystem inits
GLOBAL_LIST_INIT_TYPED(quirk_blacklist, /list/datum/quirk, list(
	list(/datum/quirk/item_quirk/blindness, /datum/quirk/item_quirk/nearsighted),
	list(/datum/quirk/jolly, /datum/quirk/depression, /datum/quirk/apathetic, /datum/quirk/hypersensitive),
	list(/datum/quirk/no_taste, /datum/quirk/vegetarian, /datum/quirk/deviant_tastes, /datum/quirk/gamer),
	list(/datum/quirk/pineapple_liker, /datum/quirk/pineapple_hater, /datum/quirk/gamer),
	list(/datum/quirk/alcohol_tolerance, /datum/quirk/light_drinker),
	list(/datum/quirk/item_quirk/clown_enjoyer, /datum/quirk/item_quirk/mime_fan, /datum/quirk/item_quirk/pride_pin),
	list(/datum/quirk/bad_touch, /datum/quirk/friendly),
	list(/datum/quirk/extrovert, /datum/quirk/introvert),
	list(/datum/quirk/prosthetic_limb, /datum/quirk/quadruple_amputee, /datum/quirk/body_purist),
	list(/datum/quirk/prosthetic_organ, /datum/quirk/tin_man, /datum/quirk/body_purist),
	list(/datum/quirk/quadruple_amputee, /datum/quirk/paraplegic, /datum/quirk/hemiplegic),
	list(/datum/quirk/quadruple_amputee, /datum/quirk/frail),
	list(/datum/quirk/social_anxiety, /datum/quirk/mute),
	list(/datum/quirk/mute, /datum/quirk/softspoken),
	list(/datum/quirk/poor_aim, /datum/quirk/bighands),
	list(/datum/quirk/bilingual, /datum/quirk/foreigner),
	list(/datum/quirk/spacer_born, /datum/quirk/paraplegic, /datum/quirk/item_quirk/settler),
	list(/datum/quirk/photophobia, /datum/quirk/nyctophobia),
	list(/datum/quirk/item_quirk/settler, /datum/quirk/freerunning),
	list(/datum/quirk/numb, /datum/quirk/selfaware),
	//SKYRAT EDIT ADDITION BEGIN
	list(/datum/quirk/equipping/nerve_staple, /datum/quirk/nonviolent),
	list(/datum/quirk/equipping/nerve_staple, /datum/quirk/item_quirk/nearsighted),
	list(/datum/quirk/no_guns, /datum/quirk/bighands, /datum/quirk/poor_aim),
	list(/datum/quirk/no_guns, /datum/quirk/nonviolent),
	list(/datum/quirk/spacer_born, /datum/quirk/oversized),
	//SKYRAT EDIT ADDITION END
))

GLOBAL_LIST_INIT(quirk_string_blacklist, generate_quirk_string_blacklist())

/proc/generate_quirk_string_blacklist()
	var/list/string_blacklist = list()
	for(var/blacklist in GLOB.quirk_blacklist)
		var/list/string_list = list()
		for(var/datum/quirk/typepath as anything in blacklist)
			string_list += initial(typepath.name)
		string_blacklist += list(string_list)
	return string_blacklist

//Used to process and handle roundstart quirks
// - Quirk strings are used for faster checking in code
// - Quirk datums are stored and hold different effects, as well as being a vector for applying trait string
PROCESSING_SUBSYSTEM_DEF(quirks)
	name = "Quirks"
	init_order = INIT_ORDER_QUIRKS
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 1 SECONDS

	var/list/quirks = list() //Assoc. list of all roundstart quirk datum types; "name" = /path/
	var/list/quirk_points = list() //Assoc. list of quirk names and their "point cost"; positive numbers are good traits, and negative ones are bad
	///An assoc list of quirks that can be obtained as a hardcore character, and their hardcore value.
	var/list/hardcore_quirks = list()

/datum/controller/subsystem/processing/quirks/Initialize()
	get_quirks()
	return SS_INIT_SUCCESS

/// Returns the list of possible quirks
/datum/controller/subsystem/processing/quirks/proc/get_quirks()
	RETURN_TYPE(/list)
	if (!quirks.len)
		SetupQuirks()

	return quirks

/datum/controller/subsystem/processing/quirks/proc/SetupQuirks()
	// Sort by Positive, Negative, Neutral; and then by name
	var/list/quirk_list = sort_list(subtypesof(/datum/quirk), GLOBAL_PROC_REF(cmp_quirk_asc))

	for(var/type in quirk_list)
		var/datum/quirk/quirk_type = type

		if(initial(quirk_type.abstract_parent_type) == type)
			continue

		// SKYRAT EDIT ADDITION START
		if(initial(quirk_type.erp_quirk) && CONFIG_GET(flag/disable_erp_preferences))
			continue
		// Hidden quirks aren't visible to TGUI or the player
		if (initial(quirk_type.hidden_quirk))
			continue
		// SKYRAT EDIT ADDITION END

		quirks[initial(quirk_type.name)] = quirk_type
		quirk_points[initial(quirk_type.name)] = initial(quirk_type.value)

		var/hardcore_value = initial(quirk_type.hardcore_value)

		if(!hardcore_value)
			continue
		hardcore_quirks[quirk_type] += hardcore_value

/datum/controller/subsystem/processing/quirks/proc/AssignQuirks(mob/living/user, client/applied_client)
	var/badquirk = FALSE
	for(var/quirk_name in applied_client.prefs.all_quirks)
		var/datum/quirk/quirk_type = quirks[quirk_name]
		if(ispath(quirk_type))
			if(user.add_quirk(quirk_type, override_client = applied_client))
				SSblackbox.record_feedback("nested tally", "quirks_taken", 1, list("[quirk_name]"))
		else
			stack_trace("Invalid quirk \"[quirk_name]\" in client [applied_client.ckey] preferences")
			applied_client.prefs.all_quirks -= quirk_name
			badquirk = TRUE
	if(badquirk)
		applied_client.prefs.save_character()

/*
 *Randomises the quirks for a specified mob
 */
/datum/controller/subsystem/processing/quirks/proc/randomise_quirks(mob/living/user)
	var/bonus_quirks = max((length(user.quirks) + rand(-RANDOM_QUIRK_BONUS, RANDOM_QUIRK_BONUS)), MINIMUM_RANDOM_QUIRKS)
	var/added_quirk_count = 0 //How many we've added
	var/list/quirks_to_add = list() //Quirks we're adding
	var/good_count = 0 //Maximum of 6 good perks
	var/score //What point score we're at
	///Cached list of possible quirks
	var/list/possible_quirks = quirks.Copy()
	//Create a random list of stuff to start with
	while(bonus_quirks > added_quirk_count)
		var/quirk = pick(possible_quirks) //quirk is a string
		if(quirk in GLOB.quirk_blacklist) //prevent blacklisted
			possible_quirks -= quirk
			continue
		if(quirk_points[quirk] > 0)
			good_count++
		score += quirk_points[quirk]
		quirks_to_add += quirk
		possible_quirks -= quirk
		added_quirk_count++

	//But lets make sure we're balanced
	while(score > 0)
		if(!length(possible_quirks))//Lets not get stuck
			break
		var/quirk = pick(quirks)
		if(quirk in GLOB.quirk_blacklist) //prevent blacklisted
			possible_quirks -= quirk
			continue
		if(!quirk_points[quirk] < 0)//negative only
			possible_quirks -= quirk
			continue
		good_count++
		score += quirk_points[quirk]
		quirks_to_add += quirk

	//And have benefits too
	while(score < 0 && good_count <= MAX_QUIRKS)
		if(!length(possible_quirks))//Lets not get stuck
			break
		var/quirk = pick(quirks)
		if(quirk in GLOB.quirk_blacklist) //prevent blacklisted
			possible_quirks -= quirk
			continue
		if(!quirk_points[quirk] > 0) //positive only
			possible_quirks -= quirk
			continue
		good_count++
		score += quirk_points[quirk]
		quirks_to_add += quirk

	for(var/datum/quirk/quirk as anything in user.quirks)
		if(quirk.name in quirks_to_add) //Don't delete ones we keep
			quirks_to_add -= quirk.name //Already there, no need to add.
			continue
		user.remove_quirk(quirk.type) //these quirks are objects

	for(var/datum/quirk/quirk as anything in quirks_to_add)
		user.add_quirk(quirks[quirk]) //these are typepaths converted from string

/// Takes a list of quirk names and returns a new list of quirks that would
/// be valid.
/// If no changes need to be made, will return the same list.
/// Expects all quirk names to be unique, but makes no other expectations.
/datum/controller/subsystem/processing/quirks/proc/filter_invalid_quirks(list/quirks, list/augments) // SKYRAT EDIT - AUGMENTS+
	var/list/new_quirks = list()
	var/list/positive_quirks = list()
	var/balance = 0

	var/list/all_quirks = get_quirks()

	// SKYRAT EDIT BEGIN - AUGMENTS+
	for(var/key in augments)
		var/datum/augment_item/aug = GLOB.augment_items[augments[key]]
		balance += aug.cost
	// SKYRAT EDIT END
	for (var/quirk_name in quirks)
		var/datum/quirk/quirk = all_quirks[quirk_name]
		if (isnull(quirk))
			continue

		if ((initial(quirk.quirk_flags) & QUIRK_MOODLET_BASED) && CONFIG_GET(flag/disable_human_mood))
			continue

		var/blacklisted = FALSE

		for (var/list/blacklist as anything in GLOB.quirk_blacklist)
			if (!(quirk in blacklist))
				continue

			for (var/other_quirk in blacklist)
				if (other_quirk in new_quirks)
					blacklisted = TRUE
					break

			if (blacklisted)
				break

		if (blacklisted)
			continue

		var/value = initial(quirk.value)
		if (value > 0)
			if (positive_quirks.len == MAX_QUIRKS)
				continue

			positive_quirks[quirk_name] = value

		balance += value
		new_quirks += quirk_name

	if (balance > 0)
		var/balance_left_to_remove = balance

		for (var/positive_quirk in positive_quirks)
			var/value = positive_quirks[positive_quirk]
			balance_left_to_remove -= value
			new_quirks -= positive_quirk

			if (balance_left_to_remove <= 0)
				break

	// It is guaranteed that if no quirks are invalid, you can simply check through `==`
	if (new_quirks.len == quirks.len)
		return quirks

	return new_quirks

#undef EXP_ASSIGN_WAYFINDER
#undef RANDOM_QUIRK_BONUS
#undef MINIMUM_RANDOM_QUIRKS
