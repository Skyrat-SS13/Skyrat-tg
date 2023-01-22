/obj/machinery/fax/nanotrasen
	name = "\improper Nanotrasen Consultant's Fax Machine"
	desc = "A fax machine containing the proper encryption keys for sending a message to Central Command."
	fax_name = "Nanotrasen Consultant's Office"
	fax_keys = list(
		FAX_KEY_CENTCOM,
	)


/obj/item/circuitboard/machine/fax/nanotrasen
	name = "Fax Machine (Nanotrasen)"
	build_path = /obj/machinery/fax/nanotrasen


/obj/structure/closet/secure_closet/nanotrasen_consultant/station
	name = "\proper nanotrasen consultant's locker"
	req_access = list(ACCESS_CAPTAIN, ACCESS_CENT_GENERAL)
	icon_state = "cc"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	door_anim_time = 0


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
	new /obj/item/assembly/flash(src)
