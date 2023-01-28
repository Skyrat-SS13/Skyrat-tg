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


/datum/outfit/construction_worker
	name = "Construction Worker"

	id = /obj/item/card/id/passport
	id_trim = /datum/id_trim/job/assistant/tourist
	uniform = /obj/item/clothing/under/misc/overalls
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/welding/up
	head = /obj/item/clothing/head/utility/hardhat
	suit = /obj/item/clothing/suit/hazardvest
	shoes = /obj/item/clothing/shoes/workboots
	l_hand = /obj/item/storage/toolbox/mechanical
	r_hand = /obj/item/clothing/head/cone
	back = /obj/item/storage/backpack/satchel/eng
	backpack_contents = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/iron/fifty = 1,
		/obj/item/stack/sheet/glass/fifty = 1,
		/obj/item/stack/sheet/mineral/wood/fifty = 1,
		/obj/item/stack/sheet/mineral/stone/fifty = 1,
	)

/datum/outfit/construction_worker/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()

/datum/outfit/construction_worker/foreman
	head = /obj/item/clothing/head/utility/hardhat/white
	r_hand = /obj/item/megaphone // so the boys can hear you

/datum/outfit/construction_worker/union_rep
	neck = /obj/item/clothing/neck/tie/black/tied
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	r_hand = /obj/item/storage/briefcase/empty

/datum/outfit/small_business_owner
	name = "Small Business Owner"

	id = /obj/item/card/id/passport
	id_trim = /datum/id_trim/job/assistant/tourist
	uniform = /obj/item/clothing/under/suit/black_really
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/sunglasses
	neck = /obj/item/clothing/neck/tie/black/tied
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/holochip/hundred_thousand = 1, // to pay the workers/bribe the locals/embezzle for yourself
	)

/datum/outfit/small_business_owner/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()

/datum/outfit/middle_management
	name = "Middle Management"
	ears = /obj/item/radio/headset/headset_cent
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	suit = /obj/item/clothing/suit/toggle/suspenders
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/regular/hipster
	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management
	belt = /obj/item/modular_computer/tablet/pda/centcom
	l_hand = /obj/item/clipboard
	r_hand = /obj/item/reagent_containers/cup/glass/coffee
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/paper = 1,
		/obj/item/pen/fountain = 1,
	)

/datum/outfit/middle_management/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()

/datum/outfit/middle_management/service
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management/service

/datum/outfit/middle_management/security
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management/security

/datum/outfit/middle_management/medbay
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management/medbay

/datum/outfit/middle_management/engineering
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management/engineering

/datum/outfit/middle_management/cargo
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management/cargo

/datum/outfit/middle_management/science
	id_trim = /datum/id_trim/centcom/centcom_inspector/middle_management/science

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

/datum/outfit/medical_student/post_equip(mob/living/carbon/human/equipped_human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/worn_id = equipped_human.wear_id
	worn_id.registered_name = equipped_human.real_name
	worn_id.update_label()

/datum/outfit/nri_shore_leave
	name = "Shore Leave NRI Marine"

	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild
	uniform = /obj/item/clothing/under/costume/nri
	suit = /obj/item/clothing/suit/armor/vest/russian/nri
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/military/nri

	back = /obj/item/storage/backpack/duffelbag/syndie/nri
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack = 1,
		/obj/item/crucifix = 1,
		/obj/item/ammo_box/magazine/m9mm_aps = 1,
		/obj/item/modular_computer/tablet/pda/security = 1,
	)

	l_pocket = /obj/item/gun/ballistic/automatic/pistol/ladon/nri
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/enclave

/datum/outfit/nri_shore_leave/post_equip(mob/living/carbon/human/nri_human, visualsOnly)
	nri_human.set_drunk_effect(45) //This isn't time; it's how drunk they are
	nri_human.remove_all_languages()
	nri_human.grant_language(/datum/language/panslavic)
