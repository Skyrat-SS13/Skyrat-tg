/obj/machinery/vending/nifsoft
	name = "NIFSoft Vendor"
	desc = "A hardlight vendor self-contained in a floating projector. This salescreen is far more advanced than the backwater old-style vendors normally found scattered around the Frontier, mostly owing to it not selling any physical product. Instead, this interface is meant for users of Nanite Implant Frameworks, forming a connection with the latent field of nanomachinery surrounding Framework users to download new programming and software from various distribution networks and directories. While many are available, Corporations are actively attempting to stop vendors such as this one from selling NIFsofts capable of harming their assets."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/machines/vendors.dmi'
	refill_canister = /obj/item/vending_refill/nifsoft_shop
	icon_state = "proj"
	tiltable = FALSE
	density = FALSE
	default_price = 300
	extra_price = 900

	product_categories = list(
		list(
			"name" = "NIFSofts",
			"icon" = "download",
			"products" = list(
				/obj/item/disk/nifsoft_uploader/shapeshifter = 10,
				/obj/item/disk/nifsoft_uploader/summoner = 10,
				/obj/item/disk/nifsoft_uploader/hivemind = 10,
			)
		)
	)

	premium = list(
		/obj/item/autosurgeon/organ/nif/disposable = 5,
	)

/obj/machinery/vending/nifsoft/ghost //Contains every NIFSoft and contains the standard NIF with persistence removed. Mostly here for ghost cafe and syndies
	default_price = 0
	extra_price = 0
	products = list(
		/obj/item/disk/nifsoft_uploader/shapeshifter = 10,
		/obj/item/disk/nifsoft_uploader/summoner/ghost = 10,
		/obj/item/disk/nifsoft_uploader/hivemind = 10,
		/obj/item/disk/nifsoft_uploader/money_sense = 10,
	)

	premium = list(
		/obj/item/autosurgeon/organ/nif/ghost_role = 5,
	)

/obj/item/vending_refill/nifsoft_shop
	machine_name = "NIFSoft Vendor"
