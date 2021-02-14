//SPAWNERS//
/obj/effect/mob_spawn/human/derelict/scavengecrew
	name = "Scavenge Crew"
	short_desc = "You are a Nanotrasen Scavenge crewman, located onboard an unknown derelict."
	flavour_text = "You were deployed here as part of a Nanotrasen Scavenge team, meant for looting derelicts in Nanotrasen Space."
	important_info = "Do not approach the station, nor leave the station space of KC13."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	outfit = /datum/outfit/scavengecrew
	permanent = FALSE
	roundstart = FALSE
	death = FALSE
	can_use_alias = TRUE
	any_station_species = TRUE

//OUTFITS//
/datum/outfit/syndicatespace/syndicrew
	ears = /obj/item/radio/headset/cybersun

/datum/outfit/syndicatespace/syndicaptain
	ears = /obj/item/radio/headset/cybersun/captain

/datum/outfit/scavengecrew
	name = "Scavenge Crewman"
	uniform = /obj/item/clothing/under/rank/cargo/tech
	shoes = /obj/item/clothing/shoes/sneakers/black
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/scavengecrew

//ITEMS//

/obj/item/radio/headset/cybersun
	keyslot = new /obj/item/encryptionkey/headset_cybersun

/obj/item/radio/headset/cybersun/captain
	name = "cybersun captain headset"
	desc = "The headset of the boss."
	command = TRUE

/obj/item/card/id/scavengecrew
	assignment = "Scavenge Crew"
	access = list(ACCESS_AWAY_GENERIC4, ACCESS_ROBOTICS)
