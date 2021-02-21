/turf/open/floor/grass/cafe
	floor_tile = null
	baseturfs = /turf/open/floor/grass/cafe/dirt

/turf/open/floor/grass/cafe/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/grass/cafe/crowbar_act(mob/living/user, obj/item/I)
	return

/turf/open/floor/grass/cafe/dirt
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	baseturfs = /turf/open/floor/grass/cafe/dirt
