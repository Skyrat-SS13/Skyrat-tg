/datum/job/expeditionary_corps
	title = "Expeditionary Trooper"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Captain")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the captain"
	selection_color = "#00ffb3"
	minimal_player_age = 40
	exp_requirements = 400
	exp_type = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/expeditionary_corps
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_KNOW_ENGI_WIRES)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/binoculars)

/datum/outfit/job/expeditionary_corps
	name = "Expeditionary Trooper"
	jobtype = /datum/job/expeditionary_corps

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/expeditionary_corps
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/sunglasses/big

	backpack_contents = list(/obj/item/pda/expeditionary_corps)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/expeditionary_corps

/obj/effect/landmark/start/expeditionary_corps
	name = "Expeditionary Trooper"
	icon_state = "Security Officer"

/obj/item/pda/expeditionary_corps
	icon_state = "pda-syndi"
	name = "Military PDA"

/obj/item/storage/box/survival/expeditionary_corps
	mask_type = /obj/item/clothing/mask/gas/alt

/obj/item/storage/box/survival/expeditionary_corps/PopulateContents()
	..()
	new /obj/item/crowbar/red(src)
	new /obj/item/kitchen/knife/combat(src)

/obj/structure/closet/secure_closet/expeditionary_corps
	name = "\proper expeditionary corps locker"
	req_access = list(ACCESS_GATEWAY, ACCESS_SEC_DOORS)
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/exp_corps/icons/closet.dmi'

/obj/structure/closet/secure_closet/expeditionary_corps/PopulateContents()
	..()
	new /obj/item/storage/belt/military/expeditionary_corps(src)
	new /obj/item/clothing/shoes/combat/expeditionary_corps(src)
	new /obj/item/clothing/gloves/combat/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/storage/backpack/duffelbag/syndie/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/firstaid/tactical(src)
	new /obj/item/radio(src)

/obj/machinery/suit_storage_unit/expeditionary_corps
	suit_type = /obj/item/clothing/suit/space/hardsuit/expeditionary_corps
	mask_type = /obj/item/clothing/mask/gas/alt
	storage_type = /obj/item/tank/internals/oxygen
