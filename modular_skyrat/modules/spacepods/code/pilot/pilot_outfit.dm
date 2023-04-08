/datum/outfit/job/spacepod_pilot
	name = "Spacepod Pilot"
	jobtype = /datum/job/spacepod_pilot

	belt = /obj/item/storage/belt/security/webbing/peacekeeper/full
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/rank/spacepod_pilot
	gloves = /obj/item/clothing/gloves/color/black/spacepod_pilot
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/alt
	head = /obj/item/clothing/head/spacepod_pilot
	backpack_contents = list(
		/obj/item/storage/box/gunset/ladon = 1,
		/obj/item/spacepod_key/sec,
		)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/spacepod_pilot

/datum/id_trim/job/spacepod_pilot
	assignment = "Security Medic"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_securitymedic"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_ASSEMBLY_BLACK
	sechud_icon_state = SECHUD_SPACEPOD_PILOT
	extra_access = list(ACCESS_DETECTIVE)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SPACEPOD_HANGAR, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM, ACCESS_MAINT_TUNNELS)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)

/datum/id_trim/job/spacepod_pilot/New()
	. = ..()

	// Config check for if sec has maint access.
	if(CONFIG_GET(flag/security_has_maint_access))
		access |= list(ACCESS_MAINT_TUNNELS)
