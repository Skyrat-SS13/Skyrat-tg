/datum/outfit/centcom/naval

/datum/outfit/centcom/naval/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.registered_name = H.real_name
	W.update_label()
	W.update_icon()
	..()

/datum/outfit/centcom/naval/ensign
	name = "Nanotrasen Naval Command - Ensign"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval

	head = /obj/item/clothing/head/caphat/naval/beret
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	uniform = /obj/item/clothing/under/rank/centcom/naval/ensign

	gloves = /obj/item/clothing/gloves/tackler/combat/insulated

	l_pocket = /obj/item/melee/baton/telescopic

	shoes = /obj/item/clothing/shoes/combat/swat

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh)

/datum/outfit/centcom/naval/lieutenant
	name = "Nanotrasen Naval Command - Lieutenant"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/lieutenant

	head = /obj/item/clothing/head/centcom_cap
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh)

/datum/outfit/centcom/naval/lieutenant_commander
	name = "Nanotrasen Naval Command - Lieutenant Commander"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/ltcr

	head = /obj/item/clothing/head/centcom_cap
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	neck = /obj/item/clothing/neck/pauldron

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh)

/datum/outfit/centcom/naval/commander
	name = "Nanotrasen Naval Command - Commander"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/commander

	head = /obj/item/clothing/head/centcom_cap
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	neck = /obj/item/clothing/neck/pauldron/commander

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh)

/datum/outfit/centcom/naval/captain
	name = "Nanotrasen Naval Command - Captain"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/captain

	head = /obj/item/clothing/head/centcom_cap
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	neck = /obj/item/clothing/neck/pauldron/captain

	suit = /obj/item/clothing/suit/armor/vest/capcarapace/naval

	uniform = /obj/item/clothing/under/rank/centcom/naval/commander

	gloves = /obj/item/clothing/gloves/combat/naval

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh)

/datum/outfit/centcom/naval/rear_admiral
	name = "Nanotrasen Naval Command - Rear Admiral"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/rear_admiral

	head = /obj/item/clothing/head/caphat/naval
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	uniform = /obj/item/clothing/under/rank/centcom/naval/admiral

	gloves = /obj/item/clothing/gloves/combat/naval

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh_captain)

/datum/outfit/centcom/naval/admiral
	name = "Nanotrasen Naval Command - Admiral"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/admiral

	head = /obj/item/clothing/head/caphat/naval
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	neck = /obj/item/clothing/neck/cloak/admiral

	uniform = /obj/item/clothing/under/rank/centcom/naval/admiral

	gloves = /obj/item/clothing/gloves/combat/naval

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh_captain)

/datum/outfit/centcom/naval/fleet_admiral
	name = "Nanotrasen Naval Command - Fleet Admiral"

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/centcom/naval/fleet_admiral

	head = /obj/item/clothing/head/caphat/naval/fleet_admiral
	ears = /obj/item/radio/headset/headset_cent/commander
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/black

	neck = /obj/item/clothing/neck/cloak/fleet_admiral

	uniform = /obj/item/clothing/under/rank/centcom/naval/fleet_admiral

	gloves = /obj/item/clothing/gloves/combat/naval/fleet_admiral

	shoes = /obj/item/clothing/shoes/combat/swat

	l_pocket = /obj/item/melee/baton/telescopic

	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/survival/security, /obj/item/storage/box/gunset/pdh_corpo)
