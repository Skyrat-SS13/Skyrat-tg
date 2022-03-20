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
	/// How many points we have left to spend
	var/points = 50
	/// Used to keep track of what categories have been used
	var/list/used_categories = list()
	/// Used to keep track of what items have been purchased
	var/list/purchased_items = list()
	/// If set, will limit this station to the products within this list.
	var/list/products

/obj/machinery/armament_station/test
	products = list(
		/datum/armament_entry/primary/assaultrifle/akm,
	)

/obj/machinery/armament_station/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ArmamentStation")
		ui.open()

// This data proc may look complex. That's because it is.
/obj/machinery/armament_station/ui_data(mob/user)
	var/list/data = list()

	data["remaining_points"] = points

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
				armament_entry = locate(params["armament_ref"]) in GLOB.armament_entries[category][CATEGORY_ENTRY]
				if(armament_entry)
					break
			if(products && !(armament_entry.type in products))
				return
			if(!armament_entry)
				return
			select_armament(usr, armament_entry)

/obj/machinery/armament_station/proc/select_armament(mob/user, datum/armament_entry/armament_entry)
	if(armament_entry.cost > points)
		to_chat(user, span_warning("Not enough points!"))
		return
	if(used_categories[armament_entry.category] >= GLOB.armament_entries[armament_entry.category][CATEGORY_LIMIT])
		to_chat(user, span_warning("Category limit reached!"))
		return
	if(purchased_items[armament_entry] >= armament_entry.max_purchase)
		to_chat(user, span_warning("Item limit reached!"))
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_to_equip = user

	var/obj/item/new_item = new armament_entry.item_type(drop_location())

	points -= armament_entry.cost
	used_categories[armament_entry.category]++
	purchased_items[armament_entry]++

	armament_entry.equip_to_human(human_to_equip, new_item)
