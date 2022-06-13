/obj/vehicle/ridden/atv/snowmobile
	name = "snowmobile"
	desc = "A tracked vehicle designed for use in the snow, it looks like it would have difficulty moving elsewhere, however."
	icon_state = "snowmobile"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'
	var/static/list/snow_typecache = typecacheof(list(/turf/open/misc/asteroid/snow/icemoon, /turf/open/floor/plating/snowed/smoothed/icemoon))

/obj/vehicle/ridden/atv/snowmobile/Moved()
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

/obj/vehicle/ridden/atv/snowmobile/snowcurity/proc/make_ridable()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/atv/snowmobile/snowcurity)


/obj/vehicle/ridden/atv/snowmobile/syndicate
	name = "snowmobile"
	desc = "A tracked vehicle designed for use in the snow, emblazened with Syndicate colors."
	icon_state = "syndimobile"
	icon = 'modular_skyrat/master_files/icons/obj/vehicles/vehicles.dmi'

