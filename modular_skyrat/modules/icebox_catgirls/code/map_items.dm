// Barrel but it works like a crate

/obj/structure/closet/crate/wooden/storage_barrel
	name = "storage barrel"
	desc = "This barrel can't hold liquids, it can just hold things inside of it however!"
	icon_state = "barrel"
	icon = 'modular_skyrat/modules/icebox_catgirls/icons/barrel.dmi'

// Wooden shelves but not var edited

/obj/structure/rack/shelf/wooden
	icon_state = "empty_shelf_1"
	icon = 'modular_skyrat/modules/mapping/icons/unique/furniture.dmi'

// Benches but in a more wood color

/obj/structure/chair/sofa/bench/woodlike
	greyscale_colors = "#5d341f"

/obj/structure/chair/sofa/bench/woodlike/left
	icon_state = "bench_left"
	greyscale_config = /datum/greyscale_config/bench_left
	greyscale_colors = "#5d341f"

/obj/structure/chair/sofa/bench/woodlike/right
	icon_state = "bench_right"
	greyscale_config = /datum/greyscale_config/bench_right
	greyscale_colors = "#5d341f"

// Bonfires but with a grill pre-attached

/obj/structure/bonfire/oh_yeah_its_grilling_time

/obj/structure/bonfire/oh_yeah_its_grilling_time/Initialize(mapload)
	. = ..()

	grill = TRUE
	add_overlay("bonfire_grill")

// Dirt but icebox

/turf/open/misc/dirt/icemoon
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = "ICEMOON_ATMOS"

// The area

/area/ruin/unpowered/icebox_catgirl_den
	name = "\improper Icewalker Camp"
