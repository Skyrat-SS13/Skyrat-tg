// Solar panels

/obj/machinery/power/solar/deployable
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar

/obj/machinery/power/solar/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/power/solar/deployable/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/solar/deployable/deconstruct(disassembled = TRUE)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar panel deployable item

/obj/item/flatpacked_machine/solar
	name = "flat-packed solar panel"
	icon_state = "solar_panel_packed"
	type_to_deploy = /obj/machinery/power/solar/deployable
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3,
	)

// Solar trackers

/obj/machinery/power/tracker/deployable
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar_tracker

/obj/machinery/power/tracker/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/power/tracker/deployable/crowbar_act(mob/user, obj/item/item_acting)
	return

/obj/machinery/power/tracker/deployable/deconstruct(disassembled = TRUE)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar tracker deployable item

/obj/item/flatpacked_machine/solar_tracker
	name = "flat-packed solar tracker"
	icon_state = "solar_tracker_packed"
	type_to_deploy = /obj/machinery/power/tracker/deployable
	deploy_time = 3 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.5,
	)
