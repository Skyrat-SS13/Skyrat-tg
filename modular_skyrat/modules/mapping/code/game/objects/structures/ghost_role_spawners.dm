//SPAWNERS//
/obj/effect/mob_spawn/human/oldsec
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	short_desc = "You are a security officer working for Nanotrasen, stationed onboard a supplementary, code charlie outpost station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Intelligence blaring an alarm - then the cold, wet darkness. As you open \
	your eyes, a dark feeling swells in your gut as metal creaks in the distance..."
	uniform = /obj/item/clothing/under/rank/security/peacekeeper

/obj/effect/mob_spawn/human/oldsec/special(mob/living/new_spawn)
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_TELEPORT, "Dereliction of Code Charlie Class Station detected. Initializing Bluespace Link...")


/obj/effect/mob_spawn/human/oldeng
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	short_desc = "You are an engineer working for Nanotrasen, stationed onboard a supplementary, code charlie outpost station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Intelligence blaring an alarm - then the cold, wet darkness. As you open \
	your eyes, a dark feeling swells in your gut as metal creaks in the distance..."

/obj/effect/mob_spawn/human/oldeng/special(mob/living/new_spawn)
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_TELEPORT, "Dereliction of Code Charlie Class Station detected. Initializing Bluespace Link...")

/obj/effect/mob_spawn/human/oldsci
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	short_desc = "You are a scientist working for Nanotrasen, stationed onboard a supplementary, code charlie outpost station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Intelligence blaring an alarm - then the cold, wet darkness. As you open \
	your eyes, a dark feeling swells in your gut as metal creaks in the distance..."

/obj/effect/mob_spawn/human/oldsci/special(mob/living/new_spawn)
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_TELEPORT, "Dereliction of Code Charlie Class Station detected. Initializing Bluespace Link...")

//OUTFITS//
/datum/outfit/syndicatespace/syndicrew
	ears = /obj/item/radio/headset/cybersun

/datum/outfit/syndicatespace/syndicaptain
	ears = /obj/item/radio/headset/cybersun/captain

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
