/obj/vehicle/ridden/train
	name = "train engine"
	desc = "Don't get stuck between two walls."
	icon = 'modular_skyrat/modules/more_vehicles/icons/vehicles.dmi'
	icon_state = "cart_engine"
	layer = ABOVE_MOB_LAYER
	base_pixel_x = -8
	pixel_x = -8
	var/mutable_appearance/wheels_overlay

/obj/vehicle/ridden/train/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/train)
	wheels_overlay = mutable_appearance(icon, "cart_wheels", ABOVE_MOB_LAYER)
	update_appearance()

/obj/vehicle/ridden/train/update_overlays()
	. = ..()
	. += wheels_overlay

/datum/component/riding/vehicle/train
	vehicle_move_delay = 1
	ride_check_flags = RIDER_NEEDS_LEGS | RIDER_NEEDS_ARMS

/datum/component/riding/vehicle/train/handle_specials()
	. = ..()
	set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(-10, 5), TEXT_WEST = list( 10, 5)))
	set_vehicle_dir_offsets(NORTH, -8, -0)
	set_vehicle_dir_offsets(SOUTH, -8, -0)
	set_vehicle_dir_offsets(EAST, -8, 0)
	set_vehicle_dir_offsets(WEST, -8, 0)
