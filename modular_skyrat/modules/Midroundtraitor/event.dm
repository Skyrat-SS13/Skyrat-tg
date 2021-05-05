/datum/round_event_control/operativetraitor
	name = "Lone Infiltrator"
	typepath = /datum/round_event/ghost_role/operativetraitor
	weight = 0 //Admin Event only. Up this for the action server, though, I reccomend 'weight = 10' personally.
	max_occurrences = 1 //One spooky blood-red man at a time, please.
	dynamic_should_hijack = TRUE

/datum/round_event/ghost_role/operativetraitor
	minimum_required = 1
	role_name = "lone infiltrator"
	fakeable = FALSE

/datum/round_event/ghost_role/operativetraitor/spawn_role()
	var/list/candidates = get_candidates(ROLE_TRAITOR, ROLE_TRAITOR)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/mob/dead/selected = pick_n_take(candidates)

	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/carpspawn/L in GLOB.landmarks_list)
		spawn_locs += L.loc
	if(!spawn_locs.len)
		return MAP_ERROR

	var/mob/living/carbon/human/operative = new(pick(spawn_locs))
	selected.client.prefs.copy_to(operative)
	operative.dna.update_dna_identity()
	operative.dna.species.before_equip_job(null, operative)
	operative.regenerate_icons()
	SSquirks.AssignQuirks(operative, selected.client, TRUE, TRUE, null, FALSE, operative)
	var/datum/mind/Mind = new /datum/mind(selected.key)
	Mind.assigned_role = "Lone Infiltrator"
	Mind.special_role = "Lone Infiltrator"
	Mind.active = TRUE
	Mind.transfer_to(operative)
	Mind.add_antag_datum(/datum/antagonist/traitor/infiltrator)

	message_admins("[ADMIN_LOOKUPFLW(operative)] has been made into lone infiltrator by an event.")
	log_game("[key_name(operative)] was spawned as a lone infiltrator by an event.")
	spawned_mobs += operative
	return SUCCESSFUL_SPAWN

//OUTFIT//
/datum/outfit/syndicateinfiltrator
	name = "Syndicate Operative - Infiltrator"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/fireproof
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/storage/belt/military
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/tank/jetpack/oxygen/harness=1,\
		/obj/item/gun/ballistic/automatic/pistol=1,\
		/obj/item/kitchen/knife/combat/survival)

	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/syndicateinfiltrator/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE
	H.update_icons()
