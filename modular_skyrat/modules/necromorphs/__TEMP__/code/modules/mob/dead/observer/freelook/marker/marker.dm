
/*
	The marker is the heart of the necromorph army
*/
/obj/machinery/marker
	name = "Marker"
	icon = 'icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_dormant"
	pixel_x = -33
	density = TRUE
	anchored = TRUE
	var/light_colour = COLOR_MARKER_RED
	var/player	//Ckey of the player controlling the marker
	var/mob/dead/observer/eye/signal/master/playermob	//Signal mob of the player controlling the marker
	var/corruption_plant
	var/last_throb = 0

	//Biomass handling
	//--------------------------
	biomass	= 200//Current actual quantity of biomass we have stored. Start with enough to spawn a small expeditionary force
	var/biomass_tick = 0	//Current amount of mass we're gaining each second. This shouldn't be edited as it is regularly recalculated
	var/list/biomass_sources = list()	//A list of various sources (mostly necromorph corpses) from which we are gradually gaining biomass. These are finite

	var/datum/necroshop/shop
	var/active = FALSE //Marker must activate first

	//How much biomass do we have invested in necros/nodes, or currently being recovered?
	//NONSENSICAL_VALUE is a magical value that means this needs to be updated
	var/unavailable_biomass = NONSENSICAL_VALUE

	//These two are subcomponents of unavailable biomass, cached seperately for performance reasons
	var/invested_biomass = NONSENSICAL_VALUE
	var/reclaiming_biomass = NONSENSICAL_VALUE

	//Necrovision
	visualnet_range = 12

/obj/machinery/marker/New(var/atom/location, var/direction, var/nocircuit = FALSE)
	SSnecromorph.marker = src	//Populate the global var with ourselves
	..()



/**

	Method which allows the marker to become player controlled, and which starts its corruption spread.

*/

/obj/machinery/marker/proc/make_active()
	if (active)
		return
	active = TRUE
	SSnecromorph.marker_activated_at = world.time

	//Any shards in the world become active
	for (var/obj/item/marker_shard/MS in SSnecromorph.shards)
		MS.activate()

	SSnecromorph.update_all_ability_lists(FALSE)	//Unlock new spells for signals

	visible_message(SPAN_WARNING("[src] starts to pulsate in a strange way..."))
	//Start spreading corruption
	start_corruption()
	update_icon()
	set_traumatic_sight(TRUE, 5) //Marker is pretty hard to look at.

	//If the marker is activated manually, tell the gamemode to activate itself too.
	//This is a circular process, activate_marker will call this proc, hence the check for active at the start
	var/datum/game_mode/marker/GM = SSticker.mode
	if (GM && !GM.marker_active)
		GM.activate_marker()

/obj/machinery/marker/Initialize()
	.=..()
	shop = new(src)//Create necroshop datum
	GLOB.necrovision.add_source(src)	//Add it as the first source for necrovision
	add_biomass_source(null, 0, 1, /datum/biomass_source/baseline)	//Add the baseline income

	//Lets create a proximity tracker to detect corpses being dragged into our vicinity
	var/datum/proximity_trigger/view/PT = new (holder = src, on_turf_entered = /obj/machinery/marker/proc/nearby_movement, range = 10)
	PT.register_turfs()
	set_extension(src, /datum/extension/proximity_manager, PT)

	if (CONFIG_GET(flag/marker_auto_activate))
		spawn(100)
			make_active()

/obj/machinery/marker/proc/open_shop(var/mob/user)
	shop.ui_interact(user)

/*

/obj/machinery/marker/attack_hand(var/mob/user)//Temporary
	open_shop(user)

/obj/machinery/marker/attack_ghost(var/mob/user)//Temporary
	open_shop(user)
*/

/obj/machinery/marker/update_icon()
	if (player && active)
		icon_state = "marker_giant_active_anim"
		set_light(1, 1, 12, 2, light_colour)
	else
		icon_state = "marker_giant_dormant"
		set_light(0)

//Each process tick, we'll loop through all biomass sources and absorb their income
/obj/machinery/marker/Process()
	handle_biomass_tick()
	throb()

/obj/machinery/marker/is_necromorph()
	return TRUE

/obj/machinery/marker/verb/shop_verb()
	set name = "Spawning Menu"
	set src in view()
	set category = null

	open_shop(usr)

// Below is a check for intermittent "throbbing". If the check passes with all the conditions, it throbs. Please don't kill me. - Lion

/obj/machinery/marker/proc/throb()
	if (player && active)
		if(world.time - last_throb > 3 MINUTES && prob(30))
			last_throb = world.time
			playsound(src.loc, 'sound/effects/markerthrob.ogg', 25, 0)
			visible_message("<span class='critical'>The marker is audibly throbbing!</span><br><br><span class='minorwarning'>It fills you with fear and paranoia...</span>", "<span class='critical'>The marker is audibly throbbing!</span></large><br><br><span class='minorwarning'>It fills you with fear and paranoia...</span>", 20)


//Biomass handling
//---------------------------------
//Rather than calculating and adding mass now, this proc calculates the mass to be added NEXT tick	(and also adds whatever we calculated last tick)
//This allows us to display an accurate preview of mass income in player-facing UIs
/obj/machinery/marker/proc/handle_biomass_tick()
	biomass += biomass_tick //Add the biomass we calculated last tick
	biomass_tick = 0	//Reset this before we recalculate it

	var/update_reclaiming = FALSE //Set true if a source which counts towards total changes its biomass
	for (var/datum/biomass_source/S as anything in biomass_sources)

		var/check = S.can_absorb()
		if (check != MASS_READY)
			if (check == MASS_PAUSE)
				continue	//ITs paused, just keep going

			if (check == MASS_EXHAUST)
				S.mass_exhausted()	//It ran out, trigger a proc before we delete the source
			biomass_sources.Remove(S)
			qdel(S)
			continue

		//If we got here, it's ready.
		var/quantity = S.absorb()
		S.last_absorb = quantity
		biomass_tick += quantity

		//We will need to update total biomass
		if (S.counts_toward_total)
			update_reclaiming = TRUE

	//We will actually add this biomass next tick

	//Flag total for update
	if (update_reclaiming)
		reclaiming_biomass = NONSENSICAL_VALUE
		unavailable_biomass = NONSENSICAL_VALUE

/obj/machinery/marker/proc/add_biomass_source(var/datum/source = null, var/total_mass = 0, var/duration = 1 SECOND, var/sourcetype = /datum/biomass_source)
	//Adds a new biomass source, can specify type

	//First create it
	var/datum/biomass_source/BS = new sourcetype(source, src, total_mass, duration)

	//Don't add it if its a duplicate
	if (BS.is_duplicate(biomass_sources))
		qdel(BS)
		return
	biomass_sources.Add(BS)
	return BS	//Return the source

/obj/machinery/marker/proc/remove_biomass_source(var/datum/biomass_source/source = null)
	biomass_sources.Remove(source)
	source.target = null //Its no longer attached to us
	if (!QDELETED(source))
		qdel(source)

/obj/machinery/marker/proc/become_master_signal(var/mob/M)
	if(!active)
		return
	if (!M || !M.key)
		return
	if (player != ckey(M.key))
		message_necromorphs(SPAN_NOTICE("[M.key] has taken charge of the marker."))

	player = ckey(M.key)

	//Get rid of the old energy handler
	var/datum/player/P = get_or_create_player(M.key)
	remove_extension(P, /datum/extension/psi_energy/signal)

	var/mob/dead/observer/eye/signal/master/S = new(M)

	playermob = S
	if (!isliving(M))
		qdel(M)
	update_icon()
	S.client?.init_verbs()
	//GLOB.unitologists.add_antagonist(playermob.mind)
	return S


/obj/machinery/marker/proc/vacate_master_signal()
	if (playermob)

		//Get rid of the old player's energy handler
		if (player)
			var/datum/player/P = get_or_create_player(player)
			if (P)
				remove_extension(P, /datum/extension/psi_energy/marker)//Remove the handler

		message_necromorphs(SPAN_NOTICE("[player] has stepped down, nobody is controlling the marker now."))
		var/mob/dead/observer/eye/signal/S = new(playermob)
		//GLOB.unitologists.remove_antagonist(playermob.mind)
		player = null
		QDEL_NULL(playermob)
		update_icon()
		return S
	else
		//Just vacate the player slot so someone else can join
		player = null

//This is defined at atom level to enable non-marker spawning systems in future
/atom/proc/get_available_biomass()
	return 0

/obj/machinery/marker/get_available_biomass()
	return biomass


//A mob was detected nearby, can we absorb it?
/obj/machinery/marker/proc/nearby_movement(var/atom/movable/AM, var/atom/old_loc)

	if (isliving(AM))
		var/mob/living/L = AM
		if (!L.is_necromorph())
			//Yes we can
			add_biomass_source(L, L.get_biomass(), 8 MINUTES, /datum/biomass_source/convergence)
			//We can only absorb dead mobs, but we don't check that here
			//We'll add a still-living mob to the list and it'll be checked each tick to see if it died yet



/obj/machinery/marker/proc/pay_biomass(var/purpose, var/amount, var/allow_negative = FALSE)
	if (allow_negative || biomass >= amount)
		biomass -= amount
		return TRUE
	return FALSE

//Corruption Handling

/obj/machinery/marker/proc/start_corruption()
	set_extension(src, /datum/extension/corruption_source, 12)


//Necrovision

//The marker reveals an area around it, seeing through walls
/obj/machinery/marker/get_visualnet_tiles(var/datum/visualnet/network)
	return trange(visualnet_range, src)

//Spawnpoints
/obj/machinery/marker/proc/add_spawnpoint(var/atom/source, var/datum/crew_objective/event)
	if (shop)
		shop.possible_spawnpoints += new /datum/necrospawn(source, source.name, event)

/obj/machinery/marker/proc/remove_spawnpoint(var/atom/source)
	if (shop)
		for (var/datum/necrospawn/N in shop.possible_spawnpoints)
			if (N.spawnpoint == source)
				shop.possible_spawnpoints.Remove(N)
				if (shop.selected_spawn == N)
					var/datum/necrospawn/N_Marker = shop.possible_spawnpoints[1]
					shop.selected_spawn = N_Marker
					message_necromorphs("<span class='necromarker'>[source] was destroyed, current spawnpoint was set to [N_Marker.spawnpoint].</span>")
				break
		SSnano.update_uis(shop)

	crash_with("Marker removing spawnpoint [source]")


//Marker spawning landmarks
/obj/effect/landmark/marker
	delete_me = TRUE

/obj/effect/landmark/marker/ishimura/Initialize()
	SSnecromorph.marker_spawns_ishimura |= get_turf(src)
	.=..()


/obj/effect/landmark/marker/aegis/Initialize()
	SSnecromorph.marker_spawns_aegis |= get_turf(src)
	.=..()


/obj/machinery/marker/proc/get_total_biomass()
	if (unavailable_biomass == NONSENSICAL_VALUE)
		update_unavailable_biomass()

	return biomass + unavailable_biomass


/obj/machinery/marker/proc/update_unavailable_biomass()
	unavailable_biomass = 0


	//Alright first of all, lets get the total biomass of live necromorphs and corruption nodes
	if (invested_biomass == NONSENSICAL_VALUE)
		invested_biomass = 0
		for (var/atom/A in SSnecromorph.massive_necroatoms)
			//If its gone, it isnt providing biomass
			if (QDELETED(A))
				SSnecromorph.massive_necroatoms -= A
				continue

			if (isliving(A))
				var/mob/living/L = A
				if (L.stat == DEAD)
					//If it died, it doesnt belong here
					SSnecromorph.massive_necroatoms -= A
					continue

			invested_biomass += A.get_biomass(src)

	//Next, we get biomass in sources currently being reclaimed which the marker owns. IE, limited sources which cannot be taken away. This includes:
	//Dead necromorphs
	//Destroyed corruption nodes
	//It does not include baseline tick, harvester gains, or human corpses currently being eaten
	if (reclaiming_biomass == NONSENSICAL_VALUE)
		reclaiming_biomass = 0
		for (var/datum/biomass_source/BS in biomass_sources)
			if (BS.counts_toward_total && BS.remaining_mass != NONSENSICAL_VALUE)
				reclaiming_biomass += BS.remaining_mass


	unavailable_biomass = invested_biomass + reclaiming_biomass

/*
	Interaction short circuits
*/
//Function stubs just to make sure it doesn't behave like other machines when it shouldn't
//Its not made of meat, despite containing hundreds of kilos of biomass
/obj/machinery/marker/get_biomass()
	return null


/obj/machinery/marker/ex_act()
	return null	//We do not break

/obj/machinery/marker/emp_act()
	return null	//We do not break

/obj/machinery/marker/bullet_act()
	return null	//We do NOT break

/obj/machinery/marker/default_deconstruction_crowbar(var/mob/user, var/obj/item/weapon/tool/crowbar/C)
	return

/obj/machinery/marker/default_deconstruction_screwdriver(var/mob/user, var/obj/item/weapon/tool/screwdriver/S)
	return

/obj/machinery/marker/default_part_replacement(var/mob/user, var/obj/item/weapon/storage/part_replacer/R)
	return

/obj/machinery/marker/dismantle()
	return


/proc/marker_active()
	var/obj/machinery/marker/M = get_marker()
	if (M && M.active)
		return TRUE

	return FALSE