/datum/outfit/centcom/ert/medic/traumateam //Medical ERT Trauma Team, Admin spawn only obviously
	name = "Trauma Team"
	id = /obj/item/card/id/advanced/centcom/ert/medical/ntrauma
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	suit = /obj/item/clothing/suit/space/ntrauma
	head = /obj/item/clothing/head/helmet/space/ntrauma
	glasses = /obj/item/clothing/glasses/hud/health/night
	ears = /obj/item/radio/headset/headset_cent/alt
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/ntrauma
	l_hand = /obj/item/gun/energy/e_gun/stun
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/military/ntrauma
	back = /obj/item/storage/backpack/medic
	mask = /obj/item/clothing/mask/breath/medical
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded,\
		/obj/item/gun/energy/cell_loaded/medigun/upgraded,\
		/obj/item/storage/box/medicells,\
		/obj/item/storage/medkit/tactical/ntrauma,\
		)
	//Chosen cells are based off the worst things to deal with: TraumaTeam is built for worst-case scenarios, so they get a temperature cell and a better toxin cell

/datum/outfit/centcom/ert/medic/traumateam/leader //Very few differences, mostly just unique leader items - namely, a medbeam rather than a Veymed
	backpack_contents = list(
		/obj/item/storage/box/survival/security,\
		/obj/item/melee/baton/security/loaded ,\
		/obj/item/reagent_containers/hypospray/combat,\
		/obj/item/gun/medbeam,\
		/obj/item/storage/medkit/tactical/ntrauma,\
		/obj/item/roller,\
		)

////////////////////
/// UNIQUE ITEMS ///
////////////////////

//A box of VeyGun cells, because storage is hell and these take up a LOT more than they're worth.
/obj/item/storage/box/plastic/medicells
	name = "box of medicells"
	desc = "A box with a few basic Medicells, designed for VeyMedical CWM cell-powered Mediguns."
	illustration = "medgel"

/obj/item/storage/box/medicells/PopulateContents()
	. = ..()
	new /obj/item/weaponcell/medical/brute(src)
	new /obj/item/weaponcell/medical/burn(src)
	new /obj/item/weaponcell/medical/toxin/better(src)
	new /obj/item/weaponcell/medical/utility/temperature(src)
	new /obj/item/weaponcell/medical/utility/bed(src)

/datum/id_trim/centcom/ert/medical/ntrauma
	assignment = "Trauma Team Specialist"
	trim_state = "trim_highcleric"	//This is the CMO trim for the RPG Titles; considering its 'angelic' sprite, its fitting for these guardian angels
	sechud_icon_state = SECHUD_SCRAMBLED

/obj/item/card/id/advanced/centcom/ert/medical/ntrauma
	registered_name = "Trauma Team Specialist"
	trim = /datum/id_trim/centcom/ert/medical/ntrauma
	icon_state = "battlecruisercaller"	//Read desc
	desc = "A semi-standard black Identification card rigged with what appears to be a small transmitter wired to a small disk - presumably filled with access tokens. Not NT standard, sure, but effectively the same card as their ERTs."

/obj/item/storage/belt/military/ntrauma
	name = "trauma chest rig"
	desc = "A set of tactical webbing worn by Trauma Response Teams."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "ert_ntrauma"
	worn_icon_state = "ert_ntrauma"

/obj/item/storage/belt/military/ntrauma/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/scalpel/advanced(src)
	new	/obj/item/cautery/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/healthanalyzer/advanced(src)
	new	/obj/item/reagent_containers/hypospray/combat(src)

/obj/item/storage/medkit/tactical/ntrauma
	name = "trauma medical kit"
	desc = "I hope you've got insurance, because the Trauma Team's premiums are HIGH."

/obj/item/storage/medkit/tactical/ntrauma/PopulateContents()
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
	desc = "A pair of nitrile-alternative gloves used by Trauma Team specialists, with a unique (and expensive) acid-repellent coating to prevent damage handling chemical hazards. Wont protect the rest of your body, though."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "ert_ntrauma"
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER	//So the LONG gloves can be shown off
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/space/ntrauma
	name = "trauma team softsuit"
	desc = "A lightweight, minimally armored, entirely sterile softsuit, used by Trauma Teams to operate in potentially hazardous environments of all sorts. It's coated in acid-repellent chemicals."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "ert_ntrauma"
	slowdown = 0.3
	armor = list(MELEE = 10, BULLET = 10, LASER = 10,ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 80, ACID = 80)
	resistance_flags = ACID_PROOF
	cell = /obj/item/stock_parts/cell/super
	supports_variations_flags = NONE	//Traumateam NEEDS to look nondescript. Its the whole gimmick, tactical healing.

/obj/item/clothing/head/helmet/space/ntrauma
	name = "trauma team helmet"
	desc = "A faceless white helmet fit to seal with a softsuit, used by Trauma Teams to operate in potentially hazardous environments. It's coated in acid-repellent chemicals."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ert_ntrauma"
	resistance_flags = ACID_PROOF
	supports_variations_flags = NONE	//Also good GOD I didnt want to re-sprite this helmet
