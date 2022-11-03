/datum/supply_order/company_import
	/// The armament entry used to fill the supply order
	var/datum/armament_entry/company_import/selected_entry
	/// The component used to create the order
	var/datum/component/armament/company_imports/used_component
	/// How much it'll add to a company's interest on-buy
	var/interest_addition
	/// If the order has multiple items in it, how many? Is null by default, set only if there's more than one item.
	var/item_amount

/datum/supply_order/company_import/Destroy(force, ...)
	selected_entry = null
	used_component = null
	. = ..()

/datum/supply_order/company_import/proc/reimburse_armament()
	if(!selected_entry || !used_component)
		return
	used_component.purchased_items[selected_entry]--
	selected_entry.stock++

/// A proc to be overriden if you want custom code to happen when SSshuttle spawns the order
/datum/supply_order/proc/on_spawn()
	return

/datum/supply_order/company_import/on_spawn()
	for(var/company in SScargo_companies.companies)
		var/datum/cargo_company/comp_datum = SScargo_companies.companies[company]
		if(comp_datum.company_flag == selected_entry?.company_bitflag)
			comp_datum.interest += interest_addition
			break
