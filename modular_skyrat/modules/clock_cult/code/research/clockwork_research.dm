/datum/clockwork_research
	/// Name of the research node
	var/name = ""
	/// Desc of the research
	var/desc = ""
	/// Extra fluff text for your research, moreso lore bits
	var/lore = ""
	/// List of tinker cache items it unlocks
	var/list/unlocked_recipes = list()
	/// List of scriptures this unlocks
	var/list/unlocked_scriptures = list()
	/// What tier this is
	var/tier = 1
	/// If this is a starting research
	var/starting = FALSE
	/// If this has been researched
	var/researched = FALSE
	/// How long this research's ritual will take to complete
	var/time_to_research = 6 MINUTES
	/// Valid areas where a research ritual may happen
	var/static/list/area_whitelist = typecacheof(list(
		/area/station/cargo,
		/area/station/command,
		/area/station/commons,
		/area/station/construction,
		/area/station/engineering,
		/area/station/maintenance/disposal,
		/area/station/maintenance/radshelter,
		/area/station/maintenance/tram,
		/area/station/medical,
		/area/station/science,
		/area/station/security,
		/area/station/service,
	))
	/// Areas where you can't be tasked to start a ritual.
	var/static/list/area_blacklist = typecacheof(list(
		/area/station/engineering/supermatter,
		/area/station/engineering/transit_tube,
		/area/station/science/ordnance/bomb,
		/area/station/science/ordnance/burnchamber,
		/area/station/science/ordnance/freezerchamber,
		/area/station/science/server,
		/area/station/security/prison/safe,
	))
	/// A typepath of the area that this research's ritual must be done in.
	var/area/selected_area


/datum/clockwork_research/New(set_area = TRUE)
	. = ..()
	if(!selected_area && set_area)
		set_new_area()


/// Pick an an area for this research to take place in
/datum/clockwork_research/proc/set_new_area(failed_validation = FALSE)
	var/list/possible_areas = GLOB.the_station_areas.Copy()
	for(var/area/possible_area as anything in possible_areas)
		if(initial(possible_area.outdoors) || !is_type_in_typecache(possible_area, area_whitelist) || is_type_in_typecache(possible_area, area_blacklist))
			possible_areas -= possible_area

	if(length(possible_areas))
		selected_area = pick(possible_areas)

	validate_area(failed_validation)


/// Makes sure the selected area is correct, and regenerates it if not. Only gets one reattempt before defaulting to the base station area (allowing it to happen anywhere).
/datum/clockwork_research/proc/validate_area(failed_validation)
	if(!selected_area || !length(get_area_turfs(selected_area)))
		if(failed_validation)
			log_mapping("Clockwork research node [src] was unable to find a ritual area! Defaulting to base /area/station type.")
			selected_area = /area/station
			return TRUE
		set_new_area(failed_validation = TRUE) // we will retry this once and only once
		return FALSE
	return TRUE


/// Makes sure the area that the atom is attempting to research, is the correct area as specified by the datum. Returns FALSE otherwise
/datum/clockwork_research/proc/check_is_place_good(atom/researcher)
	if(!istype(get_area(researcher), selected_area))
		return FALSE
	return TRUE


/// Called when a research datum is fully researched
/datum/clockwork_research/proc/on_research()
	GLOB.clockwork_research_unlocked_recipes += unlocked_recipes
	GLOB.clockwork_research_unlocked_scriptures += unlocked_scriptures
	researched = TRUE


/datum/clockwork_research/start
	name = "Starting Research"
	desc = "All studies must begin somewhere. Studying His implements is no exception."
	lore = "...And so, the last of the Justicar's faithful left after His demise, knowing that He would one day return."
	tier = 0
	starting = TRUE
	researched = TRUE
	unlocked_scriptures = list( // Bit of a clue
		/datum/scripture/create_structure/tinkerers_cache,
	)

/datum/clockwork_research/gun
	name = "Brass Rifle"
	desc = "A powerful rifle capable of shooting through walls."
	lore = "With the power of his armament, he struck down the Nar'sian dogs. Blind, he was, but all the more he was seeing."
	tier = 1
	unlocked_recipes = list(
		/datum/tinker_cache_item/clockwork_rifle,
		/datum/tinker_cache_item/clockwork_rifle_ammo,
	)

