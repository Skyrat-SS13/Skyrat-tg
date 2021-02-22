/*
	This extension handles the storage and gain of psi energy, used by signals and markers for their abilities.

	It is attached to the player datum, so it persists between relogs and mob transitions
	Signal players gain energy while they're playing as a signal waiting to do things. Their energy gain is paused while controlling a necromorph. The stored energy persists though
*/
/datum/extension/psi_energy
	flags = EXTENSION_FLAG_IMMEDIATE
	base_type = /datum/extension/psi_energy
	var/datum/player/host
	var/energy = 0
	var/energy_per_tick = 1	//1 Per second
	var/max_energy = 900	//Stores 15 minutes worth of energy
	var/ticking = FALSE

	var/list/abilities = list()

	var/list/content_data = list() //Cached list of stuff that doesn't change between UI refreshes
	var/selected_ability	//What is the user currently looking at in the menu

/datum/extension/psi_energy/New()
	.=..()
	host = holder
	build_ability_list()

/datum/extension/psi_energy/proc/is_valid_mob(var/mob/M)
	return TRUE

/datum/extension/psi_energy/proc/safety_check()
	.= FALSE
	var/client/C = host.get_client()
	if (C)//Check they're still connected
		var/mob/M = host.get_mob()
		if (is_valid_mob(M))	//And in the right mobtype
			.=TRUE

	//If we're about to return false, we may also wish to suspend ticking
	if (!. && can_stop_ticking())
		stop_ticking()

/datum/extension/psi_energy/Process()
	if (!safety_check())
		return FALSE

	change_energy(energy_per_tick)


/datum/extension/psi_energy/proc/start_ticking()
	if (!ticking)
		START_PROCESSING(SSprocessing, src)
		ticking = TRUE

/datum/extension/psi_energy/proc/stop_ticking()
	if (ticking)
		STOP_PROCESSING(SSprocessing, src)
		ticking = FALSE

/datum/extension/psi_energy/proc/can_stop_ticking()
	return TRUE


/*
	Energy Handling
*/
/datum/extension/psi_energy/proc/change_energy(var/adjustment)
	energy = CLAMP(energy+adjustment, 0, max_energy)

//The source is included for the possibility of discounts based on spell types in future
/datum/extension/psi_energy/proc/can_afford_energy_cost(var/cost, var/datum/source)
	if (energy >= cost)
		return TRUE

/*
	Signal Specific
*/
/datum/extension/psi_energy/signal
	base_type = /datum/extension/psi_energy/signal


/datum/extension/psi_energy/signal/is_valid_mob(var/mob/M)
	if (issignal(M))
		return TRUE

	return FALSE


/*
	Marker Specific
*/
/datum/extension/psi_energy/marker
	base_type = /datum/extension/psi_energy/marker
	energy_per_tick = 5	//5 Per second
	max_energy = 4500	//Stores 15 minutes worth of energy

/datum/extension/psi_energy/marker/is_valid_mob(var/mob/M)
	return TRUE	//Always gives energy regardless of mob


/*----------------------
	Helper procs
----------------------*/
/datum/proc/get_energy_extension()
	for (var/subtype in extensions)
		var/datum/extension/E = extensions[subtype]
		if (istype(E, /datum/extension/psi_energy))
			return E

	return null


/mob/get_energy_extension()
	var/datum/player/P = get_player()
	if (P)
		return P.get_energy_extension()


/mob/observer/eye/signal/get_energy_extension()
	var/datum/player/P = get_player()
	if (P)
		return get_extension(P, energy_extension_type)



/*----------------------
	Ability List
----------------------*/
/datum/extension/psi_energy/proc/build_ability_list(var/clear = TRUE)
	if (clear)
		abilities = list()
	for (var/id in GLOB.signal_abilities)
		var/datum/signal_ability/SA = GLOB.signal_abilities[id]

		if (SA.is_valid_user(host.get_mob()))
			//We can use this ability
			abilities[id] = world.time
			//This time is the last-cast time for the spell, used to check cooldowns
			//By setting it to worldtime now, spells with cooldowns can only be cast at least cooldown time after taking control of the mob
			//This prevents exploits with long-cooldown spells
		else
			abilities -= id

	sort_abilities()
	generate_content_data()

/datum/extension/psi_energy/proc/generate_content_data()
	var/list/spells = list()
	for (var/id in abilities)

		var/datum/signal_ability/SA = GLOB.signal_abilities[id]
		var/list/spell = list("name" = SA.name, "id" = SA.id, "cost" = SA.energy_cost)
		spells.Add(list(spell))

	content_data["abilities"] = spells

//Sorts the list of abilities by ascending cost
/datum/extension/psi_energy/proc/sort_abilities()
	var/list/sorted_abilities = list()
	for (var/id in abilities)

		var/datum/signal_ability/SA = GLOB.signal_abilities[id]
		var/newcost = SA.energy_cost
		var/inserted = FALSE
		for (var/i = 1; i <= sorted_abilities.len; i++)
			var/sid = sorted_abilities[i]
			var/datum/signal_ability/SA2 = GLOB.signal_abilities[sid]
			if (SA2.energy_cost > newcost)
				inserted = TRUE
				sorted_abilities.Insert(i, id)
				sorted_abilities[id] = abilities[id]
				break

		if (!inserted)
			sorted_abilities.Add(id)
			sorted_abilities[id] = abilities[id]

	abilities = sorted_abilities

/*----------------------
	Abilities Menu
----------------------*/

/datum/extension/psi_energy/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/list/data = content_data
	data["energy"] = energy
	data["income"] = energy_per_tick
	data["max_energy"]= max_energy
	if (selected_ability)
		var/datum/signal_ability/SA = GLOB.signal_abilities[selected_ability]
		data["current"] = list("name" = SA.name, "desc" = SA.get_long_description(), "id" = selected_ability)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "signal_abilities.tmpl", "Abilities Menu", 600, 600, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(TRUE)
		ui.open()


/datum/extension/psi_energy/Topic(href, href_list)
	if(..())
		return
	if (href_list["select"])
		if  (href_list["select"] in abilities)
			selected_ability = href_list["select"]

	if (href_list["cast"])
		cast_ability(href_list["cast"])

	SSnano.update_uis(src)


/*
	The ability datum handles all safety checks. tell it we want to start and thats all
*/
/datum/extension/psi_energy/proc/cast_ability(var/ability_id)
	var/mob/user = host.get_mob()
	var/datum/signal_ability/SA = GLOB.signal_abilities[ability_id]
	SA.start_casting(user)