//SPAWNERS//
/obj/effect/mob_spawn/human/oldsec
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	short_desc = "You are a security officer working for Nanotrasen, stationed onboard a supplementary, code charlie outpost station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Intelligence blaring an alarm - then the cold, wet darkness. As you open \
	your eyes, a dark feeling swells in your gut as metal creaks in the distance..."
	uniform = /obj/item/clothing/under/rank/security/peacekeeper

/obj/effect/mob_spawn/human/oldeng
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	short_desc = "You are an engineer working for Nanotrasen, stationed onboard a supplementary, code charlie outpost station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Intelligence blaring an alarm - then the cold, wet darkness. As you open \
	your eyes, a dark feeling swells in your gut as metal creaks in the distance..."

/obj/effect/mob_spawn/human/oldsci
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	short_desc = "You are a scientist working for Nanotrasen, stationed onboard a supplementary, code charlie outpost station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Intelligence blaring an alarm - then the cold, wet darkness. As you open \
	your eyes, a dark feeling swells in your gut as metal creaks in the distance..."

/obj/effect/mob_spawn/human/blackmarket
	name = "cryogenics pod"
	desc = "A humming cryo pod. The machine is attempting to wake up its occupant."
	mob_name = "a black market dealer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a black market dealer, with shop set up in Nanotrasen Space."
	flavour_text = "FTU, Independent.. whatever, whoever you are. It doesn't matter out here. \
	You've set up shop in a slightly shady, yet functional little asteroid for your dealings. \
	Explore space, find valuable artifacts and nice loot - and pawn it off to those stooges at NT. \
	Or perhaps more exotic customers are in local space...?"
	important_info = "You are not an antagonist."
	uniform = /obj/item/clothing/under/rank/cargo/tech
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/away/blackmarket
	assignedrole = "Black Market Dealer"
	can_use_alias = TRUE
	any_station_species = TRUE

/obj/effect/mob_spawn/human/ds2/prisoner
	name = "Syndicate Prisoner"
	short_desc = "You are the syndicate prisoner aboard an unknown station."
	flavour_text = "You don't know where you are, but you know you are a prisoner. The plastitanium clues you into your captors.. as for why you're here? That's up to you."
	important_info = "You are still subject to standard prisoner policy, and must Adminhelp before antagonizing Interdyne."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/ds2/prisoner
	roundstart = FALSE
	permanent = FALSE
	death = FALSE
	can_use_alias = TRUE
	any_station_species = TRUE

/obj/effect/mob_spawn/human/ds2/syndicate
	name = "Syndicate Operative"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	can_use_alias = TRUE
	any_station_species = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	short_desc = "You are a syndicate operative, employed in a top secret research facility developing biological weapons."
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has begun mining in this sector. Continue operating as best you can, and try to keep a low profile."
	important_info = "You are not an antagonist."
	outfit = /datum/outfit/ds2/syndicate
	assignedrole = "DS-2 Operative"

/obj/effect/mob_spawn/human/ds2/syndicate/special(mob/living/new_spawn)
	new_spawn.grant_language(/datum/language/codespeak, TRUE, TRUE, LANGUAGE_MIND)

/obj/effect/mob_spawn/human/ds2/syndicate/service
	outfit = /datum/outfit/ds2/syndicate/service
	assignedrole = "DS-2 Service Staff"

/obj/effect/mob_spawn/human/ds2/syndicate/enginetech
	outfit = /datum/outfit/ds2/syndicate/enginetech
	assignedrole = "DS-2 Engine Technician"

/obj/effect/mob_spawn/human/ds2/syndicate/researcher
	outfit = /datum/outfit/ds2/syndicate/researcher
	assignedrole = "DS-2 Researcher"

/obj/effect/mob_spawn/human/ds2/syndicate/stationmed
	outfit = /datum/outfit/ds2/syndicate/stationmed
	assignedrole = "DS-2 Station Medical Officer"

/obj/effect/mob_spawn/human/ds2/syndicate/masteratarms
	outfit = /datum/outfit/ds2/syndicate/masteratarms
	assignedrole = "DS-2 Master At Arms"

/obj/effect/mob_spawn/human/ds2/syndicate/brigoff
	outfit = /datum/outfit/ds2/syndicate/brigoff
	assignedrole = "DS-2 Brig Officer"

/obj/effect/mob_spawn/human/ds2/syndicate/admiral
	outfit = /datum/outfit/ds2/syndicate/admiral
	assignedrole = "DS-2 Station Admiral"

//OUTFITS//
/datum/outfit/syndicatespace/syndicrew
	ears = /obj/item/radio/headset/cybersun
	id_trim = /datum/id_trim/syndicom/skyrat/crew

/datum/outfit/syndicatespace/syndicaptain
	ears = /obj/item/radio/headset/cybersun/captain
	id_trim = /datum/id_trim/syndicom/skyrat/captain

/datum/outfit/ds2/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/advanced/prisoner

/datum/outfit/ds2/syndicate
	name = "DS-2 Operative"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/assault/assistant

/datum/outfit/ds2/syndicate/service
	name = "DS-2 Staff"
	uniform = /obj/item/clothing/under/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/syndicatestaff

/datum/outfit/ds2/syndicate/enginetech
	name = "DS-2 Engine Technician"
	uniform = /obj/item/clothing/under/utility/eng/syndicate
	id_trim = /datum/id_trim/syndicom/skyratnoicon/enginetechnician
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/ds2/syndicate/research
	name = "DS-2 Researcher"
	uniform = /obj/item/clothing/under/utility/sci/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/researcher

/datum/outfit/ds2/syndicate/stationmed
	name = "DS-2 Station Medical Officer"
	uniform = /obj/item/clothing/under/utility/med/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationmedicalofficer

/datum/outfit/ds2/syndicate/masteratarms
	name = "DS-2 Master At Arms"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/masteratarms
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	head = /obj/item/clothing/head/warden/syndicate
	ears = /obj/item/radio/headset/headset_sec/alt/interdyne

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

/datum/outfit/ds2/syndicate/brigoff
	name = "DS-2 Brig Officer"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/brigofficer
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = 	suit = /obj/item/clothing/suit/armor/bulletproof
	head = /obj/item/clothing/head/helmet/swat
	ears = /obj/item/radio/headset/headset_sec/alt/interdyne

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

/datum/outfit/ds2/syndicate/admiral
	name = "DS-2 Station Admiral"
	uniform = /obj/item/clothing/under/utility/com/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	head = /obj/item/clothing/head/hos/beret/syndicate
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/gold/generic
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/aps)
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationadmiral

/datum/outfit/ds2/syndicate/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

//ITEMS//
/obj/item/radio/headset/cybersun
	keyslot = new /obj/item/encryptionkey/headset_cybersun

/obj/item/radio/headset/cybersun/captain
	name = "cybersun captain headset"
	desc = "The headset of the boss."
	command = TRUE

//OBJECTS//
/obj/structure/showcase/machinery/oldpod/used
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod-open"


//IDS//
/obj/item/card/id/away/blackmarket
	name = "scuffed ID card"
	desc = "A faded, scuffed, plastic ID card. You can make out the rank \"Deck Crewman\"."
	trim = /datum/id_trim/away/blackmarket

/datum/id_trim/away/blackmarket
	access = list(ACCESS_AWAY_GENERIC4)
	assignment = "Deck Crewman"
