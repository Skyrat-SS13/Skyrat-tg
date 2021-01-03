/turf/open/floor/plating/cobblestone
	name = "cobblestone"
	desc = "Stone cobbles set into the ground."
	icon = 'modular_skyrat/icons/turf/floors/planetfloor.dmi'
	icon_state = "cobblestone1"
	baseturfs = /turf/open/floor/plating/smooth/dirt
	attachment_holes = FALSE

// Although our baseturf is something that will never go to space...//
/turf/open/floor/plating/cobblestone/burn_tile()
	return
/turf/open/floor/plating/cobblestone/break_tile()
	return
/turf/open/floor/plating/cobblestone/ReplaceWithLattice()
	return
//... we don't want icon changes once bombed to invalid icon-states!//

/turf/open/floor/plating/cobblestone/snow
	name = "snowy cobblestone"
	desc = "Snnnooooowwwww! Snowy cobblestone."
	icon_state = "cobblestone_snow"

/turf/open/floor/plating/cobblestone/Initialize()
	.=..()
	icon_state = "cobblestone[rand(1, 4)]"

/turf/open/floor/plating/cobblestone/snow/Initialize()
	.=..()
	icon_state = "cobblestone_snow[rand(1, 4)]"
