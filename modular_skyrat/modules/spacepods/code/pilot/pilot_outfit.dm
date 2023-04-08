/datum/outfit/job/spacepod_pilot
	name = "Spacepod Pilot"
	jobtype = /datum/job/spacepod_pilot

	belt = /obj/item/modular_computer/pda/security
	ears = /obj/item/radio/headset/headset_medsec
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/security_medic
	gloves = /obj/item/clothing/gloves/latex/nitrile
	shoes = /obj/item/clothing/shoes/jackboots/sec
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	l_hand = /obj/item/storage/medkit/brute
	head = /obj/item/clothing/head/beret/sec/peacekeeper/security_medic
	backpack_contents = list(
		/obj/item/storage/box/gunset/firefly = 1,
		)
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/security_medic

/obj/effect/landmark/start/security_officer/Initialize(mapload)
	. = ..()
	new /obj/effect/landmark/start/security_medic(get_turf(src))


/datum/outfit/shuttle_pilot
	name = "Shuttle Pilot"

	shoes = /obj/item/clothing/shoes/combat/tan
	ears = /obj/item/radio/headset/heads/captain
	uniform = /obj/item/clothing/under/rank/utility_tan
	glasses = /obj/item/clothing/glasses/sunglasses/swat
	head = /obj/item/clothing/head/helmet/tan
	suit = /obj/item/clothing/suit/armor/vest/tan

	belt = /obj/item/storage/belt/military/tan

	gloves = /obj/item/clothing/gloves/combat/tan

	back = /obj/item/storage/backpack/satchel/leather

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/chameleon/black

	belt = /obj/item/pda/syndicate
