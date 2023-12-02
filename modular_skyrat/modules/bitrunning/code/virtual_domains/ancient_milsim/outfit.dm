/datum/outfit/solfed_bitrun
	name = "Bitrunning SolFed Marine"

	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = null
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	suit = null
	shoes = /obj/item/clothing/shoes/combat
	back = /obj/item/storage/backpack/ert/odst/hecu
	glasses = null
	ears = /obj/item/radio/headset/headset_faction/bowman
	id = /obj/item/card/id/advanced/solfed
	r_hand = null
	l_hand = null
	backpack_contents = null
	belt = null
	id_trim = /datum/id_trim/solfed_bitrun

/datum/id_trim/solfed_bitrun
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "SolFed Marine"
	trim_state = "trim_solfed"
	department_color = COLOR_SOLFED_GOLD
	subdepartment_color = COLOR_SOLFED_GOLD
	sechud_icon_state = SECHUD_SOLFED

/datum/outfit/cin_soldier_corpse
	name = "Coalition Operative Corpse"
	uniform = /obj/item/clothing/under/syndicate/rus_army/cin_surplus/forest
	suit = /obj/item/clothing/suit/armor/vest/cin_surplus_vest/forest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/cybersun
	mask = /obj/item/clothing/mask/balaclavaadjust
	head = /obj/item/clothing/head/helmet/cin_surplus_helmet/forest
	back = /obj/item/storage/backpack/industrial/cin_surplus/forest
	belt = /obj/item/storage/belt/military/cin_surplus/forest
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider/cin

/datum/outfit/cin_soldier_player
	name = "Coalition Operative SNPC"
	uniform = /obj/item/clothing/under/syndicate/rus_army/cin_surplus/forest
	suit = /obj/item/clothing/suit/armor/vest/cin_surplus_vest/forest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/fingerless
	ears = /obj/item/radio/headset/cybersun
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/cin_surplus_helmet/forest
	back = /obj/item/storage/backpack/industrial/cin_surplus/forest
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/raider,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 2,
	)
	r_hand = null
	l_hand = null
	belt = /obj/item/storage/belt/military/cin_surplus/forest
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider/cin

/datum/outfit/cin_soldier_player/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	user.faction |= ROLE_SYNDICATE

	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/id_trim/nri_raider/cin
	assignment = "CIN Operative"
