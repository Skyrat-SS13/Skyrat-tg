/obj/item/storage/belt/medical/ert
	preload = TRUE

/obj/item/storage/belt/medical/ert/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/pinpointer/crew, src)
	SSwardrobe.provide_type(/obj/item/scalpel/advanced, src)
	SSwardrobe.provide_type(/obj/item/retractor/advanced, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/bone_gel, src)
	SSwardrobe.provide_type(/obj/item/cautery/advanced, src)
	SSwardrobe.provide_type(/obj/item/surgical_drapes, src)
	update_appearance()

/obj/item/storage/belt/medical/ert/get_types_to_preload()
	var/list/to_preload = list()
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/pinpointer/crew
	to_preload += /obj/item/scalpel/advanced
	to_preload += /obj/item/retractor/advanced
	to_preload += /obj/item/stack/medical/bone_gel
	to_preload += /obj/item/cautery/advanced
	to_preload += /obj/item/surgical_drapes
	return to_preload
