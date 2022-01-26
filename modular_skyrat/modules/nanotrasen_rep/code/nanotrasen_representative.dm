/datum/job/nanotrasen_representative
	title = JOB_NT_REP
	description = "Represent Nanotrasen on the station, argue with the HoS about why he can't just field execute people for petty theft, get drunk in your office."
	department_head = list(JOB_CENTCOM)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command"
	selection_color = "#c6ffe0"
	minimal_player_age = 14
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW

	department_for_prefs = /datum/job_department/captain

	departments_list = list(
		/datum/job_department/command,
		/datum/job_department/central_command
	)

	outfit = /datum/outfit/job/nanotrasen_representative
	plasmaman_outfit = /datum/outfit/plasmaman/nanotrasen_representative

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_CMD

	display_order = JOB_DISPLAY_ORDER_NANOTRASEN_REPRESENTATIVE
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/food/drinks/bottle/champagne = 10
	)

	veteran_only = TRUE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/job/nanotrasen_representative/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	to_chat(H, span_boldannounce("As the Nanotrasen Representative, you are required to follow the following placeholder policy and SOP: https://paradisestation.org/wiki/index.php/Nanotrasen_Representative"))
	//REMOVE THIS AFTER FAX MACHINES ARE ADDED!!!!
	to_chat(H, span_boldannounce("If you require IC admin intervention, send an admin help until the fax machine is added."))

/datum/outfit/job/nanotrasen_representative
	name = "Nanotrasen Representative"
	jobtype = /datum/job/nanotrasen_representative

	belt = /obj/item/pda/nanotrasen_representative
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/nanotrasen_representative
	gloves = /obj/item/clothing/gloves/combat
	uniform =  /obj/item/clothing/under/rank/nanotrasen_representative
	suit = /obj/item/clothing/suit/armor/vest/nanotrasen_representative
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/nanotrasen_representative
	backpack_contents = list(/obj/item/melee/baton/telescopic)

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/medal/gold/nanotrasen_representative

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/centcom)

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/job/nanotrasen_representative

/obj/item/radio/headset/heads/nanotrasen_representative
	name = "\proper the nanotrasen representative's headset"
	desc = "An official Central Command headset."
	icon_state = "cent_headset"
	keyslot = new /obj/item/encryptionkey/headset_com
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/heads/nanotrasen_representative/alt
	name = "\proper the nanotrasen representative's bowman headset"
	desc = "An official Central Command headset. Protects ears from flashbangs."
	icon_state = "cent_headset_alt"
	inhand_icon_state = "cent_headset_alt"

/obj/item/radio/headset/heads/nanotrasen_representative/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/effect/landmark/start/nanotrasen_representative
	name = "Nanotrasen Representative"
	icon_state = "Nanotrasen Representative"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/item/clothing/accessory/medal/gold/nanotrasen_representative
	name = "medal of diplomacy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of Nanotrasen Representative. It signifies the diplomatic abilities of said individual and their sheer dedication to Nanotrasen."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/datum/outfit/plasmaman/nanotrasen_representative
	name = "Nanotrasen Representative Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/centcom_official
	gloves = /obj/item/clothing/gloves/color/captain //Too iconic to be replaced with a plasma version
	head = /obj/item/clothing/head/helmet/space/plasmaman/centcom_official

/obj/item/pda/nanotrasen_representative
	name = "nanotrasen representatives PDA"
	default_cartridge = /obj/item/cartridge/captain
	inserted_item = /obj/item/pen/fountain/captain
	greyscale_colors = "#017941#0060b8"

/obj/item/storage/box/gunset/nanotrasen_representative
	name = "M45A5 Gunset"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/pistol/m45a5/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/nanotrasen_representative/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/m45a5/nomag(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)


/obj/structure/closet/secure_closet/nanotrasen_representative/station
	name = "\proper nanotrasen representative's locker"
	req_access = list(ACCESS_CAPTAIN, ACCESS_CENT_GENERAL)
	icon_state = "cc"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/nanotrasen_representative/station/PopulateContents()
	..()
	new /obj/item/storage/backpack/satchel/leather(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/cartridge/captain(src)
	new /obj/item/radio/headset/heads/nanotrasen_representative/alt(src)
	new /obj/item/radio/headset/heads/nanotrasen_representative(src)
	new /obj/item/clothing/glasses/sunglasses/gar/giga(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/bedsheet/centcom(src)
	new /obj/item/clothing/suit/hooded/wintercoat/centcom/ntrep(src)
	new /obj/item/gun/energy/e_gun(src)
