/obj/effect/landmark/start/solfed_liaison
	name = "SolFed Liaison"
	icon_state = "SolFed Liaison"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'


/obj/structure/closet/secure_closet/solfed_liaison
	name = "\proper solar federation liaison's locker"
	req_access = list(ACCESS_SOLFED)
	icon_state = "solfed"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	door_anim_time = 0


/obj/structure/closet/secure_closet/solfed_liaison/PopulateContents()
	. = ..()
	new /obj/item/storage/backpack/satchel/leather(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/computer_disk/command/captain(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/storage/photo_album/personal(src)
	new /obj/item/radio/headset/solfed/liaison(src)
	new /obj/item/radio/headset/solfed/liaison/alt(src)
	new /obj/item/assembly/flash(src)
	new /obj/item/clothing/under/rank/solfed_liaison/casual(src)
	new /obj/item/clothing/suit/jacket/solfed_liaison/casual(src)
	new /obj/item/clothing/suit/jacket/solfed_liaison/formal(src)


/obj/machinery/fax/solfed
	name = "\improper SolFed Liaison's Fax Machine"
	desc = "A fax machine containing the proper encryption keys to send a message to the Solar Federation."
	fax_name = "SolFed Liaison's Office"
	fax_keys = list(
		FAX_KEY_SOLFED,
	)


/obj/item/circuitboard/machine/fax/solfed
	name = "Fax Machine (SolFed)"
	build_path = /obj/machinery/fax/solfed
