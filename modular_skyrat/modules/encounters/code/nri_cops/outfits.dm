/datum/outfit/pirate/nri/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.faction -= "pirate"
	equipped.faction |= "raider"

	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = equipped.wear_id
	if(istype(id_card))
		id_card.registered_name = equipped.real_name
		id_card.update_label()

	handlebank(equipped)

/datum/outfit/pirate/nri/officer
	name = "NRI Field Officer"

	head = /obj/item/clothing/head/beret/sec/nri
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command
	mask = null
	neck = /obj/item/clothing/neck/security_cape/armplate

	uniform = /obj/item/clothing/under/costume/nri/captain
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/security/nri
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/raider = 1,
		/obj/item/ammo_box/magazine/m9mm_aps = 3,
		/obj/item/gun/ballistic/automatic/pistol/ladon/nri = 1,
		/obj/item/crucifix = 1, /obj/item/clothing/mask/gas/hecu2 = 1,
		/obj/item/modular_computer/pda/security = 1,
	)
	l_pocket = /obj/item/folder/blue/nri_cop
	r_pocket = /obj/item/storage/bag/ammo

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider/officer

/datum/id_trim/nri_raider/officer
	assignment = "NRI Field Officer"

/datum/outfit/pirate/nri/marine
	name = "NRI Marine"

	head = null
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild
	mask = null

	uniform = /obj/item/clothing/under/costume/nri
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/security/nri
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/raider = 1,
		/obj/item/crucifix = 1,
		/obj/item/ammo_box/magazine/m9mm = 3,
		/obj/item/clothing/mask/gas/hecu2 = 1,
		/obj/item/modular_computer/pda/security = 1,
	)
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/storage/bag/ammo

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider

/datum/id_trim/nri_raider
	assignment = "NRI Marine"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)
