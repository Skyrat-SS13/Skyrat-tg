/obj/machinery/elevator_control_panel
	icon = 'modular_skyrat/modules/aesthetics/industrial_lift/icons/industrial_lift.dmi'
	icon_state = "elevatorpanel0"
	base_icon_state = "elevatorpanel"

/obj/machinery/elevator_control_panel/Initialize(mapload)
	. = ..()
	preset_destination_names += list("4" = "Lower Level","5" = "Tram Level")

/obj/machinery/elevator_control_panel/ui_data(mob/user)
	var/list/data = list()

	data["emergency_level"] = capitalize(SSsecurity_level.get_current_level_as_text())
	data["is_emergency"] = SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_RED || SSsecurity_level.get_current_level_as_number() == SEC_LEVEL_ORANGE
	data["doors_open"] = !!door_reset_timerid

	var/datum/lift_master/lift = lift_weakref?.resolve()
	if(lift)
		data["lift_exists"] = TRUE
		data["currently_moving"] = lift.controls_locked == LIFT_PLATFORM_LOCKED
		data["currently_moving_to_floor"] = last_move_target
		data["current_floor"] = (lift.lift_platforms[1].z + 2)

	else
		data["lift_exists"] = FALSE
		data["currently_moving"] = FALSE
		data["current_floor"] = 0 // 0 shows up as "Floor -1" in the UI, which is fine for what it is

	return data

/obj/machinery/elevator_control_panel/populate_destinations_list(datum/lift_master/linked_lift)
	// This list will track all the raw z-levels which we found that we can travel to
	var/list/raw_destinations = list()

	// Get a list of all the starting locs our elevator starts at
	var/list/starting_locs = list()
	for(var/obj/structure/industrial_lift/lift_piece as anything in linked_lift.lift_platforms)
		starting_locs |= lift_piece.locs
		// The raw destination list will start with all the z's we start at
		raw_destinations |= lift_piece.z

	// Get all destinations below us
	add_destinations_in_a_direction_recursively(starting_locs, DOWN, raw_destinations)
	// Get all destinations above us
	add_destinations_in_a_direction_recursively(starting_locs, UP, raw_destinations)

	linked_elevator_destination = list()
	for(var/z_level in raw_destinations)
		// Check if this z-level has a preset destination associated.
		var/preset_name = preset_destination_names?[num2text(z_level + 1)]
		// If we don't have a preset name, use Floor z-1 for the title.
		// z - 1 is used because the station z-level is 2, and goes up.
		linked_elevator_destination["[z_level]"] = preset_name || "Floor [z_level + 1]"

	// Reverse the destination list.
	// By this point the list will go from bottom floor to top floor,
	// which is unintuitive when passed to the UI to show to users.
	// This way we have the top floors at the top, and the bottom floors the bottom.
	reverse_range(linked_elevator_destination)
	update_static_data_for_all_viewers()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/elevator_control_panel, 30)
