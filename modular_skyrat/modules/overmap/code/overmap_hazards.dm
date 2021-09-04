#define SHUTTLE_VELOCITY_METEORS_DIRECTIONAL_THRESHOLD 0.5
#define ASTEROID_AND_DUST_PADDING 60

/datum/overmap_object/hazard
	name = "badly coded hazard"
	visual_type = /obj/effect/abstract/overmap/hazard
	overmap_flags = NONE
	/// Seperate tracker of whether we are processing or not. Used because we unregister us from processing when its not nessecary
	var/is_processing = FALSE
	/// Lazy list of all affected shuttles, guaranteed to be /datum/overmap_object/shuttle
	var/list/affected_shuttles
	/// Color of our hazard object. Just so I dont have to make special code for the visuals too
	var/hazard_color = COLOR_PINK

/datum/overmap_object/hazard/proc/get_random_icon_state()
	return "event"

/datum/overmap_object/hazard/New()
	. = ..()
	my_visual.icon_state = get_random_icon_state()
	my_visual.color = hazard_color

/datum/overmap_object/hazard/Destroy()
	if(affected_shuttles)
		for(var/i in affected_shuttles)
			RemoveAffected(i)
	return ..()

/datum/overmap_object/hazard/proc/AddAffected(datum/overmap_object/shuttle/affected)
	LAZYINITLIST(affected_shuttles)
	affected_shuttles[affected] = TRUE
	if(!is_processing)
		SSovermap.AddObjToProcess(src)
		is_processing = TRUE

/datum/overmap_object/hazard/proc/RemoveAffected(datum/overmap_object/shuttle/affected)
	affected_shuttles -= affected
	if(!length(affected_shuttles))
		SSovermap.RemoveObjFromProcess(src)
		is_processing = FALSE
		LAZYNULL(affected_shuttles)

/datum/overmap_object/hazard/Entered(datum/overmap_object/entering, spawned = FALSE)
	if(istype(entering,/datum/overmap_object/shuttle))
		AddAffected(entering)
	. = ..()

/datum/overmap_object/hazard/Exited(datum/overmap_object/exiting, deleted = FALSE)
	if(affected_shuttles && affected_shuttles[exiting])
		RemoveAffected(exiting)
	. = ..()

/obj/effect/abstract/overmap/hazard
	icon_state = "event"
	layer = OVERMAP_LAYER_HAZARD

/obj/effect/abstract/overmap/hazard/opaque
	icon_state = "event"
	layer = OVERMAP_LAYER_HAZARD
	opacity = TRUE

/datum/overmap_object/hazard/asteroid
	name = "asteroid field"
	hazard_color = COLOR_RED
	visual_type = /obj/effect/abstract/overmap/hazard/opaque

/datum/overmap_object/hazard/asteroid/process(delta_time)
	for(var/i in affected_shuttles)
		var/datum/overmap_object/shuttle/shuttle = i
		var/shuttle_velocity = VECTOR_LENGTH(shuttle.velocity_x, shuttle.velocity_y)
		var/try_directional = FALSE
		if(shuttle_velocity > SHUTTLE_VELOCITY_METEORS_DIRECTIONAL_THRESHOLD)
			try_directional = TRUE
		var/probability = 3
		switch(shuttle_velocity)
			if(0.5 to 1)
				probability += 4
			if(1 to 2)
				probability += 6
			if(2 to 3)
				probability += 11
			if(3 to INFINITY)
				probability += 20
		if(prob(probability))
			var/obj/effect/meteor/picked_meteor_type = pickweight(GLOB.meteors_threatening)
			if(shuttle.GetShieldPercent())
				var/shield_damage = initial(picked_meteor_type.shield_damage)
				var/remaining_damage = shuttle.AbsorbShield(shield_damage)
				switch(shield_damage)
					if(5 to 8)
						shuttle.DoShieldImpactEffect('sound/effects/explosion_distant.ogg', 50, 3, 1)
					if(9 to 14)
						shuttle.DoShieldImpactEffect(pick('sound/effects/explosioncreak1.ogg', 'sound/effects/explosioncreak2.ogg'), 30, 3, 2)
					if(15 to INFINITY)
						shuttle.DoShieldImpactEffect(pick('sound/effects/explosioncreak1.ogg', 'sound/effects/explosioncreak2.ogg'), 50, 5, 2)
				if(!remaining_damage)
					continue
			var/dir
			if(try_directional)
				dir = shuttle.current_parallax_dir
			else
				dir = pick(GLOB.cardinals)
			if(shuttle.transit_instance)
				var/turf/pickedstart = shuttle.transit_instance.GetActionSideTurf(dir)
				var/turf/pickedgoal = shuttle.transit_instance.GetActionSideTurf(REVERSE_DIR(dir))
				new picked_meteor_type(pickedstart, pickedgoal)
			else if(length(shuttle.related_levels))
				var/datum/space_level/hit_level = pick(shuttle.related_levels)
				spawn_meteor(picked_meteor_type, dir, hit_level.z_value, ASTEROID_AND_DUST_PADDING)

/datum/overmap_object/hazard/asteroid/get_random_icon_state()
	return pick(list("meteor1", "meteor2", "meteor3", "meteor4"))

/datum/overmap_object/hazard/dust
	name = "space dust"
	hazard_color = COLOR_FLOORTILE_GRAY
	visual_type = /obj/effect/abstract/overmap/hazard/opaque

/datum/overmap_object/hazard/dust/process(delta_time)
	for(var/i in affected_shuttles)
		var/datum/overmap_object/shuttle/shuttle = i
		var/shuttle_velocity = VECTOR_LENGTH(shuttle.velocity_x, shuttle.velocity_y)
		var/try_directional = FALSE
		if(shuttle_velocity > SHUTTLE_VELOCITY_METEORS_DIRECTIONAL_THRESHOLD)
			try_directional = TRUE
		var/probability = 1
		switch(shuttle_velocity)
			if(0.25 to 0.5)
				probability += 4
			if(0.5 to 1)
				probability += 7
			if(1 to 2)
				probability += 10
			if(2 to 3)
				probability += 15
			if(3 to INFINITY)
				probability += 25
		if(prob(probability))
			var/obj/effect/meteor/picked_meteor_type = pickweight(GLOB.meteorsC)
			if(shuttle.GetShieldPercent())
				var/shield_damage = initial(picked_meteor_type.shield_damage)
				var/remaining_damage = shuttle.AbsorbShield(shield_damage)
				shuttle.DoShieldImpactEffect('sound/effects/explosion_distant.ogg', 30, 0, 0)
				if(!remaining_damage)
					continue
			var/dir
			if(try_directional)
				dir = shuttle.current_parallax_dir
			else
				dir = pick(GLOB.cardinals)
			if(shuttle.transit_instance)
				var/turf/pickedstart = shuttle.transit_instance.GetActionSideTurf(dir)
				var/turf/pickedgoal = shuttle.transit_instance.GetActionSideTurf(REVERSE_DIR(dir))
				new picked_meteor_type(pickedstart, pickedgoal)
			else if(length(shuttle.related_levels))
				var/datum/space_level/hit_level = pick(shuttle.related_levels)
				spawn_meteor(picked_meteor_type, dir, hit_level.z_value, ASTEROID_AND_DUST_PADDING)

/datum/overmap_object/hazard/dust/get_random_icon_state()
	return pick(list("dust1", "dust2", "dust3", "dust4"))

/datum/overmap_object/hazard/electrical_storm
	name = "electrical storm"
	hazard_color = COLOR_YELLOW

#define ELECTRICAL_STORM_ACT_PROB 6
#define ELECTRICAL_STORM_SHIELD_DAMAGE 10
#define ELECTRICAL_STORM_SEARCH_MARGIN 70
#define ELECTRICAL_STORM_LIGHTS_OUT_RANGE 25
#define ELECTRICAL_STORM_LIGHTS_OUT_RANGE_SHUTTLE 10

/datum/overmap_object/hazard/electrical_storm/process(delta_time)
	for(var/i in affected_shuttles)
		var/datum/overmap_object/shuttle/shuttle = i
		if(prob(ELECTRICAL_STORM_ACT_PROB))
			shuttle.DoShieldImpactEffect(pick('sound/magic/lightningshock.ogg','sound/magic/lightningbolt.ogg'), 10, 2, 1)
			if(shuttle.GetShieldPercent())
				var/remaining_damage = shuttle.AbsorbShield(ELECTRICAL_STORM_SHIELD_DAMAGE)
				if(!remaining_damage)
					return
			//Do effect here
			if(shuttle.transit_instance)
				var/turf/pickedturf = shuttle.transit_instance.GetActionSideTurf(middle = TRUE)
				if(prob(50))
					for(var/a in GLOB.apcs_list) //Yes very inefficient
						var/obj/machinery/power/apc/A = a
						if(get_dist(pickedturf, A) <= ELECTRICAL_STORM_LIGHTS_OUT_RANGE_SHUTTLE)
							A.overload_lighting()
				else
					//EMP
					empulse(pickedturf, 2, 6)
			else if(length(shuttle.related_levels))
				var/datum/space_level/picked_level = pick(shuttle.related_levels)
				var/turf/epicentre_turf = GetRandomTurfInZLevelWithMargin(ELECTRICAL_STORM_SEARCH_MARGIN, picked_level)
				if(prob(50))
					//Light discharge
					for(var/a in GLOB.apcs_list) //Yes very inefficient
						var/obj/machinery/power/apc/A = a
						if(get_dist(epicentre_turf, A) <= ELECTRICAL_STORM_LIGHTS_OUT_RANGE)
							A.overload_lighting()
				else
					//EMP
					empulse(epicentre_turf, 4, 10)
			//TODO: ADD HANDLING FOR SHUTTLES!!

#undef ELECTRICAL_STORM_SEARCH_MARGIN
#undef ELECTRICAL_STORM_SHIELD_DAMAGE
#undef ELECTRICAL_STORM_ACT_PROB
#undef ELECTRICAL_STORM_LIGHTS_OUT_RANGE
#undef ELECTRICAL_STORM_LIGHTS_OUT_RANGE_SHUTTLE

/datum/overmap_object/hazard/electrical_storm/get_random_icon_state()
	return pick(list("electrical1", "electrical2", "electrical3", "electrical4"))

/datum/overmap_object/hazard/ion_storm
	name = "ion storm"
	hazard_color = LIGHT_COLOR_ELECTRIC_CYAN

#define ION_STORM_SHIELD_DRAIN_PER_PROCESS 0.75

//Ion storms currently just drain shields, sluurp
/datum/overmap_object/hazard/ion_storm/process(delta_time)
	for(var/i in affected_shuttles)
		var/datum/overmap_object/shuttle/shuttle = i
		shuttle.AbsorbShield(ION_STORM_SHIELD_DRAIN_PER_PROCESS)

#undef ION_STORM_SHIELD_DRAIN_PER_PROCESS

/datum/overmap_object/hazard/ion_storm/get_random_icon_state()
	return pick(list("ion1", "ion2", "ion3", "ion4"))

/datum/overmap_object/hazard/carp_school
	name = "carp school"
	hazard_color = LIGHT_COLOR_PURPLE

/datum/overmap_object/hazard/carp_school/process(delta_time)
	for(var/i in affected_shuttles)
		var/datum/overmap_object/shuttle/shuttle = i
		var/has_shields = shuttle.GetShieldPercent()
		var/probability = has_shields ? 2 : 5
		var/shuttle_velocity = VECTOR_LENGTH(shuttle.velocity_x, shuttle.velocity_y)
		if(!has_shields && shuttle.transit_instance)
			probability += shuttle_velocity * 5
		if(prob(probability))
			var/carp_type = prob(95) ? /mob/living/simple_animal/hostile/carp : /mob/living/simple_animal/hostile/carp/megacarp
			if(shuttle.transit_instance)
				var/set_dir
				if(shuttle_velocity > 0.5)
					set_dir = shuttle.current_parallax_dir
				new carp_type(shuttle.transit_instance.GetActionSideTurf(set_dir))
			else if(length(shuttle.related_levels))
				var/datum/space_level/spawn_level = pick(shuttle.related_levels)
				var/carp_spawn_list = GetLandmarksInZLevel(/obj/effect/landmark/carpspawn, spawn_level)
				if(!length(carp_spawn_list))
					continue
				var/obj/effect/landmark/picked_spot = pick(carp_spawn_list)
				new carp_type(picked_spot.loc)
			//TODO: SHUTTLE HANDLING

/datum/overmap_object/hazard/carp_school/get_random_icon_state()
	return pick(list("carp1", "carp2", "carp3", "carp4"))

#undef SHUTTLE_VELOCITY_METEORS_DIRECTIONAL_THRESHOLD
#undef ASTEROID_AND_DUST_PADDING
