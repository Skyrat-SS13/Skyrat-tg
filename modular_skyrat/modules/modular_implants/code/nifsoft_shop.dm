/obj/machinery/vending/nifsoft
	name = "NIFSoft Vendor"
	desc = "Money can be exchanged here for NIFSofts and other NIF goods." //Placeholder description
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/machines/vendors.dmi'
	refill_canister = /obj/item/vending_refill/nifsoft_shop
	icon_state = "proj"
	density = FALSE
	default_price = 400
	extra_price = 750

	products = list(
		/obj/item/disk/nifsoft_uploader/virtual_machine = 10,
		/obj/item/disk/nifsoft_uploader/shapeshifter = 10,
		/obj/item/disk/nifsoft_uploader/summoner = 10,
		/obj/item/disk/nifsoft_uploader/hivemind = 10,
		)

	premium = list(
		/obj/item/autosurgeon/organ/nif/disposable = 5,
	)


/obj/machinery/vending/nifsoft/ghost //Contains every NIFSoft and contains the standard NIF with persistence removed. Mostly here for ghost cafe and syndies
	products = list(
		/obj/item/disk/nifsoft_uploader/virtual_machine = 10,
		/obj/item/disk/nifsoft_uploader/shapeshifter = 10,
		/obj/item/disk/nifsoft_uploader/summoner = 10,
		/obj/item/disk/nifsoft_uploader/hivemind = 10,
		/obj/item/disk/nifsoft_uploader/money_sense = 10,
	)

	premium = list(
		/obj/item/autosurgeon/organ/nif/ghost_role = 5,
	)


/obj/item/vending_refill/nifsoft_shop
	machine_name = "NIFSoft Vendor"
