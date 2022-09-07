/datum/outfit/centcom/ert/nri
	name = "Novaya Rossiyskaya Imperiya Soldier"
	head = /obj/item/clothing/head/helmet/space/hev_suit/nri
	glasses = /obj/item/clothing/glasses/night
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = /obj/item/clothing/mask/gas/hecu2
	uniform = /obj/item/clothing/under/costume/nri
	suit = /obj/item/clothing/suit/space/hev_suit/nri
	suit_store = /obj/item/gun/ballistic/automatic/akm/nri
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/nri/soldier
	back = /obj/item/storage/backpack/duffelbag/syndie/nri
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/storage/medkit/emergency,
							/obj/item/ammo_box/magazine/m9mm_aps,
							/obj/item/advanced_choice_beacon/nri/heavy,
							/obj/item/beamout_tool,
							/obj/item/crucifix)
	l_pocket = /obj/item/gun/ballistic/automatic/pistol/ladon/nri
	r_pocket = /obj/item/ammo_box/magazine/m9mm_aps
	shoes = /obj/item/clothing/shoes/magboots/advance

	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri

/datum/outfit/centcom/ert/nri/heavy
	name = "Novaya Rossiyskaya Imperiya Heavy Soldier"
	head = /obj/item/clothing/head/helmet/nri_heavy
	suit = /obj/item/clothing/suit/armor/heavy/nri
	glasses = /obj/item/clothing/glasses/hud/security/night
	mask = /obj/item/clothing/mask/gas/hecu2
	belt = /obj/item/storage/belt/military/nri/heavy
	suit_store = /obj/item/gun/ballistic/automatic/pistol/aps
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/storage/medkit/emergency,
							/obj/item/advanced_choice_beacon/nri/heavy,
							/obj/item/beamout_tool,
							/obj/item/crucifix)
	l_pocket = /obj/item/wrench/combat

	id_trim = /datum/id_trim/nri/heavy

/datum/outfit/centcom/ert/nri/commander
	name = "Novaya Rossiyskaya Imperiya Platoon Commander"
	head = /obj/item/clothing/head/helmet/space/hev_suit/nri/captain
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	uniform = /obj/item/clothing/under/costume/nri/captain
	belt = /obj/item/storage/belt/military/nri/captain/full
	suit = /obj/item/clothing/suit/space/hev_suit/nri/captain
	suit_store = /obj/item/gun/ballistic/automatic/akm/nri
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	back = /obj/item/storage/backpack/duffelbag/syndie/nri/captain
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/storage/medkit/regular,
							/obj/item/megaphone,
							/obj/item/binoculars,
							/obj/item/clothing/head/beret/sec/nri,
							/obj/item/ammo_box/magazine/m9mm_aps,
							/obj/item/beamout_tool,
							/obj/item/crucifix)

	id_trim = /datum/id_trim/nri/commander

/datum/outfit/centcom/ert/nri/medic
	name = "Novaya Rossiyskaya Imperiya Corpsman"
	head = /obj/item/clothing/head/helmet/space/hev_suit/nri/medic
	glasses = /obj/item/clothing/glasses/hud/health/night
	uniform = /obj/item/clothing/under/costume/nri/medic
	belt = /obj/item/storage/belt/military/nri/medic/full
	suit = /obj/item/clothing/suit/space/hev_suit/nri/medic
	suit_store = /obj/item/gun/ballistic/automatic/plastikov/nri
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	back = /obj/item/storage/backpack/duffelbag/syndie/nri/medic
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/storage/medkit/tactical,
							/obj/item/storage/medkit/advanced,
							/obj/item/storage/medkit/surgery,
							/obj/item/gun/medbeam,
							/obj/item/gun/energy/cell_loaded/medigun/cmo,
							/obj/item/storage/box/medicells,
							/obj/item/beamout_tool,
							/obj/item/crucifix)

	l_hand = /obj/item/shield/riot/pointman/nri

	id_trim = /datum/id_trim/nri/medic

/datum/outfit/centcom/ert/nri/engineer
	name = "Novaya Rossiyskaya Imperiya Combat Engineer"
	head = /obj/item/clothing/head/helmet/space/hev_suit/nri/engineer
	glasses = /obj/item/clothing/glasses/meson/night
	uniform = /obj/item/clothing/under/costume/nri/engineer
	belt = /obj/item/storage/belt/military/nri/engineer/full
	suit = /obj/item/clothing/suit/space/hev_suit/nri/engineer
	suit_store = /obj/item/gun/ballistic/automatic/plastikov/nri
	back = /obj/item/storage/backpack/duffelbag/syndie/nri/engineer
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/construction/rcd/loaded/upgraded,
							/obj/item/rcd_ammo/large,
							/obj/item/advanced_choice_beacon/nri/engineer,
							/obj/item/beamout_tool,
							/obj/item/crucifix)

	l_hand = /obj/item/storage/belt/utility/full/powertools

	id_trim = /datum/id_trim/nri/engineer

/datum/outfit/centcom/ert/nri/major
	name = "Novaya Rossiyskaya Imperiya Major"
	head = null
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = null
	uniform = /obj/item/clothing/under/costume/russian_officer
	suit = /obj/item/clothing/suit/jacket/officer/tan
	suit_store = null
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/gun/ballistic/revolver/nagant
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/ammo_box/n762,
							/obj/item/ammo_box/n762,
							/obj/item/suppressor,
							/obj/item/knife/combat,
							/obj/item/beamout_tool)
	l_pocket = null
	r_pocket = null
	shoes = /obj/item/clothing/shoes/combat/swat
	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri/diplomat/major

/datum/outfit/centcom/ert/nri/scientist
	name = "Novaya Rossiyskaya Imperiya Research Inspector"
	head = null
	glasses = /obj/item/clothing/glasses/regular
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = null
	uniform = /obj/item/clothing/under/rank/rnd/research_director
	suit = /obj/item/clothing/suit/toggle/labcoat
	suit_store = null
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/clipboard
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/melee/baton/telescopic,
							/obj/item/gun/energy/e_gun/mini,
							/obj/item/beamout_tool)
	l_pocket = null
	r_pocket = null
	shoes = /obj/item/clothing/shoes/sneakers/brown
	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri/diplomat/scientist

/datum/outfit/centcom/ert/nri/doctor
	name = "Novaya Rossiyskaya Imperiya Medical Inspector"
	head = null
	glasses = /obj/item/clothing/glasses/hud/health
	ears = /obj/item/radio/headset/headset_cent/alt/with_key
	mask = null
	uniform = /obj/item/clothing/under/rank/medical/chief_medical_officer
	suit = /obj/item/clothing/suit/toggle/labcoat/cmo
	suit_store = null
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/clipboard
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack,
							/obj/item/gun/ballistic/automatic/pistol/ladon/nri,
							/obj/item/ammo_box/magazine/m9mm_aps,
							/obj/item/ammo_box/magazine/m9mm_aps,
							/obj/item/storage/medkit/expeditionary,
							/obj/item/melee/baton/telescopic,
							/obj/item/beamout_tool)
	l_pocket = null
	r_pocket = null
	shoes = /obj/item/clothing/shoes/sneakers/brown
	id = /obj/item/card/id/advanced/centcom/ert/nri
	id_trim = /datum/id_trim/nri/diplomat/doctor

/datum/outfit/centcom/ert/nri/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	return
	//Two reasons for this; one, Russians aren't NT and dont need implants used mostly for NT-sympathizers. Two, the HUD looks ugly with the blue mindshield outline.
