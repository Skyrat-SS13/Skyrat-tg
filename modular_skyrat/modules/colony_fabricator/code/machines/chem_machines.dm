/obj/machinery/plumbing/synthesizer/water_synth
	name = "water synthesizer"
	desc = "An infinitely useful device for those finding themselves in a frontier without a stable source of water. \
		Using a simplified version of the chemistry dispenser's synthesizer process, it can create water out of nothing \
		but good old electricity."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "water_synth"
	dispensable_reagents = list(
		/datum/reagent/water,
	)

/obj/machinery/plumbing/synthesizer/water_synth/hydroponics
	name = "hydroponics chemical synthesizer"
	desc = "An infinitely useful device for those finding themselves in a frontier without a stable source of nutrients for crops. \
		Using a simplified version of the chemistry dispenser's synthesizer process, it can create hydroponics nutrients out of nothing \
		but good old electricity."
	icon_state = "hydro_synth"
	dispensable_reagents = list(
		/datum/reagent/plantnutriment/eznutriment,
		/datum/reagent/plantnutriment/left4zednutriment,
		/datum/reagent/plantnutriment/robustharvestnutriment,
		/datum/reagent/plantnutriment/endurogrow,
		/datum/reagent/plantnutriment/liquidearthquake,
		/datum/reagent/toxin/plantbgone/weedkiller,
		/datum/reagent/toxin/pestkiller,
	)
