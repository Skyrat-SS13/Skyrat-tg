/datum/round_event_control/space_ninja
	name = "Spawn Space Ninja"
	typepath = /datum/round_event/ghost_role/space_ninja
	max_occurrences = 1
	weight = 10
	earliest_start = 20 MINUTES
	min_players = 20
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_INVASION
	description = "A space ninja infiltrates the station."

/datum/round_event/ghost_role/space_ninja
	minimum_required = 1
	role_name = "Space Ninja"

/datum/round_event/ghost_role/space_ninja/spawn_role()
	var/spawn_location = find_space_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR

	//selecting a candidate player
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(check_jobban = ROLE_NINJA, role = ROLE_NINJA, alert_pic = /obj/item/energy_katana, jump_target = spawn_location, role_name_text = "space ninja", amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	//spawn the ninja and assign the candidate
	var/mob/living/carbon/human/ninja = create_space_ninja(spawn_location)
	ninja.key = chosen_one.key
	ninja.mind.add_antag_datum(/datum/antagonist/ninja)
	spawned_mobs += ninja
// SKYRAT EDIT ADDITION BEGIN: Preference Ninjas
	var/loadme = tgui_input_list(ninja, "Do you wish to load your character slot?", "Load Character?", list("Yes!", "No, I want to be random!"), default = "No, I want to be random!", timeout = 60 SECONDS)
	var/codename
	if(loadme == "Yes!")
		ninja.client?.prefs?.safe_transfer_prefs_to(ninja)
		codename = tgui_input_text(ninja.client, "What should your codename be?", "Agent Name", "[pick("Master", "Legendary", "Agent", "Shinobi", "Ninja")] [ninja.dna.species.name]", 42, FALSE, TRUE, 300 SECONDS)
		codename ? codename : (codename = "[pick("Master", "Legendary", "Agent", "Shinobi", "Ninja")] [ninja.dna.species.name]")
		ninja.name = codename
		ninja.real_name = codename
		ninja.dna.update_dna_identity()
	else
		ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES))
		ninja.dna.update_dna_identity()

// SKYRAT EDIT ADDITION END: Preference Ninjas
	message_admins("[ADMIN_LOOKUPFLW(ninja)] has been made into a space ninja by an event.")
	ninja.log_message("was spawned as a ninja by an event.", LOG_GAME)

	return SUCCESSFUL_SPAWN


//=======//NINJA CREATION PROCS//=======//

/proc/create_space_ninja(spawn_loc)
	var/mob/living/carbon/human/new_ninja = new(spawn_loc)
//	new_ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES)) //SKYRAT EDIT: Player Prefs Ninjas
	var/new_name = "[pick(GLOB.ninja_titles)] [pick(GLOB.ninja_names)]"
	new_ninja.name = new_name
	new_ninja.real_name = new_name
//	new_ninja.dna.update_dna_identity()  //SKYRAT EDIT: Player Prefs Ninjas
	return new_ninja
