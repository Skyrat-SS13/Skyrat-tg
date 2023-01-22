/obj/effect/landmark/start/armadyne_rep
	name = "Armadyne Representative"
	icon_state = "Armadyne Representative"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'


/obj/structure/closet/secure_closet/armadyne_representative
	name = "\proper armadyne representative's locker"
	req_access = list(ACCESS_ARMADYNE)
	icon_state = "armadyne"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	door_anim_time = 0


/obj/structure/closet/secure_closet/armadyne_representative/PopulateContents()
	. = ..()
	new /obj/item/storage/secure/briefcase/armadyne_incentive(src)
	new /obj/item/clothing/shoes/sneakers/black(src)
	new /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/armadyne(src)
	new /obj/item/computer_disk/command/captain(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/gloves/combat/peacekeeper/armadyne(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/assembly/flash(src)
	new /obj/item/radio/headset/armadyne/representative(src)
	new /obj/item/radio/headset/armadyne/representative/alt(src)
	new /obj/item/storage/backpack/satchel/leather(src)


/obj/machinery/fax/armadyne
	name = "\improper Armadyne Representative's Fax Machine"
	desc = "A fax machine containing the proper encryption keys for sending a message to the Armadyne corporation."
	fax_name = "Armadyne Representative's Office"
	fax_keys = list(
		FAX_KEY_ARMADYNE,
	)


/obj/item/circuitboard/machine/fax/armadyne
	name = "Fax Machine (Armadyne)"
	build_path = /obj/machinery/fax/armadyne
