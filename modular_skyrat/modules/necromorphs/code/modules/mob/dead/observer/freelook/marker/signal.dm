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
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/eye.dmi'
	icon_state = "markersignal"


/mob/dead/observer/eye/signal/set_eyeobj(var/atom/new_eye)
	var/eyeobj = new_eye
	//No messing with movement handlers here

/mob/dead/observer/eye/signal/is_necromorph()
	return TRUE


//This will have a mob passed in that we were created from
/mob/dead/observer/eye/signal/New(mob/body)
	..()

	var/turf/T = get_turf(body)
	if(ismob(body))
		key = body.key
		possess(src) //Possess thyself
		real_name = "[initial(name)] ([key])"

		mind = body.mind	//we don't transfer the mind but we keep a reference to it.

	forceMove(T)


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
	message_necromorphs("[key] has joined the necromorph horde.")
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
		message_necromorphs("[key] has left the necromorph horde.")
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
		to_chat("That can't be possessed!")
		return

	if (L.stat == DEAD)
		to_chat("That vessel is damaged beyond usefulness")
		return

	if (!L.is_necromorph())
		to_chat("You can only possess necromorph units.")
		return

	if (L.client)
		to_chat("Error: [L.key] is already controlling [L]")
		return

	//Seems clear
	message_necromorphs("[key] has taken control of [L].")
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

	to_chat("Error: No marker found!")

/mob/dead/observer/eye/signal/verb/jump_to_alive_necro()
	set name = "Jump to Necromorph"
	set category = SPECIES_NECROMORPH

	if(SSnecromorph.major_vessels.len <= 0)
		to_chat("No living necromorphs found!")
		return

	var/necro = input( "Choose necromorph to jump", "Jumping menu") as null|anything in SSnecromorph.major_vessels
	if(necro)
		forceMove(get_turf(necro))
		return

	to_chat("You didn't choose a necromorph to jump!")






/*
	Interaction
*/
/datum/click_handler/signal

/datum/click_handler/signal/OnLeftClick(var/atom/A, var/params)
	return

/datum/click_handler/signal/OnShiftClick(var/atom/A, var/params)
	return

/atom/proc/attack_signal(var/mob/dead/observer/eye/signal/user)
	return TRUE


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
	.=..()



