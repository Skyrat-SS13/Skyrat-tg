/datum/outfit/job/armadyne_representative
	name = "Armadyne Representative"
	jobtype = /datum/job/corporate_diplomat

	belt = /obj/item/modular_computer/pda/armadyne_representative
	glasses = /obj/item/clothing/glasses/sunglasses // Armadyne glasses are sechuds and make you look like a tool
	ears = /obj/item/radio/headset/armadyne/representative
	gloves = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	head = /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	neck = /obj/item/clothing/neck/tie/red/tied
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/storage/box/gunset/pdh_striker = 1,
	)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	id = /obj/item/card/id/advanced/black
	id_trim = /datum/id_trim/job/armadyne_representative

/datum/outfit/plasmaman/armadyne_representative
	name = "Armadyne Representative Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/security
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
	head = /obj/item/clothing/head/helmet/space/plasmaman/security
