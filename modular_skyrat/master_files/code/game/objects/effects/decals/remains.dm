/obj/effect/decal/remains/NeverShouldHaveComeHere(turf/here_turf)
	return !islava(here_turf) && !(istype(turf, /turf/open/water/beach/xen) || istype(turf, /turf/open/misc/beach/coastline_t) || istype(turf, /turf/open/water/xen_acid)) && ..()
