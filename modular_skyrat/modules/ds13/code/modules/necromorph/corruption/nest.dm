/*
	A nest node acts as an additional spawnpoint for necromorphs, allowing new ones to be created around it rather than at the marker.

	Secondarily, with an additional biomass investment, it becomes a miniature factory, growing new necromorphs that can be spawned and posessed on demand

	It is very precious and should be well protected
*/
/obj/structure/corruption_node/nest
	name = "nest"
	desc = "A wretched hive."
	icon_state = "nest"
	icon = 'icons/effects/corruption64.dmi'
	density = TRUE //Chunky
	pixel_x = -16
	pixel_y = -16

	biomass = 25
	reclamation_time = 10 MINUTES

	default_scale = 1.4
	max_health = 200	//Takes a while to kill
	resistance = 8

	var/datum/species/necromorph/spawner_species
	var/list/spawned_creatures
	var/spawns_ready
	var/max_spawns = 1

	//If we're currently growing a new necromorph, when did we start?
	var/growth_started = 0
	//When will/did current/last growth finish?
	var/growth_end = 0

	var/upgrade_level = 1

	var/list/upgrade_multipliers = list(1, 0.9, 0.75)
	var/growth_timer_handle

	can_block_movement = TRUE

/obj/structure/corruption_node/nest/Initialize()
	//Add ourselves as a possible spawnpoint for the marker
	.=..()
	if (!dummy)
		if (SSnecromorph.marker)
			SSnecromorph.marker.add_spawnpoint(src)

		set_light(1, 1, 7, 2, COLOR_NECRO_YELLOW)



/obj/structure/corruption_node/nest/Destroy()

	if (!dummy)
		if (SSnecromorph.marker)
			SSnecromorph.marker.remove_spawnpoint(src)
	.=..()


/obj/structure/corruption_node/nest/proc/increase_upgrade_level()
	if (upgrade_level >= upgrade_multipliers.len)
		return 	//Already max level

	var/upgrade_cost = spawner_species.biomass*upgrade_multipliers[upgrade_level+1]
	if (!SSnecromorph.marker.pay_biomass("Nest upgrade [x],[y],[z]", upgrade_cost))
		return FALSE
	biomass += upgrade_cost
	upgrade_level++
	max_spawns++
	recalculate_growth()
	return TRUE

/obj/structure/corruption_node/nest/verb/upgrade_spawner(var/mob/user)
	set name = "Upgrade Spawner"
	set desc = "Allows turning a nest into a spawner"
	set category = null
	set src in view()
	if (!istype(user))
		user = usr
		if (!istype(user))
			return

	if (!is_marker_master(user))
		to_chat(user, "Only the marker may do this.")
		return

	if (spawner_species)

		if (upgrade_level < upgrade_multipliers.len)
			var/upgrade_cost = spawner_species.biomass*upgrade_multipliers[upgrade_level+1]
			var/response = alert(user, "This nest is already spawning [spawner_species.name_plural]. You may upgrade it for an additional cost of [upgrade_cost] biomass.\n\
			\n\
			Biomass Investment: 		[biomass]	->	[biomass+upgrade_cost]\n\
			Max Ready/Active Spawns: 	[max_spawns]	->	[max_spawns+1]\n\
			Spawn Growth Time: 		[time2text(spawner_species.biomass_reclamation_time*upgrade_multipliers[upgrade_level], "mm:ss")]	->	[time2text(spawner_species.biomass_reclamation_time*upgrade_multipliers[upgrade_level+1], "mm:ss")]",
			"Spawning confirmation","Upgrade","Cancel")

			if (response == "Upgrade")
				if (!increase_upgrade_level())
					to_chat(user, SPAN_WARNING("Oh no, you don't have enough biomass for the upgrade!"))
		else
			to_chat(user, SPAN_NOTICE("This nest is fully upgraded!"))
		return

	var/list/spawn_possibilities = list()
	//Right lets get the list of possible species it could be upgraded to
	for (var/species_name in GLOB.all_necromorph_species)
		var/datum/species/necromorph/N = GLOB.all_necromorph_species[species_name]
		if (N.spawner_spawnable)
			spawn_possibilities["[N.name]    [N.biomass]"] = N

	var/choice = input(user, "You can upgrade this nest to automatically respawn a specified necromorph unit.\n\
	 This will cost the same biomass as that necromorph would normally cost to spawn, and once the creature dies, it will take the same time to grow another as that creature would normally take to be reabsorbed\n\
	  You will get the biomass back if the nest is destroyed\n\
	  \n\
	  Signal players can click the nest to spawn the creature when it is available.", "Spawner Upgrade Menu") as null|anything in spawn_possibilities

	if (!choice)
		return

	var/datum/species/necromorph/N = spawn_possibilities[choice]
	if (!istype(N))
		return
	//Right, lets deduct the biomass cost
	if (!SSnecromorph.marker.pay_biomass("Nest upgrade [x],[y],[z]", N.biomass * upgrade_multipliers[upgrade_level]))
		to_chat(user, SPAN_WARNING("Oh no, you don't have enough biomass for the upgrade!"))
		return

	if (set_spawn_species(N))
		to_chat(user, "This nest will now create [spawner_species.name_plural]")

/obj/structure/corruption_node/nest/proc/set_spawn_species(var/datum/species/necromorph/N)
	spawner_species = N
	biomass = initial(biomass) + N.biomass * upgrade_multipliers[upgrade_level]
	finish_growth()	//Immediately make the first one available to spawn


//Called when nest is updated while growing a necromorph
/obj/structure/corruption_node/nest/proc/recalculate_growth()
	if (total_spawns() >= max_spawns)
		return

	if (!growth_started)//No current growth
		start_growth()	//We have enough free spawns to start a new growth
		return

	//If we get here, there was already a growth ongoing
	deltimer(growth_timer_handle)
	growth_end = growth_started + spawner_species.biomass_reclamation_time * upgrade_multipliers[upgrade_level]
	if (world.time >= growth_end)	//We were reduced to an instant finish
		finish_growth()
		return
	growth_timer_handle = addtimer(CALLBACK(src, /obj/structure/corruption_node/nest/proc/finish_growth), growth_end - world.time, TIMER_STOPPABLE)


/obj/structure/corruption_node/nest/proc/start_growth()
	if (total_spawns() >= max_spawns)
		return

	//Don't restart growing if we're already doing one
	if (growth_started)
		return

	deltimer(growth_timer_handle)
	growth_started = world.time
	growth_end = world.time + spawner_species.biomass_reclamation_time * upgrade_multipliers[upgrade_level]
	growth_timer_handle = addtimer(CALLBACK(src, /obj/structure/corruption_node/nest/proc/finish_growth), spawner_species.biomass_reclamation_time, TIMER_STOPPABLE)

/obj/structure/corruption_node/nest/proc/finish_growth()
	growth_started = FALSE	//This indicates we're not currently growing anything

	if (total_spawns() >= max_spawns)
		return	//This should never happen
	deltimer(growth_timer_handle)
	spawns_ready += 1
	growth_end = world.time


	var/message = "There "
	if (spawns_ready == 1)
		message += "is a [spawner_species.name]"
	else
		message += "are [spawns_ready] [spawner_species.name_plural]"
	message += " ready to spawn at LINK"

	link_necromorphs_to(message, src)

	//Immediately attempt to start growing another, if possible
	start_growth()

/obj/structure/corruption_node/nest/proc/total_spawns()
	.=spawns_ready
	for (var/a in spawned_creatures)
		var/mob/living/L = a
		if (QDELETED(L) || L.stat == DEAD)
			GLOB.death_event.unregister(L, src, /obj/structure/corruption_node/nest/proc/start_growth)
			GLOB.destroyed_event.unregister(L, src, /obj/structure/corruption_node/nest/proc/start_growth)
			spawned_creatures -= L
			continue

		.++


/obj/structure/corruption_node/nest/get_blurb()
	. = "The nest node is vital for a forward base, as it provides an additional spawnpoint, allowing the marker to create new necromorphs at its location, thus cutting down travel times. <br>\
	In addition, the nest can be upgraded with a Spawner, allowing it to automatically generate low-tier necromorphs for signal posession"

/obj/structure/corruption_node/nest/examine(var/mob/user)
	.=..()
	if (user.is_necromorph() && spawner_species)
		user << "This nest is configured to spawn [spawner_species.name_plural]"
		if (spawns_ready)
			user << SPAN_NOTICE("There are [spawns_ready] [spawner_species.name_plural] ready to spawn!")
		if (world.time < growth_end)
			user << "The next spawn will be ready in [time2text(growth_end - world.time, "mm:ss")]"
		else
			user << "It has reached its limit and is not currently growing anything"

/obj/structure/corruption_node/nest/proc/spawn_creature()
	if (spawns_ready <= 0)
		return null
	spawns_ready--
	var/mob/living/L = new spawner_species.mob_type(loc)
	GLOB.death_event.register(L, src, /obj/structure/corruption_node/nest/proc/start_growth)
	GLOB.destroyed_event.register(L, src, /obj/structure/corruption_node/nest/proc/start_growth)
	L.biomass = 0	//This won't give anything when slain
	return L

/obj/structure/corruption_node/nest/attack_signal(var/mob/observer/eye/signal/user)
	if (is_marker_master(user))
		upgrade_spawner(user)
	else
		if (spawns_ready)
			var/response = alert(user, "[spawner_species.name_plural]: [spawns_ready]\n Would you like to spawn and take control of a [spawner_species.name] ?","Spawning confirmation","Yes","No")
			if (response == "Yes")
				//This could take an indeterminate amount of time, do more safety checks when we get response
				if (QDELETED(user))
					return
				if (spawns_ready)
					var/mob/living/L = spawn_creature()
					if (L)
						user.necro_possess(L)
				else
					to_chat(user, SPAN_DANGER("There are no spawns left. Someone must have beat you to it!"))
		else
			examine(user)