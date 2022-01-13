/datum/outfit/centcom/ert/medic/traumateam //Medical ERT Trauma Team, Admin spawn only obviously
	name = "Trauma Team"
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	suit = /obj/item/clothing/suit/space/ntrauma
	head = /obj/item/clothing/head/helmet/space/ntrauma
	glasses = /obj/item/clothing/glasses/hud/health/night
	ears = /obj/item/radio/headset/headset_cent/alt
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/ntrauma
	l_hand = /obj/item/gun/energy/e_gun/stun
	belt = /obj/item/storage/belt/military/ntrauma
	back = /obj/item/mod/control/pre_equipped/responsory/medic
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded ,\
		/obj/item/reagent_containers/hypospray/combat/nanites,\
		/obj/item/gun/medbeam,\
		/obj/item/storage/firstaid/tactical/ntrauma,\
		/obj/item/roller,\
		)

////////////////////
/// UNIQUE ITEMS ///
////////////////////
/obj/item/storage/belt/military/ntrauma
	name = "trauma chest rig"
	desc = "A set of tactical webbing worn by DeForest's premium Trauma Response Teams."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "ert_ntrauma"

/obj/item/storage/belt/military/ntrauma/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/scalpel/advanced(src)
	new	/obj/item/cautery/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/blood_filter(src)
	new /obj/item/healthanalyzer/advanced(src)

/obj/item/storage/firstaid/tactical/ntrauma
	name = "trauma medical kit"
	desc = "I hope you've got insurance, because the Trauma Team's premiums are HIGH."

/obj/item/storage/firstaid/tactical/ntrauma/PopulateContents()
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/defibrillator/compact/combat/loaded/nanotrasen(src)
	new /obj/item/reagent_containers/pill/patch/libital(src)
	new /obj/item/reagent_containers/pill/patch/libital(src)
	new /obj/item/reagent_containers/pill/patch/aiuri(src)
	new /obj/item/reagent_containers/pill/patch/aiuri(src)
	new	/obj/item/holosign_creator/medical (src)
	new /obj/item/pinpointer/crew/prox (src)

/obj/item/clothing/gloves/color/latex/nitrile/ntrauma
	name = "trauma specialist gloves"
	desc = "A pair of gloves used by Trauma Team specialists, with a unique (and expensive) acid-repellent coating to prevent damage handling chemical hazards. Wont protect the rest of your body, though."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "ert_ntrauma"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/space/ntrauma
	name = "trauma team softsuit"
	desc = "A lightweight, minimally armored, entirely sterile softsuit, used by Trauma Teams to operate in potentially hazardous environments of all sorts. It's coated in acid-repellent chemicals."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "ert_ntrauma"
	permeability_coefficient = 0.01
	slowdown = 0.3
	armor = list(MELEE = 10, BULLET = 10, LASER = 10,ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 80, ACID = 80)
	resistance_flags = ACID_PROOF
	cell = /obj/item/stock_parts/cell/super

/obj/item/clothing/head/helmet/space/ntrauma
	name = "trauma team helmet"
	desc = "A faceless white helmet fit to seal with a softsuit, used by Trauma Teams to operate in potentially hazardous environments. It's coated in acid-repellent chemicals."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ert_ntrauma"
	resistance_flags = ACID_PROOF
