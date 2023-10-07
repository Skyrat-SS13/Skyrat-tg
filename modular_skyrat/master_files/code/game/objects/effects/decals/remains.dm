/obj/effect/decal/remains/NeverShouldHaveComeHere(turf/here_turf)
	return !islava(here_turf) && !(istype(here_turf, /turf/open/water/beach/xen) || istype(here_turf, /turf/open/misc/beach/coastline_t) || istype(here_turf, /turf/open/water/xen_acid)) && ..()
