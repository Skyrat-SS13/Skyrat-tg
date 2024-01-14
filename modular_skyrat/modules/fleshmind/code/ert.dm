/**
 * post_setup()
 *
 * A proc that can be used to handle after spawn functions of ERT.
 */
/datum/ert/proc/post_setup(datum/team/incoming_team)
	return FALSE


/datum/ert/odst/fleshmind
	rename_team = "end-game ODST"
	polldesc = "the last defense of centcom"


/datum/ert/odst/fleshmind/post_setup(datum/team/incoming_team)
	var/list/valid_turfs = list()
	var/list/possible_spawn_areas = typecacheof(typesof(/area/shuttle/escape))

	var/obj/structure/mold/resin/test/test_resin = new()

	for(var/area/iterating_area in GLOB.areas)
		if(!is_type_in_typecache(iterating_area, possible_spawn_areas))
			continue
		for(var/turf/open/floor in iterating_area)
			if(!floor.Enter(test_resin))
				continue
			valid_turfs += floor

	qdel(test_resin)

	shuffle(valid_turfs)

	for(var/datum/mind/iterating_mind as anything in incoming_team.members)
		var/mob/living/living_mob = iterating_mind.current
		if(!living_mob)
			continue
		podspawn(list(
			"target" = pick_n_take(valid_turfs),
			"style" = STYLE_CENTCOM,
			"spawn" = living_mob,
		))
		to_chat(living_mob, span_redtext("The drop pod thrusters fire up, you're being deployed to the station!"))
