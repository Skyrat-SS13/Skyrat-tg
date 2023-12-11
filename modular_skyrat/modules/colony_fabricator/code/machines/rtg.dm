/obj/machinery/power/rtg/portable
	name = "radioisotope thermoelectric generator"
	desc = "The ultimate in 'middle of nowhere' power generation. Unlike standard RTGs, this particular \
		design of generator has forgone the heavy radiation shielding that most RTG designs include. \
		In better news, these tend to be pretty good with making a passable trickle of power for any \
		application."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	circuit = null
	obj_flags = CAN_BE_HIT | NO_DECONSTRUCTION
	power_gen = 7500
	/// What we turn into when we are repacked
	var/repacked_type = /obj/item/flatpacked_machine/rtg

/obj/machinery/power/rtg/portable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/radioactive)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	if(!mapload)
		flick("rtg_deploy", src)

// Item for creating the arc furnace or carrying it around

/obj/item/flatpacked_machine/rtg
	name = "flat-packed radioisotope thermoelectric generator"
	icon_state = "rtg_packed"
	type_to_deploy = /obj/machinery/power/rtg/portable
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
