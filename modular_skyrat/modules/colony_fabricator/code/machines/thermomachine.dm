/obj/machinery/atmospherics/components/unary/thermomachine/deployable
	icon = 'modular_skyrat/modules/colony_fabricator/icons/thermomachine.dmi'
	name = "atmospheric temperature regulator"
	desc = "A much more tame variant of the thermomachines commonly seen in station scale temperature control devices. \
		Its upper and lower bounds for temperature are highly limited, though it has a higher than standard heat capacity \
		and the benefit of being undeployable when you're done with it."
	circuit = null
	flags_1 = NODECONSTRUCT_1
	greyscale_config = /datum/greyscale_config/thermomachine/deployable
	min_temperature = T0C
	max_temperature = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD + 50
	heat_capacity = 10000
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/thermomachine

/obj/machinery/atmospherics/components/unary/thermomachine/deployable/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 2 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_KZ_FRONTIER)

/obj/machinery/atmospherics/components/unary/thermomachine/deployable/RefreshParts()
	. = ..()
	heat_capacity = 10000
	min_temperature = T0C
	max_temperature = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD + 50

// Item for creating the regulator and carrying it about

/obj/item/flatpacked_machine/thermomachine
	name = "flat-packed atmospheric temperature regulator"
	icon_state = "thermomachine_packed"
	type_to_deploy = /obj/machinery/atmospherics/components/unary/thermomachine/deployable
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)

// Greyscale config for the light on this machine

/datum/greyscale_config/thermomachine/deployable
	name = "Deployable Thermomachine"
	icon_file = 'modular_skyrat/modules/colony_fabricator/icons/thermomachine.dmi'
