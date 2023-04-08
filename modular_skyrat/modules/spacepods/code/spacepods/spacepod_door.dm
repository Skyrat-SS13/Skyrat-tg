/obj/structure/spacepoddoor
	name = "phase door"
	desc = "Only allows spacepods through."
	icon = 'icons/effects/beam.dmi'
	icon_state = "n_beam"
	density = TRUE
	anchored = TRUE
	can_atmos_pass = ATMOS_PASS_NO

/obj/structure/spacepoddoor/Initialize()
	. = ..()
	air_update_turf(TRUE)

/obj/structure/spacepoddoor/Destroy()
	air_update_turf(TRUE)
	return ..()

/obj/structure/spacepoddoor/CanPass(atom/movable/movable_atom, turf/our_turf)
	if(isspacepod(movable_atom))
		return TRUE
	return ..()
