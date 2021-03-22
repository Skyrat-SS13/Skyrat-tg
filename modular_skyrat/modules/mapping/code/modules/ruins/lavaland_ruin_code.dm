//SPAWNERS//
/obj/effect/mob_spawn/human/lavaland_syndicate/shaftminer
	name = "Syndicate Shaft Miner"
	short_desc = "You are a syndicate shaft miner, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer

/obj/effect/mob_spawn/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space

//OUTFITS//
/datum/outfit/lavaland_syndicate
	id = /obj/item/card/id/advanced/chameleon
	ears = /obj/item/radio/headset/interdyne

/datum/outfit/lavaland_syndicate/comms
	id = /obj/item/card/id/advanced/chameleon
	ears = /obj/item/radio/headset/interdyne/comms

/datum/outfit/lavaland_syndicate/comms/space
	id = /obj/item/card/id/advanced/chameleon
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/lavaland_syndicate/shaftminer
	name = "Lavaland Syndicate Shaft Miner"
	id = /obj/item/card/id/advanced/chameleon
	r_pocket = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1)

/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	id = /obj/item/card/id/advanced/chameleon

/obj/effect/mob_spawn/human/lavaland_syndicate/deckofficer
	name = "Syndicate Deck Officer"
	short_desc = "You are a syndicate Deck Officer, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/deckofficer

//ITEMS

/obj/item/radio/headset/interdyne
	keyslot = new /obj/item/encryptionkey/headset_interdyne

/obj/item/radio/headset/interdyne/comms
	keyslot = new /obj/item/encryptionkey/headset_interdyne
	keyslot2 = new /obj/item/encryptionkey/syndicate
