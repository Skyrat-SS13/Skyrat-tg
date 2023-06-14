/obj/vehicle/ridden/atv/snowmobile
	name = "snowmobile"
	desc = "A tracked vehicle designed for use in the snow, it looks like it would have difficulty moving elsewhere, however."
	icon_state = "snowmobile"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'
	var/static/list/snow_typecache = typecacheof(list(/turf/open/misc/asteroid/snow/icemoon, /turf/open/floor/plating/snowed/smoothed/icemoon))

/obj/vehicle/ridden/atv/snowmobile/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if (QDELETED(src))
		return
	var/datum/component/riding/riding_component = LoadComponent(/datum/component/riding)
	if(snow_typecache[loc.type])
		riding_component.vehicle_move_delay = 1
	else
		riding_component.vehicle_move_delay = 2

/obj/vehicle/ridden/atv/snowmobile/snowcurity
	name = "security snowmobile"
	desc = "For when you want to look like even more of a tool than riding a secway."
	icon_state = "snowcurity"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'
	key_type = /obj/item/key/security

/datum/component/riding/vehicle/atv/snowmobile/snowcurity
	keytype = /obj/item/key/security

// This should eventually be fixed upstream by adding make_ridable to the base ATV definition
// or, ideally, to /obj/vehicle/ridden so that it's not duplicated all over the codebase
// for wheelchairs, scooters, and snowmobiles alike.
/obj/vehicle/ridden/atv/snowmobile/snowcurity/Initialize()
	. = ..()
	// We shouldn't have the ridable component added while still in Initialize,
	// so this is hopefully safe to do.
	RemoveElement(/datum/element/ridable)
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv/snowmobile/snowcurity)


/obj/vehicle/ridden/atv/snowmobile/syndicate
	name = "snowmobile"
	desc = "A tracked vehicle designed for use in the snow, emblazened with Syndicate colors."
	icon_state = "syndimobile"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'

