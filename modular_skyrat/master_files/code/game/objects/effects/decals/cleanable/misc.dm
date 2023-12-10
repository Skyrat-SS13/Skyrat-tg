/obj/effect/decal/cleanable/NeverShouldHaveComeHere(turf/here_turf)
	return !(isclosedturf(here_turf) || isturf(here_turf, /turf/template_noop)) && ..()
