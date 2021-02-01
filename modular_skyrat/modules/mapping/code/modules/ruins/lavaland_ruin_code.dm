//SPAWNERS//
/obj/effect/mob_spawn/human/lavaland_syndicate/shaftminer
	name = "Syndicate Shaft Miner"
	short_desc = "You are a syndicate shaft miner, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer

//OUTFITS//
/datum/outfit/lavaland_syndicate
	id = /obj/item/card/id/syndicate/anyone/scientist

/datum/outfit/lavaland_syndicate/comms
	id = /obj/item/card/id/syndicate/anyone/commsagent

/datum/outfit/lavaland_syndicate/shaftminer
	name = "Lavaland Syndicate Shaft Miner"
	id = /obj/item/card/id/syndicate/anyone/shaftminer
	r_pocket = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1)

/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	id = /obj/item/card/id/syndicate/anyone/deckofficer

/obj/effect/mob_spawn/human/lavaland_syndicate/deckofficer
	name = "Syndicate Deck Officer"
	short_desc = "You are a syndicate Deck Officer, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/deckofficer

//ITEMS//
/obj/item/card/id/syndicate/anyone/commsagent
	assignment = "Comms Officer"

/obj/item/card/id/syndicate/anyone/scientist
	assignment = "Researcher"

/obj/item/card/id/syndicate/anyone/shaftminer
	assignment = "Shaft Miner"

/obj/item/card/id/syndicate/anyone/deckofficer
	assignment = "Deck Officer"
