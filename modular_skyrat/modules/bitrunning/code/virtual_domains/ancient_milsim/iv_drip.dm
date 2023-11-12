/obj/machinery/iv_drip/health_station
	name = "health station"
	desc = "A wall-mounted healing mixture dispenser designed for stationary first-aid application. Old Solarian tech that got silently deprecated \
		due to a massive healthcare privatization; still utilized by the CIN-backed states."
	icon = 'modular_skyrat/modules/bitrunning/icons/health_station.dmi'
	icon_state = "health_station"
	base_icon_state = "health_station"
	light_range = 2
	light_color = "#ad3e3e"
	anchored = TRUE
	inject_only = TRUE
	use_internal_storage = TRUE
	internal_list_reagents = list(
		/datum/reagent/medicine/salglu_solution = 125,
		/datum/reagent/iron = 125,
		/datum/reagent/medicine/coagulant = 125,
		/datum/reagent/medicine/sal_acid = 125,
		/datum/reagent/medicine/omnizine = 250,
		/datum/reagent/medicine/mine_salve = 250,
	)
	internal_volume_maximum = 1000

/obj/machinery/iv_drip/health_station/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/iv_drip/health_station, 32)
