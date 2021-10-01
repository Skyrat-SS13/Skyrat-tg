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
	var/list/var/monster_types = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab)
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

///////////// CUSTOM SPAWNERS

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
	monster_types = list(/mob/living/simple_animal/hostile/rat)
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


