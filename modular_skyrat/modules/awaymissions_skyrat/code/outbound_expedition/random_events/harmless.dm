/datum/outbound_random_event/harmless/nothing
	name = "Nothing"
	weight = 1

/datum/outbound_random_event/harmless/nothing/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, PROC_REF(clear_objective)), 4 MINUTES) // RP time
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmless/nothing/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo])

/datum/outbound_random_event/harmless/cargo
	name = "Cargo Beacon"
	weight = 1
	printout_title = "sensor readout"
	printout_strings = list(
		"Sensors have detected a cargo pod nearby the corvette.",
		"Ship has been slowed down to allow for EVA to retrieve the materials if desired.",
		"Retrieval not mandatory.",
	)
	/// List of nearby space turfs to spawn the cargo on
	var/list/space_turfs = list()

/datum/outbound_random_event/harmless/cargo/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, PROC_REF(radio_message)), 1.5 MINUTES)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait_beacon])
	var/area/space_area = GLOB.areas_by_type[/area/space/outbound_space]
	if(!length(space_turfs))
		for(var/turf/open/space/space_tile in space_area.contents)
			space_turfs += space_tile
	var/turf/chosen_turf = pick(space_turfs)
	new /obj/structure/closet/crate/secure/loot/outbound_cargo(chosen_turf)

/datum/outbound_random_event/harmless/cargo/proc/radio_message()
	OUTBOUND_CONTROLLER
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])

/datum/outbound_random_event/harmless/cargo/on_radio()
	OUTBOUND_CONTROLLER
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo/supply])
	outbound_controller.current_event = null

/datum/outbound_random_event/harmless/cargo/clear_objective()
	OUTBOUND_CONTROLLER
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])
