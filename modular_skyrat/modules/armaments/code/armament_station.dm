/**
 * Armament Station
 *
 * These are the stations designed to be used by players to outfit themselves.
 * They contain a "products" variable which you can populate with your own set of armament entries.
 *
 * If you plan on making your own station, it is strongly recommended you use your own armament entries for whatever it is you're doing.
 *
 * Never directly edit an armament entry as this will be carried through all other vendors.
 *
 * @author Gandalf2k15
 */

/obj/machinery/armament_station
	name = "Armament Outfitting Station"
	desc = "A versatile station for equipping your weapons."
	icon = 'icons/obj/vending.dmi'
	icon_state = "liberationstation"
	density = TRUE
	/// Used to keep track of what categories have been used
	var/list/used_categories = list()
	/// Used to keep track of what items have been purchased
	var/list/purchased_items = list()
	/// If set, will limit this station to the products within this list.
	var/list/products
	/// The points card that is currently inserted.
	var/obj/item/armament_points_card/inserted_card

/obj/machinery/armament_station/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(istype(weapon, /obj/item/armament_points_card))
		var/obj/item/inserting_card = weapon
		if(inserted_card)
			to_chat(user, span_warning("There is already a card inserted into [src]!"))
			return
		inserted_card = inserting_card
		inserted_card.forceMove(src)
		to_chat(user, span_notice("You insert [inserting_card] into [src]!"))
		playsound(src, 'sound/machines/terminal_insert_disc.ogg', 70)

/obj/machinery/armament_station/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ArmamentStation")
		ui.open()

// This data proc may look complex. That's because it is.
/obj/machinery/armament_station/ui_data(mob/user)
	var/list/data = list()

	data["card_inserted"] = inserted_card ? TRUE : FALSE
	data["card_name"] = "unknown"
	data["card_points"] = 0
	if(inserted_card)
		data["card_points"] = inserted_card.points
		data["card_name"] = inserted_card.name

	data["armaments_list"] = list()
	for(var/armament_category as anything in GLOB.armament_entries)
		var/list/armament_subcategories = list()
		for(var/subcategory as anything in GLOB.armament_entries[armament_category][CATEGORY_ENTRY])
			var/list/subcategory_items = list()
			for(var/datum/armament_entry/armament_entry as anything in GLOB.armament_entries[armament_category][CATEGORY_ENTRY][subcategory])
				if(products && !(armament_entry.type in products))
					continue
				subcategory_items += list(list(
					"ref" = REF(armament_entry),
					"icon" = armament_entry.cached_base64,
					"name" = armament_entry.name,
					"cost" = armament_entry.cost,
					"quantity" = armament_entry.max_purchase,
					"purchased" = purchased_items[armament_entry] ? purchased_items[armament_entry] : 0,
					"description" = armament_entry.description,
					"armament_category" = armament_entry.category,
					"equipment_subcategory" = armament_entry.subcategory,
				))
			if(!LAZYLEN(subcategory_items))
				continue
			armament_subcategories += list(list(
				"subcategory" = subcategory,
				"items" = subcategory_items,
			))
		if(!LAZYLEN(armament_subcategories))
			continue
		data["armaments_list"] += list(list(
			"category" = armament_category,
			"category_limit" = GLOB.armament_entries[armament_category][CATEGORY_LIMIT],
			"category_uses" = used_categories[armament_category],
			"subcategories" = armament_subcategories,
		))

	return data

/obj/machinery/armament_station/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("equip_item")
			var/datum/armament_entry/armament_entry
			for(var/category in GLOB.armament_entries)
				for(var/subcategory in GLOB.armament_entries[category][CATEGORY_ENTRY])
					armament_entry = locate(params["armament_ref"]) in GLOB.armament_entries[category][CATEGORY_ENTRY][subcategory]
					if(armament_entry)
						break
				if(armament_entry)
					break
			if(!armament_entry)
				return
			if(products && !(armament_entry.type in products))
				return
			select_armament(usr, armament_entry)
		if("eject_card")
			eject_card(usr)

/obj/machinery/armament_station/proc/eject_card(mob/user)
	if(!inserted_card)
		to_chat(user, span_warning("No card inserted!"))
		return
	inserted_card.forceMove(drop_location())
	user.put_in_hands(inserted_card)
	inserted_card = null
	to_chat(user, span_notice("Card ejected!"))
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 70)

/obj/machinery/armament_station/proc/select_armament(mob/user, datum/armament_entry/armament_entry)
	if(!inserted_card)
		to_chat(user, span_warning("No card inserted!"))
		return
	if(used_categories[armament_entry.category] >= GLOB.armament_entries[armament_entry.category][CATEGORY_LIMIT])
		to_chat(user, span_warning("Category limit reached!"))
		return
	if(purchased_items[armament_entry] >= armament_entry.max_purchase)
		to_chat(user, span_warning("Item limit reached!"))
		return
	if(!ishuman(user))
		return
	if(!inserted_card.use_points(armament_entry.cost))
		to_chat(user, span_warning("Not enough points!"))
		return

	var/mob/living/carbon/human/human_to_equip = user

	var/obj/item/new_item = new armament_entry.item_type(drop_location())

	used_categories[armament_entry.category]++
	purchased_items[armament_entry]++

	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)

	if(armament_entry.equip_to_human(human_to_equip, new_item))
		to_chat(user, span_notice("Equipped directly to your person."))
		playsound(src, 'sound/items/equip/toolbelt_equip.ogg', 100)
	armament_entry.after_equip(drop_location(), new_item)

/**
 * Armament points card
 *
 * To be used with the armaments vendor.
 */
/obj/item/armament_points_card
	name = "armament points card"
	desc = "A points card that can be used at an Armaments Station or Armaments Dealer."
	icon = 'modular_skyrat/modules/armaments/icons/armaments.dmi'
	icon_state = "armament_card"
	/// How many points does this card have to use at the vendor?
	var/points = 10

/obj/item/armament_points_card/Initialize(mapload)
	. = ..()
	maptext = span_maptext("<div align='center' valign='middle' style='position:relative'>[points]</div>")

/obj/item/armament_points_card/examine(mob/user)
	. = ..()
	. += span_notice("It has [points] points left.")

/obj/item/armament_points_card/proc/use_points(points_to_use)
	if(points_to_use > points)
		return FALSE

	points -= points_to_use

	update_maptext()

	return TRUE

/obj/item/armament_points_card/proc/update_maptext()
	maptext = span_maptext("<div align='center' valign='middle' style='position:relative'>[points]</div>")

/obj/item/armament_points_card/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/armament_points_card))
		var/obj/item/armament_points_card/attacking_card = attacking_item
		if(!attacking_card.points)
			to_chat(user, span_warning("No points left on [attacking_card]!"))
			return
		var/points_to_transfer = clamp(tgui_input_number(user, "How many points do you want to transfer?", "Transfer Points", 1, attacking_card.points, 1), 0, attacking_card.points)

		if(!points_to_transfer)
			return

		if(attacking_card.loc != user) // Preventing exploits.
			return

		if(attacking_card.use_points(points_to_transfer))
			points += points_to_transfer
			update_maptext()
			to_chat(user, span_notice("You transfer [points_to_transfer] onto [src]!"))
