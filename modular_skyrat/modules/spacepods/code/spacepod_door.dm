/obj/structure/spacepoddoor
	name = "phase door"
	desc = "Opens and closes."
	icon = 'icons/effects/beam.dmi'
	icon_state = "n_beam"
	density = TRUE
	anchored = TRUE
	var/id = 1.0
	can_atmos_pass = ATMOS_PASS_NO

/obj/structure/spacepoddoor/Initialize()
	..()
	air_update_turf(1)
	isakula()

/obj/structure/spacepoddoor/Destroy()
	air_update_turf(1)
	return ..()

/obj/structure/spacepoddoor/CanPass(atom/movable/movable_atom, turf/our_turf)
	if(isspacepod(movable_atom))
		return TRUE
	return ..()
