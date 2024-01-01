/datum/supply_order/company_import
	/// The armament entry used to fill the supply order
	var/datum/armament_entry/company_import/selected_entry
	/// The component used to create the order
	var/datum/component/armament/company_imports/used_component

/datum/supply_order/company_import/Destroy(force, ...)
	selected_entry = null
	used_component = null
	. = ..()

/datum/supply_order/company_import/proc/reimburse_armament()
	if(!selected_entry || !used_component)
		return
	used_component.purchased_items[selected_entry]--

/// A proc to be overriden if you want custom code to happen when SSshuttle spawns the order
/datum/supply_order/proc/on_spawn()
	return

/datum/supply_order/generate(atom/A)
	. = ..()

	if(!.)
		return

	on_spawn()
