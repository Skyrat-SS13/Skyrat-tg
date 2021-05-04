GLOBAL_LIST_EMPTY(expcorps_equipment)
GLOBAL_LIST_EMPTY(expcorps_eva)

/datum/job/expeditionary_corps
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

	outfit = /datum/outfit/job/expeditionary_corps
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_KNOW_ENGI_WIRES)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/binoculars)

	trusted_only = TRUE

/datum/outfit/job/expeditionary_corps
	name = "Expeditionary Trooper"
	jobtype = /datum/job/expeditionary_corps

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/expeditionary_corps
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

/obj/structure/closet/secure_closet/expeditionary_corps
	name = "\proper expeditionary corps locker"
	req_access = list(ACCESS_GATEWAY, ACCESS_SEC_DOORS)
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/exp_corps/icons/closet.dmi'

/obj/structure/closet/secure_closet/expeditionary_corps/PopulateContents()
	..()
	new /obj/item/storage/belt/military/expeditionary_corps(src)
	new /obj/item/clothing/gloves/combat/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/firstaid/tactical(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/radio(src)

/obj/machinery/suit_storage_unit/expeditionary_corps
	suit_type = /obj/item/clothing/suit/space/hardsuit/expeditionary_corps
	mask_type = /obj/item/clothing/mask/gas/alt
	storage_type = /obj/item/tank/internals/oxygen

/obj/effect/landmark/expcorps_equipment
	name = "expcorpsequipment"
	icon_state = "secequipment"

/obj/effect/landmark/expcorps_equipment/Initialize(mapload)
	..()
	GLOB.expcorps_equipment += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/expcorps_eva
	name = "expcorpseva"
	icon_state = "secequipment"

/obj/effect/landmark/expcorps_eva/Initialize(mapload)
	..()
	GLOB.expcorps_eva += loc
	return INITIALIZE_HINT_QDEL

/datum/controller/subsystem/job/proc/spawn_exp_corps_lockers()
	var/datum/job/exp_corps = SSjob.GetJob("Expeditionary Trooper")

	var/lockers2spawn = exp_corps.current_positions

	for(var/i = 1, i <= lockers2spawn, i++)
		if(GLOB.expcorps_equipment.len)
			var/spawnloc = GLOB.expcorps_equipment[1]
			new /obj/structure/closet/secure_closet/expeditionary_corps(spawnloc)
			GLOB.expcorps_equipment -= spawnloc
		else
			message_admins("Expeditionary corps didn't have enough locker spawns left!")
		if(GLOB.expcorps_eva.len)
			var/spawnloc = GLOB.expcorps_eva[1]
			new /obj/machinery/suit_storage_unit/expeditionary_corps(spawnloc)
			GLOB.expcorps_eva -= spawnloc
		else
			message_admins("Expeditionary corps didn't have enough suit storage unit spawns left!")

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
	new /obj/item/survivalcapsule(src)
	new /obj/item/reagent_containers/food/drinks/waterbottle(src)
