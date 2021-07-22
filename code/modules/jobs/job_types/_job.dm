/datum/job
	//The name of the job , used for preferences, bans and more. Make sure you know what you're doing before changing this.
	var/title = "NOPE"

	/// Innate skill levels unlocked at roundstart. Based on config.jobs_have_minimal_access config setting, for example with a skeleton crew. Format is list(/datum/skill/foo = SKILL_EXP_NOVICE) with exp as an integer or as per code/_DEFINES/skills.dm
	var/list/skills
	/// Innate skill levels unlocked at roundstart. Based on config.jobs_have_minimal_access config setting, for example with a full crew. Format is list(/datum/skill/foo = SKILL_EXP_NOVICE) with exp as an integer or as per code/_DEFINES/skills.dm
	var/list/minimal_skills

	//Determines who can demote this position
	var/department_head = list()

	//Tells the given channels that the given mob is the new department head. See communications.dm for valid channels.
	var/list/head_announce = null

	//Bitflags for the job
	var/auto_deadmin_role_flags = NONE

	//Players will be allowed to spawn in as jobs that are set to "Station"
	var/faction = "None"

	//How many players can be this job
	var/total_positions = 0

	//How many players can spawn in as this job
	var/spawn_positions = 0

	//How many players have this job
	var/current_positions = 0

	//Supervisors, who this person answers to directly
	var/supervisors = ""

	//Sellection screen color
	var/selection_color = "#ffffff"


	//If this is set to 1, a text is printed to the player when jobs are assigned, telling him that he should let admins know that he has to disconnect.
	var/req_admin_notify

	//If you have the use_age_restriction_for_jobs config option enabled and the database set up, this option will add a requirement for players to be at least minimal_player_age days old. (meaning they first signed in at least that many days before.)
	var/minimal_player_age = 0

	var/outfit = null

	/// The job's outfit that will be assigned for plasmamen.
	var/plasmaman_outfit = null

	var/exp_requirements = 0

	var/exp_type = ""
	var/exp_type_department = ""

	var/paycheck = PAYCHECK_MINIMAL
	var/paycheck_department = ACCOUNT_CIV

	var/list/mind_traits // Traits added to the mind of the mob assigned this job

	///Lazylist of traits added to the liver of the mob assigned this job (used for the classic "cops heal from donuts" reaction, among others)
	var/list/liver_traits = null

	var/display_order = JOB_DISPLAY_ORDER_DEFAULT

	var/bounty_types = CIV_JOB_BASIC

	/// Goodies that can be received via the mail system.
	// this is a weighted list.
	/// Keep the _job definition for this empty and use /obj/item/mail to define general gifts.
	var/list/mail_goodies = list()

	/// If this job's mail goodies compete with generic goodies.
	var/exclusive_mail_goodies = FALSE

	///Bitfield of departments this job belongs wit
	var/departments = NONE

	/// Should this job be allowed to be picked for the bureaucratic error event?
	var/allow_bureaucratic_error = TRUE

	///Is this job affected by weird spawns like the ones from station traits
	var/random_spawns_possible = TRUE

	/// List of family heirlooms this job can get with the family heirloom quirk. List of types.
	var/list/family_heirlooms

	//SKYRAT EDIT ADDITION
	///Is this job veteran only? If so, then this job requires the player to be in the veteran_players.txt
	var/veteran_only = FALSE
	//SKYRAT EDIT END

/datum/job/New()
	. = ..()
	var/list/jobs_changes = get_map_changes()
	if(!jobs_changes)
		return
	if(isnum(jobs_changes["spawn_positions"]))
		spawn_positions = jobs_changes["spawn_positions"]
	if(isnum(jobs_changes["total_positions"]))
		total_positions = jobs_changes["total_positions"]

/// Loads up map configs if necessary and returns job changes for this job.
/datum/job/proc/get_map_changes()
	var/string_type = "[type]"
	var/list/splits = splittext(string_type, "/")
	var/endpart = splits[splits.len]

	var/list/job_changes = SSmapping.config.job_changes
	if(!(endpart in job_changes))
		return list()

	return job_changes[endpart]

//Only override this proc
//H is usually a human unless an /equip override transformed it
/datum/job/proc/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	//do actions on H but send messages to M as the key may not have been transferred_yet
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_JOB_AFTER_SPAWN, src, H, M, latejoin)
	if(mind_traits)
		for(var/t in mind_traits)
			ADD_TRAIT(H.mind, t, JOB_TRAIT)

	var/obj/item/organ/liver/liver = H.getorganslot(ORGAN_SLOT_LIVER)

	if(liver)
		for(var/t in liver_traits)
			ADD_TRAIT(liver, t, JOB_TRAIT)

	var/list/roundstart_experience

	if(!ishuman(H))
		return

	if(!config) //Needed for robots.
		roundstart_experience = minimal_skills

	if(CONFIG_GET(flag/jobs_have_minimal_access))
		roundstart_experience = minimal_skills
	else
		roundstart_experience = skills

	if(roundstart_experience)
		var/mob/living/carbon/human/experiencer = H
		for(var/i in roundstart_experience)
			experiencer.mind.adjust_experience(i, roundstart_experience[i], TRUE)

/datum/job/proc/announce(mob/living/carbon/human/H, announce_captaincy = FALSE)
	if(head_announce)
		announce_head(H, head_announce)

/datum/job/proc/override_latejoin_spawn(mob/living/carbon/human/H) //Return TRUE to force latejoining to not automatically place the person in latejoin shuttle/whatever.
	return FALSE

//Used for a special check of whether to allow a client to latejoin as this job.
/datum/job/proc/special_check_latejoin(client/C)
	return TRUE

//Don't override this unless the job transforms into a non-human (Silicons do this for example)
/datum/job/proc/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source, is_captain = FALSE)
	if(!H)
		return FALSE
	if(CONFIG_GET(flag/enforce_human_authority) && (title in GLOB.command_positions))
		if(H.dna.species.id != "human")
			H.set_species(/datum/species/human)
			H.apply_pref_name("human", preference_source)
	if(!visualsOnly)
		var/datum/bank_account/bank_account = new(H.real_name, src, H.dna.species.payday_modifier)
		bank_account.payday(STARTING_PAYCHECKS, TRUE)
		H.account_id = bank_account.account_id
	get_alt_title_pref(preference_source) //SKYRAT EDIT ADD - gets alt titles for round start (yes this is fucking spaghetti it's not my fault you can't access a mob's client before their ID sets the job)


	//Equip the rest of the gear
	H.dna.species.before_equip_job(src, H, visualsOnly)

	if(outfit_override || outfit)
		H.equipOutfit(outfit_override ? outfit_override : outfit, visualsOnly)

	if(!visualsOnly && is_captain)
		var/is_acting_captain = (title != "Captain")
		SSjob.promote_to_captain(H, is_acting_captain)

	H.dna.species.after_equip_job(src, H, visualsOnly)

	if(!visualsOnly && announce)
		announce(H, is_captain)
/* SKYRAT EDIT MOVAL - MOVED TO ALTTITLEPREFS
/datum/job/proc/announce_head(mob/living/carbon/human/H, channels) //tells the given channel that the given mob is the new department head. See communications.dm for valid channels.
	if(H && GLOB.announcement_systems.len)
		//timer because these should come after the captain announcement
		SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, .proc/_addtimer, CALLBACK(pick(GLOB.announcement_systems), /obj/machinery/announcement_system/proc/announce, "NEWHEAD", H.real_name, H.job, channels), 1))
*/
//If the configuration option is set to require players to be logged as old enough to play certain jobs, then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	if(available_in_days(C) == 0)
		return TRUE //Available in 0 days = available right now = player is old enough to play.
	return FALSE


/datum/job/proc/available_in_days(client/C)
	if(!C)
		return 0
	if(!CONFIG_GET(flag/use_age_restriction_for_jobs))
		return 0
	if(!SSdbcore.Connect())
		return 0 //Without a database connection we can't get a player's age so we'll assume they're old enough for all jobs
	if(!isnum(minimal_player_age))
		return 0

	return max(0, minimal_player_age - C.player_age)

/datum/job/proc/config_check()
	return TRUE

/datum/job/proc/map_check()
	var/list/job_changes = get_map_changes()
	if(!job_changes)
		return FALSE
	return TRUE

/datum/job/proc/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :h to speak on your department's radio. To see other prefixes, look closely at your headset.</b>")

/datum/outfit/job
	name = "Standard Gear"

	var/jobtype = null

	uniform = /obj/item/clothing/under/color/grey
	id = /obj/item/card/id/advanced
	ears = /obj/item/radio/headset
	belt = /obj/item/pda
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	box = /obj/item/storage/box/survival

	var/backpack = /obj/item/storage/backpack
	var/satchel  = /obj/item/storage/backpack/satchel
	var/duffelbag = /obj/item/storage/backpack/duffelbag

	var/pda_slot = ITEM_SLOT_BELT

/datum/outfit/job/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	switch(H.backpack)
		if(GBACKPACK)
			back = /obj/item/storage/backpack //Grey backpack
		if(GSATCHEL)
			back = /obj/item/storage/backpack/satchel //Grey satchel
		if(GDUFFELBAG)
			back = /obj/item/storage/backpack/duffelbag //Grey Duffel bag
		if(LSATCHEL)
			back = /obj/item/storage/backpack/satchel/leather //Leather Satchel
		if(DSATCHEL)
			back = satchel //Department satchel
		if(DDUFFELBAG)
			back = duffelbag //Department duffel bag
		else
			back = backpack //Department backpack

	//converts the uniform string into the path we'll wear, whether it's the skirt or regular variant
	var/holder
	if(H.jumpsuit_style == PREF_SKIRT)
		holder = "[uniform]/skirt"
		if(!text2path(holder))
			holder = "[uniform]"
	else
		holder = "[uniform]"
	uniform = text2path(holder)

/datum/outfit/job/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/datum/job/J = SSjob.GetJobType(jobtype)
	if(!J)
		J = SSjob.GetJob(H.job)

	var/obj/item/card/id/C = H.wear_id
	if(istype(C))
		shuffle_inplace(C.access) // Shuffle access list to make NTNet passkeys less predictable
		C.registered_name = H.real_name
		if(H.age)
			C.registered_age = H.age
			J.get_id_titles(H, C) // SKYRAT EDIT ADD - ALT TITLES
			// C.assignment = J.title - SKYRAT EDIT - OVERWRITTEN IN ALT TITLES

		C.update_label()
		C.update_icon()
		var/datum/bank_account/B = SSeconomy.bank_accounts_by_id["[H.account_id]"]
		if(B && B.account_id == H.account_id)
			C.registered_account = B
			B.bank_cards += C
		H.sec_hud_set_ID()

	var/obj/item/pda/PDA = H.get_item_by_slot(pda_slot)
	if(istype(PDA))
		PDA.owner = H.real_name
		J.get_pda_titles(H, PDA) // SKYRAT EDIT ADD - ALT TITLES
		// PDA.ownjob = J.title - SKYRAT EDIT - OVERWRITTEN IN ALT TITLES
		PDA.update_label()

	if(H.client?.prefs.playtime_reward_cloak)
		neck = /obj/item/clothing/neck/cloak/skill_reward/playing

/datum/outfit/job/get_chameleon_disguise_info()
	var/list/types = ..()
	types -= /obj/item/storage/backpack //otherwise this will override the actual backpacks
	types += backpack
	types += satchel
	types += duffelbag
	return types

/// An overridable getter for more dynamic goodies.
/datum/job/proc/get_mail_goodies(mob/recipient)
	return mail_goodies
<<<<<<< HEAD
=======


/datum/job/proc/award_service(client/winner, award)
	return


/datum/job/proc/get_captaincy_announcement(mob/living/captain)
	return "Due to extreme staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"


/// Returns an atom where the mob should spawn in.
/datum/job/proc/get_roundstart_spawn_point()
	if(random_spawns_possible)
		if(HAS_TRAIT(SSstation, STATION_TRAIT_LATE_ARRIVALS))
			return get_latejoin_spawn_point()
		if(HAS_TRAIT(SSstation, STATION_TRAIT_RANDOM_ARRIVALS))
			return get_safe_random_station_turf(typesof(/area/hallway)) || get_latejoin_spawn_point()
		if(HAS_TRAIT(SSstation, STATION_TRAIT_HANGOVER))
			var/obj/effect/landmark/start/hangover_spawn_point
			for(var/obj/effect/landmark/start/hangover/hangover_landmark in GLOB.start_landmarks_list)
				hangover_spawn_point = hangover_landmark
				if(hangover_landmark.used) //so we can revert to spawning them on top of eachother if something goes wrong
					continue
				hangover_landmark.used = TRUE
				break
			return hangover_spawn_point || get_latejoin_spawn_point()
	if(length(GLOB.jobspawn_overrides[title]))
		return pick(GLOB.jobspawn_overrides[title])
	var/obj/effect/landmark/start/spawn_point = get_default_roundstart_spawn_point()
	if(!spawn_point) //if there isn't a spawnpoint send them to latejoin, if there's no latejoin go yell at your mapper
		return get_latejoin_spawn_point()
	return spawn_point


/// Handles finding and picking a valid roundstart effect landmark spawn point, in case no uncommon different spawning events occur.
/datum/job/proc/get_default_roundstart_spawn_point()
	for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
		if(spawn_point.name != title)
			continue
		. = spawn_point
		if(spawn_point.used) //so we can revert to spawning them on top of eachother if something goes wrong
			continue
		spawn_point.used = TRUE
		break
	if(!.)
		log_world("Couldn't find a round start spawn point for [title]")


/// Finds a valid latejoin spawn point, checking for events and special conditions.
/datum/job/proc/get_latejoin_spawn_point()
	if(length(GLOB.jobspawn_overrides[title])) //We're doing something special today.
		return pick(GLOB.jobspawn_overrides[title])
	if(length(SSjob.latejoin_trackers))
		return pick(SSjob.latejoin_trackers)
	return SSjob.get_last_resort_spawn_points()


/// Spawns the mob to be played as, taking into account preferences and the desired spawn point.
/datum/job/proc/get_spawn_mob(client/player_client, atom/spawn_point)
	var/mob/living/spawn_instance
	if(ispath(spawn_type, /mob/living/silicon/ai))
		// This is unfortunately necessary because of snowflake AI init code. To be refactored.
		spawn_instance = new spawn_type(get_turf(spawn_point), null, player_client.mob)
	else
		spawn_instance = new spawn_type(player_client.mob.loc)
		spawn_point.JoinPlayerHere(spawn_instance, TRUE)
	spawn_instance.apply_prefs_job(player_client, src)
	if(!player_client)
		qdel(spawn_instance)
		return // Disconnected while checking for the appearance ban.
	return spawn_instance


/// Applies the preference options to the spawning mob, taking the job into account. Assumes the client has the proper mind.
/mob/living/proc/apply_prefs_job(client/player_client, datum/job/job)


/mob/living/carbon/human/apply_prefs_job(client/player_client, datum/job/job)
	var/fully_randomize = GLOB.current_anonymous_theme || player_client.prefs.should_be_random_hardcore(job, player_client.mob.mind) || is_banned_from(player_client.ckey, "Appearance")
	if(!player_client)
		return // Disconnected while checking for the appearance ban.
	if(fully_randomize)
		if(CONFIG_GET(flag/enforce_human_authority) && (job.departments & DEPARTMENT_COMMAND))
			if(player_client.prefs.pref_species.id != SPECIES_HUMAN)
				player_client.prefs.pref_species = new /datum/species/human
			player_client.prefs.randomise_appearance_prefs(~RANDOMIZE_SPECIES)
		else
			player_client.prefs.randomise_appearance_prefs()
		player_client.prefs.apply_prefs_to(src)
		if(GLOB.current_anonymous_theme)
			fully_replace_character_name(null, GLOB.current_anonymous_theme.anonymous_name(src))
	else
		var/is_antag = (player_client.mob.mind in GLOB.pre_setup_antags)
		if(CONFIG_GET(flag/enforce_human_authority) && (job.departments & DEPARTMENT_COMMAND))
			player_client.prefs.randomise[RANDOM_SPECIES] = FALSE
			if(player_client.prefs.pref_species.id != SPECIES_HUMAN)
				player_client.prefs.pref_species = new /datum/species/human
		player_client.prefs.safe_transfer_prefs_to(src, TRUE, is_antag)
		if(CONFIG_GET(flag/force_random_names))
			player_client.prefs.real_name = player_client.prefs.pref_species.random_name(player_client.prefs.gender, TRUE)
	dna.update_dna_identity()


/mob/living/silicon/ai/apply_prefs_job(client/player_client, datum/job/job)
	if(GLOB.current_anonymous_theme)
		fully_replace_character_name(real_name, GLOB.current_anonymous_theme.anonymous_ai_name(TRUE))
		return
	apply_pref_name("ai", player_client) // This proc already checks if the player is appearance banned.
	set_core_display_icon(null, player_client)


/mob/living/silicon/robot/apply_prefs_job(client/player_client, datum/job/job)
	if(mmi)
		var/organic_name 
		if(GLOB.current_anonymous_theme)
			organic_name = GLOB.current_anonymous_theme.anonymous_name(src)
		else if(player_client.prefs.randomise[RANDOM_NAME] || CONFIG_GET(flag/force_random_names) || is_banned_from(player_client.ckey, "Appearance"))
			if(!player_client)
				return // Disconnected while checking the appearance ban.
			organic_name = player_client.prefs.pref_species.random_name(player_client.prefs.gender, TRUE)
		else
			if(!player_client)
				return // Disconnected while checking the appearance ban.
			organic_name = player_client.prefs.real_name

		mmi.name = "[initial(mmi.name)]: [organic_name]"
		if(mmi.brain)
			mmi.brain.name = "[organic_name]'s brain"
		if(mmi.brainmob)
			mmi.brainmob.real_name = organic_name //the name of the brain inside the cyborg is the robotized human's name.
			mmi.brainmob.name = organic_name
	// If this checks fails, then the name will have been handled during initialization.
	if(!GLOB.current_anonymous_theme && player_client.prefs.custom_names["cyborg"] != DEFAULT_CYBORG_NAME)
		apply_pref_name("cyborg", player_client)

/**
 * Called after a successful roundstart spawn.
 * Client is not yet in the mob.
 * This happens after after_spawn()
 */
/datum/job/proc/after_roundstart_spawn(mob/living/spawning, client/player_client)
	SHOULD_CALL_PARENT(TRUE)


/**
 * Called after a successful latejoin spawn.
 * Client is in the mob.
 * This happens after after_spawn()
 */
/datum/job/proc/after_latejoin_spawn(mob/living/spawning)
	SHOULD_CALL_PARENT(TRUE)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_JOB_AFTER_LATEJOIN_SPAWN, src, spawning)
>>>>>>> 6c8c797cdcc (Fixes security not getting assigned to departments (#60349))
