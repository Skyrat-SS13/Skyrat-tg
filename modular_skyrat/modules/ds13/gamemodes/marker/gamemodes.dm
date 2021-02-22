GLOBAL_DATUM_INIT(shipsystem, /datum/ship_subsystems, new)


/*
	Main gamemode. Marker starts aboard ishimura
*/
/datum/game_mode/marker/containment
	name = "Containment"
	round_description = "The crew of the USG Ishimura has brought aboard a strange artifact and is tasked with discovering what its purpose is."
	extended_round_description = "The crew must holdout until help arrives"
	config_tag = "containment"
	votable = TRUE

/datum/game_mode/marker/containment/get_marker_location()
	return pick(SSnecromorph.marker_spawns_ishimura)


/*
	Alternate Gamemode: Marker starts on aegis, unitologists start with a shard
*/

/datum/game_mode/marker/enemy_within
	name = "Enemy Within"
	round_description = "The USG Ishimura has discovered a strange artifact on Aegis VII, but it is not whole. Some piece of it has been broken off and smuggled aboard"
	extended_round_description = "The crew must holdout until help arrives"
	config_tag = "enemy_within"
	votable = TRUE
	antag_tags = list(MODE_UNITOLOGIST_SHARD)

/datum/game_mode/marker/enemy_within/get_marker_location()
	return pick(SSnecromorph.marker_spawns_aegis)

/datum/game_mode/marker
	name = "unnamed"
	round_description = "The USG Ishimura has unearthed a strange artifact and is tasked with discovering what its purpose is."
	extended_round_description = "The crew must holdout until help arrives"
	config_tag = "unnamed"
	required_players = 0
	required_enemies = 0
	end_on_antag_death = 0
	round_autoantag = TRUE
	auto_recall_shuttle = FALSE
	antag_tags = list(MODE_UNITOLOGIST)
	latejoin_antag_tags = list(MODE_UNITOLOGIST)
	antag_templates = list(/datum/antagonist/unitologist)
	require_all_templates = FALSE
	votable = FALSE
	var/marker_setup_time = 45 MINUTES
	var/marker_active = FALSE
	antag_scaling_coeff = 8

	//Auto End condition stuff. To make the round auto end when necromorphs kill everyone

	//For it to trigger, there needs to have been at least this many crewmembers in total over the round
	//This includes the living, and the dead
	var/minimum_historic_crew	=	5
	var/minimum_alive_percentage = 0.1 //0.1 = 10%

/datum/game_mode/marker/post_setup() //Mr Gaeta. Start the clock.
	. = ..()
	//Alright lets spawn the marker
	spawn_marker()

	if(!SSnecromorph.marker)
		message_admins("There are no markers on this map!")
		return
	evacuation_controller.add_can_call_predicate(new /datum/evacuation_predicate/travel_points)
	command_announcement.Announce("Delivery of alien artifact successful at [get_area(SSnecromorph.marker)].","Ishimura Deliveries Subsystem") //Placeholder
	addtimer(CALLBACK(src, .proc/activate_marker), rand_between(0.85, 1.15)*marker_setup_time) //We have to spawn the marker quite late, so guess we'd best wait :)


/datum/game_mode/marker/proc/spawn_marker()
	var/turf/T = get_marker_location()
	if (T)
		return new /obj/machinery/marker(T)


/datum/game_mode/marker/proc/get_marker_location()
	return null

/datum/game_mode/marker/proc/pick_marker_player()
	if (SSnecromorph.marker.player)
		return	//There's already a marker player

	var/mob/M
	if(!SSnecromorph.signals.len) //No signals? We can't pick one
		message_admins("No signals, unable to pick a marker player! The marker is now active and awaiting anyone who wishes to control it")
		return FALSE

	var/list/marker_candidates = SSnecromorph.signals.Copy()
	while (marker_candidates.len)
		M = pick_n_take(marker_candidates)
		if (!M.client)
			continue


		//Alright pick them!
		to_chat(M, "<span class='warning'>You have been selected to become the marker!</span>")
		SSnecromorph.marker.become_master_signal(M)
		return M

	message_admins("No signals, unable to pick a marker player! The marker is now active and awaiting anyone who wishes to control it")
	return FALSE

/datum/game_mode/marker/proc/activate_marker()
	last_pointgain_time = world.timeofday
		//This handles preventing evac until we have enough points
	charge_evac_points()
	SSnecromorph.marker.make_active() //Allow controlling
	pick_marker_player()
	marker_active = TRUE
	return TRUE

/client/proc/activate_marker()
	set name = "Activate Marker"
	set category = "Admin"
	set desc = "Forces the marker to immediately activate"

	var/confirm = alert(src, "You will be activating the marker. Are you super duper sure?", "Make us Whole?", "Send in the Necromorphs!", "On second thought, maybe not...")
	if(confirm != "Send in the Necromorphs!")
		return

	var/datum/game_mode/marker/GM = ticker.mode
	if (!istype(GM))
		return

	if (GM.marker_active)
		to_chat(src, "The marker is already active")
		return
	GM.activate_marker()

/**

There is probably a better way to do this, but I've added some more stringent checks to the gamemode win conditions to prevent things like:
Admin characters being counted as crew, and on their deletion, ending the game
Non-critical characters like any ghost-roles you may wish to add, or even antags, from counting as "dead crew" (Antags fallback to their own "are the antags dead checks"

*/

//Marker gamemode can end when necros kill most of the crew
/datum/game_mode/marker/check_finished()
	if(marker_active)	//Marker must be active
		if (get_historic_crew_total() >= minimum_historic_crew)	//We need to have had a minimum total crewcount
			var/minimum_living_crew = Ceiling(get_historic_crew_total() * minimum_alive_percentage)	//This many crew players at least, need to be left alive
			if (get_living_crew_total() < minimum_living_crew)
				return TRUE

	return ..() //Fallback to the default game end conditions like all antags dying, shuttles being docked, etc.