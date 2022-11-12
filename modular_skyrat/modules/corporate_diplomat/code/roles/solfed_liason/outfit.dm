/datum/outfit/job/solfed_liason
	name = "Solar Federation Liason"
	jobtype = /datum/job/corporate_diplomat

	belt = /obj/item/modular_computer/tablet/pda/solfed_lasion
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/solfed/liason
	uniform = /obj/item/clothing/under/rank/solfed_liason
	suit = /obj/item/clothing/suit/jacket/solfed_liason
	shoes = /obj/item/clothing/shoes/laceup
	neck = /obj/item/clothing/neck/tie/solfed
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/storage/box/gunset/rebellion = 1,
		)

	l_pocket = /obj/item/clothing/accessory/medal/solfed_pin // It somewhat clashes so they get the option to wear it or not

	id = /obj/item/card/id/advanced/solfed
	id_trim = /datum/id_trim/job/solfed/liasion

/obj/item/modular_computer/tablet/pda/solfed_lasion
	name = "\improper Solar Federation Liason's PDA"
	inserted_disk = /obj/item/computer_disk/command
	inserted_item = /obj/item/pen/fountain
	greyscale_colors = "#C39C00#0060b8"

/datum/outfit/plasmaman/solfed_liason
	name = "Solar Federation Liason Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/enviroslacks
	gloves = /obj/item/clothing/gloves/color/plasmaman/white
	head = /obj/item/clothing/head/helmet/space/plasmaman/white

/obj/item/radio/headset/solfed
	name = "\improper Solar Federation headset"
	icon_state = "rob_headset"
	freerange = TRUE
	freqlock = TRUE
	keyslot = new /obj/item/encryptionkey/headset_solfed

/obj/item/radio/headset/solfed/command
	command = TRUE

/obj/item/radio/headset/solfed/liason
	name = "\improper Solar Federation liason headset"
	keyslot = new /obj/item/encryptionkey/headset_solfed/liason
	command = TRUE

/obj/item/radio/headset/solfed/marshal
	keyslot2 = new /obj/item/encryptionkey/headset_sec

/obj/item/radio/headset/solfed/breach_control
	keyslot2 = new /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/solfed/emt
	keyslot2 = new /obj/item/encryptionkey/headset_med

/obj/item/encryptionkey/headset_solfed
	name = "\improper Solar Federation radio encryption key"
	channels = list(
		RADIO_CHANNEL_SOLFED = 1,
	)
	greyscale_colors = "#C39C00#f28a1b"

/obj/item/encryptionkey/headset_solfed/liason
	name = "\improper Solar Federation liason encryption key"
	channels = list(
		RADIO_CHANNEL_SOLFED = 1,
		RADIO_CHANNEL_COMMAND = 1,
	)
	greyscale_colors = "#C39C00#f28a1b"
