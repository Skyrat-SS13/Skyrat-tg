/datum/job/blueshield
	title = "Blueshield"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Central Command")
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command"
	selection_color = "#ddddff"
	minimal_player_age = 7
	exp_requirements = 2400
	exp_type = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/blueshield

	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	outfit = /datum/outfit/job/blueshield

	id_trim = /datum/id_trim/job/blueshield

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	uniform = /obj/item/clothing/under/rank/security/blueshield
	suit = /obj/item/clothing/suit/armor/vest/blueshield
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	id = /obj/item/card/id/advanced/silver
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/heads/blueshield/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(/obj/item/storage/box/gunset/blueshield,/obj/item/melee/baton/blueshieldprod = 1)
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffel/blueshield
	head = /obj/item/clothing/head/beret/blueshield
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/pda/security



/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield


