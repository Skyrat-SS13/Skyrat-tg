/datum/component/spawner
	var/mob_types = list(/mob/living/basic/carp)
	var/spawn_time = 300 //30 seconds default
	var/list/spawned_mobs = list()
	var/spawn_delay = 0
	var/max_mobs = 5
	var/spawn_text = "emerges from"
	var/list/faction = list("mining")

/datum/component/spawner/Initialize(mob_types = list(), spawn_time = 30 SECONDS, max_mobs = 5, faction = list(FACTION_MINING), spawn_text = "emerges from")
	if (!length(mob_types))
		CRASH("No types of mob to spawn specified for spawner component!")
	src.spawn_time = spawn_time
	src.mob_types = mob_types
	src.faction = faction
	src.spawn_text = spawn_text
	src.max_mobs = max_mobs

	RegisterSignal(parent, COMSIG_PARENT_QDELETING, PROC_REF(stop_spawning))
	START_PROCESSING(SSprocessing, src)

/datum/component/spawner/process()
	try_spawn_mob()


/datum/component/spawner/proc/stop_spawning(force)
	SIGNAL_HANDLER

	STOP_PROCESSING(SSprocessing, src)
	for(var/mob/living/simple_animal/L in spawned_mobs)
		if(L.nest == src)
			L.nest = null
	spawned_mobs = null

/datum/component/spawner/proc/try_spawn_mob()
	var/atom/P = parent
	if(spawned_mobs.len >= max_mobs)
		return
	if(spawn_delay > world.time)
		return
	spawn_delay = world.time + spawn_time
	var/chosen_mob_type = pick(mob_types)
	var/mob/living/simple_animal/L = new chosen_mob_type(P.loc)
	L.flags_1 |= (P.flags_1 & ADMIN_SPAWNED_1)
	spawned_mobs += L
	L.nest = src
	L.faction = src.faction
	P.visible_message(span_danger("[L] [spawn_text] [P]."))
