//If someone can do this in a neater way, be my guest-Kor

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).


//HEY! LISTEN! anything that is ALIVE and thus GHOSTS CAN TAKE is in ghost_role_spawners.dm!

/obj/effect/mob_spawn
	name = "Mob Spawner"
	density = TRUE
	anchored = TRUE
	icon = 'icons/effects/mapping_helpers.dmi' // These aren't *really* mapping helpers but it fits the most with it's common usage (to help place corpses in maps)
	icon_state = "mobspawner" // So it shows up in the map editor
	var/mob_type = null
	var/mob_name = ""
	var/mob_gender = null
	var/death = TRUE //Kill the mob
	var/roundstart = TRUE //fires on initialize
	var/instant = FALSE //fires on New
	var/short_desc = "The mapper forgot to set this!"
	var/flavour_text = ""
	var/important_info = ""
	/// Lazy string list of factions that the spawned mob will be in upon spawn
	var/list/faction
	var/permanent = FALSE //If true, the spawner will not disappear upon running out of uses.
	var/random = FALSE //Don't set a name or gender, just go random
	var/antagonist_type
	var/objectives = null
	var/uses = 1 //how many times can we spawn from it. set to -1 for infinite.
	var/brute_damage = 0
	var/oxy_damage = 0
	var/burn_damage = 0
	var/datum/disease/disease = null //Do they start with a pre-spawned disease?
	var/mob_color //Change the mob's color
	/// Typepath indicating the kind of job datum this ert member will have.
	var/spawner_job_path = /datum/job/ghost_role
	var/show_flavour = TRUE
	var/banType = ROLE_LAVALAND
	var/ghost_usable = TRUE
	var/list/excluded_gamemodes
	// If the spawner is ready to function at the moment
	var/ready = TRUE
	/// If the spawner uses radials
	var/radial_based = FALSE


//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/effect/mob_spawn/attack_ghost(mob/user)
	if(!SSticker.HasRoundStarted() || !loc || !ghost_usable)
		return
	if(!radial_based)
		var/ghost_role = tgui_alert(usr, "Become [mob_name]? (Warning, You can no longer be revived!)",, list("Yes", "No"))
		if(ghost_role != "Yes" || !loc || QDELETED(user))
			return
	//SKYRAT EDIT ADDITION BEGIN
	if(!extra_prompts(user))
		return

	if(SSticker.mode.type in excluded_gamemodes)
		to_chat(user, "<span class='warning'>Error, unable to spawn.</span>")
		return

	if(is_banned_from(user.ckey, BAN_GHOST_ROLE_SPAWNER))
		to_chat(user, "Error, you are banned from playing ghost roles!")
		return
	//SKYRAT EDIT ADDITION END

	if(!(GLOB.ghost_role_flags & GHOSTROLE_SPAWNER) && !(flags_1 & ADMIN_SPAWNED_1))
		to_chat(user, span_warning("An admin has temporarily disabled non-admin ghost roles!"))
		return
	if(!uses)
		to_chat(user, span_warning("This spawner is out of charges!"))
		return
	if(is_banned_from(user.key, banType))
		to_chat(user, span_warning("You are jobanned!"))
		return
	if(!allow_spawn(user))
		return
	if(QDELETED(src) || QDELETED(user))
		return
	log_game("[key_name(user)] became [mob_name]")
	//create(ckey = user.ckey) //ORIGINAL
	create(user.ckey, null, user) //SKYRAT EDIT CHANGE

/obj/effect/mob_spawn/Initialize(mapload)
	. = ..()
	if(faction)
		faction = string_list(faction)
	if(instant || (roundstart && (mapload || (SSticker && SSticker.current_state > GAME_STATE_SETTING_UP))))
		INVOKE_ASYNC(src, .proc/create)
	else if(ghost_usable)
		SSpoints_of_interest.make_point_of_interest(src)
		LAZYADD(GLOB.mob_spawners[name], src)

/obj/effect/mob_spawn/Destroy()
	var/list/spawners = GLOB.mob_spawners[name]
	LAZYREMOVE(spawners, src)
	if(!LAZYLEN(spawners))
		GLOB.mob_spawners -= name
	return ..()

//SKYRAT EDIT ADDITION BEGIN
/obj/effect/mob_spawn/proc/extra_prompts(mob/user)
	return TRUE

/obj/effect/mob_spawn/proc/create_mob(mob/user, newname)
	var/mob/living/M = new mob_type(get_turf(src)) //living mobs only
	if(!random || newname)
		if(newname)
			M.real_name = newname
		else
			M.real_name = mob_name ? mob_name : M.name
		if(!mob_gender)
			mob_gender = pick(MALE, FEMALE)
		M.gender = mob_gender
	return M
//SKYRAT EDIT ADDITION END

/obj/effect/mob_spawn/proc/allow_spawn(mob/user) //Override this to add spawn limits to a ghost role
	return TRUE

/obj/effect/mob_spawn/proc/special(mob/M)
	return

/obj/effect/mob_spawn/proc/equip(mob/M)
	return

///obj/effect/mob_spawn/proc/create(mob/user, newname) //ORIGINAL
/obj/effect/mob_spawn/proc/create(ckey, newname, mob/user) //SKYRAT EDIT CHANGE
	//SKYRAT EDIT CHANGE BEGIN
	//var/mob/living/M = new mob_type(get_turf(src)) //ORIGINAL
	var/mob/living/M = create_mob(user, newname)
	/*
	if(!random || newname)
		if(newname)
			M.real_name = newname
		else if(!M.unique_name)
			M.real_name = mob_name ? mob_name : M.name
		if(!mob_gender)
			mob_gender = pick(MALE, FEMALE)
		if(ishuman(M))
			var/mob/living/carbon/human/hoomie = M
			hoomie.body_type = mob_gender
	*/
	//SKYRAT EDIT CHANGE END
	if(faction)
		M.faction = faction
	if(disease)
		M.ForceContractDisease(new disease)
	if(death)
		M.death(1) //Kills the new mob

	M.adjustOxyLoss(oxy_damage)
	M.adjustBruteLoss(brute_damage)
	M.adjustFireLoss(burn_damage)
	M.color = mob_color
	equip(M)

	if(user?.ckey)
		M.ckey = user.ckey
		if(show_flavour)
			var/output_message = "<span class='infoplain'><span class='big bold'>[short_desc]</span></span>"
			if(flavour_text != "")
				output_message += "\n<span class='infoplain'><b>[flavour_text]</b></span>"
			if(important_info != "")
				output_message += "\n[span_userdanger("[important_info]")]"
			to_chat(M, output_message)
		var/datum/mind/MM = M.mind
		var/datum/antagonist/A
		if(antagonist_type)
			A = MM.add_antag_datum(antagonist_type)
		if(objectives)
			if(!A)
				A = MM.add_antag_datum(/datum/antagonist/custom)
			for(var/objective in objectives)
				var/datum/objective/O = new/datum/objective(objective)
				O.owner = MM
				A.objectives += O
		M.mind.set_assigned_role(SSjob.GetJobType(spawner_job_path))
		special(M)
		MM.name = M.real_name
	if(uses > 0)
		uses--
	if(!permanent && !uses)
		qdel(src)
	return M

// Base version - place these on maps/templates.
/obj/effect/mob_spawn/human
	mob_type = /mob/living/carbon/human
	//Human specific stuff.
	//var/mob_species = null //Set to make them a mutant race such as lizard or skeleton. Uses the datum typepath instead of the ID. //ORIGINAL
	var/mob_species = /datum/species/human //SKYRAT EDIT CHANGE
	var/datum/outfit/outfit = /datum/outfit	//If this is a path, it will be instanced in Initialize()
	var/disable_pda = TRUE
	var/disable_sensors = TRUE
	spawner_job_path = /datum/job/ghost_role

	var/husk = null
	//these vars are for lazy mappers to override parts of the outfit
	//these cannot be null by default, or mappers cannot set them to null if they want nothing in that slot
	var/uniform = -1
	var/r_hand = -1
	var/l_hand = -1
	var/suit = -1
	var/shoes = -1
	var/gloves = -1
	var/ears = -1
	var/glasses = -1
	var/mask = -1
	var/head = -1
	var/belt = -1
	var/r_pocket = -1
	var/l_pocket = -1
	var/back = -1
	var/id = -1
	var/neck = -1
	var/backpack_contents = -1
	var/suit_store = -1

	var/hairstyle
	var/facial_hairstyle
	var/haircolor
	var/facial_haircolor
	var/skin_tone
	//SKYRAT EDIT ADDITION BEGIN
	var/can_use_pref_char = TRUE
	var/can_use_alias = FALSE
	var/any_station_species = FALSE
	var/chosen_alias
	var/is_pref_char
	var/last_ckey //For validation of the user
	//SKYRAT EDIT ADDITION END

//SKYRAT EDIT ADDITION BEGIN
/obj/effect/mob_spawn/human/extra_prompts(mob/user)
	last_ckey = user.ckey
	chosen_alias = null
	is_pref_char = null
	if(can_use_pref_char)
		var/initial_string = "Would you like to spawn as a randomly created character, or use the one currently selected in your preferences?"
		var/action = tgui_alert(user, initial_string, "", list("Use Random Character", "Use Character From Preferences"))
		if(action && action == "Use Character From Preferences")
			var/warning_string = "WARNING: This spawner will use your currently selected character in prefs ([user.client.prefs?.read_preference(/datum/preference/name/real_name)])\nMake sure that the character is not used as a station crew, or would have a good reason to be this role.(ie. intern in Space Hotel)\nUSING STATION CHARACTERS FOR SYNDICATE OR HOSTILE ROLES IS PROHIBITED WILL GET YOU BANNED!\nConsider making a character dedicated to the role.\nDo you wanna proceed?"
			var/action2 = tgui_alert(user, warning_string, "", list("Yes", "No"))
			if(action2 && action2 == "Yes")
				is_pref_char = TRUE
			else
				return FALSE

	if(can_use_alias)
		var/action = tgui_alert(user, "Would you like to use an alias?\nIf you do, your name will be changed to that", "", list("Dont Use Alias", "Use Alias"))
		if(action && action == "Use Alias")
			var/msg = reject_bad_name(input(user, "Set your character's alias for this role", "Alias") as text|null)
			if(!msg)
				return FALSE
			chosen_alias = msg

	if(is_pref_char)
		var/species_type = user.client.prefs.read_preference(/datum/preference/choiced/species)
		if(!any_station_species && species_type != mob_species)
			alert(user, "Sorry, This spawner is limited to those species: [mob_species]. Please switch your character.", "", "Ok")
			return FALSE

	if(QDELETED(src) || QDELETED(user))
		return FALSE
	//What's happening here?
	//This function is fairly asynchronous and doesnt keep variables in context, so this check is for validation that we are using the correct user
	if(last_ckey != user.ckey)
		return FALSE
	return TRUE

/obj/effect/mob_spawn/human/create_mob(mob/user, newname)
	var/mob/living/carbon/human/H = new mob_type(get_turf(src))
	if(is_pref_char && user?.client)
		user.client.prefs.safe_transfer_prefs_to(H)
		H.dna.update_dna_identity()
		if(chosen_alias)
			H.name = chosen_alias
			H.real_name = chosen_alias
		//Pre-job equips so Voxes dont die
		H.dna.species.pre_equip_species_outfit(null, H)
		H.regenerate_icons()
		SSquirks.AssignQuirks(H, user.client, TRUE, TRUE, null, FALSE, H)
		for(var/datum/loadout_item/item as anything in loadout_list_to_datums(H?.client?.prefs?.loadout_list))
			item.post_equip_item(H.client?.prefs, H)
	else
		if(!random || newname)
			if(newname)
				H.real_name = newname
			else
				H.real_name = mob_name ? mob_name : H.name
			if(!mob_gender)
				mob_gender = pick(MALE, FEMALE)
			H.gender = mob_gender
			H.body_type = mob_gender
		if(mob_species)
			H.set_species(mob_species)
		H.underwear = "Nude"
		H.undershirt = "Nude"
		H.socks = "Nude"
		if(hairstyle)
			H.hairstyle = hairstyle
		else
			H.hairstyle = random_hairstyle(H.gender)
		if(facial_hairstyle)
			H.facial_hairstyle = facial_hairstyle
		else
			H.facial_hairstyle = random_facial_hairstyle(H.gender)
		if(skin_tone)
			H.skin_tone = skin_tone
		else
			H.skin_tone = random_skin_tone()
		H.update_hair()
		H.update_body()
	return H
//SKYRAT EDIT ADDITION END

/obj/effect/mob_spawn/human/Initialize(mapload)
	if(ispath(outfit))
		outfit = new outfit()
	if(!outfit)
		outfit = new /datum/outfit
	return ..()

/obj/effect/mob_spawn/human/equip(mob/living/carbon/human/H)
	//SKYRAT EDIT REMOVAL BEGIN - MOVED
	/*
	if(mob_species)
		H.set_species(mob_species)
	*/
	//SKYRAT EDIT REMOVAL END
	if(husk)
		H.Drain()
	else //Because for some reason I can't track down, things are getting turned into husks even if husk = false. It's in some damage proc somewhere.
		H.cure_husk()
	//SKYRAT EDIT REMOVAL BEGIN - MOVED
	/*
	H.underwear = "Nude"
	H.undershirt = "Nude"
	H.socks = "Nude"
	if(hairstyle)
		H.hairstyle = hairstyle
	else
		H.hairstyle = random_hairstyle(H.gender)
	if(facial_hairstyle)
		H.facial_hairstyle = facial_hairstyle
	else
		H.facial_hairstyle = random_facial_hairstyle(H.gender)
	if(haircolor)
		H.hair_color = haircolor
	else
		H.hair_color = random_short_color()
	if(facial_haircolor)
		H.facial_hair_color = facial_haircolor
	else
		H.facial_hair_color = random_short_color()
	if(skin_tone)
		H.skin_tone = skin_tone
	else
		H.skin_tone = random_skin_tone()
	H.update_hair()
	H.update_body()
	*/
	//SKYRAT EDIT REMOVAL END
	if(outfit)
		var/static/list/slots = list("uniform", "r_hand", "l_hand", "suit", "shoes", "gloves", "ears", "glasses", "mask", "head", "belt", "r_pocket", "l_pocket", "back", "id", "neck", "backpack_contents", "suit_store")
		for(var/slot in slots)
			var/T = vars[slot]
			if(!isnum(T))
				outfit.vars[slot] = T
		H.equipOutfit(outfit)
		if(disable_pda)
			// We don't want corpse PDAs to show up in the messenger list.
			var/obj/item/pda/PDA = locate(/obj/item/pda) in H
			if(PDA)
				PDA.toff = TRUE
		if(disable_sensors)
			// Using crew monitors to find corpses while creative makes finding certain ruins too easy.
			var/obj/item/clothing/under/C = H.w_uniform
			if(istype(C))
				C.sensor_mode = NO_SENSORS
				H.update_suit_sensors()

	var/obj/item/card/id/W = H.wear_id
	if(W)
		if(H.age)
			W.registered_age = H.age
		W.registered_name = H.real_name
		W.update_label()
		W.update_icon()

//Instant version - use when spawning corpses during runtime
/obj/effect/mob_spawn/human/corpse
	icon_state = "corpsehuman"
	roundstart = FALSE
	instant = TRUE

/obj/effect/mob_spawn/human/corpse/damaged
	brute_damage = 1000

//i left this here despite being a mob spawner because this is a base type
/obj/effect/mob_spawn/human/alive
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	death = FALSE
	roundstart = FALSE //you could use these for alive fake humans on roundstart but this is more common scenario

/obj/effect/mob_spawn/human/corpse/delayed
	ghost_usable = FALSE //These are just not-yet-set corpses.
	instant = FALSE
	invisibility = 101 // a fix for the icon not wanting to cooperate

//Non-human spawners

/obj/effect/mob_spawn/AICorpse/create(mob/user) //Creates a corrupted AI
	var/A = locate(/mob/living/silicon/ai) in loc
	if(A)
		return
	var/mob/living/silicon/ai/spawned/M = new(loc) //spawn new AI at landmark as var M
	M.name = src.name
	M.real_name = src.name
	M.aiPDA.toff = TRUE //turns the AI's PDA messenger off, stopping it showing up on player PDAs
	M.death() //call the AI's death proc
	qdel(src)

/obj/effect/mob_spawn/slime
	mob_type = /mob/living/simple_animal/slime
	var/mobcolour = "grey"
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey baby slime" //sets the icon in the map editor

/obj/effect/mob_spawn/slime/equip(mob/living/simple_animal/slime/S)
	S.colour = mobcolour

/obj/effect/mob_spawn/facehugger/create(mob/user) //Creates a squashed facehugger
	var/obj/item/clothing/mask/facehugger/O = new(src.loc) //variable O is a new facehugger at the location of the landmark
	O.name = src.name
	O.Die() //call the facehugger's death proc
	qdel(src)

// I'll work on making a list of corpses people request for maps, or that I think will be commonly used. Syndicate operatives for example.

///////////Civilians//////////////////////

/obj/effect/mob_spawn/human/corpse/assistant
	name = "Assistant"
	outfit = /datum/outfit/job/assistant
	icon_state = "corpsegreytider"

/obj/effect/mob_spawn/human/corpse/assistant/beesease_infection
	disease = /datum/disease/beesease

/obj/effect/mob_spawn/human/corpse/assistant/brainrot_infection
	disease = /datum/disease/brainrot

/obj/effect/mob_spawn/human/corpse/assistant/spanishflu_infection
	disease = /datum/disease/fluspanish

/obj/effect/mob_spawn/human/corpse/cargo_tech
	name = "Cargo Tech"
	outfit = /datum/outfit/job/cargo_tech
	icon_state = "corpsecargotech"

/obj/effect/mob_spawn/human/cook
	name = "Cook"
	outfit = /datum/outfit/job/cook
	icon_state = "corpsecook"

/obj/effect/mob_spawn/human/doctor
	name = "Doctor"
	outfit = /datum/outfit/job/doctor
	icon_state = "corpsedoctor"

/obj/effect/mob_spawn/human/geneticist
	name = "Geneticist"
	outfit = /datum/outfit/job/geneticist
	icon_state = "corpsescientist"

/obj/effect/mob_spawn/human/engineer
	name = "Engineer"
	outfit = /datum/outfit/job/engineer/gloved
	icon_state = "corpseengineer"

/obj/effect/mob_spawn/human/engineer/rig
	outfit = /datum/outfit/job/engineer/gloved/rig

/obj/effect/mob_spawn/human/engineer/rig/gunner
	outfit = /datum/outfit/job/engineer/gloved/rig/gunner

/obj/effect/mob_spawn/human/clown
	name = "Clown"
	outfit = /datum/outfit/job/clown
	icon_state = "corpseclown"

/obj/effect/mob_spawn/human/scientist
	name = "Scientist"
	outfit = /datum/outfit/job/scientist
	icon_state = "corpsescientist"

/obj/effect/mob_spawn/human/miner
	name = "Shaft Miner"
	outfit = /datum/outfit/job/miner
	icon_state = "corpseminer"

/obj/effect/mob_spawn/human/miner/rig
	outfit = /datum/outfit/job/miner/equipped/hardsuit

/obj/effect/mob_spawn/human/miner/explorer
	outfit = /datum/outfit/job/miner/equipped

/obj/effect/mob_spawn/human/plasmaman
	mob_species = /datum/species/plasmaman
	outfit = /datum/outfit/plasmaman

/obj/effect/mob_spawn/human/bartender
	name = "Space Bartender"
	outfit = /datum/outfit/spacebartender

/obj/effect/mob_spawn/human/beach
	outfit = /datum/outfit/beachbum

/////////////////Officers+Nanotrasen Security//////////////////////

/obj/effect/mob_spawn/human/bridgeofficer
	name = "Bridge Officer"
	outfit = /datum/outfit/nanotrasenbridgeofficercorpse

/datum/outfit/nanotrasenbridgeofficercorpse
	name = "Bridge Officer Corpse"
	ears = /obj/item/radio/headset/heads/hop
	uniform = /obj/item/clothing/under/rank/centcom/officer
	suit = /obj/item/clothing/suit/armor/bulletproof
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/corpse/bridge_officer

/obj/effect/mob_spawn/human/commander
	name = "Commander"
	outfit = /datum/outfit/nanotrasencommandercorpse

/datum/outfit/nanotrasencommandercorpse
	name = "\improper Nanotrasen Private Security Commander"
	uniform = /obj/item/clothing/under/rank/centcom/commander
	suit = /obj/item/clothing/suit/armor/bulletproof
	ears = /obj/item/radio/headset/heads/captain
	glasses = /obj/item/clothing/glasses/eyepatch
	mask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	head = /obj/item/clothing/head/centhat
	gloves = /obj/item/clothing/gloves/tackler/combat
	shoes = /obj/item/clothing/shoes/combat/swat
	r_pocket = /obj/item/lighter
	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/corpse/commander

/obj/effect/mob_spawn/human/nanotrasensoldier
	name = "\improper Nanotrasen Private Security Officer"
	outfit = /datum/outfit/nanotrasensoldiercorpse

/datum/outfit/nanotrasensoldiercorpse
	name = "NT Private Security Officer Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/centcom/corpse/private_security

/obj/effect/mob_spawn/human/intern //this is specifically the comms intern from the event
	name = "CentCom Intern"
	outfit = /datum/outfit/centcom/centcom_intern/unarmed
	mob_name = "Nameless Intern"
	mob_gender = MALE

/////////////////Spooky Undead//////////////////////
//there are living variants of many of these, they're now in ghost_role_spawners.dm

/obj/effect/mob_spawn/human/skeleton
	name = "skeletal remains"
	mob_name = "skeleton"
	mob_species = /datum/species/skeleton
	mob_gender = NEUTER

/obj/effect/mob_spawn/human/zombie
	name = "rotting corpse"
	mob_name = "zombie"
	mob_species = /datum/species/zombie
	spawner_job_path = /datum/job/zombie

/obj/effect/mob_spawn/human/abductor
	name = "abductor"
	mob_name = "alien"
	mob_species = /datum/species/abductor
	outfit = /datum/outfit/abductorcorpse

/datum/outfit/abductorcorpse
	name = "Abductor Corpse"
	uniform = /obj/item/clothing/under/color/grey
	shoes = /obj/item/clothing/shoes/combat
