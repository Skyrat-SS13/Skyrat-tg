//SPAWNERS//
/obj/effect/mob_spawn/ghost_role/human/interdyne
	name = "Interdyne Operative"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "a interdyne operative"
	you_are_text = "You are a member of Interdyne Pharmaceuticals, a rival corporation to Nanotransen and nominally a third party in the Syndicate's war on them. The frontier has turned the facility into a cooperative, where the employees work on illicit research, spy on Nanotransen, and party on the clock."
	flavour_text = "Your rival corporation, Nanotransen, has set up shop nearby - and with them the Syndicate follows, although you're nominally a third party in their war. The frontier makes for interesting bed fellows and corporate animosity doesn't necessarily translate out here!"
	important_text = "Abide by ghost role policy. You must have a seperate character from your Nanotransen one."
	outfit = /datum/outfit/interdyne
	spawner_job_path = /datum/job/lavaland_syndicate // investigate this
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/interdyne/shaftminer
	name = "Interdyne Shaft Miner"
	you_are_text = "You are an Interdyne shaft miner, tasked with braving the hellish outside without the union benefits of the FTU."
	important_text = "Friendly competition is fine, but avoid rushing mega-fauna encounters away from the main station's miners."
	outfit = /datum/outfit/interdyne/shaftminer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space

/obj/effect/mob_spawn/ghost_role/human/interdyne/shaftminer/ice
	name = "Interdyne Shaft Miner"
	outfit = /datum/outfit/interdyne/shaftminer/ice

/obj/effect/mob_spawn/ghost_role/human/interdyne/ice
	outfit = /datum/outfit/interdyne/ice

//OUTFITS//
/datum/outfit/interdyne // copy paste, tidy up
	name = "Interdyne Operative"
	id = /obj/item/card/id/advanced/black
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat
	back = /obj/item/storage/backpack
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/interdyne
	shoes = /obj/item/clothing/shoes/combat
	r_pocket = /obj/item/gun/ballistic/automatic/pistol
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne

/datum/outfit/interdyne/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	syndicate.faction |= ROLE_SYNDICATE

	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(syndicate)
	return ..()

/datum/outfit/interdyne/ice
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	suit = /obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate
	ears = /obj/item/radio/headset/interdyne/comms

/datum/outfit/lavaland_syndicate/comms/space
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/interdyne/shaftminer
	name = "Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate
	suit = null //Subtype moment
	r_pocket = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1)

/datum/outfit/interdyne/shaftminer/deckofficer
	name = "Interdyne Deck Officer"
	uniform = /obj/item/clothing/under/rank/cargo/qm/skyrat/syndie
	neck = /obj/item/clothing/neck/cloak/qm/syndie
	ears = /obj/item/radio/headset/interdyne/command
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne/deckofficer

/obj/effect/mob_spawn/ghost_role/human/interdyne/deckofficer
	name = "Interdyne Deck Officer"
	you_are_text = "You are an Interdyne Deck Officer, employed in a top secret research facility developing biological weapons."
	outfit = /datum/outfit/interdyne/shaftminer/deckofficer

/obj/effect/mob_spawn/ghost_role/human/interdyne/deckofficer/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/interdyne/shaftminer/ice
	name = "Icemoon Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/skyrat/tactical
	suit = /obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate

//ITEMS

/obj/item/radio/headset/interdyne
	name = "interdyne headset"
	desc = "A bowman headset with a large red cross on the earpiece, has a small 'IP' written on the top strap."
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = new /obj/item/encryptionkey/headset_syndicate/interdyne

/obj/item/radio/headset/interdyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/interdyne/command
	name = "interdyne command headset"
	desc = "A commanding headset to gather your underlings."
	command = TRUE

/obj/item/radio/headset/interdyne/comms
	keyslot = new /obj/item/encryptionkey/headset_syndicate/interdyne
	keyslot2 = new /obj/item/encryptionkey/syndicate
