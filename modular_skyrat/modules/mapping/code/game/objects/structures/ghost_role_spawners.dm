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
