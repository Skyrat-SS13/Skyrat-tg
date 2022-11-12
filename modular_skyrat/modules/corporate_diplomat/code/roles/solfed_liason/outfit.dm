/datum/outfit/job/solfed_liason
	name = "Solar Federation Liason"
	jobtype = /datum/job/corporate_diplomat

	belt = /obj/item/modular_computer/tablet/pda/armadyne_representative
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/nanotrasen_consultant
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

/obj/item/modular_computer/tablet/pda/armadyne_representative
	name = "\improper Solar Federation Liason's PDA"
	inserted_disk = /obj/item/computer_disk/command
	inserted_item = /obj/item/pen/fountain
	greyscale_colors = "#C39C00#0060b8"

/datum/outfit/plasmaman/solfed_liason
	name = "Solar Federation Liason Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/enviroslacks
	gloves = /obj/item/clothing/gloves/color/plasmaman/white
	head = /obj/item/clothing/head/helmet/space/plasmaman/white

