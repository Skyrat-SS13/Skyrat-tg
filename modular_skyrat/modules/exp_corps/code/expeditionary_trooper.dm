GLOBAL_LIST_EMPTY(expcorps_equipment)
GLOBAL_LIST_EMPTY(expcorps_eva)

/datum/job/expeditionary_trooper
	title = "Expeditionary Trooper"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Captain")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the captain"
	selection_color = "#9fffe2"
	minimal_player_age = 40
	exp_requirements = 400
	exp_type = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/expeditionary_trooper

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_KNOW_ENGI_WIRES)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/binoculars)

	trusted_only = TRUE

/datum/outfit/job/expeditionary_trooper
	name = "Expeditionary Trooper"
	jobtype = /datum/job/expeditionary_trooper

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/expeditionary_corps
	glasses = /obj/item/clothing/glasses/sunglasses/big

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list()

	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/expeditionary_trooper

	belt = /obj/item/pda/expeditionary_corps

/obj/effect/landmark/start/expeditionary_corps
	name = "Expeditionary Trooper"
	icon_state = "Security Officer"

/obj/item/pda/expeditionary_corps
	icon_state = "pda-syndi"
	name = "Military PDA"

/obj/item/storage/box/survival/expeditionary_corps
	mask_type = /obj/item/clothing/mask/gas/alt

/obj/item/storage/box/expeditionary_survival
	name = "expedition survival pack"
	desc = "A box filled with useful items for your expedition!"
	icon_state = "survival_pack"
	icon = 'modular_skyrat/modules/exp_corps/icons/survival_pack.dmi'
	illustration = null

/obj/item/storage/box/expeditionary_survival/PopulateContents()
	new /obj/item/crowbar/red(src)
	new /obj/item/kitchen/knife/combat/survival(src)
	new /obj/item/storage/box/donkpockets(src)
	new /obj/item/flashlight/glowstick(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/reagent_containers/food/drinks/waterbottle(src)
	new /obj/item/reagent_containers/blood/universal(src)
	new /obj/item/reagent_containers/syringe(src)

/obj/structure/closet/crate/secure/exp_corps
	name = "expeditionary gear crate"
	desc = "A secure weapons crate."
	icon_state = "expcrate"
	icon = 'modular_skyrat/modules/exp_corps/icons/exp_crate.dmi'
	req_access = list(ACCESS_GATEWAY)

/obj/structure/closet/crate/secure/exp_corps/PopulateContents()
	new /obj/item/storage/firstaid/tactical(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/clothing/suit/space/hardsuit/expeditionary_corps(src)
	new /obj/item/radio(src)
	new /obj/item/melee/tomahawk(src)
	new /obj/item/clothing/gloves/combat/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)

/obj/item/choice_beacon/exp_corps_equip
	name = "Expeditionary Corps Supply Beacon"
	desc = "Used to request your job supplies, use in hand to do so!"
	uses = 1

/obj/item/choice_beacon/exp_corps/generate_display_names()
	var/list/choices = list(/obj/structure/closet/crate/secure/exp_corps)
	return choices
