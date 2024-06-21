/datum/outfit/centcom/naval
	name = "Nanotrasen Naval Command - Default"
	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval
	id = /obj/item/card/id/advanced/centcom
	l_pocket = /obj/item/melee/baton/telescopic
	shoes = /obj/item/clothing/shoes/combat/swat
	back = /obj/item/storage/backpack/satchel/leather
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black
	ears = /obj/item/radio/headset/headset_cent/commander

/datum/outfit/centcom/naval/post_equip(mob/living/carbon/human/human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/id_card = human.wear_id
	id_card.registered_name = human.real_name
	id_card.update_label()
	id_card.update_icon()
	..()

/datum/outfit/centcom/naval/ensign
	name = "Nanotrasen Naval Command - Ensign"

	id_trim = /datum/id_trim/centcom/naval

	head = /obj/item/clothing/head/beret/centcom_formal

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval

	gloves = /obj/item/clothing/gloves/tackler/combat/insulated

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/lieutenant
	name = "Nanotrasen Naval Command - Lieutenant"

	id_trim = /datum/id_trim/centcom/naval/lieutenant

	head = /obj/item/clothing/head/hats/centcom_cap

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/lieutenant_commander
	name = "Nanotrasen Naval Command - Lieutenant Commander"

	id_trim = /datum/id_trim/centcom/naval/ltcr

	head = /obj/item/clothing/head/hats/centcom_cap

	neck = /obj/item/clothing/neck/pauldron

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/commander
	name = "Nanotrasen Naval Command - Commander"

	id_trim = /datum/id_trim/centcom/naval/commander

	head = /obj/item/clothing/head/hats/centcom_cap

	neck = /obj/item/clothing/neck/pauldron/commander

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/captain
	name = "Nanotrasen Naval Command - Captain"

	id_trim = /datum/id_trim/centcom/naval/captain

	head = /obj/item/clothing/head/hats/centcom_cap

	neck = /obj/item/clothing/neck/pauldron/captain

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/rear_admiral
	name = "Nanotrasen Naval Command - Rear Admiral"

	id_trim = /datum/id_trim/centcom/naval/rear_admiral

	head = /obj/item/clothing/head/hats/caphat/naval

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/admiral

	gloves = /obj/item/clothing/gloves/combat/naval

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/admiral
	name = "Nanotrasen Naval Command - Admiral"

	id_trim = /datum/id_trim/centcom/naval/admiral

	head = /obj/item/clothing/head/hats/caphat/naval

	neck = /obj/item/clothing/neck/cloak/admiral

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/admiral

	gloves = /obj/item/clothing/gloves/combat/naval

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

/datum/outfit/centcom/naval/fleet_admiral
	name = "Nanotrasen Naval Command - Fleet Admiral"

	id_trim = /datum/id_trim/centcom/naval/fleet_admiral

	head = /obj/item/clothing/head/hats/caphat/naval/fleet_admiral

	neck = /obj/item/clothing/neck/cloak/fleet_admiral

	uniform = /obj/item/clothing/under/rank/centcom/skyrat/naval/fleet_admiral

	gloves = /obj/item/clothing/gloves/combat/naval/fleet_admiral

	backpack_contents = list(
		/obj/item/storage/box/survival/security,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)
