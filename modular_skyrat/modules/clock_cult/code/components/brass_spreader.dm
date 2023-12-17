/// A component that spreads brass to a tile in [range] every [cooldown] seconds, converting everything on it into brass as well.
/datum/component/brass_spreader
	/// The range of which to spread brass
	var/range = 5
	/// The cooldown between spread attempts
	var/cooldown = 5 SECONDS

	COOLDOWN_DECLARE(turf_conversion_cooldown)


/datum/component/brass_spreader/Initialize(range, cooldown)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	START_PROCESSING(SSobj, src)

	src.range = range
	src.cooldown = cooldown


/datum/component/brass_spreader/Destroy(force, silent)
	STOP_PROCESSING(SSobj, src)
	return ..()


/datum/component/brass_spreader/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, turf_conversion_cooldown))
		return

	var/list/valid_turfs = list()
	var/list/cult_turfs = list()

	for(var/nearby_turf in circle_view_turfs(parent, range))
		if(istype(nearby_turf, /turf/open/floor/bronze))
			cult_turfs += nearby_turf
			continue

		var/static/list/blacklisted_spread_turfs = typecacheof(list(
			/turf/open/floor/bronze,
			/turf/open/space,
			/turf/open/lava,
			/turf/open/chasm,
			/turf/open/misc/asteroid,
		))

		if(is_type_in_typecache(nearby_turf, blacklisted_spread_turfs))
			continue

		valid_turfs += nearby_turf

	if(length(valid_turfs))
		var/turf/converted_turf = pick(valid_turfs)

		if(isplatingturf(converted_turf))
			converted_turf.place_on_top(/turf/open/floor/bronze, flags = CHANGETURF_INHERIT_AIR)
			new /obj/effect/temp_visual/ratvar/floor(converted_turf)

		else if(isopenturf(converted_turf))
			converted_turf.ChangeTurf(/turf/open/floor/bronze, flags = CHANGETURF_INHERIT_AIR)
			new /obj/effect/temp_visual/ratvar/floor(converted_turf)

		else
			converted_turf.ChangeTurf(/turf/closed/wall/mineral/bronze)
			new /obj/effect/temp_visual/ratvar/wall(converted_turf)

		for(var/obj/object in converted_turf.contents)
			if(istype(object, /obj/structure/window))
				new /obj/structure/window/bronze/fulltile(object.loc)
				new /obj/effect/temp_visual/ratvar/window(object.loc)
				new /obj/effect/temp_visual/ratvar/beam(object.loc)
				qdel(object)

			else if(istype(object, /obj/machinery/door/airlock/glass))
				new /obj/machinery/door/airlock/bronze/clock/glass(object.loc)
				new /obj/effect/temp_visual/ratvar/door(object.loc)
				new /obj/effect/temp_visual/ratvar/beam(object.loc)
				qdel(object)

			else if(istype(object, /obj/machinery/door/airlock))
				new /obj/machinery/door/airlock/bronze/clock(object.loc)
				new /obj/effect/temp_visual/ratvar/door(object.loc)
				new /obj/effect/temp_visual/ratvar/beam(object.loc)
				qdel(object)

			else if(istype(object, /obj/structure/table))
				new /obj/structure/table/bronze(object.loc)
				new /obj/effect/temp_visual/ratvar/beam(object.loc)
				qdel(object)


	else if (length(cult_turfs))
		var/turf/open/floor/bronze/cult_turf = pick(cult_turfs)
		new /obj/effect/temp_visual/ratvar/floor(cult_turf)

	else
		// Are we in space or something? No cult turfs or convertable turfs? Double the cooldown
		COOLDOWN_START(src, turf_conversion_cooldown, cooldown * 2)
		return

	COOLDOWN_START(src, turf_conversion_cooldown, cooldown)
