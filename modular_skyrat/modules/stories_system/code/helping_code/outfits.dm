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


/datum/outfit/syndicate_inspector
	name = "Syndicate Centcom Inspector"
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
	implants = list(
		/obj/item/implant/storage = 1, // So they can hide the nuke/SM kit
		/obj/item/implant/radio/syndicate = 1, // For certified Bad Man access
	)
	/// The name of the item to steal
	var/steal_item = "nothing"

/datum/outfit/syndicate_inspector/nuke_core
	name = "Syndicate Centcom Inspector (Nuke Core)"
	backpack_contents = list(
		/obj/item/paper = 1,
		/obj/item/pen/fountain = 1,
		/obj/item/modular_computer/tablet/pda/centcom = 1,
		/obj/item/storage/box/syndie_kit/nuke = 1,
	)
	steal_item = "the nuclear core"

/datum/outfit/syndicate_inspector/sm_sliver
	name = "Syndicate Centcom Inspector (Supermatter Sliver)"
	backpack_contents = list(
		/obj/item/paper = 1,
		/obj/item/pen/fountain = 1,
		/obj/item/modular_computer/tablet/pda/centcom = 1,
		/obj/item/storage/box/syndie_kit/supermatter = 1,
	)
	steal_item = "a supermatter sliver"

/datum/outfit/syndicate_inspector/rd_server
	name = "Syndicate Centcom Inspector (R&D Server)"
	backpack_contents = list(
		/obj/item/paper = 1,
		/obj/item/pen/fountain = 1,
		/obj/item/modular_computer/tablet/pda/centcom = 1,
		/obj/item/storage/box/syndie_kit/rnd_server = 1,
	)
	steal_item = "the R&D server HDD"


/datum/outfit/mafioso
	name = "Mafioso"

	id = /obj/item/card/id/passport
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

/datum/outfit/tourist
	name = "Tourist"

	id = /obj/item/card/id/passport
	id_trim = /datum/id_trim/job/assistant/tourist
	uniform = /obj/item/clothing/under/shorts/grey
	suit = /obj/item/clothing/suit/hawaiian_shirt/random
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/fake_sunglasses/aviator
	head = /obj/item/clothing/head/fedora/beige
	shoes = /obj/item/clothing/shoes/sandal
	l_hand = /obj/item/camera
	r_hand = /obj/item/camera_film
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/camera_film = 1,
		/obj/item/holochip/thousand = 1,
	)

/datum/outfit/tourist/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()

/datum/outfit/tourist/wealthy
	backpack_contents = list(
		/obj/item/camera_film = 1,
		/obj/item/holochip/ten_thousand = 1,
	)

/datum/outfit/tourist/broke
	backpack_contents = list(
		/obj/item/camera_film = 1,
		/obj/item/holochip/hundred = 1,
	)

/datum/outfit/salaryman
	name = "Salaryman"

	id = /obj/item/card/id/passport
	id_trim = /datum/id_trim/job/assistant/tourist
	uniform = /obj/item/clothing/under/suit/black_really
	neck = /obj/item/clothing/neck/tie/black/tied
	ears = /obj/item/radio/headset
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/briefcase/empty
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/holochip/thousand = 1,
	)

/datum/outfit/salaryman/boss
	name = "Salaryman's Boss"
	backpack_contents = list(
		/obj/item/holochip/ten_thousand = 1,
	)

/datum/outfit/salaryman/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()

/datum/outfit/medical_student
	name = "Medical Student"

	id = /obj/item/card/id/passport
	id_trim = /datum/id_trim/job/assistant/med_student
	uniform = /obj/item/clothing/under/rank/medical/scrubs/green
	glasses = /obj/item/clothing/glasses/regular
	suit = /obj/item/clothing/suit/toggle/labcoat
	ears = /obj/item/radio/headset/headset_med
	shoes = /obj/item/clothing/shoes/sneakers/white
	l_hand = /obj/item/clipboard
	back = /obj/item/storage/backpack/satchel/med
	backpack_contents = list(
		/obj/item/pen = 1,
		/obj/item/paper = 2,
	)
