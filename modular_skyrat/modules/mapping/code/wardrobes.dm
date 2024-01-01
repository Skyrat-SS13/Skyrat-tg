/obj/machinery/vending/wardrobe/canLoadItem(obj/item/I,mob/user)
	return (I.type in products)

/obj/machinery/vending/wardrobe/syndie_wardrobe
	name = "\improper SynDrobe"
	desc = "A vending machine for our boys in red, now in brand new crimson!"
	icon = 'modular_skyrat/modules/mapping/icons/obj/vending.dmi'
	icon_state = "syndrobe"
	product_ads = "Put a Donk on it!;Aim, Style, Shoot!;Brigged for wearing the best!"
	vend_reply = "Thank you for using the SynDrobe!"
	light_mask = ""
	products = list(
		/obj/item/clothing/under/syndicate/skyrat/tactical = 3,
		/obj/item/clothing/under/syndicate/skyrat/tactical/skirt = 3,
		/obj/item/clothing/under/syndicate/skyrat/overalls = 3,
		/obj/item/clothing/under/syndicate/skyrat/overalls/skirt = 3,
		/obj/item/clothing/under/syndicate/bloodred/sleepytime = 3,
		/obj/item/clothing/under/syndicate/sniper = 3,
		/obj/item/clothing/under/syndicate/camo = 3,
		/obj/item/clothing/under/syndicate/combat = 3,
		/obj/item/clothing/shoes/combat = 3,
		/obj/item/clothing/mask/gas/syndicate = 3,
		/obj/item/clothing/mask/gas/sechailer/syndicate = 3,
		/obj/item/clothing/suit/hooded/wintercoat/skyrat/syndicate = 5,
		/obj/item/clothing/head/soft/sec/syndicate = 3,
		/obj/item/clothing/head/beret/sec/syndicate = 3,
	)
	contraband = list(
		/obj/item/knife/combat = 1,
		/obj/item/clothing/under/syndicate/coldres = 2,
		/obj/item/clothing/shoes/combat/coldres = 2,
	)
	premium = list(
		/obj/item/knife/combat/survival = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 5,
		/obj/item/clothing/gloves/combat = 3,
		/obj/item/clothing/under/syndicate/skyrat/maid = 5,
		/obj/item/clothing/gloves/combat/maid = 5,
		/obj/item/clothing/head/costume/maidheadband/syndicate = 5,
		/obj/item/storage/box/nif_ghost_box/ghost_role = 10,
	)

	refill_canister = /obj/item/vending_refill/wardrobe/syndie_wardrobe
	light_color = COLOR_MOSTLY_PURE_RED

/obj/machinery/vending/wardrobe/syndie_wardrobe/ghost_cafe
	excluded_products = list(
		/obj/item/storage/box/nif_ghost_box/ghost_role,
	)

/obj/item/vending_refill/wardrobe/syndie_wardrobe
	machine_name = "SynDrobe"

/// This is essentially just a copy paste of the holy beacon, but with all options unlocked regardless of the global religion
/obj/item/choice_beacon/unholy
	name = "armaments beacon"
	desc = "Contains a set of armaments for those who would unlock their power."

/obj/item/choice_beacon/unholy/open_options_menu(mob/living/user)
	var/list/armament_names_to_images = list()
	var/list/armament_names_to_typepaths = list()
	for(var/obj/item/storage/box/holy/holy_box as anything in typesof(/obj/item/storage/box/holy))
		var/box_name = initial(holy_box.name)
		var/obj/item/preview_item = initial(holy_box.typepath_for_preview)
		armament_names_to_typepaths[box_name] = holy_box
		armament_names_to_images[box_name] = image(icon = initial(preview_item.icon), icon_state = initial(preview_item.icon_state))

	var/chosen_name = show_radial_menu(
		user = user,
		anchor = src,
		choices = armament_names_to_images,
		custom_check = CALLBACK(src, PROC_REF(can_use_beacon), user),
		require_near = TRUE,
	)
	if(!can_use_beacon(user))
		return
	var/chosen_type = armament_names_to_typepaths[chosen_name]
	if(!ispath(chosen_type, /obj/item/storage/box/holy))
		return

	consume_use(chosen_type, user)

/obj/item/choice_beacon/unholy/spawn_option(obj/choice_path, mob/living/user)
	playsound(src, 'sound/effects/pray_chaplain.ogg', 40, TRUE)
	return ..()

/// Just take out and replace the holy beacon with our 'unholy' beacon
/obj/machinery/vending/wardrobe/chap_wardrobe/unholy/Initialize(mapload)
	. = ..()
	for(var/datum/data/vending_product/record in product_records)
		if(record.product_path == /obj/item/choice_beacon/holy)
			record.product_path = /obj/item/choice_beacon/unholy
			record.amount = 3

			products.Remove(/obj/item/choice_beacon/holy)
			products.Add(list(
				/obj/item/choice_beacon/unholy = 3,)
			)

			return
