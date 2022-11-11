/datum/outfit/job/nanotrasen_consultant
	name = "Nanotrasen Consultant"
	jobtype = /datum/job/nanotrasen_consultant

	belt = /obj/item/modular_computer/tablet/pda/nanotrasen_consultant
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/nanotrasen_consultant
	gloves = /obj/item/clothing/gloves/combat
	uniform =  /obj/item/clothing/under/rank/nanotrasen_consultant
	suit = /obj/item/clothing/suit/armor/vest/nanotrasen_consultant
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/nanotrasen_consultant
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/storage/box/gunset/nanotrasen_consultant = 1,
		)

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/medal/gold/nanotrasen_consultant

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/centcom)

	id = /obj/item/card/id/advanced/centcom
	id_trim = /datum/id_trim/job/nanotrasen_consultant

/obj/item/radio/headset/heads/nanotrasen_consultant
	name = "\proper the nanotrasen consultant's headset"
	desc = "An official Central Command headset."
	icon_state = "cent_headset"
	keyslot = new /obj/item/encryptionkey/headset_com
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/heads/nanotrasen_consultant/alt
	name = "\proper the nanotrasen consultant's bowman headset"
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
	gloves = /obj/item/clothing/gloves/color/captain //Too iconic to be replaced with a plasma version
	head = /obj/item/clothing/head/helmet/space/plasmaman/centcom_official

/obj/item/modular_computer/tablet/pda/nanotrasen_consultant
	name = "nanotrasen consultant's PDA"
	inserted_disk = /obj/item/computer_disk/command/captain
	inserted_item = /obj/item/pen/fountain/captain
	greyscale_colors = "#017941#0060b8"

/obj/item/storage/box/gunset/nanotrasen_consultant
	name = "M45A5 gunset"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/pistol/m45a5/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/nanotrasen_consultant/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/m45a5/nomag(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)
	new /obj/item/ammo_box/magazine/m45a5(src)


/obj/structure/closet/secure_closet/nanotrasen_consultant/station
	name = "\proper nanotrasen consultant's locker"
	req_access = list(ACCESS_CAPTAIN, ACCESS_CENT_GENERAL)
	icon_state = "cc"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/nanotrasen_consultant/station/PopulateContents()
	..()
	new /obj/item/storage/backpack/satchel/leather(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/computer_disk/command/captain(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant/alt(src)
	new /obj/item/radio/headset/heads/nanotrasen_consultant(src)
	new /obj/item/clothing/glasses/sunglasses/gar/giga(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/bedsheet/centcom(src)
	new /obj/item/clothing/suit/hooded/wintercoat/centcom/nt_consultant(src)
