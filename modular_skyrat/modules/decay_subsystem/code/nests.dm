#define NEST_FACTION "nest spawned"

/obj/structure/mob_spawner
	name = "nest"
	desc = "A nasty looking pile of sticks and debris."
	icon = 'modular_skyrat/modules/decay_subsystem/icons/nests.dmi'
	icon_state = "nest"
	density = FALSE
	anchored = TRUE
	layer = TABLE_LAYER
	max_integrity = 100
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	var/spawn_delay = 0
	/// What mob to spawn
	var/list/monster_types = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab)
	/// How many mobs can we spawn?
	var/max_mobs = 3
	var/list/faction = list(NEST_FACTION)
	var/spawned_mobs = 0
	/// How long it takes for a new mob to emerge after being triggered.
	var/spawn_cooldown = 30 SECONDS
	/// How long it takes to regenerate mobs to spawn again
	var/regenerate_time = 20 MINUTES
	var/retaliated = FALSE
	/// How long it takes for us to retaliate again.
	var/retaliate_cooldown = 20 SECONDS
	var/list/registered_turfs = list()
	/// What loot do we spawn upon death?
	var/list/loot = list()
	/// Do spawned mobs become ghost controllable?
	var/ghost_controllable = FALSE
	/// The range at which these are triggered.
	var/trigger_range = 5
	/// Does this nest passively spawn mobs too?
	var/passive_spawning = FALSE

/obj/structure/mob_spawner/Initialize(mapload)
	. = ..()
	calculate_trigger_turfs()
	if(passive_spawning)
		START_PROCESSING(SSobj, src)

/obj/structure/mob_spawner/proc/calculate_trigger_turfs()
	for(var/turf/open/seen_turf in view(trigger_range, src))
		registered_turfs += seen_turf
		RegisterSignal(seen_turf, COMSIG_ATOM_ENTERED, .proc/proximity_trigger)

/obj/structure/mob_spawner/atom_destruction(damage_flag)
	if(loot)
		for(var/path in loot)
			var/number = loot[path]
			if(!isnum(number))//Default to 1
				number = 1
			for(var/i in 1 to number)
				new path (loc)
	playsound(src, 'sound/effects/blobattack.ogg', 100)
	return ..()

/obj/structure/mob_spawner/Destroy()
	for(var/t in registered_turfs)
		UnregisterSignal(t, COMSIG_ATOM_ENTERED)
	registered_turfs = null
	if(passive_spawning)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/mob_spawner/process(delta_time)
	if(passive_spawning)
		if(spawned_mobs >= max_mobs)
			return
		if(spawn_delay > world.time)
			return
		spawn_delay = world.time + spawn_cooldown
		spawn_mob()

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

	if((NEST_FACTION in entered_mob.faction))
		return

	spawn_mob()

/obj/structure/mob_spawner/proc/spawn_mob()
	var/sound/sound_to_play = pick('modular_skyrat/master_files/sound/effects/rustle1.ogg', 'modular_skyrat/master_files/sound/effects/rustle2.ogg')
	playsound(src, sound_to_play, 100)
	do_squish(0.8, 1.2)

	spawned_mobs++

	var/chosen_mob_type = pick(monster_types)
	var/mob/living/spawned_mob = new chosen_mob_type(loc)

	spawned_mob.flags_1 |= (flags_1 & ADMIN_SPAWNED_1)
	spawned_mob.faction = faction
	spawned_mob.ghost_controllable = ghost_controllable

	RegisterSignal(spawned_mob, COMSIG_LIVING_DEATH, .proc/mob_death)

	visible_message(span_danger("[spawned_mob] emerges from [src]."))

/obj/structure/mob_spawner/proc/mob_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	spawned_mobs--
	UnregisterSignal(dead_guy, COMSIG_LIVING_DEATH)

/obj/structure/mob_spawner/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	do_jiggle()
	if(!retaliated)
		visible_message(span_danger("[src] grubbles angrily!"))
		var/chosen_mob_type = pick(monster_types)
		var/mob/living/simple_animal/L = new chosen_mob_type(loc)
		visible_message(span_danger("[L] emerges from [src]."))
		retaliated = TRUE
		addtimer(CALLBACK(src, .proc/ready_retaliate), retaliate_cooldown)

/obj/structure/mob_spawner/proc/ready_retaliate()
	retaliated = FALSE
	visible_message(span_danger("[src] calms down."))

/*
*	CUSTOM SPAWNERS
*/

/obj/structure/mob_spawner/spiders
	name = "sticky cobwebs"
	desc = "A mush of sticky cobwebs and nasty looking eggs..."
	icon_state = "nest_spider"
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	monster_types = list(/mob/living/simple_animal/hostile/giant_spider/hunter, /mob/living/simple_animal/hostile/giant_spider)
	loot = list(/obj/item/spider_egg = 4)

/obj/item/spider_egg
	name = "spider egg"
	desc = "A white egg with something crawling around inside. Looks... fragile."
	icon = 'modular_skyrat/modules/decay_subsystem/icons/loot.dmi'
	icon_state = "spider_egg"

/obj/item/spider_egg/attack_self(mob/user, modifiers)
	. = ..()
	to_chat(user, span_danger("You begin to crack open [src]..."))
	if(do_after(user, 3 SECONDS, src))
		to_chat(user, span_userdanger("You crack [src] open, something monsterous crawls out!"))
		playsound(src, 'sound/effects/blobattack.ogg', 100)
		new /mob/living/simple_animal/hostile/giant_spider (user.loc)
		qdel(src)

/obj/structure/mob_spawner/bush
	name = "bloody bush"
	desc = "A bush... oozing blood?"
	icon_state = "nest_grass"
	light_color = LIGHT_COLOR_GREEN
	monster_types = list(/mob/living/simple_animal/hostile/killertomato)
	loot = list(/obj/item/seeds/random = 3)
	max_mobs = 6

/obj/structure/mob_spawner/beehive
	name = "beehive"
	desc = "Filled with little beings that exist only to make your life a living hell."
	icon_state = "nest_bee"
	light_color = LIGHT_COLOR_YELLOW
	monster_types = list(/mob/living/simple_animal/hostile/bee)
	max_mobs = 15
	spawn_cooldown = 5 SECONDS
	loot = list(/obj/item/reagent_containers/honeycomb = 5, /obj/item/queen_bee)
	var/swarmed = FALSE

/obj/structure/mob_spawner/beehive/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(!swarmed)
		playsound(src, 'sound/creatures/bee.ogg', 100)
		visible_message(span_userdanger("[src] buzzes violently as bees pour out!"))
		for(var/i=1, i<max_mobs, ++i)
			new /mob/living/simple_animal/hostile/bee (loc)
		swarmed = TRUE

/obj/structure/mob_spawner/beehive/toxic
	name = "oozing beehive"
	desc = "A beehive... it looks off however, it's oozing some kind of green glowing goop."
	icon_state = "nest_bee_toxic"
	monster_types = list(/mob/living/simple_animal/hostile/bee/toxin)
	max_mobs = 6
	color = LIGHT_COLOR_ELECTRIC_GREEN

/obj/structure/mob_spawner/snake
	name = "disgusting eggs"
	desc = "These pulsating eggs are oozing out a puss like substance..."
	icon_state = "nest_eggs"
	light_color = LIGHT_COLOR_YELLOW
	monster_types = list(/mob/living/simple_animal/hostile/retaliate/snake)
	max_mobs = 8
	spawn_cooldown = 5 SECONDS

/obj/structure/mob_spawner/rats
	name = "nasty nest"
	desc = "A nest crawling with... something!"
	icon_state = "nest_rats"
	light_color = LIGHT_COLOR_GREEN
	max_mobs = 8
	spawn_cooldown = 15 SECONDS
	monster_types = list(/mob/living/basic/mouse/rat)
	loot = list(/obj/item/seeds/replicapod = 2)

/obj/structure/mob_spawner/grapes
	name = "grapevine"
	desc = "A grapevine... with... eggs?"
	icon_state = "nest_grapes"
	light_color = LIGHT_COLOR_PURPLE
	monster_types = list(/mob/living/simple_animal/hostile/ooze/grapes)
	loot = list(/obj/item/resurrection_crystal)

/obj/structure/mob_spawner/grapes/atom_destruction(damage_flag)
	if(loot)
		for(var/path in loot)
			var/number = loot[path]
			if(!isnum(number))//Default to 1
				number = 1
			for(var/i in 1 to number)
				new path (loc)
	playsound(src, 'sound/effects/blobattack.ogg', 100)
	new /mob/living/simple_animal/hostile/vatbeast(loc)
	return ..()


