// Barrel but it works like a crate

/obj/structure/closet/crate/wooden/storage_barrel
	name = "storage barrel"
	desc = "This barrel can't hold liquids, it can just hold things inside of it however!"
	icon_state = "barrel"
	base_icon_state = "barrel"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/barrel.dmi'

// Wooden shelves but not var edited

/obj/structure/rack/shelf/wooden
	icon_state = "empty_shelf_1"
	icon = 'modular_skyrat/modules/mapping/icons/unique/furniture.dmi'

// Bonfires but with a grill pre-attached

/obj/structure/bonfire/grill_pre_attached

/obj/structure/bonfire/grill_pre_attached/Initialize(mapload)
	. = ..()

	grill = TRUE
	add_overlay("bonfire_grill")

// Dirt but icebox

/turf/open/misc/dirt/icemoon
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = "ICEMOON_ATMOS"

// The area

/area/ruin/unpowered/primitive_catgirl_den
	name = "\improper Icewalker Camp"
