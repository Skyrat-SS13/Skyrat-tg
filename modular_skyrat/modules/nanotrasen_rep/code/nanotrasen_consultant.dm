/datum/job/nanotrasen_consultant
	title = JOB_NT_REP
	description = "Represent Nanotrasen on the station, argue with the HoS about why he can't just field execute people for petty theft, get drunk in your office."
	department_head = list(JOB_CENTCOM)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Central Command"
	minimal_player_age = 14
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "NANOTRASEN_CONSULTANT"

	department_for_prefs = /datum/job_department/captain

	departments_list = list(
		/datum/job_department/command,
		/datum/job_department/central_command
	)

	outfit = /datum/outfit/job/nanotrasen_consultant
	plasmaman_outfit = /datum/outfit/plasmaman/nanotrasen_consultant

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CMD

	display_order = JOB_DISPLAY_ORDER_NANOTRASEN_CONSULTANT
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

	mail_goodies = list(
		/obj/item/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10
	)

	veteran_only = TRUE
	job_flags = STATION_JOB_FLAGS | JOB_BOLD_SELECT_TEXT | JOB_CANNOT_OPEN_SLOTS

/datum/outfit/job/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	jobtype = /datum/job/nanotrasen_consultant

	belt = /obj/item/modular_computer/pda/nanotrasen_consultant
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/nanotrasen_consultant
	gloves = /obj/item/clothing/gloves/combat
	uniform =  /obj/item/clothing/under/rank/nanotrasen_consultant
	suit = /obj/item/clothing/suit/armor/vest/nanotrasen_consultant
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/nanotrasen_consultant
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/gun/energy/e_gun/mini = 1,
		)

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/medal/gold/nanotrasen_consultant

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/centcom)

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/job/nanotrasen_consultant

/obj/item/radio/headset/heads/nanotrasen_consultant
	name = "\proper the Nanotrasen consultant's headset"
	desc = "An official Central Command headset."
	icon_state = "cent_headset"
	keyslot = new /obj/item/encryptionkey/headset_com
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/heads/nanotrasen_consultant/alt
	name = "\proper the Nanotrasen consultant's bowman headset"
	desc = "An official Central Command headset. Protects ears from flashbangs."
	icon_state = "cent_headset_alt"

/obj/item/radio/headset/heads/nanotrasen_consultant/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/effect/landmark/start/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	icon_state = "Nanotrasen Consultant"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/item/clothing/accessory/medal/gold/nanotrasen_consultant
	name = "medal of diplomacy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of Nanotrasen Consultant. It signifies the diplomatic abilities of said individual and their sheer dedication to Nanotrasen."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/datum/outfit/plasmaman/nanotrasen_consultant
	name = "Nanotrasen Consultant Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/centcom_official
	gloves = /obj/item/clothing/gloves/captain //Too iconic to be replaced with a plasma version
	head = /obj/item/clothing/head/helmet/space/plasmaman/centcom_official

/obj/item/modular_computer/pda/nanotrasen_consultant
	name = "nanotrasen consultant's PDA"
	inserted_disk = /obj/item/computer_disk/command/captain
	inserted_item = /obj/item/pen/fountain/captain
	greyscale_colors = "#017941#0060b8"

/obj/item/storage/bag/garment/nanotrasen_consultant
	name = "nanotrasen consultant's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the Nanotrasen consultant."

/obj/item/storage/bag/garment/nanotrasen_consultant/PopulateContents()
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/glasses/sunglasses/gar/giga(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/gloves/combat/naval/nanotrasen_consultant(src)
	new /obj/item/clothing/suit/hooded/wintercoat/centcom/nt_consultant(src)
	new /obj/item/clothing/under/rank/nanotrasen_consultant(src)
	new /obj/item/clothing/under/rank/nanotrasen_consultant/skirt(src)
	new /obj/item/clothing/under/rank/centcom/officer(src)
	new /obj/item/clothing/under/rank/centcom/officer_skirt(src)
	new /obj/item/clothing/head/nanotrasen_consultant(src)
	new /obj/item/clothing/head/nanotrasen_consultant/beret(src)
	new /obj/item/clothing/head/beret/centcom_formal/nt_consultant(src)
	new /obj/item/clothing/head/hats/centhat(src)
	new /obj/item/clothing/suit/armor/centcom_formal/nt_consultant(src)
	new /obj/item/clothing/under/rank/centcom/intern(src)
	new /obj/item/clothing/head/hats/intern(src)

/obj/structure/closet/secure_closet/nanotrasen_consultant
	name = "nanotrasen consultant's locker"
	req_access = list(ACCESS_CAPTAIN, ACCESS_CENT_GENERAL)
	icon_state = "cc"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'

/obj/structure/closet/secure_closet/nanotrasen_consultant/PopulateContents()
	..()
	new /obj/item/storage/backpack/satchel/leather(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/computer_disk/command/captain(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant/alt(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/bedsheet/centcom(src)
	new /obj/item/storage/bag/garment/nanotrasen_consultant(src)
	new /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/firefly(src)
