GLOBAL_LIST_INIT(signal_sprites, list("markersignal-1",
	"markersignal-2",
	"markersignal-3",
	"markersignal-4",
	"markersignal-5",
	"markersignal-6",
	"markersignal-7",
	"markersignal-8",
	"markersignal-9",
	"markersignal-10",
	"markersignal-11",
	"markersignal-12",
	"markersignal-13",
	"markersignal-14",
	"markersignal-15",
	"markersignal-16",
	"markersignal-17",
	"markersignal-18",
	"markersignal-19",
	"markersignal-20",
	"markersignal-21",
	"markersignal-22",
	"markersignal-23",
	"markersignal-24",
	"markersignal-25"
	))

/mob/dead/observer/eye/signal
	name = "Signal"
	real_name = "Signal"
	icon = 'icons/mob/eye.dmi'
	icon_state = "markersignal"
	atom_flags = ATOM_FLAG_INTANGIBLE
	plane = ABOVE_OBSCURITY_PLANE
	var/energy_extension_type = /datum/extension/psi_energy/signal
	var/datum/extension/psi_energy/psi_energy

	var/datum/preferences/prefs

	var/list/variations

	movement_handlers = list(
		/datum/movement_handler/mob/incorporeal/eye
	)

/mob/dead/observer/eye/signal/set_eyeobj(var/atom/new_eye)
	eyeobj = new_eye
	//No messing with movement handlers here


/mob/dead/observer/eye/signal/is_necromorph()
	return TRUE

/mob/dead/observer/eye/signal/apply_customisation(var/datum/preferences/prefs)
	var/list/custom
	if (prefs)
		custom = prefs.get_necro_custom_list()
	else
		//With blank prefs, we use the global default
		custom = get_default_necro_custom()
	var/list/things = custom[SIGNAL][SIGNAL_DEFAULT]
	if (length(things))
		variations = things.Copy()
	update_icon()

/mob/dead/observer/eye/signal/update_icon()
	if (LAZYLEN(variations))
		icon_state = pick(variations)
	else
		icon_state = pick(GLOB.signal_sprites)

//This will have a mob passed in that we were created from
/mob/dead/observer/eye/signal/New(mob/body)
	..()
	visualnet = GLOB.necrovision	//Set the visualnet of course

	variations = GLOB.signal_sprites.Copy()	//All are enabled by default

	var/turf/T = get_turf(body)
	if(ismob(body))
		key = body.key
		possess(src) //Possess thyself
		SetName("[initial(name)] ([key])")
		real_name = "[initial(name)] ([key])"

		mind = body.mind	//we don't transfer the mind but we keep a reference to it.

	add_verb(src, /mob/proc/prey_sightings)

	forceMove(T)

	PushClickHandler(/datum/click_handler/signal)

//Joining and leaving
//-------------------------------
/mob/dead/observer/ghost/verb/join_marker_verb()
	set name = "Join Necromorph Horde"
	set category = "Necromorph"
	set desc = "Joins the necromorph team, and allows you to control horrible creatures."

	var/response = tgui_alert(src, "Would you like to join the necromorph side?", "Make us whole again", list("Yes", "No"))
	if (response != "Yes")
		return

	var/mob/dead/observer/eye/signal/S = join_marker()	//This cannot fail, do safety checks first
	S.jump_to_marker()
	qdel(src)



/mob/proc/join_marker()
	message_necromorphs(SPAN_NOTICE("[key] has joined the necromorph horde."))
	var/mob/dead/observer/eye/signal/S = new(src)
	set_necromorph(TRUE)

	return S


/mob/dead/observer/eye/signal/verb/leave_marker_verb()
	set name = "Leave Necromorph Horde"
	set category = "Necromorph"
	set desc = "Leaves the necromorph team, making you a normal ghost"

	//Lets not look like an eye after we become a ghost
	icon = 'icons/mob/mob.dmi'
	icon_state = "ghost"


	if (ckey)
		message_necromorphs(SPAN_NOTICE("[key] has left the necromorph horde."))
		set_necromorph(FALSE)
	var/mob/dead/observer/ghost/ghost = ghostize(0)
	qdel(src)
	return ghost


//Signals don't leave behind ghosts if they are clientless
/mob/dead/observer/eye/signal/ghostize(var/can_reenter_corpse = CORPSE_CAN_REENTER)
	if (!client)
		return null

	.=..()


//Possession and evacuating
//-------------------------------
/mob/dead/observer/eye/signal/verb/necro_possess(var/mob/living/L)
	set name = "Possess"
	set category = "Necromorph"
	set desc = "Take control of a necromorph vessel"

	if (!istype(L))
		to_chat(src, SPAN_DANGER("That can't be possessed!"))
		return

	if (L.stat == DEAD)
		to_chat(src, SPAN_DANGER("That vessel is damaged beyond usefulness"))
		return

	if (!L.is_necromorph())
		to_chat(src, SPAN_DANGER("You can only possess necromorph units."))
		return

	if (L.client)
		to_chat(src, SPAN_DANGER("Error: [L.key] is already controlling [L]"))
		return

	//Seems clear
	message_necromorphs(SPAN_NOTICE("[key] has taken control of [L]."))
	L.key = key
	L.client.init_verbs()
	qdel(src)

/mob/proc/necro_evacuate()
	set name = "Evacuate"
	set category = "Necromorph"
	set desc = "Depart your body and return to the marker. You can go back and forth with ease"

	necro_ghost()


//Evacuates a mob from their body but makes them a marker signal instead of a normal ghost
/mob/proc/necro_ghost()
	if (is_marker_master(src))	//If they are the marker's player, lets be sure to put them into the correct signal type
		var/obj/machinery/marker/marker = get_marker()
		if (marker)
			marker.become_master_signal(src)
		return
	else
		var/mob/signal = new /mob/dead/observer/eye/signal(src)
		signal.client?.init_verbs()
		if(isobserver(src) && !issignal(src))
			qdel(src)
		return signal


//Signals cant become signals, silly
/mob/dead/observer/eye/signal/necro_ghost()
	return src





//Necroqueue Handling
//---------------------------


/mob/dead/observer/eye/signal/Login()
	..()
	set_necromorph(TRUE)
	SSnecromorph.signals |= src
	start_energy_tick()

	//Lets load preferences if possible
	//This will set our icon to one of the players' chosen ones

	if (client)
		apply_customisation(client.prefs)

	spawn(1)	//Prevents issues when downgrading from master
		if (!istype(src, /mob/dead/observer/eye/signal/master))	//The master doesn't queue


			add_verb(src, /mob/dead/observer/eye/signal/proc/join_necroqueue)
			if (client && client.prefs && client.prefs.auto_necroqueue)
				SSnecromorph.join_necroqueue(src)



/mob/dead/observer/eye/signal/Logout()
	if (!istype(src, /mob/dead/observer/eye/signal/master))
		SSnecromorph.remove_from_necroqueue(src)
	.=..()
	spawn()
		if (!QDELETED(src))
			qdel(src)	//A signal shouldn't exist with nobody in it

/mob/dead/observer/eye/signal/Destroy()

	SSnecromorph.remove_from_necroqueue(src)
	SSnecromorph.signals -= src
	..()
	return QDEL_HINT_HARDDEL_NOW

/mob/dead/observer/eye/signal/proc/join_necroqueue()
	set name = "Join Necroqueue"
	set category = SPECIES_NECROMORPH

	SSnecromorph.join_necroqueue(src)


/mob/dead/observer/eye/signal/proc/leave_necroqueue()
	set name = "Leave Necroqueue"
	set category = SPECIES_NECROMORPH

	SSnecromorph.remove_from_necroqueue(src)

//Misc Verbs
//--------------------------------
/mob/dead/observer/eye/signal/verb/jump_to_marker()
	set name = "Jump to Marker"
	set category = SPECIES_NECROMORPH

	if (SSnecromorph.marker)
		forceMove(get_turf(SSnecromorph.marker))
		return

	to_chat(src, SPAN_DANGER("Error: No marker found!"))

/mob/dead/observer/eye/signal/verb/jump_to_alive_necro()
	set name = "Jump to Necromorph"
	set category = SPECIES_NECROMORPH

	if(SSnecromorph.major_vessels.len <= 0)
		to_chat(src, SPAN_DANGER("No living necromorphs found!"))
		return

	var/necro = input(src, "Choose necromorph to jump", "Jumping menu") as null|anything in SSnecromorph.major_vessels
	if(necro)
		forceMove(get_turf(necro))
		return

	to_chat(src, SPAN_DANGER("You didn't choose a necromorph to jump!"))






/*
	Interaction
*/
/datum/click_handler/signal

/datum/click_handler/signal/OnLeftClick(var/atom/A, var/params)
	return A.attack_signal(user)

/datum/click_handler/signal/OnShiftClick(var/atom/A, var/params)
	return user.examinate(A)

/atom/proc/attack_signal(var/mob/dead/observer/eye/signal/user)
	return TRUE


/*
	Energy Handling
*/
/mob/dead/observer/eye/signal/proc/start_energy_tick()
	if (!key)
		return	//Logged in players only
	var/datum/player/myself = get_or_create_player(key)
	psi_energy = get_or_create_extension(myself, energy_extension_type)
	psi_energy.start_ticking()






/mob/dead/observer/eye/signal/verb/ability_menu()
	set name = "Ability Menu"
	set desc = "Opens the menu to cast abilities using your psi energy"
	set category = "Necromorph"


	var/datum/extension/psi_energy/PE	= get_energy_extension()
	PE.ui_interact(src)


/*
	Verb handling
*/
/mob/dead/observer/eye/signal/update_verbs()
	.=..()
	update_verb(/mob/proc/jump_to_shard, (SSnecromorph.shards.len > 0))	//Give us the verb to jump to shards, if there are any


/*
	Helper
*/

//Called from new_player/New when a player disconnects and then reconnects while playing as signal/marker
//This proc recreates the appropriate mob type and puts them in it
/mob/proc/create_signal()
	if (is_marker_master(src))
		return SSnecromorph.marker.become_master_signal(src)
	else
		return join_marker()


/mob/dead/new_player/create_signal()
	spawning = TRUE
	if (!QDELETED(src))
		close_spawn_windows()
	.=..()



