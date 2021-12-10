/datum/job/gun_dealer
	title = "Gun Dealer"
	description = "Sell guns, sell ammo, sell excuses for Security to arrest people."
	department_head = list("Quartermaster")
	job_spawn_title = "Cargo Technician"
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Quartermaster"
	selection_color = "#ffeeee"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/gun_dealer
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_CARGO_TECHNICIAN
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/clipboard)

	mail_goodies = list(
		/obj/item/pizzabox = 10,
		/obj/item/stack/sheet/mineral/gold = 5,
		/obj/item/stack/sheet/mineral/uranium = 4,
		/obj/item/stack/sheet/mineral/diamond = 3,
		/obj/item/gun/ballistic/rifle/boltaction = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/obj/item/clothing/glasses/hud/gun
	name = "gun permit HUD"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their firearm licenses."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "gunhud"
	hud_type = DATA_HUD_GUNDEALER
	glass_colour_type = /datum/client_colour/glass_colour/orange

/obj/item/clothing/under/rank/cargo/gun_dealer
	name = "gun dealer outfit"
	desc = "/advert raid"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "dealer_uniform"
	worn_icon_state = "dealer_uniform"
	mutant_variants = STYLE_DIGITIGRADE
	can_adjust = TRUE

/obj/item/clothing/suit/gun_dealer
	name = "gun dealer coat"
	desc = "What're ya buyin'?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "dealer_coat"
	worn_icon_state = "dealer_coat"
	mutant_variants = null

/obj/item/clothing/head/gun_dealer
	name = "gun dealer beret"
	desc = "Come back any time!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "dealer_beret"
	worn_icon_state = "dealer_beret"
	mutant_variants = null

/datum/outfit/job/gun_dealer
	name = "Gun Dealer"
	jobtype = /datum/job/gun_dealer

	id_trim = /datum/id_trim/job/gun_dealer
	uniform = /obj/item/clothing/under/rank/cargo/gun_dealer
	suit = /obj/item/clothing/suit/gun_dealer
	head = /obj/item/clothing/head/gun_dealer
	backpack_contents = list(
		/obj/item/modular_computer/tablet/preset/cargo = 1,
		)
	belt = /obj/item/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	glasses = /obj/item/clothing/glasses/hud/gun

/datum/id_trim/job/gun_dealer
	assignment = "Gun Dealer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_gundealer"
	extra_access = list(ACCESS_QM, ACCESS_MINING, ACCESS_MINING_STATION)
	minimal_access = list(ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_MAINT_TUNNELS, ACCESS_MECH_MINING, ACCESS_MINERAL_STOREROOM, ACCESS_GUNDEALER, ACCESS_WEAPONS)
	config_job = "gundealer"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/gun_dealer
