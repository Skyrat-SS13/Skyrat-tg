/obj/machinery/vending/nifsoft
	name = "NIFSoft Vendor"
	desc = "Money can be exchanged here for NIFSofts and other NIF goods" //Placeholder description
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/machines/vendors.dmi'
	icon_state = "proj"
	density = FALSE

	products = list(
		/obj/item/disk/nifsoft_uploader/virtual_machine = 10,
		/obj/item/disk/nifsoft_uploader/shapeshifter = 10,
		/obj/item/disk/nifsoft_uploader/summoner = 10,
		/obj/item/disk/nifsoft_uploader/hivemind = 10,
		)

	premium = list(
		/obj/item/autosurgeon/organ/nif/disposable = 5,
	)
