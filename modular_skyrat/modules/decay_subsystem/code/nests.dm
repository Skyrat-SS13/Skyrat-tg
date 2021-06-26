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
	/// What mob to spawn
	var/list/var/monster_types = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab)
	/// How many mobs can we spawn?
	var/max_mobs = 2
	var/list/faction = list("nest spawned")
	var/spawned_mobs = 0
	/// How long it takes for a new mob to emerge after being triggered.
	var/spawn_cooldown = 30 SECONDS
	/// How long it takes to regenerate mobs to spawn again
	var/regenerate_time = 15 MINUTES
	var/retaliated = FALSE
	/// How long it takes for us to retaliate again.
	var/retaliate_cooldown = 15 SECONDS
	var/list/registered_turfs = list()
	/// What loot do we spawn upon death?
	var/list/loot = list()

/obj/structure/mob_spawner/Initialize()
	. = ..()
	for(var/turf/open/seen_turf in view(7, src))
		registered_turfs += seen_turf
		RegisterSignal(seen_turf, COMSIG_ATOM_ENTERED, .proc/proximity_trigger)

/obj/structure/mob_spawner/Destroy()
	for(var/loot_item in loot)
		new loot_item (loc)
	playsound(src, 'sound/effects/blobattack.ogg', 100)
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

	var/sound/sound_to_play = pick('modular_skyrat/master_files/sound/effects/rustle1.ogg', 'modular_skyrat/master_files/sound/effects/rustle2.ogg')

	playsound(src, sound_to_play, 100)

	do_squish(0.8, 1.2)

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

///////////// CUSTOM SPAWNERS
/obj/structure/mob_spawner/swarmers
	name = "broken metal heap"
	desc = "A heap of broken metal... it's moving."
	icon_state = "nest_swarmer"
	light_color = LIGHT_COLOR_BLUE
	monster_types = list(/mob/living/simple_animal/hostile/swarmer/ai/resource)

/obj/structure/mob_spawner/spiders
	name = "sticky cobwebs"
	desc = "A mush of sticky cobwebs and nasty looking eggs..."
	icon_state = "nest_spider"
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	monster_types = list(/mob/living/simple_animal/hostile/giant_spider/hunter, /mob/living/simple_animal/hostile/giant_spider)

/obj/structure/mob_spawner/bush
	name = "bloody bush"
	desc = "A bush... oozing blood?"
	icon_state = "nest_grass"
	light_color = LIGHT_COLOR_GREEN
	monster_types = list(/mob/living/simple_animal/hostile/killertomato)

/mob/living/simple_animal/hostile/bee/wasp
	name = "wasp"
	desc = "Little bastard!"
	maxHealth = 20
	health = 20

/obj/structure/mob_spawner/waspnest
	name = "wasp nest"
	desc = "Filled with little beings that exist only to make your life a living hell."
	icon_state = "nest_wasp"
	light_color = LIGHT_COLOR_YELLOW
	monster_types = list(/mob/living/simple_animal/hostile/bee/wasp)
	max_mobs = 10
	spawn_cooldown = 2 SECONDS

	var/swarmed = FALSE

/obj/structure/mob_spawner/waspnest/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(!swarmed)
		playsound(src, 'sound/creatures/bee.ogg', 100)
		visible_message(span_userdanger("[src] buzzes violently as bees pour out!"))
		for(var/i=1, i<max_mobs, ++i)
			new /mob/living/simple_animal/hostile/bee (loc)
		swarmed = TRUE

/obj/structure/mob_spawner/headcrab
	name = "disgusting eggs"
	desc = "These pulsating eggs are oozing out a puss like substance..."
	icon_state = "nest_eggs"
	light_color = LIGHT_COLOR_YELLOW
	monster_types = list(/mob/living/simple_animal/hostile/headcrab)
	max_mobs = 6
	spawn_cooldown = 5 SECONDS

/obj/structure/mob_spawner/rats
	name = "nasty nest"
	desc = "A nest crawling with... something!"
	icon_state = "nest_rats"
	light_color = LIGHT_COLOR_GREEN
	max_mobs = 8
	spawn_cooldown = 2 SECONDS
	monster_types = list(/mob/living/simple_animal/hostile/rat)

/obj/structure/mob_spawner/grapes
	name = "grapevine"
	desc = "A grapevine... with... eggs?"
	icon_state = "nest_grapes"
	light_color = LIGHT_COLOR_PURPLE
	monster_types = list(/mob/living/simple_animal/hostile/ooze/grapes)

/obj/structure/mob_spawner/grapes/Destroy()
	new /mob/living/simple_animal/hostile/vatbeast(loc)
	return ..()



