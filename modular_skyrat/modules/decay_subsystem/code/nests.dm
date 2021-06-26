/mob/living/simple_animal
	var/obj/structure/mob_spawner/spawner

/obj/structure/mob_spawner
	name = "nest"
	desc = "A nasty looking pile of sticks and debris."
	icon = 'modular_skyrat/modules/decay_subsystem/icons/nests.dmi'
	icon_state = "nest"
	density = FALSE
	anchored = TRUE
	layer = TABLE_LAYER
	max_integrity = 150
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	var/spawn_delay = 0
	var/list/var/monster_types = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab)
	var/max_mobs = 3
	var/list/faction = list("nest spawned")
	var/spawned_mobs = 0
	var/spawn_cooldown = 30 SECONDS
	var/regenerate_time = 10 MINUTES //How long it takes to regenerate mobs!
	var/list/registered_turfs = list()

/obj/structure/mob_spawner/swarmers
	name = "broken metal heap"
	desc = "A heap of broken metal... it's moving."
	icon_state = "nest_swarmer"
	light_color = LIGHT_COLOR_BLUE
	monster_types = list(/mob/living/simple_animal/hostile/swarmer/ai, /mob/living/simple_animal/hostile/swarmer/ai/resource, /mob/living/simple_animal/hostile/swarmer/ai/ranged_combat)

/obj/structure/mob_spawner/spiders
	name = "sticky cobwebs"
	desc = "A mush of sticky cobwebs and nasty looking eggs..."
	icon_state = "nest_spider"
	monster_types = list(/mob/living/simple_animal/hostile/giant_spider/hunter, /mob/living/simple_animal/hostile/giant_spider)

/obj/structure/mob_spawner/bush
	name = "bloody bush"
	desc = "A bush... oozing blood?"
	icon_state = "nest_grass"
	light_color = LIGHT_COLOR_GREEN
	monster_types = list(/mob/living/simple_animal/hostile/killertomato, /mob/living/simple_animal/hostile/venus_human_trap)

/obj/structure/mob_spawner/grapes
	name = "grapevine"
	desc = "A grapevine... with... eggs?"
	icon_state = "nest_grapes"
	light_color = LIGHT_COLOR_PURPLE
	monster_types = list(/mob/living/simple_animal/hostile/ooze/grapes)

/obj/structure/mob_spawner/grapes/Destroy()
	new /mob/living/simple_animal/hostile/vatbeast(src)
	. = ..()

/obj/structure/mob_spawner/Initialize()
	. = ..()
	for(var/turf/open/seen_turf in view(7, src))
		registered_turfs += seen_turf
		RegisterSignal(seen_turf, COMSIG_ATOM_ENTERED, .proc/proximity_trigger)

/obj/structure/mob_spawner/Destroy()
	for(var/t in registered_turfs)
		UnregisterSignal(t, COMSIG_ATOM_ENTERED)
	registered_turfs = null
	return ..()

/obj/structure/mob_spawner/proc/proximity_trigger(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(spawned_mobs >= max_mobs)
		return
	if(spawn_delay > world.time)
		return
	spawn_delay = world.time + spawn_cooldown

	if(!isliving(AM))
		return

	var/mob/living/entered_mob = AM

	if(entered_mob.faction in faction)
		return

	playsound(src, pick('modular_skyrat/master_files/sound/effects/rustle1.ogg', 'modular_skyrat/master_files/sound/effects/rustle2.ogg'))

	var/chosen_mob_type = pick(monster_types)
	var/mob/living/simple_animal/L = new chosen_mob_type(loc)
	L.flags_1 |= (flags_1 & ADMIN_SPAWNED_1)
	spawned_mobs++
	L.faction = faction

	visible_message(span_danger("[L] emerges from [src]."))

	addtimer(CALLBACK(src, .proc/regenerate_mobs), regenerate_time)

/obj/structure/mob_spawner/proc/regenerate_mobs()
	visible_message(span_danger("[src] contorts and wriggles!"))
	spawned_mobs = 0


