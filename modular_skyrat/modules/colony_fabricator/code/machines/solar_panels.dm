// Solar panels

/obj/machinery/power/solar/quickdeploy
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar

/obj/machinery/power/solar/quickdeploy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)

/obj/machinery/power/solar/quickdeploy/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/solar/quickdeploy/deconstruct(disassembled = TRUE)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar panel deployable item

/obj/item/flatpacked_machine/solar
	name = "\improper flatpacked solar panel"
	desc = "The whole of a solar panel, panel included. This one's frame is built different \
		to standard panels in order to allow a relatively compact stowage form factor."
	icon_state = "solar_panel_packed"
	type_to_deploy = /obj/machinery/power/solar/quickdeploy
	deploy_time = 2 SECONDS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.75, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3)

// Solar trackers

/obj/machinery/power/tracker/quickdeploy
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar_tracker

/obj/machinery/power/tracker/quickdeploy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 1 SECONDS)

/obj/machinery/power/tracker/quickdeploy/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/tracker/quickdeploy/deconstruct(disassembled = TRUE)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar tracker deployable item

/obj/item/flatpacked_machine/solar_tracker
	name = "\improper flatpacked solar tracker"
	desc = "The whole of a solar tracker, panel included. This one's frame is built different \
		to standard panels in order to allow a relatively compact stowage form factor."
	icon_state = "solar_tracker_packed"
	type_to_deploy = /obj/machinery/power/tracker/quickdeploy
