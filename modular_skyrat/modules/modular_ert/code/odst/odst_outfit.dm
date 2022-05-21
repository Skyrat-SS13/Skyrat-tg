/datum/outfit/centcom/ert/odst // ODST, Admin spawn only obviously
	name = "ODST"
	id = /obj/item/card/id/advanced/centcom/ert
	uniform = /obj/item/clothing/under/odst
	glasses = /obj/item/clothing/glasses/hud/security/night
	ears = /obj/item/radio/headset/headset_cent/alt
	gloves = /obj/item/clothing/gloves/combat
	l_hand = /obj/item/gun/ballistic/automatic/pitbull
	belt = /obj/item/storage/belt/military/odst
	back = /obj/item/mod/control/pre_equipped/responsory/security
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded ,\
		)
	l_pocket = /obj/item/gun/energy/e_gun/mini
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

/obj/item/storage/backpack/ert/odst
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	icon_state = "ert_odst"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	worn_icon_state = "ert_odst"
	name = "odst backpack"
	desc = "A modified backpack that attaches via magnetic harness, removing the need for straps."
	inhand_icon_state = "securitypack"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/military/odst
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	name = "commando chest rig"
	desc = "A tactical plate carrier."
	icon_state = "ert_odst"
	worn_icon_state = "ert_odst"
	inhand_icon_state = "utility"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/military/odst/PopulateContents()
	new /obj/item/crowbar/red (src)
	new /obj/item/grenade/frag (src)
	new /obj/item/grenade/frag (src)


