//SPAWNERS//
/obj/effect/mob_spawn/human/lavaland_syndicate/shaftminer
	name = "Syndicate Shaft Miner"
	short_desc = "You are a syndicate shaft miner, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer

/obj/effect/mob_spawn/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space

/obj/effect/mob_spawn/human/lavaland_syndicate/shaftminer/ice
	name = "Syndicate Shaft Miner"
	short_desc = "You are a syndicate shaft miner, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/ice

/obj/effect/mob_spawn/human/lavaland_syndicate/ice
	name = "Syndicate Bioweapon Scientist"
	short_desc = "You are a syndicate science technician, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/ice

//OUTFITS//
/datum/outfit/lavaland_syndicate
	uniform = /obj/item/clothing/under/utility/sci/syndicate
	ears = /obj/item/radio/headset/interdyne

/datum/outfit/lavaland_syndicate/ice
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/hooded/wintercoat/syndicate
	ears = /obj/item/radio/headset/interdyne

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	ears = /obj/item/radio/headset/interdyne/comms

/datum/outfit/lavaland_syndicate/comms/space
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/lavaland_syndicate/shaftminer
	name = "Lavaland Syndicate Shaft Miner"
	uniform = /obj/item/clothing/under/utility/cargo/syndicate
	suit = null //Subtype moment
	r_pocket = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1)

/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	name = "Lavaland Syndicate Deck Officer"
	uniform = /obj/item/clothing/under/rank/cargo/qm/syndie
	neck = /obj/item/clothing/neck/cloak/qm/syndie
	ears = /obj/item/radio/headset/interdyne/command
	id = /obj/item/card/id/advanced/silver/generic
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne/deckofficer

/obj/effect/mob_spawn/human/lavaland_syndicate/deckofficer
	name = "Syndicate Deck Officer"
	short_desc = "You are a syndicate Deck Officer, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/deckofficer

/obj/effect/mob_spawn/human/lavaland_syndicate/deckofficer/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/lavaland_syndicate/shaftminer/ice
	name = "Icemoon Syndicate Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/hooded/wintercoat/syndicate
	r_pocket = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1)

//ITEMS

/obj/item/radio/headset/interdyne
	name = "interdyne headset"
	desc = "A bowman headset with a large red cross on the earpiece, has a small 'IP' written on the top strap. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = "syndie_headset"
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = new /obj/item/encryptionkey/headset_interdyne

/obj/item/radio/headset/interdyne/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/interdyne/command
	name = "interdyne command headset"
	desc = "A commanding headset to gather your underlings. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = "syndie_headset"
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = new /obj/item/encryptionkey/headset_interdyne
	command = TRUE

/obj/item/radio/headset/interdyne/command/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/interdyne/comms
	keyslot = new /obj/item/encryptionkey/headset_interdyne
	keyslot2 = new /obj/item/encryptionkey/syndicate
