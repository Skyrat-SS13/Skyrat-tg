/obj/effect/mob_spawn/human/syndicate/assops
	name = "Syndicate Assault Guard"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/syndicate_empty
	assignedrole = "Syndicate DS-1 Operative"
	permanent = FALSE
	can_use_alias = TRUE
	any_station_species = TRUE
	excluded_gamemodes = list(/datum/game_mode/assaultops)

//PRISONERS//
/obj/effect/mob_spawn/human/assops_prisoner
	name = "Syndicate Prisoner"
	short_desc = "You are the syndicate prisoner aboard an unknown station."
	flavour_text = "You don't know where you are, but you know you are a prisoner. Perhaps that guard knows more?"
	important_info = "Admin-help before you provoke the Syndicate."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/assops/prisoner
	roundstart = FALSE
	permanent = FALSE
	death = FALSE
	can_use_alias = TRUE
	any_station_species = TRUE
	excluded_gamemodes = list(/datum/game_mode/assaultops)

/datum/outfit/assops/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/advanced/prisoner

/datum/outfit/syndicate_empty/assops
	id = /obj/item/card/id/advanced/black
	id_trim = /datum/id_trim/chameleon/operative

//SECURITY//
/obj/effect/mob_spawn/human/syndicate/assops/empty
	name = "Syndicate Operative"
	short_desc = "You are an operative aboard the Syndicate facility DS-1."
	flavour_text = "Your job is to be decided on arrival."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives."
	outfit = /datum/outfit/syndicate_empty
	excluded_gamemodes = list(/datum/game_mode/assaultops)

/obj/effect/mob_spawn/human/syndicate/assops/empty/special(mob/living/new_spawn)
	var/list/loadouts = list(
		"cqb" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "cqb"),
		"demoman" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "demoman"),
		"medic" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "medic"),
		"heavy" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "heavy"),
		"assault" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "assault"),
		"sniper" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "sniper"),
		"tech" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "tech"),
		)

	var/chosen_loadout = show_radial_menu(new_spawn, new_spawn, loadouts, radius = 40)

	var/datum/outfit/assaultops/chosen_loadout_type

	var/loadout_desc = ""

	switch(chosen_loadout)
		if("cqb")
			chosen_loadout_type = /datum/outfit/assaultops/cqb
			loadout_desc = "<span class='notice'>You have chosen the CQB class, your role is to deal with hand-to-hand combat!</span>"
		if("demoman")
			chosen_loadout_type = /datum/outfit/assaultops/demoman
			loadout_desc = "<span class='notice'>You have chosen the Demolitions class, your role is to blow shit up!</span>"
		if("medic")
			chosen_loadout_type = /datum/outfit/assaultops/medic
			loadout_desc = "<span class='notice'>You have chosen the Medic class, your role is providing medical aid to fellow operatives!</span>"
		if("heavy")
			chosen_loadout_type = /datum/outfit/assaultops/heavy
			loadout_desc = "<span class='notice'>You have chosen the Heavy class, your role is continuous suppression!</span>"
		if("assault")
			chosen_loadout_type = /datum/outfit/assaultops/assault
			loadout_desc = "<span class='notice'>You have chosen the Assault class, your role is general combat!</span>"
		if("sniper")
			chosen_loadout_type = /datum/outfit/assaultops/sniper
			loadout_desc = "<span class='notice'>You have chosen the Sniper class, your role is suppressive fire!</span>"
		if("tech")
			chosen_loadout_type = /datum/outfit/assaultops/tech
			loadout_desc = "<span class='notice'>You have chosen the Tech class, your role is hacking!</span>"
		else
			chosen_loadout_type = pick(/datum/outfit/assaultops/cqb, /datum/outfit/assaultops/demoman, /datum/outfit/assaultops/medic, /datum/outfit/assaultops/heavy, /datum/outfit/assaultops/assault, /datum/outfit/assaultops/sniper, /datum/outfit/assaultops/tech)

	if(!chosen_loadout)
		chosen_loadout_type = /datum/outfit/assaultops

	new_spawn.equipOutfit(chosen_loadout_type)

	to_chat(new_spawn, loadout_desc)

	return TRUE

/datum/outfit/syndicate_empty/assops/prison_guard
	name = "Syndicate Brig Officer"
	head = /obj/item/clothing/head/helmet/swat
	suit = /obj/item/clothing/suit/armor/bulletproof
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/assault
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/security/full
	implants = list(/obj/item/implant/weapons_auth)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/brigofficer

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

/datum/outfit/syndicate_empty/assops/prison_warden
	name = "Syndicate Master At Arms"
	head = /obj/item/clothing/head/warden/syndicate
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/assault
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	belt = /obj/item/storage/belt/security/full

	id_trim = /datum/id_trim/syndicom/skyrat/assault/masteratarms

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)


//SERVICE//

/datum/outfit/syndicate_empty/assops/facility_staff
	name = "Syndicate Facility Staff"
	suit = /obj/item/clothing/suit/armor/bulletproof
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/assault
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/syndicatestaff

/datum/outfit/syndicate_empty/assops/syndicate_assistant
	name = "Syndicate Assistant"//Ditto
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/assault
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/assistant

//SCIENCE//
/datum/outfit/syndicate_empty/assops/syndicate_scientist
	name = "Syndicate Researcher"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/assault
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/researcher

//MEDICAL//
/datum/outfit/syndicate_empty/assops/station_medical_officer
	name = "Syndicate Medical Officer"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat/medical
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/assault
	back = /obj/item/storage/backpack/medic
	implants = list(/obj/item/implant/weapons_auth)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationmedicalofficer

//HEADS OF STAFF//
/datum/outfit/syndicate_empty/assops/heads
	name = "Syndicate Head Of Staff"
	ears = /obj/item/radio/headset/assault/command
	implants = list(/obj/item/implant/weapons_auth)

//Admiral//
/datum/outfit/syndicate_empty/assops/heads/syndicate_admiral
	name = "Syndicate Admiral"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	head = /obj/item/clothing/head/hos/beret/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/aps)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationadmiral

//Chief Master At Arms//
/datum/outfit/syndicate_empty/assops/heads/chief_master_at_arms
	name = "Chief Master At Arms"
	uniform = /obj/item/clothing/under/rank/security/head_of_security
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	head = /obj/item/clothing/head/hos/beret/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/security/full
	backpack_contents = list(/obj/item/storage/box/handcuffs)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/chiefmasteratarms

//Chief Research Officer//
/datum/outfit/syndicate_empty/assops/heads/chief_research_officer
	name = "Chief Research Officer"
	uniform = /obj/item/clothing/under/rank/rnd/research_director
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/science
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/chiefresearchofficer

//Chief Engineering Officer//
/datum/outfit/syndicate_empty/assops/heads/chief_engineering_officer
	name = "Chief Engineering Officer"
	uniform = /obj/item/clothing/under/rank/engineering/chief_engineer
	head = /obj/item/clothing/head/hardhat/white
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/industrial
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic)

	id_trim = /datum/id_trim/syndicom/skyrat/assault/chiefengineeringofficer

	skillchips = list(/obj/item/skillchip/job/engineer)
