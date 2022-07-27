/area/space/outbound_no_leave
	icon_state = "away"

/area/space/outbound_no_leave/Enter(O, oldloc)
	if(isobserver(O))
		. = ..()

/area/awaymission/outbound_expedition
	name = "Outbound Expediton"

/area/awaymission/outbound_expedition/dock
	name = "Vanguard Dock"
	requires_power = FALSE

/area/awaymission/outbound_expedition/dock/elevator
	name = "Vanguard Dock Elevator"

/area/awaymission/outbound_expedition/dock/elevator/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	OUTBOUND_CONTROLLER
	if(!ismob(arrived) || !outbound_controller)
		return

	if(outbound_controller.elevator_time == initial(outbound_controller.elevator_time))
		addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/tick_elevator_time), 1 SECONDS)
		if(!length(outbound_controller.elevator_doors))
			var/area/dock_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/dock/team_addition]
			for(var/obj/machinery/door/poddoor/shutters/indestructible/shutter in dock_area)
				outbound_controller.elevator_doors += shutter

	var/mob/arrived_mob = arrived
	arrived_mob?.hud_used?.away_dialogue.set_text("Waiting... ([round(outbound_controller.elevator_time / 10)] seconds remaining)")

/area/awaymission/outbound_expedition/dock/team_addition

/area/awaymission/outbound_expedition/dock/team_addition/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	OUTBOUND_CONTROLLER
	if(!isliving(arrived) || !outbound_controller)
		return

	var/mob/living/living_mob = arrived
	outbound_controller.participating_mobs |= arrived
	outbound_controller.give_objective(living_mob, outbound_controller.objectives[/datum/outbound_objective/talk_person])
	if(!HAS_TRAIT(living_mob, TRAIT_DNR))
		ADD_TRAIT(living_mob, TRAIT_DNR, src) // leaving for now, might remove idk

/area/awaymission/outbound_expedition/shuttle
	name = "Vanguard Shuttle"
	icon_state = "awaycontent2"
