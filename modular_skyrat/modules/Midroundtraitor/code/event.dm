/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator
	name = "Lone Infiltrator"
	antag_datum = /datum/antagonist/traitor/infiltrator
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	antag_flag = ROLE_LONE_INFILTRATOR
	restricted_roles = list(JOB_CYBORG, JOB_AI, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_HEAD_OF_SECURITY, JOB_CAPTAIN, JOB_CORRECTIONS_OFFICER, JOB_VANGUARD_OPERATIVE, JOB_NT_REP, JOB_BLUESHIELD, JOB_ORDERLY, JOB_BOUNCER, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_SCIENCE_GUARD) //SKYRAT EDIT - Sec_haul
	required_candidates = 1
	weight = 5 //Slightly less common than normal midround traitors.
	cost = 15 //But also slightly more costly.
	requirements = list(50,40,30,20,10,10,10,10,10,10)
	var/list/spawn_locs = list()

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/execute()
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		spawn_locs += (C.loc)
	if(!spawn_locs.len)
		message_admins("No valid spawn locations found, aborting...")
		return MAP_ERROR
	. = ..()

/datum/dynamic_ruleset/midround/from_ghosts/lone_infiltrator/generate_ruleset_body(mob/applicant)
	var/datum/mind/player_mind = new /datum/mind(applicant.key)

	var/mob/living/carbon/human/operative = new(pick(spawn_locs))
	applicant.client.prefs.safe_transfer_prefs_to(operative)
	operative.dna.update_dna_identity()
	operative.dna.species.pre_equip_species_outfit(null, operative)
	operative.regenerate_icons()
	SSquirks.AssignQuirks(operative, applicant.client, TRUE, TRUE, null, FALSE, operative)
	player_mind.set_assigned_role(SSjob.GetJobType(/datum/job/lone_operative))
	player_mind.special_role = "Lone Infiltrator"
	player_mind.active = TRUE
	player_mind.transfer_to(operative)
	player_mind.add_antag_datum(/datum/antagonist/traitor/infiltrator)

	message_admins("[ADMIN_LOOKUPFLW(operative)] has been made into lone infiltrator by midround ruleset.")
	log_game("[key_name(operative)] was spawned as a lone infiltrator by midround ruleset.")
	return operative

//OUTFIT//
/datum/outfit/syndicateinfiltrator
	name = "Syndicate Operative - Infiltrator"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/mod/control/pre_equipped/nuclear
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/storage/belt/military
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/tank/jetpack/oxygen/harness=1,\
		/obj/item/gun/ballistic/automatic/pistol=1,\
		/obj/item/knife/combat/survival)

	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/syndicateinfiltrator/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE
	H.update_icons()
