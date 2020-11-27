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

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_FORENSICS_LOCKERS, \
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_HEADS, \
			            ACCESS_MAINT_TUNNELS, ACCESS_CONSTRUCTION, ACCESS_MORGUE, \
			            ACCESS_RESEARCH, ACCESS_CARGO, \
			            ACCESS_RC_ANNOUNCE, ACCESS_GATEWAY, ACCESS_WEAPONS, ACCESS_BLUESHIELD)
	minimal_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH,
			            ACCESS_RC_ANNOUNCE, ACCESS_HEADS, ACCESS_BLUESHIELD, ACCESS_WEAPONS)
	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	outfit = /datum/outfit/job/blueshield

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	uniform = /obj/item/clothing/under/rank/security/blueshield
	id = /obj/item/card/id/silver
	suit = /obj/item/clothing/suit/armor/vest/blueshield
	suit_store = /obj/item/gun/ballistic/automatic/wt550
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated/blueshield
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/heads/blueshield/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(/obj/item/ammo_box/magazine/wt550m9 = 2,/obj/item/melee/baton/blueshieldprod = 1)
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

/obj/item/choice_beacon/blueshield
	name = "blueshield's shotgun beacon"
	desc = "A beacon, allowing the blueshield to select between two available models of personal shotguns."

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/bshield
	if(!bshield)
		bshield = list()
		bshield["Energy Revolver"] = /obj/item/gun/energy/e_gun/revolver
		bshield["PDW-9"] = /obj/item/gun/energy/e_gun/revolver/pdw9
	return bshield
