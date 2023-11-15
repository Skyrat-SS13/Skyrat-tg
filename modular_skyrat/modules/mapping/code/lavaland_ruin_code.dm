//SPAWNERS//
/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/shaftminer
	name = "Interdyne Shaft Miner"
	you_are_text = "You are an Interdyne shaft miner, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/shaftminer/ice
	name = "Interdyne Shaft Miner"
	you_are_text = "You are an Interdyne shaft miner, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/ice

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	name = "Interdyne Bioweapon Scientist"
	you_are_text = "You are an Interdyne science technician, employed in a top secret research facility developing biological weapons."

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/ice
	outfit = /datum/outfit/lavaland_syndicate/ice

//OUTFITS//
/datum/outfit/lavaland_syndicate
	name = "Interdyne Bioweapon Scientist"
	uniform = /obj/item/clothing/under/syndicate/skyrat/interdyne
	suit = /obj/item/clothing/suit/toggle/labcoat/skyrat/interdyne_labcoat/white
	head = /obj/item/clothing/head/beret/medical/skyrat/interdyne
	ears = /obj/item/radio/headset/interdyne/green

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	syndicate.faction |= ROLE_SYNDICATE

	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(syndicate)
	return ..()

/datum/outfit/lavaland_syndicate/ice
	uniform = /obj/item/clothing/under/syndicate/skyrat/interdyne
	suit = /obj/item/clothing/suit/hooded/wintercoat/medical/viro/interdyne
	ears = /obj/item/radio/headset/interdyne/green
	head = /obj/item/clothing/head/beret/medical/skyrat/interdyne

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate
	ears = /obj/item/radio/headset/interdyne/comms

/datum/outfit/lavaland_syndicate/comms/space
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/lavaland_syndicate/shaftminer
	name = "Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/skyrat/interdyne/miner
	suit = /obj/item/clothing/suit/syndicate/interdyne_jacket
	head = null //funny subtypes
	r_pocket = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/card/mining_point_card=1)

/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	name = "Interdyne Deck Officer"
	uniform = /obj/item/clothing/under/syndicate/skyrat/interdyne/deckofficer
	head = /obj/item/clothing/head/hats/syndicate/interdyne_deckofficer_black
	suit = /obj/item/clothing/suit/armor/hos/deckofficer
	ears = /obj/item/radio/headset/interdyne/command
	id = /obj/item/card/id/advanced/silver/generic
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne/deckofficer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/deckofficer
	name = "Interdyne Deck Officer"
	you_are_text = "You are an Interdyne Deck Officer, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/deckofficer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/deckofficer/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/lavaland_syndicate/shaftminer/ice
	name = "Icemoon Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/skyrat/interdyne/miner
	head = /obj/item/clothing/ears/headphones
	suit = /obj/item/clothing/suit/syndicate/interdyne_jacket

//ITEMS

/obj/item/radio/headset/interdyne
	name = "interdyne headset"
	desc = "A bowman headset with a large red cross on the earpiece, has a small 'IP' written on the top strap. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne

/obj/item/radio/headset/interdyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/interdyne/command
	name = "interdyne command headset"
	desc = "A commanding headset to gather your underlings. Protects the ears from flashbangs."
	command = TRUE

/obj/item/radio/headset/interdyne/comms
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne
	keyslot2 = /obj/item/encryptionkey/syndicate

/obj/item/radio/headset/interdyne/green
	name = "interdyne branded headset"
	desc = "A bowman headset in interdyne green, has a small 'IP' written on the earpiece. Protects the ears from flashbangs."
	icon_state = "headset_ip"
	worn_icon_state = "headset_ip"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/ears.dmi'

/obj/structure/closet/crate/freezer/sansufentanyl
	name = "sansufentanyl crate"
	desc = "A freezer. Contains refrigerated Sansufentanyl, for managing Hereditary Manifold Sickness. A product of Interdyne Pharmaceuticals."

/obj/structure/closet/crate/freezer/sansufentanyl/PopulateContents()
	. = ..()
	for(var/grabbin_pills in 1 to 10)
		new /obj/item/storage/pill_bottle/sansufentanyl(src)

//MOBS

// hivelords that stand guard where they spawn
/mob/living/basic/mining/hivelord/no_wander
	ai_controller = /datum/ai_controller/basic_controller/hivelord/no_wander

//MOB AI

// same as a regular hivelord minus the idle walking
/datum/ai_controller/basic_controller/hivelord/no_wander
	idle_behavior = null
