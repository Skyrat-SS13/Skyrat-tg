//////////////////////////////
//SKYRAT MODULAR OUTFITS FILE
//PUT ANY NEW ERT OUTFITS HERE
//////////////////////////////

/datum/outfit/centcom/asset_protection
	name = "Asset Protection"

	uniform = /obj/item/clothing/under/rank/centcom/commander
	suit = /obj/item/clothing/suit/space/hardsuit/deathsquad
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/hud/toggle/thermal
	back = /obj/item/storage/backpack/security
	l_pocket = /obj/item/door_remote/captain //need to make an all access one
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	belt = /obj/item/storage/belt/security //probably change this to something other than security belt, eventually
	l_hand = /obj/item/gun/energy/pulse/carbine/loyalpin //if this is still bulky make it not bulky and storable on belt/back/bag/exosuit
	id = /obj/item/card/id/ert
	ears = /obj/item/radio/headset/headset_cent/alt

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/firstaid/regular=1,\
		/obj/item/flashlight=1,\
		/obj/item/storage/box/handcuffs=1)

/datum/outfit/centcom/asset_protection/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CENTCOM)
	R.freqlock = TRUE
	var/obj/item/card/id/W = H.wear_id
	W.access = get_all_accesses()//They get full station access.
	W.access += get_centcom_access("Asset_Protection")//Let's add their alloted CentCom access.
	W.assignment = "Asset_Protection"
	W.registered_name = H.real_name
	W.update_label()
	..()

/datum/outfit/centcom/asset_protection/officer
	name = "Asset Protection Officer"
	head = /obj/item/clothing/head/helmet/space/beret
