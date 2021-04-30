/obj/effect/mob_spawn/human/syndicate/assops
	name = "Syndicate DS-1 Operative"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/syndicate_empty
	assignedrole = "Syndicate DS-1 Operative"
	permanent = FALSE
	can_use_alias = TRUE
	any_station_species = TRUE

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

/datum/outfit/assops/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/advanced/prisoner

/datum/outfit/syndicate_empty/assops
	id = /obj/item/card/id/advanced/black
	id_trim = /datum/id_trim/chameleon/operative

//SECURITY//
/obj/effect/mob_spawn/human/syndicate/assops/prison_guard
	short_desc = "You are a brig officer aboard the Syndicate facility DS-1."
	flavour_text = "Your job is to keep the prisoners in check and ensure they do not cause trouble. Patrol the prison, DO NOT TAKE ITEMS FROM THE ARMORY."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives."
	outfit = /datum/outfit/syndicate_empty/assops/prison_guard

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
/obj/effect/mob_spawn/human/syndicate/assops/prison_warden
	short_desc = "You are a Master At Arms aboard the Syndicate facility DS-1."
	flavour_text = "Your job is to oversee facility operations and ensure a smooth running prison. You deal with executions and sentencing."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives."
	outfit = /datum/outfit/syndicate_empty/assops/prison_warden
	excluded_gamemodes = list()


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
/obj/effect/mob_spawn/human/syndicate/assops/facility_staff
	short_desc = "You are a general purpose crewmember aboard the Syndicate facility DS-1."
	flavour_text = "Your job is not combat, but instead is to run the syndicate facilites such as the bar, cooking areas, engineering and janitorial work."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/facility_staff

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

/obj/effect/mob_spawn/human/syndicate/assops/syndicate_assistant
	short_desc = "You are an operative aboard the Syndicate facility DS-1."
	flavour_text = "Your job is NOT combat, unless the assault team requires it. Otherwise you are simply there to assist the guards and warden. Or relax."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/syndicate_assistant

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
/obj/effect/mob_spawn/human/syndicate/assops/syndicate_scientist
	short_desc = "You are a scientist aboard the Syndicate facility DS-1."
	flavour_text = "Your job is that of research and development! You should further your scientific research and utilise the given tools."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/syndicate_scientist

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
/obj/effect/mob_spawn/human/syndicate/assops/station_medical_officer
	short_desc = "You are a Medical Officer aboard the Syndicate facility DS-1."
	flavour_text = "Your job is to maintain and improve the health and safety of the crew on-board."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/station_medical_officer

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
/obj/effect/mob_spawn/human/syndicate/assops/heads
	outfit = /datum/outfit/syndicate_empty/assops/heads

/datum/outfit/syndicate_empty/assops/heads
	name = "Syndicate Head Of Staff"
	ears = /obj/item/radio/headset/assault/command
	implants = list(/obj/item/implant/weapons_auth)

//Admiral//
/obj/effect/mob_spawn/human/syndicate/assops/heads/station_admiral
	short_desc = "You are the Station Admiral of Syndicate facility DS-1."
	flavour_text = "Your job is to coordinate the heads of staff onboard, and otherwise relax. Unlike those Nanotrasen NADs, yours is in no danger of being tracked."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/heads/syndicate_admiral

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
/obj/effect/mob_spawn/human/syndicate/assops/heads/chief_master_at_arms
	short_desc = "You are the Chief Master At Arms onboard the Syndicate facility DS-1."
	flavour_text = "Your job is to oversee the Brig Officers and Master At Arms."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/heads/chief_master_at_arms

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
/obj/effect/mob_spawn/human/syndicate/assops/heads/chief_research_officer
	short_desc = "You are the Chief Research Officer onboard the Syndicate facility DS-1."
	flavour_text = "Your job is to oversee the Researchers and maintain DS-1's coordinate secrecy." //An IC Solution to the problem of DS-1 Operatives getting too handsy with research, since RND consoles log who did research and where.
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/heads/chief_research_officer

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
/obj/effect/mob_spawn/human/syndicate/assops/heads/chief_engineering_officer
	short_desc = "You are the Chief Engineering Officer onboard the Syndicate facility DS-1."
	flavour_text = "Your job is to maintain DS-1's power generation and hull integrity. Or 'touching up' the disused section east of cargo."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/assops/heads/chief_engineering_officer

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
