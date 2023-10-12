// Machine that makes water and nothing else

/obj/machinery/plumbing/synthesizer/water_synth
	name = "water synthesizer"
	desc = "An infinitely useful device for those finding themselves in a frontier without a stable source of water. \
		Using a simplified version of the chemistry dispenser's synthesizer process, it can create water out of nothing \
		but good old electricity."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "water_synth"
	anchored = FALSE
	dispensable_reagents = list(
		/datum/reagent/water,
	)

/obj/machinery/plumbing/synthesizer/water_synth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Deployable item for cargo for the water synth

/obj/item/flatpacked_machine/water_synth
	name = "water synthesizer parts kit"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "water_synth_parts"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/plumbing/synthesizer/water_synth
	deploy_time = 2 SECONDS
