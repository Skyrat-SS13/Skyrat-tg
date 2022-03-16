//VENDING MACHINES
/obj/machinery/vending/assaultops_ammo
	name = "\improper Syndicate Ammo Station"
	desc = "An ammo vending machine which holds a variety of different ammo mags."
	icon_state = "liberationstation"
	vend_reply = "Item dispensed."
	scan_id = FALSE
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF
	onstation = FALSE
	light_mask = "liberation-light-mask"
	default_price = 0
	var/filled = FALSE

/obj/machinery/vending/assaultops_ammo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		fill_ammo(user)
		ui = new(user, src, "Vending")
		ui.open()


/obj/machinery/vending/assaultops_ammo/proc/fill_ammo(mob/user)
	if(last_shopper == user && filled)
		return
	else
		filled = FALSE

	if(!ishuman(user))
		return FALSE

	if(!user.mind.has_antag_datum(/datum/antagonist/assault_operative))
		return FALSE

	//Remove all current items from the vending machine
	products.Cut()
	product_records.Cut()

	var/mob/living/carbon/human/human_user = user

	//Find all the ammo we should display
	for(var/i in human_user.contents)
		if(istype(i, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/gun = i
			if(!gun.internal_magazine)
				products.Add(gun.mag_type)
		if(istype(i, /obj/item/storage))
			var/obj/item/storage/storage = i
			for(var/C in storage.contents)
				if(istype(C, /obj/item/gun/ballistic))
					var/obj/item/gun/ballistic/gun = C
					if(!gun.internal_magazine)
						products.Add(gun.mag_type)

	//Add our items to the list of products
	build_inventory(products, product_records, FALSE)

	filled = TRUE

/obj/machinery/vending/assaultops_ammo/build_inventory(list/productlist, list/recordlist, start_empty = FALSE)
	default_price = 0
	extra_price = 0
	for(var/typepath in productlist)
		var/amount = 4
		var/atom/temp = typepath
		var/datum/data/vending_product/vending_product = new /datum/data/vending_product()

		GLOB.vending_products[typepath] = 1
		vending_product.name = initial(temp.name)
		vending_product.product_path = typepath
		if(!start_empty)
			vending_product.amount = amount
		vending_product.max_amount = amount
		vending_product.custom_price = 0
		vending_product.custom_premium_price = 0
		vending_product.age_restricted = FALSE
		recordlist += vending_product
