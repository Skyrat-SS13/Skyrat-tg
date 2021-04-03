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

//OUTFITS//
/datum/outfit/syndicatespace/syndicrew
	ears = /obj/item/radio/headset/cybersun
	id_trim = /datum/id_trim/syndicom/skyrat/crew

/datum/outfit/syndicatespace/syndicaptain
	ears = /obj/item/radio/headset/cybersun/captain
	id_trim = /datum/id_trim/syndicom/skyrat/captain

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
