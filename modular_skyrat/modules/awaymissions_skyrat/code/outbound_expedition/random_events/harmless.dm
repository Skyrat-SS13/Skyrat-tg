/datum/outbound_random_event/harmless/nothing
	name = "Nothing"
	weight = 2

/datum/outbound_random_event/harmless/nothing/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 5 MINUTES) // RP time
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmless/nothing/proc/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo])

/datum/outbound_random_event/harmless/cargo
	name = "Cargo Beacon"
	weight = 2
	/// List of nearby space turfs to spawn the cargo on
	var/list/space_turfs = list()

/datum/outbound_random_event/harmless/cargo/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 2 MINUTES)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait_beacon])
	if(!length(space_turfs))
		var/obj/effect/landmark/center = locate(/obj/effect/landmark/ship_center) in GLOB.landmarks_list
		for(var/turf/open/space/space_tile in range(25, center))
			space_turfs += space_tile
	var/turf/chosen_turf = pick(space_turfs)
	var/obj/structure/closet/crate/secure/outbound_cargo/crate = new (chosen_turf)
	outbound_controller.deletion_stuff += crate

/datum/outbound_random_event/harmless/cargo/proc/clear_objective()
	OUTBOUND_CONTROLLER
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])

/datum/outbound_random_event/harmless/salvage
	name = "Drifting Salvage"
	weight = 1
