#define SPAWN_ALWAYS 100
#define SPAWN_LIKELY 85
#define SPAWN_UNLIKELY 35
#define SPAWN_RARE 10

<<<<<<< HEAD
/datum/modular_mob_segment
	/// Spawn no more than this amount
	var/max = 4
	/// Set this to false if you want explicitly what's in the list to spawn
	var/exact = FALSE
	/// The list of mobs to spawn
	var/list/mob/living/mobs = list()
	/// The mobs spawned from this segment
	var/list/spawned_mob_refs = list()
	/// Chance this will spawn (1 - 100)
	var/probability = SPAWN_LIKELY

=======

/// Handles spawning mobs for this landmark. Sends a signal when done.
/obj/effect/landmark/bitrunning/mob_segment/proc/spawn_mobs(turf/origin, datum/modular_mob_segment/segment)
	var/list/mob/living/spawned_mobs = list()

	spawned_mobs += segment.spawn_mobs(origin)

	SEND_SIGNAL(src, COMSIG_BITRUNNING_MOB_SEGMENT_SPAWNED, spawned_mobs)

	var/list/datum/weakref/mob_refs = list()
	for(var/mob/living/spawned as anything in spawned_mobs)
		if(QDELETED(spawned))
			continue

		mob_refs += WEAKREF(spawned)

	return mob_refs


/**
 * A list for mob spawning landmarks to use.
 */
/datum/modular_mob_segment
	/// Set this to false if you want explicitly what's in the list to spawn
	var/exact = FALSE
	/// The list of mobs to spawn
	var/list/mobs = list()
	/// Spawn no more than this amount
	var/max = 4
	/// Chance this will spawn (1 - 100)
	var/probability = SPAWN_LIKELY


>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/// Spawns mobs in a circle around the location
/datum/modular_mob_segment/proc/spawn_mobs(turf/origin)
	if(!prob(probability))
		return

<<<<<<< HEAD
	var/total_amount = exact ? rand(1, max) : length(mobs)

	shuffle_inplace(mobs)


=======
	var/list/mob/living/spawned_mobs = list()

	var/total_amount = exact ? length(mobs) : rand(1, max)

	shuffle_inplace(mobs)

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	var/list/turf/nearby = list()
	for(var/turf/tile as anything in RANGE_TURFS(2, origin))
		if(!tile.is_blocked_turf())
			nearby += tile

	if(!length(nearby))
		stack_trace("Couldn't find any valid turfs to spawn on")
		return

	for(var/index in 1 to total_amount)
		// For each of those, we need to find an open space
		var/turf/destination = pick(nearby)

		var/path // Either a random mob or the next mob in the list
		if(exact)
			path = mobs[index]
		else
			path = pick(mobs)

		var/mob/living/mob = new path(destination)
		nearby -= destination
<<<<<<< HEAD
		spawned_mob_refs.Add(WEAKREF(mob))
=======
		spawned_mobs += mob

	return spawned_mobs

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3

// Some generic mob segments. If you want to add generic ones for any map, add them here

/datum/modular_mob_segment/gondolas
	mobs = list(
		/mob/living/basic/pet/gondola,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/corgis
	max = 2
	mobs = list(
		/mob/living/basic/pet/dog/corgi,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/monkeys
	mobs = list(
		/mob/living/carbon/human/species/monkey,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/syndicate_team
	mobs = list(
		/mob/living/basic/trooper/syndicate/ranged,
		/mob/living/basic/trooper/syndicate/melee,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/abductor_agents
	mobs = list(
		/mob/living/basic/trooper/abductor/melee,
		/mob/living/basic/trooper/abductor/ranged,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/syndicate_elite
	mobs = list(
		/mob/living/basic/trooper/syndicate/melee/sword/space/stormtrooper,
		/mob/living/basic/trooper/syndicate/ranged/space/stormtrooper,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/bears
	max = 2
	mobs = list(
		/mob/living/basic/bear,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/bees
	exact = TRUE
	mobs = list(
		/mob/living/basic/bee,
		/mob/living/basic/bee,
		/mob/living/basic/bee,
		/mob/living/basic/bee,
		/mob/living/basic/bee/queen,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/bees_toxic
	mobs = list(
		/mob/living/basic/bee/toxin,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/blob_spores
	mobs = list(
		/mob/living/basic/blob_minion,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/carps
	mobs = list(
		/mob/living/basic/carp,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/hivebots
	mobs = list(
		/mob/living/basic/hivebot,
		/mob/living/basic/hivebot/range,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/hivebots_strong
	mobs = list(
		/mob/living/basic/hivebot/strong,
		/mob/living/basic/hivebot/range,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/lavaland_assorted
	mobs = list(
		/mob/living/basic/mining/basilisk,
		/mob/living/basic/mining/goliath,
		/mob/living/basic/mining/brimdemon,
		/mob/living/basic/mining/lobstrosity,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/spiders
	mobs = list(
		/mob/living/basic/spider/giant/ambush,
		/mob/living/basic/spider/giant/hunter,
		/mob/living/basic/spider/giant/nurse,
		/mob/living/basic/spider/giant/tarantula,
		/mob/living/basic/spider/giant/midwife,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/venus_trap
	mobs = list(
		/mob/living/basic/venus_human_trap,
	)

<<<<<<< HEAD
=======

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/modular_mob_segment/xenos
	mobs = list(
		/mob/living/basic/alien,
		/mob/living/basic/alien/sentinel,
		/mob/living/basic/alien/drone,
	)

<<<<<<< HEAD
=======

/datum/modular_mob_segment/deer
	max = 1
	mobs = list(
		/mob/living/basic/deer,
	)


/datum/modular_mob_segment/revolutionary
	mobs = list(
		/mob/living/basic/revolutionary,
	)


>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
#undef SPAWN_ALWAYS
#undef SPAWN_LIKELY
#undef SPAWN_UNLIKELY
#undef SPAWN_RARE
