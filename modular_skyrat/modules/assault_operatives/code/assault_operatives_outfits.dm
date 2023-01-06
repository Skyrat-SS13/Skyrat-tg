

//KITS
/datum/outfit/assaultops
	name = "Assault Ops - Default"

	uniform = /obj/item/clothing/under/syndicate/sniper
	shoes = /obj/item/clothing/shoes/jackboots
	gloves =  /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/chameleon
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	glasses = /obj/item/clothing/glasses/sunglasses
	mask = /obj/item/clothing/mask/gas/sechailer/syndicate

	l_pocket = /obj/item/switchblade
	r_pocket = /obj/item/armament_points_card/assaultops

	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/assaultops/post_equip(mob/living/carbon/human/equipping_human)
	var/obj/item/radio/radio = equipping_human.ears
	radio.set_frequency(FREQ_SYNDICATE)
	radio.freqlock = TRUE
	radio.command = TRUE

	var/obj/item/implant/weapons_auth/weapons_authorisation = new/obj/item/implant/weapons_auth(equipping_human)
	weapons_authorisation.implant(equipping_human)

	equipping_human.faction |= ROLE_SYNDICATE

	equipping_human.update_icons()
