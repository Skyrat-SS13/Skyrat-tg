/datum/outfit/centcom/ert/nri
	name = "Novaya Rossiyskaya Imperiya Soldier"
	head = /obj/item/clothing/head/helmet/rus_helmet/nri
	glasses = /obj/item/clothing/glasses/night
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = /obj/item/clothing/mask/balaclavaadjust
	uniform = /obj/item/clothing/under/costume/nri
	suit = /obj/item/clothing/suit/armor/vest/russian/nri
	suit_store = /obj/item/gun/ballistic/automatic/akm
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/nri/full
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack, /obj/item/storage/medkit/emergency, /obj/item/clothing/mask/gas/alt)
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/ammo_box/magazine/m9mm
	shoes = /obj/item/clothing/shoes/jackboots/black

	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri

/datum/outfit/centcom/ert/nri/heavy
	name = "Novaya Rossiyskaya Imperiya Heavy Soldier"
	head = /obj/item/clothing/head/helmet/nri_heavy
	suit = /obj/item/clothing/suit/armor/heavy/nri
	glasses = /obj/item/clothing/glasses/hud/security/night
	mask = /obj/item/clothing/mask/gas/alt
	belt = /obj/item/storage/belt/military/nri/full_heavy
	suit_store = /obj/item/gun/ballistic/automatic/pistol
	back = /obj/item/deployable_turret_folded
	backpack_contents = null
	l_pocket = /obj/item/wrench/combat

	id_trim = /datum/id_trim/nri/heavy

/datum/outfit/centcom/ert/nri/commander
	name = "Novaya Rossiyskaya Imperiya Platoon Commander"
	head = /obj/item/clothing/head/beret/sec/nri
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	belt = /obj/item/storage/belt/military/nri/full_commander
	suit_store = /obj/item/gun/ballistic/automatic/ppsh
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack, /obj/item/storage/medkit/emergency, /obj/item/clothing/mask/gas/alt, /obj/item/clothing/accessory/armband, /obj/item/megaphone, /obj/item/binoculars)

	id_trim = /datum/id_trim/nri/commander

/datum/outfit/centcom/ert/nri/medic
	name = "Novaya Rossiyskaya Imperiya Corpsman"
	head = /obj/item/clothing/head/helmet/rus_helmet/nri
	glasses = /obj/item/clothing/glasses/hud/health/night
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = /obj/item/clothing/mask/balaclavaadjust
	uniform = /obj/item/clothing/under/costume/nri
	suit = /obj/item/clothing/suit/armor/vest/russian/nri
	suit_store = /obj/item/gun/ballistic/automatic/plastikov
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/military/nri/full_support
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack, /obj/item/clothing/mask/gas/alt, /obj/item/storage/medkit/tactical, /obj/item/storage/medkit/advanced, /obj/item/gun/medbeam, /obj/item/clothing/accessory/armband/med)
	shoes = /obj/item/clothing/shoes/jackboots/black

	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri

/datum/outfit/centcom/ert/nri/engineer
	name = "Novaya Rossiyskaya Imperiya Combat Engineer"
	head = /obj/item/clothing/head/helmet/rus_helmet/nri
	glasses = /obj/item/clothing/glasses/meson/night
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = /obj/item/clothing/mask/balaclavaadjust
	uniform = /obj/item/clothing/under/costume/nri
	suit = /obj/item/clothing/suit/armor/vest/russian/nri
	suit_store = /obj/item/gun/ballistic/automatic/plastikov
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/nri/full_support
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack, /obj/item/clothing/mask/gas/alt, /obj/item/clothing/accessory/armband/engine, /obj/item/construction/rcd/combat, /obj/item/clothing/glasses/welding)
	shoes = /obj/item/clothing/shoes/jackboots/black

	l_hand = /obj/item/storage/belt/utility/full/powertools

	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri

/datum/outfit/centcom/ert/nri/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	return
	//Two reasons for this; one, Russians arent NT and dont need implants used mostly for NT-sympathizers. Two, the HuD looks ugly with the blue mindshield outline.
