/datum/outfit/centcom_inspector
	name = "Centcom Inspector"
	ears = /obj/item/radio/headset/headset_cent
	uniform = /obj/item/clothing/under/rank/centcom/officer
	suit = /obj/item/clothing/suit/trenchblack
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/centcom_inspector
	l_hand = /obj/item/clipboard
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/paper = 1,
		/obj/item/pen/fountain = 1,
		/obj/item/modular_computer/tablet/pda/centcom = 1,
	)


/datum/outfit/mafioso
	name = "Mafioso"

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/mobster
	uniform = /obj/item/clothing/under/suit/black_really
	neck = /obj/item/clothing/neck/tie/red/tied
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/gun/ballistic/automatic/tommygun
	r_hand = /obj/item/storage/toolbox/syndicate
	back = /obj/item/storage/backpack/satchel/flat/empty

/datum/outfit/mafioso/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()
	worn_id.update_icon()
