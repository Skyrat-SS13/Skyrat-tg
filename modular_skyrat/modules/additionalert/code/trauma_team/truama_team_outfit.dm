/datum/outfit/centcom/ert/medic/traumateam //Medical ERT Trauma Team, Admin spawn only obviously
	name = "Trauma Team"

	suit =  /obj/item/clothing/suit/space/hardsuit/ert/traumateam
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	ears = /obj/item/radio/headset/headset_cent/alt
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/infiltrator/ntrauma
	suit_store = /obj/item/gun/energy/e_gun/stun
	belt = /obj/item/storage/belt/military/ntrauma
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded ,\
		/obj/item/reagent_containers/hypospray/combat/nanites,\
		/obj/item/gun/medbeam,\
		/obj/item/storage/firstaid/tactical/ntrauma,\
		/obj/item/roller,\
		)

/obj/item/storage/belt/military/ntrauma
	desc = "A set of tactical webbing worn by Nanotrasen Elite Squad Members"

/obj/item/storage/belt/military/ntrauma/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/scalpel/advanced(src)
	new	/obj/item/cautery/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/blood_filter(src)
	new /obj/item/healthanalyzer/advanced(src)


/obj/item/storage/firstaid/tactical/ntrauma/PopulateContents()
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/defibrillator/compact/combat/loaded/nanotrasen(src)
	new /obj/item/reagent_containers/pill/patch/libital(src)
	new /obj/item/reagent_containers/pill/patch/libital(src)
	new /obj/item/reagent_containers/pill/patch/aiuri(src)
	new /obj/item/reagent_containers/pill/patch/aiuri(src)
	new /obj/item/clothing/glasses/hud/health/night(src)

/obj/item/clothing/gloves/color/latex/nitrile/infiltrator/ntrauma
	name = "specialist gloves"
	desc = "A pair of gloves used by Trauma Team Specialists"
